Return-Path: <cyrus@holtmann.org>
Message-ID: <4CEF74BA.4050807@nokia.com>
Date: Fri, 26 Nov 2010 11:50:02 +0300
From: Yuri Ershov <ext-yuri.ershov@nokia.com>
MIME-Version: 1.0
To: "ext Gustavo F. Padovan" <padovan@profusion.mobi>
CC: marcel@holtmann.org, davem@davemloft.net, jprvita@profusion.mobi,
        linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
        andrei.emeltchenko@nokia.com
Subject: Re: [PATCH 1/1] bluetooth: Fix NULL pointer dereference issue
References: <e98b2c6fd02b11300d82577cb54cfdb63e8400d2.1290678703.git.ext-yuri.ershov@nokia.com> <20101125181614.GA25686@vigoh>
In-Reply-To: <20101125181614.GA25686@vigoh>
Content-Type: multipart/alternative;
 boundary="------------060207040007000205080509"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060207040007000205080509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ext Gustavo F. Padovan wrote:
> Hi Yuri,
>
> * Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-11-25 12:55:33 +0300]:
>
>   
>> This patch is an addition to my previous patch for this issue.
>> The problem is in resynchronization between two loops:
>> 1. Main controlling loop (l2cap_connect_req, l2cap_config_req,
>> l2cap_config_rsp, l2cap_disconnect_req, etc.)
>> 2. Loop waiting of BT_CONNECTED state of socket (l2cap_sock_accept,
>> bt_accept_dequeue, etc.).
>> In case of fast sequence of connect/disconnect operations the loop #1
>> makes several cycles, while the loop #2 only has time to make one
>> cycle and it results crash.
>>     
>
> What is the crash point? Can you provide a log?
>
>   
Hello,

There are two situations depending on timing:
1. Dereferencing in "bt_accept_unlink of NULL pointer bt_sk(sk)->parent 
of already freed socket.

