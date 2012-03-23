Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
Date: Fri, 23 Mar 2012 12:51:12 -0500
Message-ID: <CAB7rCTid2cRwetSyNpaT3vGGT_GrSGxzjqR6BJt-J-g4wJuM0w@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: Mike <puffy.taco@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 22, 2012 at 12:18 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mike,
>
> On Wed, Mar 21, 2012 at 4:02 PM, Mike <puffy.taco@gmail.com> wrote:
>> I'm having some trouble with MediaEndpoint/MediaTransport and A2DP.
>> When I get the "SetConfiguration" call, I wait 2 seconds and then call
>> "Acquire", generally giving BlueZ enough time get the D-Bus interface
>> ready to go.  However, the delay isn't always long enough.  Shown
>> below is a time when my phone is attempting to pair with BlueZ.  The
>> error "org.bluez.Error.NotAuthorized" is output from my application.
>> In this case, the problem is that the audio source is still in the
>> CONFIGURED state, not in the OPEN state.  Is there a recommended
>> method of how long to wait before calling acquire?  Or should I rely
>> on the AudioSource "State" property to become connected (or playing)?
>> Is there any reason I can't get the transport when in the Configured
>> state (does the fd not exist yet?)?  Or why is "a2dp_resume" being
>> called on open (which is what is rejecting my acquire call)?
>
> In case of PA we do wait for Audio.Connected property before loading
> the module which does call MediaTransport.Acquire, but 2 seconds is
> too much there might be something else holding the setup, do you reply
> right away the SetConfiguration, if you do try to Acquire while
> bluetoothd is waiting you to reply it might fail.
>

Going back to this idea, it seems like MediaTransport should be
redesigned to push the file descriptor to the endpoint, rather than
the endpoint having to request it from the transport.  this would
solve this issue.  The main problem is that acquiring the endpoint
forces a call to resume.  In the case of HFP, this is bad.  I'm
currently needing to implement HFP "Audio Connection Transfer Towards
the AG".  Since I am the HS, all I need to do is drop the SCO
connection -- however, there is no interface to do this well.  I tried
implementing an SCO endpoint, since at least then the acquire and
release calls would bring up an SCO connection and then allow me to
drop it.  The issue here is that a phone that is connected via HFP
will have a MediaTransport even though the SCO connection will not yet
exist.  So, I get the SetConfiguration call which means I should be
good to go on calling acquire.  But, if I call acquire now, it will
create a useless SCO connection to my phone that then is dropped.
There's no reason at this point to open the SCO connection.  I would
rather be notified when the SCO connection exists, and have two
additional methods called suspend and resume.  In the case of HFP,
calling resume would eventually result in a new FD being pushed to me.
