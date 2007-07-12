Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Date: Thu, 12 Jul 2007 10:51:47 +0100
Message-ID: <f74tjk$jve$1@sea.gmane.org>
References: <cfd8c35a0707112244j1f2d9f4ex6718237d700ce480@mail.gmail.com>
	<cfd8c35a0707112246m4dd4cd44ke18b4620a7f92572@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problems with bluetooth and pairing (Samsung E900
	and MDA Vario )
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Adrian van Dongen wrote:

> I am having some problems with pairing my mobile devices. I saw the
> btproximity monitor on the gentoo wiki and here on the ubuntu forums and i
> thought it would be nice to install it on my machine to but i run into
> some problems.
> 
> URL: http://ubuntuforums.org/showthread.php?t=486735&highlight=proximity
> 
> First of all let me explain what i am using:
> 
> * Ubuntu Fiesty Fawn
> * Samsung SGH-E900
> * T-mobile MDA Vario
> * Bluetooth USB dongle
> 
> The script didn't work so i tried the steps by hand to see where things go
> wrong. Didn't take long to see that there was no connection being made. I
> first tried it on the samsung but didn't work at all. Then i tried it with
> the MDA (which gives some responce) but this would also not work.
> 
> So let me explain what i did:
> 
> First i checked if my bluetooth was up and running:
> 
> 
> avdongen@Masahiro:~$ hciconfig
>   hci0:   Type: USB
>         BD Address: 00:10:60:A9:10:28 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:2841 acl:34 sco:0 events:105 errors:0
>         TX bytes:1226 acl:33 sco:0 commands:40 errors:0
> 
> When i try to search for my devices via hidd i get nothing..
> 
> avdongen@Masahiro:~$ sudo hidd --search
> Password:
> Searching ...
> 
> but when i search with the hcitool i find both my phones
> 
> avdongen@Masahiro:~$ sudo hcitool scan
> Scanning ...
>         00:12:37:A7:C8:93       Avdongen
>         00:17:D5:59:F0:16       Avdongen2
> 
> So my first guess is, there is something wrong when i use hidd so i
> continue to use hcitool. So next i try to connect to the one of the
> devices:
> 
> avdongen@Masahiro :~$ sudo hcitool cc 00:17:D5:59:F0:16
> avdongen@Masahiro:~$ sudo hcitool cc 00:12:37:A7:C8:93
> 
> nothing.. no error, no warning on the either of the phones... so i try
> hidd to connect:
> 
> avdongen@Masahiro:~$ sudo hidd --connect 00:17:D5:59:F0:16
> avdongen@Masahiro:~$ sudo hidd --connect 00:12:37:A7:C8:93
> Can't connect: Connection reset by peer (104)
> 
> Finally some reaction, the Samsung doesn't do anything but the MDA asks me
> if my machine is allowed to connect and then asks me for a pin. I enter
> 1234 (this also the default in in my bluetooth config) but then i get the
> connection reset by peer error.

I know very little about bluez, but in my experience
after you entered the passkey on the phone,
you should have been asked on the computer to enter the same passkey.

Under Fedora-7 (which I run)
this facility is provided by bluez-gnome,
which creates an applet in the panel.
When you enter the passkey in the phone
the applet comes alive and asks you for the passkey on the computer.


-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
