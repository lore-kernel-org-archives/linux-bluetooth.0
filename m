Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Mar 2008 09:11:11 +0800
From: "liu_xx" <liu_xx@sina.com>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Message-Id: <20080326011113.1AF5018599@smtp.sina.com.cn>
Subject: [Bluez-devel] Headset has no sound
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0590453532=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0590453532==
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi,everyone

All seems ok, but no sound. I use FC6 OS.
#btsco -v 00:12:A1:00:12:6C :
btsco v0.42
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 8 connected
Using interface hci0

#lsusb
Bus 004 Device 005: ID 1310:0001 Roper Class 1 Bluetooth Dongle

#aplay -D plughw:Headset /usr/share/sounds/shutdown1.wav

I can hear nothing but 'ssss'.  using hcidump can see data sent.

Can anyone give me some ideas? Thanks.




--===============0590453532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0590453532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0590453532==--
