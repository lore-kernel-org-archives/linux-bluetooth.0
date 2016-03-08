Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1457384483-19894-1-git-send-email-dev@codyps.com>
References: <1457384483-19894-1-git-send-email-dev@codyps.com>
Date: Tue, 8 Mar 2016 16:20:45 +0200
Message-ID: <CABBYNZK9AerksXPwTu7EXpL_BUbQ64JHiHMTdDWLk6cHvRQDSA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] uuid: fix 1 byte stack overflow
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Cody P Schafer <dev@codyps.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cody,

On Mon, Mar 7, 2016 at 11:01 PM, Cody P Schafer <dev@codyps.com> wrote:
> scanf requires that '[' convertion specifiers have enough room for all
> characters in the string, _plus a terminating null byte_. We were
> previously not providing room for the terminating null byte.
>
> This was detected by AddressSanitizer:
>
> ==15036==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffe4e774401 at pc 0x7fd33f572c98 bp 0x7ffe4e774270 sp 0x7ffe4e7739f8
> WRITE of size 2 at 0x7ffe4e774401 thread T0
>     #0 0x7fd33f572c97 in scanf_common /build/gcc-multilib/src/gcc-5-20160209/libsanitizer/sanitizer_common/sanitizer_common_interceptors_format.inc:340
>     #1 0x7fd33f5739ea in __interceptor_vsscanf /build/gcc-multilib/src/gcc-5-20160209/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:769
>     #2 0x7fd33f573b49 in __interceptor_sscanf /build/gcc-multilib/src/gcc-5-20160209/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:793
>     #3 0x650db5 in is_base_uuid128 lib/uuid.c:191
>     #4 0x65196e in bt_string_to_uuid lib/uuid.c:267
>     #5 0x56f28e in parse_uuid src/gatt-database.c:1473
>     #6 0x5729e0 in database_add_service src/gatt-database.c:2053
>     #7 0x57329f in database_add_app src/gatt-database.c:2106
>     #8 0x573adc in client_ready_cb src/gatt-database.c:2211
>     #9 0x6695fd in get_managed_objects_reply gdbus/client.c:1097
>     #10 0x7fd33efd5391  (/usr/lib/libdbus-1.so.3+0x13391)
>     #11 0x7fd33efd8db0 in dbus_connection_dispatch (/usr/lib/libdbus-1.so.3+0x16db0)
>     #12 0x651ecd in message_dispatch gdbus/mainloop.c:72
>     #13 0x7fd33f25cc39 in g_main_context_dispatch (/usr/lib/libglib-2.0.so.0+0x49c39)
>     #14 0x7fd33f25cfdf  (/usr/lib/libglib-2.0.so.0+0x49fdf)
>     #15 0x7fd33f25d301 in g_main_loop_run (/usr/lib/libglib-2.0.so.0+0x4a301)
>     #16 0x54b7d1 in main src/main.c:687
>     #17 0x7fd33d90870f in __libc_start_main (/usr/lib/libc.so.6+0x2070f)
>     #18 0x40bba8 in _start (/home/cody/g/bluez/src/bluetoothd+0x40bba8)
>
> Address 0x7ffe4e774401 is located in stack of thread T0 at offset 33 in frame
>     #0 0x650ccd in is_base_uuid128 lib/uuid.c:184
>
>   This frame has 2 object(s):
>     [32, 33) 'dummy' <== Memory access at offset 33 overflows this variable
>     [96, 98) 'uuid'
> HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
>       (longjmp and C++ exceptions *are* supported)
> SUMMARY: AddressSanitizer: stack-buffer-overflow /build/gcc-multilib/src/gcc-5-20160209/libsanitizer/sanitizer_common/sanitizer_common_interceptors_format.inc:340 scanf_common
> Shadow bytes around the buggy address:
>   0x100049ce6830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x100049ce6840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x100049ce6850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x100049ce6860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x100049ce6870: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
> =>0x100049ce6880:[01]f4 f4 f4 f2 f2 f2 f2 02 f4 f4 f4 f3 f3 f3 f3
>   0x100049ce6890: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
>   0x100049ce68a0: 00 f4 f4 f4 f2 f2 f2 f2 00 00 04 f4 f2 f2 f2 f2
>   0x100049ce68b0: 00 00 00 00 00 00 00 00 00 f4 f4 f4 f3 f3 f3 f3
>   0x100049ce68c0: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
>   0x100049ce68d0: 01 f4 f4 f4 f2 f2 f2 f2 00 00 04 f4 f3 f3 f3 f3
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Heap right redzone:      fb
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack partial redzone:   f4
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
> ==15036==ABORTING
> ---
>  lib/uuid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 20b67d0..ac071fa 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -183,14 +183,14 @@ static inline int is_uuid128(const char *string)
>  static inline int is_base_uuid128(const char *string)
>  {
>         uint16_t uuid;
> -       char dummy;
> +       char dummy[2];
>
>         if (!is_uuid128(string))
>                 return 0;
>
>         return sscanf(string,
>                 "0000%04hx-0000-1000-8000-00805%1[fF]9%1[bB]34%1[fF]%1[bB]",
> -               &uuid, &dummy, &dummy, &dummy, &dummy) == 5;
> +               &uuid, dummy, dummy, dummy, dummy) == 5;
>  }
>
>  static inline int is_uuid32(const char *string)
> --
> 2.7.2

Interesting it seems this has been broken for a while although
valgrind could not detect this invalid access, or perhaps we don't
really execute this code with unit tests. Anyway we could possible add
this tool to be run with make check but I could not find any match for
AddressSanitizer in fedora at least.

-- 
Luiz Augusto von Dentz
