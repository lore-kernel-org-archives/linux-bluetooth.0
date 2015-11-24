Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <484556914.3688034.1448353597364.JavaMail.yahoo@mail.yahoo.com>
References: <CABBYNZKVBHbbYk+YhhG0MQdS7A9nXVrWaD3JvXHork0xT+gjxg@mail.gmail.com>
	<484556914.3688034.1448353597364.JavaMail.yahoo@mail.yahoo.com>
Date: Tue, 24 Nov 2015 11:01:00 +0200
Message-ID: <CABBYNZJ4n8KHMbAKz3idgLmADhO+FFDsGF7JiBdf7Xfq9V_78A@mail.gmail.com>
Subject: Re: bluetoothd crashes when connecting to XiaoMi RC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?B?5p+P5oe/IOW7lg==?= <boyiliao@yahoo.com.tw>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Tue, Nov 24, 2015 at 10:26 AM, 柏懿 廖 <boyiliao@yahoo.com.tw> wrote:
> Hi Luiz Augusto von Dentz,
>
> blcause i used valgrind on raspberri pi, but it couldn't work.
>
>
> bluetoothd[18044]: src/adapter.c:adapter_init() sending read version command
> bluetoothd[18044]: Starting SDP server
> bluetoothd[18044]: src/sdpd-service.c:register_device_id() Adding device id
> record for 0002:1d6b:0246:0520
> disInstr(arm): unhandled instruction: 0xF1010200
>                  cond=15(0xF) 27:20=16(0x10) 4:4=0 3:0=0(0x0)
> ==18044== valgrind: Unrecognised instruction at address 0x4843588.
> ==18044==    at 0x4843588: ??? (in
> /usr/lib/arm-linux-gnueabihf/libcofi_rpi.so)
> ==18044== Your program just tried to execute an instruction that Valgrind
> ==18044== did not recognise.  There are two possible reasons for this.
> ==18044== 1. Your program has a bug and erroneously jumped to a non-code
> ==18044==    location.  If you are running Memcheck and you just saw a
> ==18044==    warning about a bad jump, it's probably your program's fault.
> ==18044== 2. The instruction is legitimate but Valgrind doesn't handle it,
> ==18044==    i.e. it's Valgrind's fault.  If you think this is the case or
> ==18044==    you are not sure, please let us know and we'll try to fix it.
> ==18044== Either way, Valgrind will now raise a SIGILL signal which will
> ==18044== probably kill your program.
> ==18044==
> ==18044== Process terminating with default action of signal 4 (SIGILL)
> ==18044==  Illegal opcode at address 0x4843588
> ==18044==    at 0x4843588: ??? (in
> /usr/lib/arm-linux-gnueabihf/libcofi_rpi.so)
> ==18044==
> ==18044== HEAP SUMMARY:
> ==18044==     in use at exit: 27,453 bytes in 423 blocks
> ==18044==   total heap usage: 2,115 allocs, 1,692 frees, 188,303 bytes
> allocated
> ==18044==
> ==18044== LEAK SUMMARY:
> ==18044==    definitely lost: 0 bytes in 0 blocks
> ==18044==    indirectly lost: 0 bytes in 0 blocks
> ==18044==      possibly lost: 0 bytes in 0 blocks
> ==18044==    still reachable: 27,453 bytes in 423 blocks
> ==18044==         suppressed: 0 bytes in 0 blocks
> ==18044== Reachable blocks (those to which a pointer was found) are not
> shown.
> ==18044== To see them, rerun with: --leak-check=full --show-reachable=yes
> ==18044==
> ==18044== For counts of detected and suppressed errors, rerun with: -v
> ==18044== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 27 from 6)
> Illegal instruction

No top-posting in the mailing list please.

> 1. Do you have another way or tool to trace the  "Segmentation fault" ?

gdb would be another option, in the other hand you may want to try to
reproduce the problem with your laptop/desktop where valgrind is
probably more stable.

> 2. what's the meaning of  "ry running  with upstream ?"

Run using git master branch, if you can't compile for rpi you can use
a laptop/desktop as I suggested above, there have been a couple of
changes to HoG plugin that may or may not help in this case.

-- 
Luiz Augusto von Dentz
