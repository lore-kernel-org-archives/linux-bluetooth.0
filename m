Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0055C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A1D20879
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 13:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfAJNqD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:46:03 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:59506 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728759AbfAJNqC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 08:46:02 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 7E20C29735
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 13:46:00 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 722B42973D; Thu, 10 Jan 2019 13:46:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202213] New: bluez trunk tests fail with GCC 9 (or with
 -fsanitize=address with GCC 9)
Date:   Thu, 10 Jan 2019 13:45:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mliska@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-202213-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202213

            Bug ID: 202213
           Summary: bluez trunk tests fail with GCC 9 (or with
                    -fsanitize=address with GCC 9)
           Product: Drivers
           Version: 2.5
    Kernel Version: master
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mliska@suse.cz
        Regression: No

As of GCC r259641 there are new sanitizer errors:

$ export CFLAGS='-fsanitize=address -g'
$ make && make test
...

./unit/test-sdp
bluetoothd[24441]: Bluetooth daemon 5.50

/TP/SERVER/SS/BV-01-C/UUID-16 - init
/TP/SERVER/SS/BV-01-C/UUID-16 - setup
/TP/SERVER/SS/BV-01-C/UUID-16 - setup complete
/TP/SERVER/SS/BV-01-C/UUID-16 - run
=================================================================
==24441==ERROR: AddressSanitizer: stack-use-after-scope on address
0x7fffffff1a20 at pc 0x7ffff73fbbd8 bp 0x7fffffff1250 sp 0x7fffffff0a00
READ of size 13 at 0x7fffffff1a20 thread T0
    #0 0x7ffff73fbbd7 in __interceptor_memcpy
/home/marxin/Programming/gcc/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:790
    #1 0x404431 in send_pdu unit/test-sdp.c:204
    #2 0x7ffff7ed8626  (/usr/lib64/libglib-2.0.so.0+0x4d626)
    #3 0x7ffff7edbc14 in g_main_context_dispatch
(/usr/lib64/libglib-2.0.so.0+0x50c14)
    #4 0x7ffff7edbfd7  (/usr/lib64/libglib-2.0.so.0+0x50fd7)
    #5 0x7ffff7edc2d1 in g_main_loop_run (/usr/lib64/libglib-2.0.so.0+0x512d1)
    #6 0x4a2783 in mainloop_run src/shared/mainloop-glib.c:79
    #7 0x4a31ee in mainloop_run_with_signal src/shared/mainloop-notify.c:201
    #8 0x4a180a in tester_run src/shared/tester.c:870
    #9 0x461163 in main unit/test-sdp.c:2834
    #10 0x7ffff7018fea in __libc_start_main ../csu/libc-start.c:308
    #11 0x4039a9 in _start
(/home/marxin/Programming/bluez/unit/test-sdp+0x4039a9)

Address 0x7fffffff1a20 is located in stack of thread T0 at offset 1392 in frame
    #0 0x40876c in main unit/test-sdp.c:779

  This frame has 590 object(s):
    [48, 49) '<unknown>'
    [64, 66) '<unknown>'
    [80, 82) '<unknown>'
    [96, 98) '<unknown>'
    [112, 114) '<unknown>'
    [128, 131) '<unknown>'
    [144, 147) '<unknown>'
    [160, 164) 'argc' (line 778)
    [176, 181) '<unknown>'
    [208, 213) '<unknown>'
    [240, 246) '<unknown>'
    [272, 279) '<unknown>'
    [304, 311) '<unknown>'
    [336, 343) '<unknown>'
    [368, 375) '<unknown>'
    [400, 407) '<unknown>'
    [432, 439) '<unknown>'
    [464, 471) '<unknown>'
    [496, 503) '<unknown>'
    [528, 535) '<unknown>'
    [560, 567) '<unknown>'
    [592, 599) '<unknown>'
    [624, 631) '<unknown>'
    [656, 663) '<unknown>'
    [688, 695) '<unknown>'
    [720, 727) '<unknown>'
    [752, 759) '<unknown>'
    [784, 791) '<unknown>'
    [816, 824) 'argv' (line 778)
    [848, 857) '<unknown>'
    [880, 889) '<unknown>'
    [912, 922) '<unknown>'
    [944, 954) '<unknown>'
    [976, 986) '<unknown>'
    [1008, 1018) '<unknown>'
    [1040, 1050) '<unknown>'
    [1072, 1082) '<unknown>'
    [1104, 1114) '<unknown>'
    [1136, 1146) '<unknown>'
    [1168, 1178) '<unknown>'
    [1200, 1210) '<unknown>'
    [1232, 1242) '<unknown>'
    [1264, 1274) '<unknown>'
    [1296, 1306) '<unknown>'
    [1328, 1339) '<unknown>'
    [1360, 1372) '<unknown>'
    [1392, 1405) '<unknown>' <== Memory access at offset 1392 is inside this
