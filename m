Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] I-Tec Bluetooth USB -- Same Problem...
References: <10865.30319-12503-1360465066-1076449270@seznam.cz> <1076452227.2777.28.camel@pegasus> <404D69F5.50300@utia.cas.cz>
In-Reply-To: <404D69F5.50300@utia.cas.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403090851.20295.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 9 Mar 2004 08:51:19 +0100

05.03.2004
New Bluetooth kernel patch for 2.6.3 available
With this patch the RFCOMM TTY device are created on demand and this gives =
a=20
nice integration with devfs and udev. Some more enhancements towards full S=
CO=20
audio support are made=20

and the i-Tec dongle now works like a charm.

Ruda, download a patch :)

Michal

Dne =FAt 9. b=F8ezna 2004 07:53 Rudolf Matousek napsal(a):
> Marcel,
>
> I have lost all my patience. i-Tec is selling a dongle without any type
> mark. I tried to contact Broadcom in order to get more information about
> the chip that is in the bloody dongle. Unfortunatelly, I've sent the
> mail two times without any reply. Marcel, have you any method how to
> force Broadcom to, at least, reply my email? You have the copy of my
> email, is there something inconvenient?
>
> I propose to remove the i-Tec dongle from the working hardware list at
> the page http://www.holtmann.org/linux/bluetooth/devices.html, because
> it is likely that any new dongle will be based on the same chipset.At
> least there should be an information, that there exist another device
> with the same vendor type and no type mark that is not working yet.
>
> I'll probably go to my hardware shop and replace the i-Tec dongle with
> another one with proper vendor and type marks. I'll try to handle my
> complaint in a way that they sold me a dongle that I didn't wanted.
>
> Regards,
>
>
> Ruda Matousek
>
> --
>
> Marcel Holtmann wrote:
> > Hi Dave,
> >
> >>I'm having the same problem with the I-Tec device -- got it today, put =
it
> >> in -- and nothing comes up with HCICONFIG -- if I take it out, and put
> >> in the EPOX device -- the EPOX device works fine -- if I take it back
> >> out, and put the I-Tec back in, nothing.
> >
> > I need a full USB SnoopyPro of all three devices this dongles presents.
> > With comparable timestamps of course.
> >
> >>Let me know if (and how) I can get you info to get it working.
> >
> > Is there anyone who will sponsor me a dongle of these?
> >
> > Regards
> >
> > Marcel
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
