Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex Holland <ah160@student.cs.york.ac.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] File transfer
References: <20040210093353.99692.qmail@web40701.mail.yahoo.com> <200402161104.58753.ah160@student.cs.york.ac.uk> <200402161238.36360.tim@birdsnest.maths.tcd.ie>
In-Reply-To: <200402161238.36360.tim@birdsnest.maths.tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402161256.04985.ah160@student.cs.york.ac.uk>
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
Date: Mon, 16 Feb 2004 12:56:04 +0000

On Monday 16 February 2004 12:38, Timothy Murphy wrote:

> Does KDE Bluetooth use Bluez?
> I looked briefly at the kde-bluetooth archive but couldn't see that
> info.

Yup, it depends on a correctly configured Bluez system to actually work.

> Also, is it necessary to use Konqueror (which I don't)?

Nope, you can run the obex stuff seperately. But I like being able to 
browse sdp:// in Konq.

It has kbtobexclient, which searches for phones then lets you send files 
to them, and an obex server running as a daemon, so you can send files 
to your PC at any time and it'll recieve them (with nice thumbnails, 
and an option to choose where to save). The latest CVS versions also 
have a Qt Pin helper, which is certainly preferable to bluepin (which 
never worked for me).

Other fancy functionality includes serial chat, a systray icon to show 
BT activity, bemused XMMS control, and the ability to have your PC go 
into screensaver lock as soon as your phone/PDA goes out of range, then 
unlock on return. Not everything's 100% yet, but it's maturing very 
quickly.

There's talk of irmc sync stuff through Kitchensync, but I got the 
impression that won't be around for a while yet. It would be great to 
abandon Evolution and Multisync, though.

> Sadly, there does not appear to be a Fedora RPM.

There's been a bit of chatter about it on the mailing list. There's 
certainly some instructions out for building from tarballs on Fedora, 
though possibly not on the main page.

> (Nb KdeBT is unknown to google - is it your abbreviation?)

My abbreviation, sorry. http://kde-bluetooth.sourceforge.net/ is the 
main page, but Sourceforge appears to be screwy at the moment.

Alex Holland
Who isn't being paid by the KDE BT team, just really likes their 
software.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