variable
    [1424, 1437) '<unknown>'
    [1456, 1469) '<unknown>'
    [1488, 1501) '<unknown>'
    [1520, 1533) '<unknown>'
    [1552, 1565) '<unknown>'
    [1584, 1597) '<unknown>'
    [1616, 1629) '<unknown>'
    [1648, 1661) '<unknown>'
    [1680, 1694) '<unknown>'
    [1712, 1726) '<unknown>'
    [1744, 1758) '<unknown>'
    [1776, 1790) '<unknown>'
    [1808, 1822) '<unknown>'
    [1840, 1854) '<unknown>'
    [1872, 1886) '<unknown>'
    [1904, 1918) '<unknown>'
    [1936, 1950) '<unknown>'
    [1968, 1982) '<unknown>'
    [2000, 2014) '<unknown>'
    [2032, 2046) '<unknown>'
    [2064, 2078) '<unknown>'
    [2096, 2110) '<unknown>'
    [2128, 2142) '<unknown>'
    [2160, 2174) '<unknown>'
    [2192, 2206) '<unknown>'
    [2224, 2238) '<unknown>'
    [2256, 2270) '<unknown>'
    [2288, 2302) '<unknown>'
    [2320, 2334) '<unknown>'
    [2352, 2366) '<unknown>'
    [2384, 2398) '<unknown>'
    [2416, 2430) '<unknown>'
    [2448, 2462) '<unknown>'
    [2480, 2494) '<unknown>'
    [2512, 2526) '<unknown>'
    [2544, 2558) '<unknown>'
    [2576, 2590) '<unknown>'
    [2608, 2622) '<unknown>'
    [2640, 2654) '<unknown>'
    [2672, 2686) '<unknown>'
    [2704, 2718) '<unknown>'
    [2736, 2750) '<unknown>'
    [2768, 2782) '<unknown>'
    [2800, 2815) '<unknown>'
    [2832, 2847) '<unknown>'
    [2864, 2879) '<unknown>'
    [2896, 2911) '<unknown>'
    [2928, 2943) '<unknown>'
    [2960, 2975) '<unknown>'
    [2992, 3007) '<unknown>'
    [3024, 3039) '<unknown>'
    [3056, 3071) '<unknown>'
    [3088, 3103) '<unknown>'
    [3120, 3135) '<unknown>'
    [3152, 3167) '<unknown>'
    [3184, 3199) '<unknown>'
    [3216, 3231) '<unknown>'
    [3248, 3263) '<unknown>'
    [3280, 3295) '<unknown>'
    [3312, 3327) '<unknown>'
    [3344, 3359) '<unknown>'
    [3376, 3391) '<unknown>'
    [3408, 3424) '<unknown>'
    [3440, 3456) '<unknown>'
    [3472, 3488) '<unknown>'
    [3504, 3520) '<unknown>'
    [3536, 3552) '<unknown>'
    [3568, 3585) '<unknown>'
    [3632, 3649) '<unknown>'
    [3696, 3713) '<unknown>'
    [3760, 3777) '<unknown>'
    [3824, 3841) '<unknown>'
    [3888, 3905) '<unknown>'
    [3952, 3969) '<unknown>'
    [4016, 4033) '<unknown>'
    [4080, 4097) '<unknown>'
    [4144, 4161) '<unknown>'
    [4208, 4225) '<unknown>'
    [4272, 4289) '<unknown>'
    [4336, 4353) '<unknown>'
    [4400, 4417) '<unknown>'
    [4464, 4481) '<unknown>'
    [4528, 4545) '<unknown>'
    [4592, 4609) '<unknown>'
    [4656, 4673) '<unknown>'
    [4720, 4737) '<unknown>'
    [4784, 4801) '<unknown>'
    [4848, 4865) '<unknown>'
    [4912, 4929) '<unknown>'
    [4976, 4993) '<unknown>'
    [5040, 5057) '<unknown>'
    [5104, 5121) '<unknown>'
    [5168, 5185) '<unknown>'
    [5232, 5249) '<unknown>'
    [5296, 5313) '<unknown>'
    [5360, 5377) '<unknown>'
    [5424, 5441) '<unknown>'
    [5488, 5505) '<unknown>'
    [5552, 5569) '<unknown>'
    [5616, 5633) '<unknown>'
    [5680, 5697) '<unknown>'
    [5744, 5761) '<unknown>'
    [5808, 5825) '<unknown>'
    [5872, 5889) '<unknown>'
    [5936, 5953) '<unknown>'
    [6000, 6017) '<unknown>'
    [6064, 6081) '<unknown>'
    [6128, 6145) '<unknown>'
    [6192, 6209) '<unknown>'
    [6256, 6273) '<unknown>'
    [6320, 6337) '<unknown>'
    [6384, 6401) '<unknown>'
    [6448, 6465) '<unknown>'
    [6512, 6529) '<unknown>'
    [6576, 6593) '<unknown>'
    [6640, 6657) '<unknown>'
    [6704, 6721) '<unknown>'
    [6768, 6785) '<unknown>'
    [6832, 6849) '<unknown>'
    [6896, 6913) '<unknown>'
    [6960, 6977) '<unknown>'
    [7024, 7041) '<unknown>'
    [7088, 7105) '<unknown>'
    [7152, 7169) '<unknown>'
    [7216, 7233) '<unknown>'
    [7280, 7297) '<unknown>'
    [7344, 7361) '<unknown>'
    [7408, 7425) '<unknown>'
    [7472, 7489) '<unknown>'
    [7536, 7553) '<unknown>'
    [7600, 7617) '<unknown>'
    [7664, 7681) '<unknown>'
    [7728, 7745) '<unknown>'
    [7792, 7809) '<unknown>'
    [7856, 7873) '<unknown>'
    [7920, 7937) '<unknown>'
    [7984, 8001) '<unknown>'
    [8048, 8065) '<unknown>'
    [8112, 8129) '<unknown>'
    [8176, 8193) '<unknown>'
    [8240, 8257) '<unknown>'
    [8304, 8321) '<unknown>'
    [8368, 8385) '<unknown>'
    [8432, 8449) '<unknown>'
    [8496, 8513) '<unknown>'
    [8560, 8577) '<unknown>'
    [8624, 8641) '<unknown>'
    [8688, 8706) '<unknown>'
    [8752, 8770) '<unknown>'
    [8816, 8834) '<unknown>'
    [8880, 8898) '<unknown>'
    [8944, 8962) '<unknown>'
    [9008, 9026) '<unknown>'
    [9072, 9090) '<unknown>'
    [9136, 9154) '<unknown>'
    [9200, 9218) '<unknown>'
    [9264, 9282) '<unknown>'
    [9328, 9346) '<unknown>'
    [9392, 9410) '<unknown>'
    [9456, 9474) '<unknown>'
    [9520, 9538) '<unknown>'
    [9584, 9602) '<unknown>'
    [9648, 9666) '<unknown>'
    [9712, 9730) '<unknown>'
    [9776, 9794) '<unknown>'
    [9840, 9858) '<unknown>'
    [9904, 9922) '<unknown>'
    [9968, 9986) '<unknown>'
    [10032, 10050) '<unknown>'
    [10096, 10114) '<unknown>'
    [10160, 10178) '<unknown>'
    [10224, 10242) '<unknown>'
    [10288, 10306) '<unknown>'
    [10352, 10370) '<unknown>'
    [10416, 10434) '<unknown>'
    [10480, 10498) '<unknown>'
    [10544, 10562) '<unknown>'
    [10608, 10626) '<unknown>'
    [10672, 10690) '<unknown>'
    [10736, 10754) '<unknown>'
    [10800, 10818) '<unknown>'
    [10864, 10882) '<unknown>'
    [10928, 10946) '<unknown>'
    [10992, 11010) '<unknown>'
    [11056, 11074) '<unknown>'
    [11120, 11138) '<unknown>'
    [11184, 11202) '<unknown>'
    [11248, 11266) '<unknown>'
    [11312, 11330) '<unknown>'
    [11376, 11394) '<unknown>'
    [11440, 11458) '<unknown>'
    [11504, 11522) '<unknown>'
    [11568, 11586) '<unknown>'
    [11632, 11650) '<unknown>'
    [11696, 11714) '<unknown>'
    [11760, 11778) '<unknown>'
    [11824, 11842) '<unknown>'
    [11888, 11906) '<unknown>'
    [11952, 11970) '<unknown>'
    [12016, 12034) '<unknown>'
    [12080, 12098) '<unknown>'
    [12144, 12162) '<unknown>'
    [12208, 12226) '<unknown>'
    [12272, 12290) '<unknown>'
    [12336, 12354) '<unknown>'
    [12400, 12418) '<unknown>'
    [12464, 12482) '<unknown>'
    [12528, 12546) '<unknown>'
    [12592, 12610) '<unknown>'
    [12656, 12674) '<unknown>'
    [12720, 12738) '<unknown>'
    [12784, 12802) '<unknown>'
    [12848, 12866) '<unknown>'
    [12912, 12930) '<unknown>'
    [12976, 12994) '<unknown>'
    [13040, 13058) '<unknown>'
    [13104, 13122) '<unknown>'
    [13168, 13186) '<unknown>'
    [13232, 13250) '<unknown>'
    [13296, 13314) '<unknown>'
    [13360, 13378) '<unknown>'
    [13424, 13442) '<unknown>'
    [13488, 13506) '<unknown>'
    [13552, 13570) '<unknown>'
    [13616, 13634) '<unknown>'
    [13680, 13698) '<unknown>'
    [13744, 13762) '<unknown>'
    [13808, 13826) '<unknown>'
    [13872, 13890) '<unknown>'
    [13936, 13954) '<unknown>'
    [14000, 14018) '<unknown>'
    [14064, 14082) '<unknown>'
    [14128, 14146) '<unknown>'
    [14192, 14210) '<unknown>'
    [14256, 14274) '<unknown>'
    [14320, 14338) '<unknown>'
    [14384, 14404) '<unknown>'
    [14448, 14468) '<unknown>'
    [14512, 14532) '<unknown>'
    [14576, 14596) '<unknown>'
    [14640, 14660) '<unknown>'
    [14704, 14724) '<unknown>'
    [14768, 14788) '<unknown>'
    [14832, 14852) '<unknown>'
    [14896, 14916) '<unknown>'
    [14960, 14980) '<unknown>'
    [15024, 15044) '<unknown>'
    [15088, 15108) '<unknown>'
    [15152, 15172) '<unknown>'
    [15216, 15236) '<unknown>'
    [15280, 15300) '<unknown>'
    [15344, 15364) '<unknown>'
    [15408, 15428) '<unknown>'
    [15472, 15492) '<unknown>'
    [15536, 15556) '<unknown>'
    [15600, 15620) '<unknown>'
    [15664, 15684) '<unknown>'
    [15728, 15748) '<unknown>'
    [15792, 15812) '<unknown>'
    [15856, 15876) '<unknown>'
    [15920, 15940) '<unknown>'
    [15984, 16004) '<unknown>'
    [16048, 16068) '<unknown>'
    [16112, 16132) '<unknown>'
    [16176, 16196) '<unknown>'
    [16240, 16260) '<unknown>'
    [16304, 16324) '<unknown>'
    [16368, 16388) '<unknown>'
    [16432, 16452) '<unknown>'
    [16496, 16516) '<unknown>'
    [16560, 16580) '<unknown>'
    [16624, 16644) '<unknown>'
    [16688, 16708) '<unknown>'
    [16752, 16772) '<unknown>'
    [16816, 16836) '<unknown>'
    [16880, 16900) '<unknown>'
    [16944, 16964) '<unknown>'
    [17008, 17028) '<unknown>'
    [17072, 17092) '<unknown>'
    [17136, 17156) '<unknown>'
    [17200, 17220) '<unknown>'
    [17264, 17284) '<unknown>'
    [17328, 17348) '<unknown>'
    [17392, 17412) '<unknown>'
    [17456, 17476) '<unknown>'
    [17520, 17540) '<unknown>'
    [17584, 17604) '<unknown>'
    [17648, 17668) '<unknown>'
    [17712, 17733) '<unknown>'
    [17776, 17797) '<unknown>'
    [17840, 17861) '<unknown>'
    [17904, 17926) '<unknown>'
    [17968, 17990) '<unknown>'
    [18032, 18054) '<unknown>'
    [18096, 18119) '<unknown>'
    [18160, 18183) '<unknown>'
    [18224, 18247) '<unknown>'
    [18288, 18311) '<unknown>'
    [18352, 18375) '<unknown>'
    [18416, 18439) '<unknown>'
    [18480, 18504) '<unknown>'
    [18544, 18568) '<unknown>'
    [18608, 18632) '<unknown>'
    [18672, 18696) '<unknown>'
    [18736, 18760) '<unknown>'
    [18800, 18825) '<unknown>'
    [18864, 18889) '<unknown>'
    [18928, 18953) '<unknown>'
    [18992, 19017) '<unknown>'
    [19056, 19081) '<unknown>'
    [19120, 19145) '<unknown>'
    [19184, 19209) '<unknown>'
    [19248, 19274) '<unknown>'
    [19312, 19338) '<unknown>'
    [19376, 19402) '<unknown>'
    [19440, 19466) '<unknown>'
    [19504, 19530) '<unknown>'
    [19568, 19594) '<unknown>'
    [19632, 19658) '<unknown>'
    [19696, 19722) '<unknown>'
    [19760, 19786) '<unknown>'
    [19824, 19850) '<unknown>'
    [19888, 19914) '<unknown>'
    [19952, 19978) '<unknown>'
    [20016, 20042) '<unknown>'
    [20080, 20107) '<unknown>'
    [20144, 20171) '<unknown>'
    [20208, 20235) '<unknown>'
    [20272, 20299) '<unknown>'
    [20336, 20363) '<unknown>'
    [20400, 20427) '<unknown>'
    [20464, 20491) '<unknown>'
    [20528, 20555) '<unknown>'
    [20592, 20619) '<unknown>'
    [20656, 20683) '<unknown>'
    [20720, 20747) '<unknown>'
    [20784, 20811) '<unknown>'
    [20848, 20875) '<unknown>'
    [20912, 20939) '<unknown>'
    [20976, 21003) '<unknown>'
    [21040, 21067) '<unknown>'
    [21104, 21131) '<unknown>'
    [21168, 21195) '<unknown>'
    [21232, 21259) '<unknown>'
    [21296, 21323) '<unknown>'
    [21360, 21387) '<unknown>'
    [21424, 21451) '<unknown>'
    [21488, 21515) '<unknown>'
    [21552, 21579) '<unknown>'
    [21616, 21643) '<unknown>'
    [21680, 21707) '<unknown>'
    [21744, 21771) '<unknown>'
    [21808, 21835) '<unknown>'
    [21872, 21899) '<unknown>'
    [21936, 21963) '<unknown>'
    [22000, 22027) '<unknown>'
    [22064, 22092) '<unknown>'
    [22128, 22156) '<unknown>'
    [22192, 22220) '<unknown>'
    [22256, 22286) '<unknown>'
    [22320, 22350) '<unknown>'
    [22384, 22416) '<unknown>'
    [22448, 22480) '<unknown>'
    [22512, 22544) '<unknown>'
    [22576, 22608) '<unknown>'
    [22640, 22672) '<unknown>'
    [22704, 22736) '<unknown>'
    [22768, 22800) '<unknown>'
    [22832, 22864) '<unknown>'
    [22896, 22928) '<unknown>'
    [22960, 22992) '<unknown>'
    [23024, 23056) '<unknown>'
    [23088, 23120) '<unknown>'
    [23152, 23184) '<unknown>'
    [23216, 23248) '<unknown>'
    [23280, 23312) '<unknown>'
    [23344, 23376) '<unknown>'
    [23408, 23440) '<unknown>'
    [23472, 23504) '<unknown>'
    [23536, 23568) '<unknown>'
    [23600, 23632) '<unknown>'
    [23664, 23696) '<unknown>'
    [23728, 23760) '<unknown>'
    [23792, 23824) '<unknown>'
    [23856, 23888) '<unknown>'
    [23920, 23952) '<unknown>'
    [23984, 24016) '<unknown>'
    [24048, 24080) '<unknown>'
    [24112, 24144) '<unknown>'
    [24176, 24208) '<unknown>'
    [24240, 24272) '<unknown>'
    [24304, 24336) '<unknown>'
    [24368, 24400) '<unknown>'
    [24432, 24466) '<unknown>'
    [24512, 24546) '<unknown>'
    [24592, 24626) '<unknown>'
    [24672, 24707) '<unknown>'
    [24752, 24787) '<unknown>'
    [24832, 24867) '<unknown>'
    [24912, 24948) '<unknown>'
    [24992, 25028) '<unknown>'
    [25072, 25108) '<unknown>'
    [25152, 25190) '<unknown>'
    [25232, 25270) '<unknown>'
    [25312, 25350) '<unknown>'
    [25392, 25430) '<unknown>'
    [25472, 25510) '<unknown>'
    [25552, 25590) '<unknown>'
    [25632, 25670) '<unknown>'
    [25712, 25750) '<unknown>'
    [25792, 25830) '<unknown>'
    [25872, 25910) '<unknown>'
    [25952, 25990) '<unknown>'
    [26032, 26070) '<unknown>'
    [26112, 26154) '<unknown>'
    [26192, 26234) '<unknown>'
    [26272, 26314) '<unknown>'
    [26352, 26394) '<unknown>'
    [26432, 26474) '<unknown>'
    [26512, 26554) '<unknown>'
    [26592, 26682) '<unknown>'
    [26720, 26810) '<unknown>'
    [26848, 26938) '<unknown>'
    [26976, 27066) '<unknown>'
    [27104, 27194) '<unknown>'
    [27232, 27322) '<unknown>'
    [27360, 27456) 'pdus' (line 790)
    [27488, 27584) 'pdus' (line 795)
    [27616, 27712) 'pdus' (line 800)
    [27744, 27840) 'pdus' (line 861)
    [27872, 27968) 'pdus' (line 866)
    [28000, 28096) 'pdus' (line 873)
    [28128, 28224) 'pdus' (line 885)
    [28256, 28352) 'pdus' (line 889)
    [28384, 28480) 'pdus' (line 893)
    [28512, 28608) 'pdus' (line 906)
    [28640, 28736) 'pdus' (line 910)
    [28768, 28864) 'pdus' (line 914)
    [28896, 28992) 'pdus' (line 1359)
    [29024, 29120) 'pdus' (line 1407)
    [29152, 29248) 'pdus' (line 1413)
    [29280, 29376) 'pdus' (line 1419)
    [29408, 29504) 'pdus' (line 1434)
    [29536, 29632) 'pdus' (line 1440)
    [29664, 29760) 'pdus' (line 1446)
    [29792, 29888) 'pdus' (line 1461)
    [29920, 30016) 'pdus' (line 1467)
    [30048, 30144) 'pdus' (line 1473)
    [30176, 30272) 'pdus' (line 1488)
    [30304, 30400) 'pdus' (line 1495)
    [30432, 30528) 'pdus' (line 1502)
    [30560, 30656) 'pdus' (line 1580)
    [30688, 30784) 'pdus' (line 1587)
    [30816, 30912) 'pdus' (line 1594)
    [30944, 31040) 'pdus' (line 1610)
    [31072, 31168) 'pdus' (line 1617)
    [31200, 31296) 'pdus' (line 1624)
    [31328, 31424) 'pdus' (line 1640)
    [31456, 31552) 'pdus' (line 1647)
    [31584, 31680) 'pdus' (line 1654)
    [31712, 31808) 'pdus' (line 1670)
    [31840, 31936) 'pdus' (line 1677)
    [31968, 32064) 'pdus' (line 1684)
    [32096, 32192) 'pdus' (line 1700)
    [32224, 32320) 'pdus' (line 1709)
    [32352, 32448) 'pdus' (line 1718)
    [32480, 32576) 'pdus' (line 1736)
    [32608, 32704) 'pdus' (line 1743)
    [32736, 32832) 'pdus' (line 1750)
    [32864, 32960) 'pdus' (line 1766)
    [32992, 33088) 'pdus' (line 1774)
    [33120, 33216) 'pdus' (line 1782)
    [33248, 33344) 'pdus' (line 1799)
    [33376, 33472) 'pdus' (line 1806)
    [33504, 33600) 'pdus' (line 1813)
    [33632, 33728) 'pdus' (line 1829)
    [33760, 33856) 'pdus' (line 1838)
    [33888, 33984) 'pdus' (line 1847)
    [34016, 34112) 'pdus' (line 2027)
    [34144, 34240) 'pdus' (line 2034)
    [34272, 34368) 'pdus' (line 2041)
    [34400, 34496) 'pdus' (line 2057)
    [34528, 34624) 'pdus' (line 2065)
    [34656, 34752) 'pdus' (line 2073)
    [34784, 34880) 'pdus' (line 2090)
    [34912, 35008) 'pdus' (line 2099)
    [35040, 35136) 'pdus' (line 2108)
    [35168, 35264) 'pdus' (line 2126)
    [35296, 35392) 'pdus' (line 2135)
    [35424, 35520) 'pdus' (line 2144)
    [35552, 35648) 'pdus' (line 2162)
    [35680, 35776) 'pdus' (line 2170)
    [35808, 35904) 'pdus' (line 2178)
    [35936, 36032) 'pdus' (line 2195)
    [36064, 36160) 'pdus' (line 2199)
    [36192, 36288) 'pdus' (line 2204)
    [36320, 36416) 'pdus' (line 2218)
    [36448, 36544) 'pdus' (line 2223)
    [36576, 36672) 'pdus' (line 2228)
    [36704, 36864) 'pdus' (line 814)
    [36928, 37088) 'pdus' (line 826)
    [37152, 37312) 'pdus' (line 838)
    [37376, 37536) 'pdus' (line 926)
    [37600, 37760) 'pdus' (line 975)
    [37824, 37984) 'pdus' (line 994)
    [38048, 38208) 'pdus' (line 1015)
    [38272, 38432) 'pdus' (line 1035)
    [38496, 38656) 'pdus' (line 1055)
    [38720, 38880) 'pdus' (line 1075)
    [38944, 39104) 'pdus' (line 1095)
    [39168, 39328) 'pdus' (line 1114)
    [39392, 39552) 'pdus' (line 1215)
    [39616, 39776) 'pdus' (line 1235)
    [39840, 40000) 'pdus' (line 1255)
    [40064, 40224) 'pdus' (line 1275)
    [40288, 40448) 'pdus' (line 1297)
    [40512, 40672) 'pdus' (line 1319)
    [40736, 40896) 'pdus' (line 1338)
    [40960, 41120) 'pdus' (line 1371)
    [41184, 41344) 'pdus' (line 1388)
    [41408, 41568) 'pdus' (line 1865)
    [41632, 41792) 'pdus' (line 1880)
    [41856, 42016) 'pdus' (line 1895)
    [42080, 42240) 'pdus' (line 1920)
    [42304, 42464) 'pdus' (line 1935)
    [42528, 42688) 'pdus' (line 1950)
    [42752, 42912) 'pdus' (line 1975)
    [42976, 43136) 'pdus' (line 1989)
    [43200, 43360) 'pdus' (line 2003)
    [43424, 43648) 'pdus' (line 1136)
    [43712, 43936) 'pdus' (line 1163)
    [44000, 44224) 'pdus' (line 1189)
    [44288, 44512) 'pdus' (line 1518)
    [44576, 44800) 'pdus' (line 1534)
    [44864, 45088) 'pdus' (line 1550)
    [45152, 45376) 'pdus' (line 2620)
    [45440, 45664) 'pdus' (line 2657)
    [45728, 45952) 'pdus' (line 2694)
    [46016, 46240) 'pdus' (line 2817)
    [46304, 46592) 'pdus' (line 946)
    [46656, 47968) 'pdus' (line 2241)
    [48096, 49408) 'pdus' (line 2363)
    [49536, 50848) 'pdus' (line 2485)
HINT: this may be a false positive if your program uses some custom stack
unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-use-after-scope
/home/marxin/Programming/gcc/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:790
in __interceptor_memcpy
Shadow bytes around the buggy address:
  0x10007fff62f0: f8 f2 f2 f2 f8 f2 f2 f2 f8 f2 00 00 00 f2 00 00
  0x10007fff6300: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
  0x10007fff6310: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
  0x10007fff6320: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
  0x10007fff6330: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
=>0x10007fff6340: f8 f8 00 00[f8]f8 00 00 f8 f8 00 00 f8 f8 00 00
  0x10007fff6350: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
  0x10007fff6360: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
  0x10007fff6370: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
  0x10007fff6380: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
  0x10007fff6390: f8 f8 00 00 f8 f8 00 00 f8 f8 00 00 f8 f8 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==24441==ABORTING

-- 
You are receiving this mail because:
You are the assignee for the bug.
