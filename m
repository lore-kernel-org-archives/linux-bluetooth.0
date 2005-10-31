Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80510310430y7f360672j32a39a213b039dbf@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
In-Reply-To: <1130760862.17124.20.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051029175338.GA26114@localhost.localdomain>
	 <1130609278.5396.48.camel@blade>
	 <20051029184820.GA26657@localhost.localdomain>
	 <1130612847.5396.51.camel@blade>
	 <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
	 <20051031120753.GA31744@localhost.localdomain>
	 <1130760862.17124.20.camel@blade>
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
Date: Mon, 31 Oct 2005 09:30:10 -0300

Hi Marcel,

I've implemented the DeviceList function from /org/bluez/Devices. I've
also made some code clean up in dbus.c. Right now I'm  hunting a
segfault and as soon I have fixed this I'll send another patch.

BR,
Eduardo.

--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

On 10/31/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
> > > - use session bus to send the PinRequest message: using the session
> > > bus it's possible start the dbus pin helper application automatically
> >
> > I don't think that's the right thing or even a possible thing to do.
> > This is because hcid is a system-wide daemon and cannot know about user=
s
> > session busses.
>
> so this is not working out. Then we still need a program that starts a
> session time. Does anyone work on a Bluetooth applet for Gnome that will
> also handle the PIN requests?
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


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
