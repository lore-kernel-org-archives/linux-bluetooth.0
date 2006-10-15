Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4532BD75.6050405@xmission.com>
Date: Sun, 15 Oct 2006 17:00:05 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <453296A6.5030505@xmission.com>	<1160943663.14340.10.camel@localhost>
	<4532A5C1.4080504@xmission.com>
	<1160947761.14340.13.camel@localhost>
In-Reply-To: <1160947761.14340.13.camel@localhost>
Subject: Re: [Bluez-devel] pskey gone, but bccmd won't build
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

> Call configure with --enable-bccmd and then call make in the common and
> tools directory. That should work fine.

ok... there must have been some messed up files in my checkout.
re-checking it out resulted in a successful build including bccmd.

I see a few values without a description. If someone knows where I can
look these up, I'd give you a patch.

# ./bccmd -t HCI psread
// PSKEY_BDADDR
&0001 = 00a4 c9a3 0060 0010
// PSKEY_LC_POWER_TABLE
&001e = 0aff fa00 10ff fd00 14ff 0000 1aff 0300 22ff 0600 27ff 0900 30ff
0c00 36ff 0f00 3cff 1200
// PSKEY_LC_DEFAULT_TX_POWER
&0021 = 0006
// PSKEY_FREE_KEY_PIGEON_HOLE
&00c9 = 0001
// PSKEY_LINK_KEY_BD_ADDR0
&00ca = 0002 17a2 003a 000a 2b7e 82f0 0347 5799 227d 4bb6 c85e a3c8
// 0x00dc
&00dc = 006d 0065 0064 002d 0030 0000 0000 0000 0000 0000 0000 0000 0000
0000
// 0x00dd
&00dd = 002e 0063 006f 006d 002d 0030 0000 0000 0000 0000 0000 0000 0000
0000
// 0x00ee
&00ee = 0005
// 0x0191
&0191 = 03b0 00a8 00fa 0014 0004 0000 0004 001e 0064 000a
// PSKEY_ANA_FTRIM
&01f6 = 0023
// PSKEY_HOST_INTERFACE
&01f9 = 0002
// PSKEY_TX_OFFSET_HALF_MHZ
&0217 = fffc
// PSKEY_TX_PRE_LVL
&0240 = 0001
// PSKEY_RX_SINGLE_ENDED
&0242 = 0001
// PSKEY_MODULE_SECURITY_CODE
&025c = 7a55 456d 3555 676d 3976 3a6f 2c53 6340

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
