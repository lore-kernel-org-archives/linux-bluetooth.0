Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dca64414-003d-235e-0cb8-d6b706f00f83@message-id.googlemail.com>
References: <2992e569-78e1-ea64-52b5-a2df11a6c948@message-id.googlemail.com> <dca64414-003d-235e-0cb8-d6b706f00f83@message-id.googlemail.com>
From: Felipe Tonello <eu@felipetonello.com>
Date: Sun, 28 May 2017 18:55:03 +0100
Message-ID: <CAGrhNMwEi+sHSs2zDVT2PL8HsxEWTthNJSvgO5Qo4+7Paf2OQA@mail.gmail.com>
Subject: Re: [BUG] unit/test-midi spurious failure
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

On Fri, May 26, 2017 at 9:17 AM, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> Hi all,
>
> I get spurious failures in unit/test-midi
>
> Debugging gives:
>
> ALSA SysEx events to Raw BLE packets - init
> ALSA SysEx events to Raw BLE packets - setup
> ALSA SysEx events to Raw BLE packets - setup complete
> ALSA SysEx events to Raw BLE packets - run
> **
> ERROR:unit/test-midi.c:287:compare_events: assertion failed (ev1->data.ext.len == ev2->data.ext.len): (5 == 4)
>
> Program received signal SIGABRT, Aborted.
> 0x00007ffff746a8d7 in raise () from /lib64/libc.so.6
> Missing separate debuginfos, use: zypper install libasound2-debuginfo-1.1.2-1.2.x86_64 libglib-2_0-0-debuginfo-2.48.2-1.10.x86_64 libpcre1-debuginfo-8.33-4.51.x86_64
> (gdb) bt
> #0  0x00007ffff746a8d7 in raise () from /lib64/libc.so.6
> #1  0x00007ffff746bcaa in abort () from /lib64/libc.so.6
> #2  0x00007ffff7b3bbc5 in g_assertion_message () from /usr/lib64/libglib-2.0.so.0
> #3  0x00007ffff7b3bf61 in g_assertion_message_cmpnum () from /usr/lib64/libglib-2.0.so.0
> #4  0x000055555555662c in compare_events (ev1=0x55555575bb20 <event4>, ev2=0x7fffffffe590) at unit/test-midi.c:285
> #5  0x000055555555693b in compare_events_cb (parser=0x7fffffffe660, user_data=0x7fffffffe640) at unit/test-midi.c:577
> #6  0x0000555555556bcb in test_midi_writer (data=0x55555575bb00 <midi4>) at unit/test-midi.c:603
> #7  0x0000555555557878 in run_callback (user_data=0x555555763600) at src/shared/tester.c:415
> #8  0x00007ffff7b18015 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
> #9  0x00007ffff7b18388 in ?? () from /usr/lib64/libglib-2.0.so.0
> #10 0x00007ffff7b1864a in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
> #11 0x0000555555558721 in tester_run () at src/shared/tester.c:830
> #12 0x0000555555556429 in main (argc=1, argv=0x7fffffffe9c8) at unit/test-midi.c:631
> (gdb)
>
> It does not happen every time, but maybe once in 10 runs,
> the assertion failure numbers are different:
> ERROR:unit/test-midi.c:287:compare_events: assertion failed (ev1->data.ext.len == ev2->data.ext.len): (1024 == 1023)
> Aborted (core dumped)
> ERROR:unit/test-midi.c:287:compare_events: assertion failed (ev1->data.ext.len == ev2->data.ext.len): (5 == 4)
> Aborted (core dumped)
>
> About one in four runs fails:
>
> #!/bin/bash
> G=0; B=0;
> for i in `seq 1 1000`; do
>   if unit/test-midi; then
>     G=$((G+1)
>   else
>     B=$((B+1))
>   fi
> done
> echo "good: $G bad: $B"
>
> good: 730 bad: 270
>
> I have no idea what this means, if this is an error in the
> test code or a sign something is wrong with the testing system.
>
> It started to happen with bluez-5.45, still happens with git master.

Does it happen on BlueZ 5.44? If so, then I believe it is a bug in the
MIDI code.

Thanks for finding it out.

Felipe
