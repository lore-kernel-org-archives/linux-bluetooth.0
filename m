Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <412EF0FF.4070200@cs.tcd.ie>
From: Andronikos Nedos <nedosa@cs.tcd.ie>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] hci_usb bug on 2.6 kernels?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 27 Aug 2004 09:29:51 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

When I recently migrated to a 2.6 kernel, my TDK USB bluetooth adapter
stopped working. I could load all the modules fine, but as soon as I
start hcid I got the following error:

Aug 12 10:23:33 mulligans hci_usb_intr_rx_submit: hci0 intr rx submit
failed urb f744f5ec err -28

I've tried a few of the latest kernels, mainly 2.6.7 and the 2.6.8-rc
series and the problem remained.

Yesterday though, I switched my TDK from the USB2 controller to a USB1.1
~ controller and it worked.

I am using gentoo. Appended is the output from lspci:

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20
[EHCI])

/Andronikos
- --
+---------------------------------------------------------------------+
~   _/_/_/_/_/  _/_/_/  __/_/_/_/  Andronikos Nedos
~      _/     _/    _/  _/     _/  Ph.D student, Computer Science
~     _/     _/        _/     _/   Trinity College Dublin
~    _/     _/        _/     _/    tel : +353 (0)1 6081543
~   _/     _/    _/  _/     _/     email: nedosa at cs dot tcd dot ie
~  _/      _/_/_/  __/_/_/_/       http://www.cs.tcd.ie/Andronikos.Nedos/
+---------------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBLvD/VkjeB91Q/7oRAtyWAJ4hUKu3DEgu1HTYQSNbONJSxtiX5gCbBPKh
M/PcsmyQZj1G0A0EPxxT67I=
=gcEj
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
