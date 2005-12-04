Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Gorbach <mgorbach@yahoo.com>
To: bluez-users@lists.sourceforge.net
References: <20051204040506.D045A9426E@sc8-sf-spam1.sourceforge.net>
In-Reply-To: <20051204040506.D045A9426E@sc8-sf-spam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200512032308.50356.mgorbach@yahoo.com>
Subject: [Bluez-users] hcid errors
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 3 Dec 2005 23:08:50 -0500

I'm using bluez-utils 2.22 on gentoo linux 2005.0.

On Saturday 03 December 2005 23:04, bluez-users-request@lists.sourceforge.net 
wrote:
> Send Bluez-users mailing list submissions to
> 	bluez-users@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://lists.sourceforge.net/lists/listinfo/bluez-users
> or, via email, send a message with subject or body 'help' to
> 	bluez-users-request@lists.sourceforge.net
>
> You can reach the person managing the list at
> 	bluez-users-admin@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bluez-users digest..."
>
>
> Today's Topics:
>
>    1. Re: fujitsu internal bluetooth (Marcel Holtmann)
>    2. Re: Errors from hcid (Marcel Holtmann)
>    3. Re: Correction (Rutger Hendriks)
>    4. Cellink BTA-6030 adapter of choice? usb & bt 2.0 (sean)
>
> --__--__--
>
> Message: 1
> Subject: Re: [Bluez-users] fujitsu internal bluetooth
> From: Marcel Holtmann <marcel@holtmann.org>
> To: bluez-users@lists.sourceforge.net
> Date: Sat, 03 Dec 2005 06:19:50 +0100
> Reply-To: bluez-users@lists.sourceforge.net
>
> Hi Brad,
>
> > I'm interested in a fujitsu (lifebook p1510d) but of course there's no
> > way to find out from them which bluetooth chip they use internally. Does
> > anyone have one of the fujitsu models with internal bluetooth? What are
> > they using for internal bluetooth? (run "hciconfig hci0 revision" as
> > root to see)
>
> in the past they used CSR BlueCore02 chips. I don't know what they are
> using now.
>
> Regards
>
> Marcel
>
>
>
>
> --__--__--
>
> Message: 2
> Subject: Re: [Bluez-users] Errors from hcid
> From: Marcel Holtmann <marcel@holtmann.org>
> To: bluez-users@lists.sourceforge.net
> Date: Sat, 03 Dec 2005 06:20:40 +0100
> Reply-To: bluez-users@lists.sourceforge.net
>
> Hi Michael,
>
> > I've set up my dinovo bluetooth dongle after some playing around, using
> > hid2hci. It is working ok ... but I am getting errors every 5 or 10
> > minutes in my 12th console and in /var/log/messages. They look like this:
> > Dec  2 18:21:16 swatBox hcid[11586]: Can't send D-BUS inquiry start
> > message Dec  2 18:21:20 swatBox hcid[11586]: Can't send D-BUS inquiry
> > result message Dec  2 18:21:24 swatBox hcid[11586]: Can't send D-BUS
> > inquiry complete message Dec  2 18:26:17 swatBox hcid[11586]: Can't send
> > D-BUS inquiry start message Dec  2 18:26:20 swatBox hcid[11586]: Can't
> > send D-BUS inquiry result message Dec  2 18:26:24 swatBox hcid[11586]:
> > Can't send D-BUS inquiry complete message Can anyone tell me what's going
> > on here, and what i need to do to fix or at least get some more info on
> > what's going on?
>
> what version of bluez-utils are you using and what kind of Linux
> distribution is this?
>
> Regards
>
> Marcel
>
>
>
>
> --__--__--
>
> Message: 3
> From: Rutger Hendriks <Loial@home.nl>
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Correction
> Date: Sat, 3 Dec 2005 13:21:14 +0100
> Reply-To: bluez-users@lists.sourceforge.net
>
> --nextPart1322770.iItLZbcnqH
> Content-Type: text/plain;
>   charset="iso-8859-1"
> Content-Transfer-Encoding: quoted-printable
> Content-Disposition: inline
>
> On Wednesday 30 November 2005 16:46, Michael Gorbach wrote:
> > Sorry about a typo ... When i wrote "mouse" i meant keyboard. My dinovo
> > keybord is stuck in f-lock mode after I run hid2hci. Actually ... the
> > f-keys seem to be working in console mode (outside of x). Inside x, it
> > xev shows a kepress of the event "f12" but nothing seems to happen. Weird
> > isnt it? Is it a problem with x keybindings?
>
> By stuck, do you mean the F-lock light on the receiver does not respond?=20
> because it doesn't respond here either, it burns continuously, but I can=20
> still switch between F1-F12 and F-lock mode by pressing the F-lock key.=20
> Unfortunately only Undo (F5) and My Comp (F9) work when in F-lock mode,
> but= =20
> that is another problem.
>
> xev should recognise the F1-F12 keypresses and applications should respond.
>
> > Also ... is there no way to put the=20
> > device out of hci mode when the system shuts off so that I can have
> > access to GRUB and my BIOS? The windows drivers seem to be OK doing this
> > ...
>
> I'm experiencing no problems in GRUB or the BIOS when I reboot my machine.
> = It=20
> just takes a second for the first keypress to get processed it seems,
> after= =20
> that no delays or problems.
>
> --nextPart1322770.iItLZbcnqH
> Content-Type: application/pgp-signature
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2 (GNU/Linux)
>
> iD8DBQBDkY3DZNkx8LIJzQ4RAkx5AJ9fksaVkIshKfnSucM9HdJlafa2RACeI8/Z
> gI1Hz7SZxov+DmR04UNsZ+U=
> =YEWl
> -----END PGP SIGNATURE-----
>
> --nextPart1322770.iItLZbcnqH--
>
>
> --__--__--
>
> Message: 4
> To: bluez-users@lists.sourceforge.net
> From:  sean <seandarcy2@gmail.com>
> Date:  Sat, 03 Dec 2005 20:22:24 -0500
> Subject: [Bluez-users] Cellink BTA-6030 adapter of choice? usb & bt 2.0
> Reply-To: bluez-users@lists.sourceforge.net
>
> I'm looking for a bt usb Class 1 dongle with usb 2.0 and bt 2.0.
>
> I've gooten burned buying a zonet dongle which had a
> broadcom chip. Won't work with bluez.
>
> Anyone have this one working. It's supposed to hace the CSR
> BLue4 chip. Is that supported?
>
> Any other adapters out there that work with bluez?
>
> sean
>
>
>
>
> --__--__--
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> End of Bluez-users Digest


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
