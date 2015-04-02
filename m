Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
References: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
Date: Wed, 1 Apr 2015 19:51:58 -0700
Message-ID: <CAHrH25SfLmmFdB96ANHSQoMzuc0czP+jFi6rkmc-jgkfF7C+rQ@mail.gmail.com>
Subject: Re: [BlueZ v8 00/10] Implement LE Advertisement D-Bus API
From: Arman Uguray <armansito@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> On Wed, Apr 1, 2015 at 2:09 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Implementation of the LE Advertisement D-Bus API.
>
> Things that are missing still:
>  * Semantics for multiple Advertisements (currently any more than one will fail)
>  * TX Power property parsing / interface
>  * Setting other Flags in the advertisement.
>
> v1 -> v2:
>  * Cleanup based on comments from Arman
>  * Add g_dbus_proxy_set_read_watch function to avoid ObjectManager dependency
>  * Consolidate script updates into single test script
>
> v2 -> v3:
>  * Change "ManufacturerSpecificData" to "ManufacturerData"
>  * Add advertisement-api.txt to EXTRA_DIST
>  * Add Release() callback to org.bluez.LEAdvertisement1
>  * Remove IncludePower from the LEAdvertisement1 API
>
> v3 -> v4:
>  * Rename "g_dbus_proxy_set_read_watch" to "g_dbus_proxy_set_ready_watch"
>
> v4 -> v5:
>  * Rebase
>  * Use g_dbus_client_set_proxy_handlers instead of g_dbus_proxy_set_ready_watch
>  * Add MGMT interface calls to actually advertise.
>
> v5 -> v6:
>  * Minor patch cruft cleanup
>  * Rename btd_advertising_manager to btd_advertising and fix filename change.
>
> v6 -> v7:
>  * Rebase for included patches
>  * Rename ad structure to bt_ad
>  * Fixes for bt_ad_generate bugs
>  * Correctly error for invalid length
>  * Improvements so advertisement-example works out of the box
>
> v7 -> v8:
>  * Rebase
>  * Use eir.h constants instead of local constants
>  * Rename internal structures for brevity
>  * Add null checks
>  * Check for queue_* failures
>  * Address misc other comments
>
> Michael Janssen (10):
>   shared: add bt_ad structure
>   core/advertising: use bt_ad
>   core/advertising: Parse ServiceUUIDs
>   core/advertising: Parse SolicitUUIDs
>   core/advertising: Parse ManufacturerSpecificData
>   core/advertising: Parse ServiceData
>   Update TODO for LE Advertising
>   shared/ad: implement bt_ad_generate
>   core/advertising: Add and Remove AD using MGMT
>   test: improvements to advertising-example
>
>  Makefile.am                |   1 +
>  TODO                       |  20 +-
>  src/advertising.c          | 310 +++++++++++++++++++++++-
>  src/eir.h                  |  12 +
>  src/shared/ad.c            | 584 +++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/ad.h            |  60 +++++
>  test/example-advertisement |  12 +-
>  7 files changed, 972 insertions(+), 27 deletions(-)
>  create mode 100644 src/shared/ad.c
>  create mode 100644 src/shared/ad.h
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm hitting the following memory leak which you should fix:

bluetoothd[16815]: Stopping SDP server
bluetoothd[16815]: Exit
==16815==
==16815== HEAP SUMMARY:
==16815==     in use at exit: 51,901 bytes in 405 blocks
==16815==   total heap usage: 59,785 allocs, 59,380 frees, 15,269,979
bytes allocated
==16815==
==16815== 120 bytes in 5 blocks are definitely lost in loss record 206 of 249
==16815==    at 0x4C2C080: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==16815==    by 0x48F6D6: bt_ad_generate (ad.c:362)
==16815==    by 0x45AE0A: refresh_advertisement (advertising.c:386)
==16815==    by 0x45AE0A: parse_advertisement (advertising.c:444)
==16815==    by 0x45AE0A: advertisement_proxy_added (advertising.c:455)
==16815==    by 0x48C1D7: get_all_properties_reply (client.c:303)
==16815==    by 0x5150DB1: ??? (in /usr/lib/libdbus-1.so.3.8.11)
==16815==    by 0x5154280: dbus_connection_dispatch (in
/usr/lib/libdbus-1.so.3.8.11)
==16815==    by 0x486AAF: message_dispatch (mainloop.c:72)
==16815==    by 0x4E7F62C: g_main_context_dispatch (in
/usr/lib/libglib-2.0.so.0.4200.2)
==16815==    by 0x4E7FA07: ??? (in /usr/lib/libglib-2.0.so.0.4200.2)
==16815==    by 0x4E7FD31: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.4200.2)
==16815==    by 0x40B235: main (main.c:661)
==16815==
==16815== 175 bytes in 5 blocks are definitely lost in loss record 213 of 249
==16815==    at 0x4C2C080: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==16815==    by 0x45AE2F: refresh_advertisement (advertising.c:398)
==16815==    by 0x45AE2F: parse_advertisement (advertising.c:444)
==16815==    by 0x45AE2F: advertisement_proxy_added (advertising.c:455)
==16815==    by 0x48C1D7: get_all_properties_reply (client.c:303)
==16815==    by 0x5150DB1: ??? (in /usr/lib/libdbus-1.so.3.8.11)
==16815==    by 0x5154280: dbus_connection_dispatch (in
/usr/lib/libdbus-1.so.3.8.11)
==16815==    by 0x486AAF: message_dispatch (mainloop.c:72)
==16815==    by 0x4E7F62C: g_main_context_dispatch (in
/usr/lib/libglib-2.0.so.0.4200.2)
==16815==    by 0x4E7FA07: ??? (in /usr/lib/libglib-2.0.so.0.4200.2)
==16815==    by 0x4E7FD31: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.4200.2)
==16815==    by 0x40B235: main (main.c:661)
==16815==
==16815== LEAK SUMMARY:
==16815==    definitely lost: 295 bytes in 10 blocks
==16815==    indirectly lost: 0 bytes in 0 blocks
==16815==      possibly lost: 0 bytes in 0 blocks
==16815==    still reachable: 51,606 bytes in 395 blocks
==16815==         suppressed: 0 bytes in 0 blocks
==16815== Reachable blocks (those to which a pointer was found) are not shown.
==16815== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==16815==
==16815== For counts of detected and suppressed errors, rerun with: -v
==16815== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)


Thanks,
Arman
