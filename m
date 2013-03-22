Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK9-WKBCF59yVkdWC22aXw37iW3tjch-F+Z40wrw8EjMQ@mail.gmail.com>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
 <3117038.DiW6TICzsh@uw000953> <CABBYNZJc=Bk1NfJcYqj939rB9QtsbA+gBwNjt-w=HcmAD9HVBw@mail.gmail.com>
 <CABBYNZK9-WKBCF59yVkdWC22aXw37iW3tjch-F+Z40wrw8EjMQ@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Fri, 22 Mar 2013 10:36:57 -0700
Message-ID: <CAGd9gwiUUw409KGZu8rGrtpOWqwWLHt0HsHZ1OH7Ed+m1CgANQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] The Autopair strikes back
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"keybuk@chromium.org" <keybuk@chromium.org>, "marcel@holtmann.org" <marcel@holtmann.org>, hadess@hadess.net
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all!
I'll address all the comments in this email. First of, keep in mind
the goal and that context is usually dumb devices:
* Don't ask the user (i.e. the agent) a question if we know the right answer.

1) Requiring paring vs non requiring pairing (mice):
This thing of asking the agent implies that we are talking about
paring, i.e. calling org.bluez.Device1.Pair . If you want to pair with
the device, you call Device1.Pair and we do our best to pair with it.
If the device doesn't support that, or you don't know the pincode, we
fail the Device1.Pair call and your free to call Device1.Connect and
have fun there.

2) The pin-code-database.xml
I'm not a fan of having such a database, and that one in particular
doesn't seem to fit very well in our context. Matching with the name
(see next point) and not requiring pairing for mice is something I
don't like. Pairing with a mouse (if supported) is really good because
then it will connect back to your computer next time you turn it on.
Most of the BT mice I have support pairing except two (microsoft 5000
and logitech).
There is a lot of questions in the database approach I don't like:
Do we ship the DB with BlueZ? Do we read the db each time we need a pin?
Do we really want an xml parser in C somehow linked in the plugin?
parsing xml is a lot of code for such a simple pincode db. (Note: we
had an out of bounds read bug in the parsing functions in textfile.c.
Those functions read very very very simple text file formatted like
"key value\n" in a unnecessarily complicated way in C. Do we really
want to parse xml just for this?) If we ship the db with the bluez
code, why don't embed it in the autopair.c file in a sort of logic? It
allow us to have more logic around it.
Anyway, what I want to get done here is the retrying mechanism to
allow the list of plugins. This will allow anyone to write a database
based plugin for this if they want one, and send it together with the
plugin.

3) Use class vs other ids.
When you have your shiny new whatever bluetooth device still smelling
like new, you turn it on, click on "scan for new device" (or your OS
equivalent) and desperately click in "add" (i.e Pair) when you see a
device in the list that matches the whatever class of your shiny new
whatever device... Even before we ask for the name of the device or
the services it exports. (well... maybe we have the name just before
providing the pin). So the only reliable information is the mac
address and the class. Using information that may or may not be
available at that time doesn't look good to me.
Someone said that the class field is variable. That's true... but I
think it's not the case with the dumb devices that are the target of
this patch.

4) Repeated pairing attempts
bluetoothd will handle several pairing attempts for the same
Device1.Pair call, getting the error back.
Szymon mentioned that we have to deal with the 'repeated attempts'
problem. In some way, we deal with it when this patch retries the pair
only after a auth_failed error (it returns an error to Pair if the
underlying error is something else). But yes, I agree we should threat
that error in a different way and add a sort of timeout for the next
attempt. Szymon, do you have any information on these timeout values?
How long should I wait until the device stops reporting a Repeated
attempts error?

5) Devices exiting the pairing mode after wrong pincode
Although the plan is to provide the right pincode for the right
device, we may fail.
Do you have a device that behaves like that? (exits the discovery mode
just after an auth failure)


Resuming, will you agree in the following idea?
The plugin's callback list iterator can span several Pair attempts,
and has the agent (if any) at the end (technically is not in the list,
to allow enable/disable it between Pair calls).
When you call Device1.Pair, a pair is attempted. When (if) the pincode
is requested, the iterator gets the next pincode in the plugin's list
(calling several functions until we get a pincode). If we got a
pincode from a plugin in this iteration we send that to the device. If
we don't have a pincode, then we try the agent (if any) or just return
a negative reply to the pin request if no agent.
If the pin works, we just return successfully the Pair call and reset
the iterator state.
If the pin doesn't work, it could be caused by an auth failed, or any
other error. If it is because an auth failed, we retry the pairing. If
it's something else (like the repeated attempts) we return to the user
with an error in Device1.Pair... BUT... we keep the iterator state for
futures retries: If the error was a repeated attempts and we provided
a pincode, the pincode was wrong and doesn't make sense to retry all
the pincodes from the beginning. If the error was something else (page
timeout, or disconnected right after the connect with a repeated
attempts) and we didn't get an auth_failed for the provided pincode,
we restore the iterator to the previous state, to retry that pincode
next time.

This handles the case of having a loooong list of plugins providing
random codes, since it will allow the agent to provide its pincode at
some point, even after a few Device1.Pair calls.

Comments? Complaints? =)?
Alex.
