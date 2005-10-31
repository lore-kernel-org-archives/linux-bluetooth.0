Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510310547m51a457f2m19f00ec5cf194289@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
In-Reply-To: <1130760726.17124.17.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051029175338.GA26114@localhost.localdomain>
	 <1130609278.5396.48.camel@blade>
	 <20051029184820.GA26657@localhost.localdomain>
	 <1130612847.5396.51.camel@blade>
	 <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
	 <1130760726.17124.17.camel@blade>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 31 Oct 2005 11:47:53 -0200

Hi Marcel,

Regarding the dbus pin helper app,  I am trying develop a  app using
python for test purpose, based on pygtk and pydbus.  However, there is
an problem with asynchronous request, I sent an email to dbus mailing
list, but according with the received answer, I think will be not easy
implement the functionality that I want.

On 10/31/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > I don't have cleanup patches to be sent. A new release can be good to
> > receive the users/developers feedback.
>
> I have to do some other small fixes in other parts of bluez-utils, but
> the release is actually planned for today.
>
> > Some cleanups/improvements suggestions for the next release:
> > - find_conn is a shared function: put in a shared directory. It's used
> > by hcitool.c and dbus.c
>
> I know, but this has time. Maybe you wanna move it into lib.c inside the
> hcid directory first.
[Claudio Takahasi]
Probably in the future when we start develop another features(rfcomm,
pan, ...) we will find more shared functions. I will put the find_conn
to a lib.c(inside de hcid) directory first according with your
suggestion. In the future we can discuss it later again.
Another file that I want create is the error.c

>
> > - Disconnect signal: handle de disconnect signal sent when the
> > dbus-daemon exits.
>
> I have no idea what that means.
[Claudio Takahasi]
When the dbus-daemon exits, the hcid will receive a "Disconnect"
signal. The hcid can start a task to re-establish the bus connection
each X seconds or it can exit.
Currently, hcid catches the signal, but there is no action associated
with this signal.

>
> > - split dbus.c file:
> > - use session bus to send the PinRequest message: using the session
> > bus it's possible start the dbus pin helper application automatically
>
> This sounds like a good idea. Is anybody working on it? However the
> bluez-pin package needs to updated to support the latest D-Bus version,
> because we don't support the D-Bus 0.23 anymore.
[Claudio Takahasi]
I updated the bluez-pin perform authentication tests. I will analize
it and send
a patch to fix it.

>
> > I think Eduardo is working on some services device configuration
> > services. Maybe it should be better wait his patch. I will ask him and
> > confirm soon.
>
> There is plenty of time after the release. I don't consider the current
> D-Bus API as stable.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