[ 3555.897247] Unable to handle kernel NULL pointer dereference at virtual
address 000000bc
[ 3555.915039] pgd = cab9c000
[ 3555.917785] [000000bc] *pgd=8bf3d031, *pte=00000000, *ppte=00000000
[ 3555.928314] Internal error: Oops: 17 [#1] PREEMPT
[ 3555.933044] last sysfs file:
/sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
[ 3555.940734] Modules linked in: wl1271_spi iptable_filter ip_tables rfcomm
sco l2cap xt_IDLETIMER x_tables arc4 ecb crc7 wl1271 mac80211 ]
[ 3555.999786] CPU: 0    Not tainted  (2.6.32.21-13874-g67918ef #65)
[ 3556.005981] PC is at bt_accept_unlink+0x20/0x58 [bluetooth]
[ 3556.011627] LR is at bt_accept_dequeue+0x3c/0xe8 [bluetooth]
[ 3556.017303] pc : [<bf0007fc>]    lr : [<bf000870>]    psr: 68000153
[ 3556.017333] sp : cfa7fea8  ip : df24a95c  fp : bee2eab4
[ 3556.028869] r10: df24ac00  r9 : df24a800  r8 : c8231c00
[ 3556.034118] r7 : df24ad5c  r6 : df24ad5c  r5 : df24a800  r4 : df24a95c
[ 3556.040679] r3 : df24a95c  r2 : 00000000  r1 : 00000000  r0 : df24a800
[ 3556.047241] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment
user
[ 3556.054504] Control: 10c5387d  Table: 8ab9c019  DAC: 00000015
[ 3556.060272] Process l2test (pid: 9298, stack limit = 0xcfa7e2e8)
[ 3556.066314] Stack: (0xcfa7fea8 to 0xcfa80000)
[ 3556.070709] fea0:                   7fffffff df24ac00 cfa7e000 00000001
c8231c00 cfa7e000
[ 3556.078948] fec0: bee2ea8c bf324df8 c04640e0 00000001 ca1bb0c0 c005c0b8
c8231910 c8231910
[ 3556.087158] fee0: c8231c00 00000005 00000000 c8231900 bee2ea6c c026a0a8
0000081f cfa7ffb0
[ 3556.095397] ff00: 4019=4a4 4001e2e0 00001040 c002c2b4 da87e080 ca1bb0c0
c041c5f8 00000002
[ 3556.103607] ff20: 00000000 00000000 cfa7ff4c c005939c c041c5f8 da87e080
000025a4 00000000
[ 3556.111846] ff40: 00000000 00000000 cfa7ff64 c005c47c 00000000 60000053
da87e080 01200011
[ 3556.120086] ff60: bee2ea1c c005e290 df92c480 00000000 dfe6d9c0 df92c480
00000000 c00cc0b4
[ 3556.128295] ff80: 00000000 df92c500 dfe6d9c0 00000000 bee2ea8c bee2ea74
0000011d c002cb24
[ 3556.136535] ffa0: 000147c8 c002c9a0 00000000 bee2ea8c 00000003 bee2ea6c
bee2ea8c 00000001
[ 3556.144744] ffc0: 00000000 bem2ea8c bee2ea74 0000011d 00000005 00014800
000147c8 bee2eab4
[ 3556.152984] ffe0: bee2ea70 bee2ea20 00009f64 4012d6ec 40000050 00000003
00000000 00000000
[ 3556.161285] [<bf0007fc>] (bt_accept_unlink+0x20/0x58 [bluetooth]) from
[<bf000870>] (bt_accept_dequeue+0x3c/0xe8 [bluetooth])
[ 3556.172729] [<bf000870>] (bt_accept_dequeue+0x3c/0xe8 [bluetooth]) from
[<bf324df8>] (l2cap_sock_accept+0x100/0x15c [l2cap])
[ 3556.184082] [<bf324df8>] (l2cap_sock_accept+0x100/0x15c [l2cap]) from
[<c026a0a8>] (sys_accept4+0x120/0x1e0)
[ 3556.193969] [<c026a0a8>] (sys_accept4+0x120/0x1e0) from [<c002c9a0>]
(ret_fast_syscall+0x0/0x2c)
[ 3556.202819] Code: e5813000 e5901164 e580c160 e580c15c (e1d13bbc) 
[ 3556.215393] ---[ end trace f11f032273933575 ]---

This was partially fixed by Andrei Emeltchenko by checking of 
sock_owned_by_user in l2cap_disconnect_req.

2. Attempt of access to non-valid pointer of freed socket.

[  997.846099] Unable to handle kernel paging request at virtual address
65756c62
[  997.853424] pgd = b2680000
[  997.856140] [65756c62] *pgd=00000000
[  997.859771] Internal error: Oops: 5 [#1] PREEMPT
[  997.864410] last sysfs file:
/sys/devices/platform/i2c_omap.2/i2c-2/2-0032/engine1_mode
[  997.872467] Modules linked in: rfcomm sco xt_IDLETIMER x_tables l2cap arc4
ecb wl1271_spi crc7 wl1271 mac80211 cfg80211 pn_pep as3645a ad58xx smiapp
smiaregs board_rm680_camera omap3_isp v4l2_common iovmm omap3_iommu g_nokia
iommu2 iommu fuse mtdswap mtd_blkdevs bridgedriver omaplfb iphb uinput
cmt_speech ssi_protocol cmt hsi_char phonet radio_wl1273 hci_h4p videodev
pvrsrvkm omap_ssi lis3lv02d_i2c mailbox_mach twl5031_aci lis3lv02d
hid_twl4030_vibra leds_lp5523 rtc_twl4030 mailbox media bcm4751_gps ak8974
bhsfh led_class rtc_core input_polldev twl4030_pwrbutton twl4030_keypad
gpio_keys eci ff_memless bluetooth [last unloaded: g_file_storage]
[  997.930175] CPU: 0    Not tainted  (2.6.32.23-13390-g03b424f #314)
[  997.936401] PC is at release_sock+0x5c/0xe4
[  997.940612] LR is at release_sock+0x18/0xe4
[  997.944793] pc : [<b02868d4>]    lr : [<b0286890>]    psr: 60000053
[  997.944824] sp : ba17de88  ip : 00000000  fp : aeff5ab4
[  997.956359] r10: ba16d000  r9 : b33b0c00  r8 : c545d300
[  997.961608] r7 : 65756c62  r6 : ba17c000  r5 : b33b0c00  r4 : b33b0c00
[  997.968170] r3 : 00000000  r2 : ba17c000  r1 : 00000000  r0 : b33b0c00
[  997.974731] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment
user
[  997.981964] Control: 10c5387d  Table: 82680019  DAC: 00000015
[  997.987762] Process l2test (pid: 3973, stack limit = 0xba17c2e8)
[  997.993774] Stack: (0xba17de88 to 0xba17e000)
[  997.998168] de80:                   b33b0c00 b33b0d5c ba16d15c b33b0d5c
c545d300 af000c2c
[  998.006378] dea0: ba17c000 ba16d000 7fffffff 00000001 00000000 ba17c000
c545d300 af16fac4
[  998.014617] dec0: b032d040 00000001 b27416c0 b006427c c545d610 c545d610
00000005 c545d300
[  998.022827] dee0: 00000005 00000000 c545d600 aeff5a6c aeff5a8c b028590c
0000081f ba17dfb0
[  998.031066] df00: 3ac5d490 00001258 3ac5e264 b002d2b4 b2742080 b27416c0
b044c600 00000003
[  998.039276] df20: 00000000 00000000 ba17df4c b00617d8 b044c600 b2742080
000015f1 00000000
[  998.047515] df40: 00000000 00000000 ba17df64 b0064600 00000000 60000053
b2742080 01200011
[  998.055725] df60: aeff5a14 b0066420 cbad2700 00000000 b6e98780 cbad2700
00000000 b00d4698
[  998.063934] df80: 00000000 cbad2480 b6e98780 00015214 000151e0 00000003
0000011d b002db24
[  998.072174] dfa0: aeff5a8c b002d9a0 00015214 000151e0 00000003 aeff5a6c
aeff5a8c 0000000c
[  998.080383] dfc0: 00015214 000151e0 00000003 0000011d 00000000 aeff5a74
aeff5a8c aeff5ab4
[  998.088623] dfe0: aeff5a6c aeff5a18 0000a6f8 3abee76c 40000050 00000003
00000000 00000000
[  998.096923] [<b02868d4>] (release_sock+0x5c/0xe4) from [<af000c2c>]
(bt_accept_dequeue+0xec/0x13c [bluetooth])
[  998.107055] [<af000c2c>] (bt_accept_dequeue+0xec/0x13c [bluetooth]) from
[<af16fac4>] (l2cap_sock_accept+0x148/0x234 [l2cap])
[  998.118469] [<af16fac4>] (l2cap_sock_accept+0x148/0x234 [l2cap]) from
[<b028590c>] (sys_accept4+0x120/0x1e0)
[  998.128356] [<b028590c>] (sys_accept4+0x120/0x1e0) from [<b002d9a0>]
(ret_fast_syscall+0x0/0x2c)
[  998.137207] Code: e5963000 e3130002 0a000000 eb01f2d8 (e5974000) 
[  998.143341] ---[ end trace 2b5f71a75cc62b96 ]---
[  998.148010] Kernel panic - not syncing: Fatal exception in interrupt
[  998.154418] [<b003266c>] (unwind_backtrace+0x0/0x150) from [<b0302cec>]
(panic+0x58/0x130)
[  998.162750] [<b0302cec>] (panic+0x58/0x130) from [<b003107c>]
(die+0x27c/0x2b8)
[  998.170135] [<b003107c>] (die+0x27c/0x2b8) from [<b0033530>]
(__do_kernel_fault+0x64/0x74)
[  998.178466] [<b0033530>] (__do_kernel_fault+0x64/0x74) from [<b03070b8>]
(do_page_fault+0x240/0x258)
[  998.187683] [<b03070b8>] (do_page_fault+0x240/0x258) from [<b002d2b4>]
(do_DataAbort+0x34/0x94)
[  998.196441] [<b002d2b4>] (do_DataAbort+0x34/0x94) from [<b030522c>]
(__dabt_svc+0x4c/0x60)
[  998.204772] Exception stack(0xba17de40 to 0xba17de88)
[  998.209838] de40: b33b0c00 00000000 ba17c000 00000000 b33b0c00 b33b0c00
ba17c000 65756c62
[  998.218078] de60: c545d300 b33b0c00 ba16d000 aeff5ab4 00000000 ba17de88
b0286890 b02868d4
[  998.226318] de80: 60000053 ffffffff
[  998.229858] [<b030522c>] (__dabt_svc+0x4c/0x60) from [<b02868d4>]
(release_sock+0x5c/0xe4)
[  998.238220] [<b02868d4>] (release_sock+0x5c/0xe4) from [<af000c2c>]
(bt_accept_dequeue+0xec/0x13c [bluetooth])
[  998.248352] [<af000c2c>] (bt_accept_dequeue+0xec/0x13c [bluetooth]) from
[<af16fac4>] (l2cap_sock_accept+0x148/0x234 [l2cap])
[  998.259765] [<af16fac4>] (l2cap_sock_accept+0x148/0x234 [l2cap]) from
[<b028590c>] (sys_accept4+0x120/0x1e0)
[  998.269653] [<b028590c>] (sys_accept4+0x120/0x1e0) from [<b002d9a0>]
(ret_fast_syscall+0x0/0x2c)


Regards,
Yuri


--------------060207040007000205080509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
ext Gustavo F. Padovan wrote:
<blockquote cite="mid:20101125181614.GA25686@vigoh" type="cite">
  <pre wrap="">Hi Yuri,

* Yuri Ershov <a class="moz-txt-link-rfc2396E" href="mailto:ext-yuri.ershov@nokia.com">&lt;ext-yuri.ershov@nokia.com&gt;</a> [2010-11-25 12:55:33 +0300]:

  </pre>
  <blockquote type="cite">
    <pre wrap="">This patch is an addition to my previous patch for this issue.
The problem is in resynchronization between two loops:
1. Main controlling loop (l2cap_connect_req, l2cap_config_req,
l2cap_config_rsp, l2cap_disconnect_req, etc.)
2. Loop waiting of BT_CONNECTED state of socket (l2cap_sock_accept,
bt_accept_dequeue, etc.).
In case of fast sequence of connect/disconnect operations the loop #1
makes several cycles, while the loop #2 only has time to make one
cycle and it results crash.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
What is the crash point? Can you provide a log?

  </pre>
</blockquote>
Hello,<br>
<br>
There are two situations depending on timing:<br>
1. Dereferencing in "bt_accept_unlink of NULL pointer
bt_sk(sk)-&gt;parent of already freed socket.<br>
<pre class="bz_comment_text" id="comment_text_0">[ 3555.897247] Unable to handle kernel NULL pointer dereference at virtual
address 000000bc
[ 3555.915039] pgd = cab9c000
[ 3555.917785] [000000bc] *pgd=8bf3d031, *pte=00000000, *ppte=00000000
[ 3555.928314] Internal error: Oops: 17 [#1] PREEMPT
[ 3555.933044] last sysfs file:
/sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
[ 3555.940734] Modules linked in: wl1271_spi iptable_filter ip_tables rfcomm
sco l2cap xt_IDLETIMER x_tables arc4 ecb crc7 wl1271 mac80211 ]
[ 3555.999786] CPU: 0    Not tainted  (2.6.32.21-13874-g67918ef #65)
[ 3556.005981] PC is at bt_accept_unlink+0x20/0x58 [bluetooth]
[ 3556.011627] LR is at bt_accept_dequeue+0x3c/0xe8 [bluetooth]
[ 3556.017303] pc : [&lt;bf0007fc&gt;]    lr : [&lt;bf000870&gt;]    psr: 68000153
[ 3556.017333] sp : cfa7fea8  ip : df24a95c  fp : bee2eab4
[ 3556.028869] r10: df24ac00  r9 : df24a800  r8 : c8231c00
[ 3556.034118] r7 : df24ad5c  r6 : df24ad5c  r5 : df24a800  r4 : df24a95c
[ 3556.040679] r3 : df24a95c  r2 : 00000000  r1 : 00000000  r0 : df24a800
[ 3556.047241] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment
user
[ 3556.054504] Control: 10c5387d  Table: 8ab9c019  DAC: 00000015
[ 3556.060272] Process l2test (pid: 9298, stack limit = 0xcfa7e2e8)
[ 3556.066314] Stack: (0xcfa7fea8 to 0xcfa80000)
[ 3556.070709] fea0:                   7fffffff df24ac00 cfa7e000 00000001
c8231c00 cfa7e000
[ 3556.078948] fec0: bee2ea8c bf324df8 c04640e0 00000001 ca1bb0c0 c005c0b8
c8231910 c8231910
[ 3556.087158] fee0: c8231c00 00000005 00000000 c8231900 bee2ea6c c026a0a8
0000081f cfa7ffb0
[ 3556.095397] ff00: 4019=4a4 4001e2e0 00001040 c002c2b4 da87e080 ca1bb0c0
c041c5f8 00000002
[ 3556.103607] ff20: 00000000 00000000 cfa7ff4c c005939c c041c5f8 da87e080
000025a4 00000000
[ 3556.111846] ff40: 00000000 00000000 cfa7ff64 c005c47c 00000000 60000053
da87e080 01200011
[ 3556.120086] ff60: bee2ea1c c005e290 df92c480 00000000 dfe6d9c0 df92c480
00000000 c00cc0b4
[ 3556.128295] ff80: 00000000 df92c500 dfe6d9c0 00000000 bee2ea8c bee2ea74
0000011d c002cb24
[ 3556.136535] ffa0: 000147c8 c002c9a0 00000000 bee2ea8c 00000003 bee2ea6c
bee2ea8c 00000001
[ 3556.144744] ffc0: 00000000 bem2ea8c bee2ea74 0000011d 00000005 00014800
000147c8 bee2eab4
[ 3556.152984] ffe0: bee2ea70 bee2ea20 00009f64 4012d6ec 40000050 00000003
00000000 00000000
[ 3556.161285] [&lt;bf0007fc&gt;] (bt_accept_unlink+0x20/0x58 [bluetooth]) from
[&lt;bf000870&gt;] (bt_accept_dequeue+0x3c/0xe8 [bluetooth])
[ 3556.172729] [&lt;bf000870&gt;] (bt_accept_dequeue+0x3c/0xe8 [bluetooth]) from
[&lt;bf324df8&gt;] (l2cap_sock_accept+0x100/0x15c [l2cap])
[ 3556.184082] [&lt;bf324df8&gt;] (l2cap_sock_accept+0x100/0x15c [l2cap]) from
[&lt;c026a0a8&gt;] (sys_accept4+0x120/0x1e0)
[ 3556.193969] [&lt;c026a0a8&gt;] (sys_accept4+0x120/0x1e0) from [&lt;c002c9a0&gt;]
(ret_fast_syscall+0x0/0x2c)
[ 3556.202819] Code: e5813000 e5901164 e580c160 e580c15c (e1d13bbc) 
[ 3556.215393] ---[ end trace f11f032273933575 ]---
</pre>
This was partially fixed by Andrei Emeltchenko by checking of
sock_owned_by_user in l2cap_disconnect_req. <br>
<br>
2. Attempt of access to non-valid pointer of freed socket. <br>
<br>
<pre class="bz_comment_text" id="comment_text_11">[  997.846099] Unable to handle kernel paging request at virtual address
65756c62
[  997.853424] pgd = b2680000
[  997.856140] [65756c62] *pgd=00000000
[  997.859771] Internal error: Oops: 5 [#1] PREEMPT
[  997.864410] last sysfs file:
/sys/devices/platform/i2c_omap.2/i2c-2/2-0032/engine1_mode
[  997.872467] Modules linked in: rfcomm sco xt_IDLETIMER x_tables l2cap arc4
ecb wl1271_spi crc7 wl1271 mac80211 cfg80211 pn_pep as3645a ad58xx smiapp
smiaregs board_rm680_camera omap3_isp v4l2_common iovmm omap3_iommu g_nokia
iommu2 iommu fuse mtdswap mtd_blkdevs bridgedriver omaplfb iphb uinput
cmt_speech ssi_protocol cmt hsi_char phonet radio_wl1273 hci_h4p videodev
pvrsrvkm omap_ssi lis3lv02d_i2c mailbox_mach twl5031_aci lis3lv02d
hid_twl4030_vibra leds_lp5523 rtc_twl4030 mailbox media bcm4751_gps ak8974
bhsfh led_class rtc_core input_polldev twl4030_pwrbutton twl4030_keypad
gpio_keys eci ff_memless bluetooth [last unloaded: g_file_storage]
[  997.930175] CPU: 0    Not tainted  (2.6.32.23-13390-g03b424f #314)
[  997.936401] PC is at release_sock+0x5c/0xe4
[  997.940612] LR is at release_sock+0x18/0xe4
[  997.944793] pc : [&lt;b02868d4&gt;]    lr : [&lt;b0286890&gt;]    psr: 60000053
[  997.944824] sp : ba17de88  ip : 00000000  fp : aeff5ab4
[  997.956359] r10: ba16d000  r9 : b33b0c00  r8 : c545d300
[  997.961608] r7 : 65756c62  r6 : ba17c000  r5 : b33b0c00  r4 : b33b0c00
[  997.968170] r3 : 00000000  r2 : ba17c000  r1 : 00000000  r0 : b33b0c00
[  997.974731] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment
user
[  997.981964] Control: 10c5387d  Table: 82680019  DAC: 00000015
[  997.987762] Process l2test (pid: 3973, stack limit = 0xba17c2e8)
[  997.993774] Stack: (0xba17de88 to 0xba17e000)
[  997.998168] de80:                   b33b0c00 b33b0d5c ba16d15c b33b0d5c
c545d300 af000c2c
[  998.006378] dea0: ba17c000 ba16d000 7fffffff 00000001 00000000 ba17c000
c545d300 af16fac4
[  998.014617] dec0: b032d040 00000001 b27416c0 b006427c c545d610 c545d610
00000005 c545d300
[  998.022827] dee0: 00000005 00000000 c545d600 aeff5a6c aeff5a8c b028590c
0000081f ba17dfb0
[  998.031066] df00: 3ac5d490 00001258 3ac5e264 b002d2b4 b2742080 b27416c0
b044c600 00000003
[  998.039276] df20: 00000000 00000000 ba17df4c b00617d8 b044c600 b2742080
000015f1 00000000
[  998.047515] df40: 00000000 00000000 ba17df64 b0064600 00000000 60000053
b2742080 01200011
[  998.055725] df60: aeff5a14 b0066420 cbad2700 00000000 b6e98780 cbad2700
00000000 b00d4698
[  998.063934] df80: 00000000 cbad2480 b6e98780 00015214 000151e0 00000003
0000011d b002db24
[  998.072174] dfa0: aeff5a8c b002d9a0 00015214 000151e0 00000003 aeff5a6c
aeff5a8c 0000000c
[  998.080383] dfc0: 00015214 000151e0 00000003 0000011d 00000000 aeff5a74
aeff5a8c aeff5ab4
[  998.088623] dfe0: aeff5a6c aeff5a18 0000a6f8 3abee76c 40000050 00000003
00000000 00000000
[  998.096923] [&lt;b02868d4&gt;] (release_sock+0x5c/0xe4) from [&lt;af000c2c&gt;]
(bt_accept_dequeue+0xec/0x13c [bluetooth])
[  998.107055] [&lt;af000c2c&gt;] (bt_accept_dequeue+0xec/0x13c [bluetooth]) from
[&lt;af16fac4&gt;] (l2cap_sock_accept+0x148/0x234 [l2cap])
[  998.118469] [&lt;af16fac4&gt;] (l2cap_sock_accept+0x148/0x234 [l2cap]) from
[&lt;b028590c&gt;] (sys_accept4+0x120/0x1e0)
[  998.128356] [&lt;b028590c&gt;] (sys_accept4+0x120/0x1e0) from [&lt;b002d9a0&gt;]
(ret_fast_syscall+0x0/0x2c)
[  998.137207] Code: e5963000 e3130002 0a000000 eb01f2d8 (e5974000) 
[  998.143341] ---[ end trace 2b5f71a75cc62b96 ]---
[  998.148010] Kernel panic - not syncing: Fatal exception in interrupt
[  998.154418] [&lt;b003266c&gt;] (unwind_backtrace+0x0/0x150) from [&lt;b0302cec&gt;]
(panic+0x58/0x130)
[  998.162750] [&lt;b0302cec&gt;] (panic+0x58/0x130) from [&lt;b003107c&gt;]
(die+0x27c/0x2b8)
[  998.170135] [&lt;b003107c&gt;] (die+0x27c/0x2b8) from [&lt;b0033530&gt;]
(__do_kernel_fault+0x64/0x74)
[  998.178466] [&lt;b0033530&gt;] (__do_kernel_fault+0x64/0x74) from [&lt;b03070b8&gt;]
(do_page_fault+0x240/0x258)
[  998.187683] [&lt;b03070b8&gt;] (do_page_fault+0x240/0x258) from [&lt;b002d2b4&gt;]
(do_DataAbort+0x34/0x94)
[  998.196441] [&lt;b002d2b4&gt;] (do_DataAbort+0x34/0x94) from [&lt;b030522c&gt;]
(__dabt_svc+0x4c/0x60)
[  998.204772] Exception stack(0xba17de40 to 0xba17de88)
[  998.209838] de40: b33b0c00 00000000 ba17c000 00000000 b33b0c00 b33b0c00
ba17c000 65756c62
[  998.218078] de60: c545d300 b33b0c00 ba16d000 aeff5ab4 00000000 ba17de88
b0286890 b02868d4
[  998.226318] de80: 60000053 ffffffff
[  998.229858] [&lt;b030522c&gt;] (__dabt_svc+0x4c/0x60) from [&lt;b02868d4&gt;]
(release_sock+0x5c/0xe4)
[  998.238220] [&lt;b02868d4&gt;] (release_sock+0x5c/0xe4) from [&lt;af000c2c&gt;]
(bt_accept_dequeue+0xec/0x13c [bluetooth])
[  998.248352] [&lt;af000c2c&gt;] (bt_accept_dequeue+0xec/0x13c [bluetooth]) from
[&lt;af16fac4&gt;] (l2cap_sock_accept+0x148/0x234 [l2cap])
[  998.259765] [&lt;af16fac4&gt;] (l2cap_sock_accept+0x148/0x234 [l2cap]) from
[&lt;b028590c&gt;] (sys_accept4+0x120/0x1e0)
[  998.269653] [&lt;b028590c&gt;] (sys_accept4+0x120/0x1e0) from [&lt;b002d9a0&gt;]
(ret_fast_syscall+0x0/0x2c)
</pre>
<br>
Regards,<br>
Yuri<br>
<br>
</body>
</html>

--------------060207040007000205080509--
