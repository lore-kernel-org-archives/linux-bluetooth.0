Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
References: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
Date: Tue, 6 Jan 2015 15:11:50 -0200
Message-ID: <CABBYNZ+1oXAorZAJZrp-ASq_ZM-GmxT1wO5rFed7GVLMs7ZYzg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 00/12] Add TS Large Databases, more server tests.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Mon, Jan 5, 2015 at 7:32 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Adds a "large database" as defined by the test spec, and a set of
> new tests from the test spec.
>
> To support some tests, find_by_type_value is now supported.
>
> gatt_db_find_by_type shares some code with gatt_db_find_by_type_value, and
> callbacks are preferred to queues, so those functions and users have been
> reworked to use callbacks instead.
>
> v1 -> v2:
>  * Rebased to subsume already-commited patches
>  * Switch find_by_type and find_by_type_value to callbacks
>
> Michael Janssen (12):
>   gatt_db: use callback for gatt_db_find_by_type
>   shared/gatt-db: Add gatt_db_find_by_type_value
>   shared/gatt-server: support Discover by UUID
>   unit/gatt: Add Test Spec Large Database 1
>   unit/gatt: Comment cleanup
>   unit/gatt: Add /TP/GAD/SR/BV-02-C test
>   unit/gatt: Add /TP/GAD/SR/BV-03-C test
>   unit/gatt: Add /TP/GAD/SR/BV-04-C test
>   unit/gatt: Add clarifying note about dup tests.
>   unit/gatt: Add /TP/GAD/SR/BV-06-C test
>   unit/gatt: Add /TP/GAR/SR/BV-01-C test
>   unit/gatt: Add /TP/GAR/SR/BI-02-C test
>
>  android/gatt.c           |  85 ++++----
>  src/shared/gatt-client.c |  43 ++--
>  src/shared/gatt-db.c     |  44 +++-
>  src/shared/gatt-db.h     |  21 +-
>  src/shared/gatt-server.c | 103 +++++++++
>  unit/test-gatt.c         | 529 ++++++++++++++++++++++++++++++++++++++++++++++-
>  6 files changed, 742 insertions(+), 83 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Ive applied this set expect for 09/12 since it was not clear which
tests were duplicate to what as you mentioned 4 but I could find only
one being implemented, also please make sure you run the tests with
valgrind, I got the following problem introduced in the very first
patch:

==16068== Conditional jump or move depends on uninitialised value(s)
==16068==    at 0x41C618: init_complete (gatt-client.c:1166)
==16068==    by 0x419C44: discover_descs_cb (gatt-client.c:628)
==16068==    by 0x41658B: discover_descs_cb (gatt-helpers.c:1453)
==16068==    by 0x415D2D: can_read_data (att.c:600)
==16068==    by 0x421BDA: watch_callback (io-glib.c:170)
==16068==    by 0x4E7A2A5: g_main_context_dispatch (in
/usr/lib64/libglib-2.0.so.0.3800.2)
==16068==    by 0x4E7A627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==16068==    by 0x4E7AA39: g_main_loop_run (in
/usr/lib64/libglib-2.0.so.0.3800.2)
==16068==    by 0x413990: test_client (test-gatt.c:601)
==16068==    by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==16068==    by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==16068==    by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==16068==  Uninitialised value was created by a stack allocation
==16068==    at 0x41C5A0: init_complete (gatt-client.c:1150)


-- 
Luiz Augusto von Dentz
