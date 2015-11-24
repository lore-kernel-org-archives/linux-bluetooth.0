Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1309850050.3963844.1448363624231.JavaMail.yahoo@mail.yahoo.com>
References: <CABBYNZJ4n8KHMbAKz3idgLmADhO+FFDsGF7JiBdf7Xfq9V_78A@mail.gmail.com>
	<1309850050.3963844.1448363624231.JavaMail.yahoo@mail.yahoo.com>
Date: Tue, 24 Nov 2015 13:46:03 +0200
Message-ID: <CABBYNZJWw1vPgbzkLxxV2iMqAY47UV8L-rxRajzUNf4W31E4pg@mail.gmail.com>
Subject: Re: bluetoothd crashes when connecting to XiaoMi RC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?B?5p+P5oe/IOW7lg==?= <boyiliao@yahoo.com.tw>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 24, 2015 at 1:13 PM, 柏懿 廖 <boyiliao@yahoo.com.tw> wrote:
> Hi Luiz Augusto von Dentz,
>
>
>
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> 於 2015/11/24 (週二) 5:01 PM 寫道﹕
>
>
> Hi Patrick,
>
> On Tue, Nov 24, 2015 at 10:26 AM, 柏懿 廖 <boyiliao@yahoo.com.tw> wrote:
>> Hi Luiz Augusto von Dentz,
>>
>> blcause i used valgrind on raspberri pi, but it couldn't work.
>>
>>
>> bluetoothd[18044]: src/adapter.c:adapter_init() sending read version
>> command
>> bluetoothd[18044]: Starting SDP server
>> bluetoothd[18044]: src/sdpd-service.c:register_device_id() Adding device
>> id
>> record for 0002:1d6b:0246:0520
>> disInstr(arm): unhandled instruction: 0xF1010200
>>                  cond=15(0xF) 27:20=16(0x10) 4:4=0 3:0=0(0x0)
>> ==18044== valgrind: Unrecognised instruction at address 0x4843588.
>> ==18044==    at 0x4843588: ??? (in
>> /usr/lib/arm-linux-gnueabihf/libcofi_rpi.so)
>> ==18044== Your program just tried to execute an instruction that Valgrind
>> ==18044== did not recognise.  There are two possible reasons for this.
>> ==18044== 1. Your program has a bug and erroneously jumped to a non-code
>> ==18044==    location.  If you are running Memcheck and you just saw a
>> ==18044==    warning about a bad jump, it's probably your program's fault.
>> ==18044== 2. The instruction is legitimate but Valgrind doesn't handle it,
>> ==18044==    i.e. it's Valgrind's fault.  If you think this is the case or
>> ==18044==    you are not sure, please let us know and we'll try to fix it.
>> ==18044== Either way, Valgrind will now raise a SIGILL signal which will
>> ==18044== probably kill your program.
>> ==18044==
>> ==18044== Process terminating with default action of signal 4 (SIGILL)
>> ==18044==  Illegal opcode at address 0x4843588
>> ==18044==    at 0x4843588: ??? (in
>> /usr/lib/arm-linux-gnueabihf/libcofi_rpi.so)
>> ==18044==
>> ==18044== HEAP SUMMARY:
>> ==18044==    in use at exit: 27,453 bytes in 423 blocks
>> ==18044==  total heap usage: 2,115 allocs, 1,692 frees, 188,303 bytes
>> allocated
>> ==18044==
>> ==18044== LEAK SUMMARY:
>> ==18044==    definitely lost: 0 bytes in 0 blocks
>> ==18044==    indirectly lost: 0 bytes in 0 blocks
>> ==18044==      possibly lost: 0 bytes in 0 blocks
>> ==18044==    still reachable: 27,453 bytes in 423 blocks
>> ==18044==        suppressed: 0 bytes in 0 blocks
>> ==18044== Reachable blocks (those to which a pointer was found) are not
>> shown.
>> ==18044== To see them, rerun with: --leak-check=full --show-reachable=yes
>> ==18044==
>> ==18044== For counts of detected and suppressed errors, rerun with: -v
>> ==18044== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 27 from 6)
>> Illegal instruction
>
> No top-posting in the mailing list please.
>
>> 1. Do you have another way or tool to trace the  "Segmentation fault" ?
>
> gdb would be another option, in the other hand you may want to try to
> reproduce the problem with your laptop/desktop where valgrind is
> probably more stable.
>
>> 2. what's the meaning of  "ry running  with upstream ?"
>
> Run using git master branch, if you can't compile for rpi you can use
> a laptop/desktop as I suggested above, there have been a couple of
> changes to HoG plugin that may or may not help in this case.
>
>
> --
> Luiz Augusto von Dentz
> --
>
>
> i found when running to  hog.c  discover_descriptor_cb function ( ) function
> case "GATT_EXTERNAL_REPORT_REFERENCE" attrib address the memory address will
> be different.
>
> Sorry i didn't have linux x86 to reproduce, i used gdb to trace .
> the message is in the belowm is it enough?
>
>
>>>GATT_REPORT_REFERENCE
>>> discover_descriptor_cb - 249 attrib = 0xca348
>>> gatt_read_char - 861 call g_attrib_ref  attrib = 0xca348
> bluetoothd[19608]: attrib/gattrib.c:g_attrib_ref() 0xca348: g_attrib_ref=6
>>> discover_descriptor_cb - 239 user_data = 0xbe320
>
>  >>GATT_CLIENT_CHARAC_CFG_UUID
>>> discover_descriptor_cb - 241 enable_report_notifications = 0xbe320
>>> gatt_write_char - 967 attrib = 0xca348
>>> buf = >> buf = 0xa >> buf = 0x1b >> buf = 0x0 >> buf = 0x1
>>> discover_descriptor_cb - 256 user_data = 0xbe320
>
>  >>> GATT_EXTERNAL_REPORT_REFERENCE
>>> discover_descriptor_cb - 258 attrib = 0xc2ad0
>>> gatt_read_char - 861 call g_attrib_ref  attrib = 0xc2ad0
> bluetoothd[19608]: attrib/gattrib.c:g_attrib_ref() 0xc2ad0:
> g_attrib_ref=808464433
>
> Program received signal SIGSEGV, Segmentation fault.
> bt_att_get_mtu (att=0x39316132) at src/shared/att.c:1078
> 1078        return att->mtu;
> (gdb) bt
> #0  bt_att_get_mtu (att=0x39316132) at src/shared/att.c:1078
> #1  0x000373f4 in g_attrib_get_buffer (attrib=0xc2ad0, len=0xbefff484) at
> attrib/gattrib.c:448
> #2  0x0003669c in gatt_read_char (attrib=<optimized out>, handle=<optimized
> out>, func=0x32524 <external_report_reference_cb>, user_data=0xbe320) at
> attrib/gatt.c:873
> #3  0x00031a60 in discover_descriptor_cb (status=<optimized out>,
> descs=<optimized out>, user_data=0xbe320) at profiles/input/hog.c:259
> #4  0x000357c8 in desc_discovered_cb (status=<optimized out>,
> ipdu=<optimized out>, iplen=<optimized out>, user_data=0xc2720) at
> attrib/gatt.c:1142
> #5  0x00036e3c in attrib_callback_result (opcode=<optimized out>,
> pdu=0xb9189, length=<optimized out>, user_data=0xc37e8) at
> attrib/gattrib.c:284
> #6  0x0007df28 in handle_rsp (pdu_len=9, pdu=0xb9189 "\001o",
> opcode=<optimized out>, att=0xc0180) at src/shared/att.c:680
> #7  can_read_data (io=<optimized out>, user_data=0xc0180) at
> src/shared/att.c:852
> #8  0x00085d7c in watch_callback (user_data=<optimized out>,
> channel=<optimized out>, cond=<optimized out>) at src/shared/io-glib.c:170
> #9  watch_callback (channel=<optimized out>, cond=<optimized out>,
> user_data=<optimized out>) at src/shared/io-glib.c:158
> #10 0xb6f5eed4 in ?? () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
> #11 0xb6f5eed4 in ?? () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> (gdb)

It is probably fixed by the following patch:

commit 47a337152d342a37e3021dab0b18487b185e8b76
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Jun 27 21:08:58 2014 +0300

    android/hog: Fix using the same callback for different descriptors

    External Report and Report descriptors take different user_data so have
    different callbacks to avoid possible crash if a discover happen to find
    the descriptors of unexpect type.

This was merged into profiles/input/hog-lib.c which is one of the
reasons I was asking you to use the upstream version.


-- 
Luiz Augusto von Dentz
