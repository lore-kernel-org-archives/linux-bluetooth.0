Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Gorbach <mgorbach@yahoo.com>
To: bluez-users@lists.sourceforge.net
References: <20051204040506.D045A9426E@sc8-sf-spam1.sourceforge.net>
In-Reply-To: <20051204040506.D045A9426E@sc8-sf-spam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200512041532.17365.mgorbach@yahoo.com>
Subject: [Bluez-users] Re: Bluez-users digest, Vol 1 #2127 - 4 msgs
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
Date: Sun, 4 Dec 2005 15:32:17 -0500

Ok ... the f keys seem to work ok for me now ... i guess i just got confused. 
The keyboard does not work AT ALL though in grub. Before I enabled bluetooth 
on my linux system, it was detected after a short delay ... which was OK. 
What seems to happen is after i run hid2hci it puts the dongle into hci mode 
and this is not removed on reboot. The dongle continues to be in hci mode and 
of course my comp does not know how to operate a hci bluetooth keyboard with 
no drivers (in bios). For me, if i remove the usb connection to my comp and 
place it in a different port, the dongle recets to hid mode and it works 
again.

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


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
