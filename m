Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <456937F3.7090107@xmission.com>
Date: Sat, 25 Nov 2006 23:45:07 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] bccmd and usb/uart switching
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

Hey

I am about to switch a bluegiga bluecore4 module from usb to uart/h4 so
I can use it to work on audio stuff using a gumstix. I really can't
afford to brick this thing and documentation is hard to come by... does
it look like

bccmd psset 0x1f9 3
bccmd psset 0x3cd 4

(to change HOST_INTERFACE & INITIAL_BOOTMODE respectively) is what I
need so the module will respond on the uart at 115k with hw flow control?

$ bccmd psread
// PSKEY_BDADDR
&0001 = 0081 bc3e 0080 0007
// PSKEY_LC_MAX_TX_POWER
&0017 = 0014
// PSKEY_TX_GAIN_RAMP
&001d = 3004
// PSKEY_LC_DEFAULT_TX_POWER
&0021 = 000c
// PSKEY_LC_ENHANCED_POWER_TABLE
&0031 = 0784 0000 3fc8 4100 ee00 098b 0000 3fc8 4300 f300 0a93 0000 3fdc
4500 f800 0aa3 0000 3fc8 4800 fd00 09ff 0000 3fd2 4b00 0200 12ff 0000
3fe3 4e00 0700 1eff 0000 3f00 0001 0c00
// PSKEY_DEVICE_NAME
&0108 = 5457 3131
// PSKEY_DFU_ATTRIBUTES
&0136 = 0005
// PSKEY_DFUENC_VMAPP_PK_MODULUS_MSB
&015e = c208 899a 96a2 8dbb 851d 1013 81bf 14c7 9bfe 8b70 6e30 47af 18ec
c19a 64cf a2ca 824b 638e 7bf5 f0eb 4f2b a166 66a0 cf16 86ec 6054 8e9a
67f9 cce7 15bd 1191 116c
// PSKEY_DFUENC_VMAPP_PK_MODULUS_LSB
&015f = c5c1 e4db 80b4 a854 fc02 fb10 bb70 163f 2153 f9aa 120a 4ccf b614
a957 fcd5 d932 9ed9 dfdc ccc3 e769 1ba4 67f8 bca2 0144 661d 1a71 9246
610e d478 39ef 658d 9981
// PSKEY_DFUENC_VMAPP_PK_M_DASH
&0160 = 597f
// PSKEY_DFUENC_VMAPP_PK_R2N_MSB
&0161 = 398b 10ee 48f1 ba7f 134f b237 0b2c 16c6 3267 280d 900c 732e ff8b
f0c6 7d31 7b89 b1bf 161f c3cd a7b3 f087 9a8d d8b5 762f b36d 4e9d 4cfd
4b9c e10f 3987 64d1 44af
// PSKEY_DFUENC_VMAPP_PK_R2N_LSB
&0162 = 6364 2838 c8cf 6307 8617 4f41 1a41 1660 7b0d c08c 108c 1833 8e55
32d6 bff1 3b78 ee31 ec6b 8e49 f12f 4db5 25fa ad12 2561 3604 4674 4370
efe9 beed d103 96df 6bfe
// PSKEY_UART_BAUDRATE
&01be = 01d8
// PSKEY_ANA_FTRIM
&01f6 = 0027
// PSKEY_TXRX_PIO_CONTROL
&0209 = 0002
// PSKEY_TX_PRE_LVL
&0240 = 0001
// PSKEY_RX_SINGLE_ENDED
&0242 = 0001
// PSKEY_MODULE_DESIGN
&025a = 0004
// PSKEY_MOD_MANUF0
&025e = 0002 0001 0000
// PSKEY_MOD_MANUF1
&025f = 000c
// PSKEY_USR35
&02ad = 5457 3131
// PSKEY_MR_TX_CONFIG2
&03ba = ff07
// PSKEY_MR_TX_FILTER_CONFIG
&03bb = aa00 0001
// PSKEY_INITIAL_BOOTMODE
&03cd = 0003
// 0x04b0
&04b0 = 01f9 0268 03cc
// 0x04b2
&04b2 = 01f9 025d 02d0
// 0x04b3
&04b3 = 01f9 025d
// 0x04b4
&04b4 = 01f9 025d
// 0x04b8
&04b8 = 0004
// 0x04b9
&04b9 = 0000
// 0x04ba
&04ba = 0001
// 0x0538
&0538 = 0002
// 0x0539
&0539 = 0001
// 0x053a
&053a = 0002
// 0x0578
&0578 = 0002
// 0x0579
&0579 = 0001
// 0x05b8
&05b8 = 0003
// 0x05b9
&05b9 = 0001

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
