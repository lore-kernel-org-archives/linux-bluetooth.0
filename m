Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Hilzinger <marcel@hilzinger.hu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] diNovo, once more
References: <200502250934.35817.marcel@hilzinger.hu> <1109578789.17256.17.camel@pegasus>
In-Reply-To: <1109578789.17256.17.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200502281310.14929.marcel@hilzinger.hu>
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
Date: Mon, 28 Feb 2005 13:10:14 +0100

Am Montag, 28. Februar 2005 09:19 schrieb Marcel Holtmann:
> Hi Marcel,
>
> > kernel 2.6.10 with patch -mh4:
> > if you switch from usb to bluetooth-mode, the special keys won't work a=
ny
> > more.
> >
> > They nevertheless work with 2.6.9 and -mh4 for 2.6.9 out-of-the-box.
> >
> > Any idea, where the error is?
>
> I think parts of the input layer got changed. Do you see any messages in
> dmesg of unmapped keycodes?
No.=20
Perhaps this helps: there are two leds on the bluetooth-hub for Capslock an=
d=20
=46-lock. Although Capslock and F-lock can be switched, the leds do not rea=
ct=20
in bluetooth-mode.

=2D-=20
=C3=9Cdv=C3=B6zlettel -- Mit freundlichen Gr=C3=BCssen,
Marcel Hilzinger


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
