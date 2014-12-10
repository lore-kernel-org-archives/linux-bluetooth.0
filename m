Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
References: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
Date: Wed, 10 Dec 2014 10:08:16 +0200
Message-ID: <CABBYNZ+rkWVGF2c340xSohLqrkQriK2fDgVkgqVe1AMZP5Bbyw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/8] Define TS-approved "small database"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wed, Dec 10, 2014 at 1:08 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> This patch set's main goal is to add the small source database as defined
> by page 24 of the GATT Test Spec.
>
> It also adds improvements to bt_string_to_uuid to ease defined service UUID
> strings, and some minor simplification of the existing test data.
>
> Finally it allows the test database used by the IUT to be switched.
>
> v1 -> v2:
>   * Refactor UUID compaction patch
>   * Add some tests for compaction
>   * Add Service Discovery by UUID
>   * Add /TP/GAD/SR/BV-02-C test
>
> Michael Janssen (8):
>   lib/uuid: Simplify BT base UUIDs when possible
>   unit/gatt: Define repeated MTU PDUs.
>   unit/gatt: Use source db for server_tests
>   unit/gatt: Add test spec "small test database"
>   unit/gatt: minor fix for test PDUs
>   shared/gatt-db: Add gatt_db_find_by_type_value
>   shared/gatt-server: support Discover by UUID
>   unit/gatt: Add /TP/GAD/SR/BV-02-C test
>
>  lib/uuid.c               |  17 ++-
>  src/shared/gatt-db.c     |  27 +++++
>  src/shared/gatt-db.h     |   7 ++
>  src/shared/gatt-server.c | 107 +++++++++++++++++
>  unit/test-gatt.c         | 295 +++++++++++++++++++++++++++++++++--------------
>  unit/test-uuid.c         |  52 ++++++++-
>  6 files changed, 410 insertions(+), 95 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Patches 1-5 are applied, please not that I have to fix the following
in the first patch:

WARNING:LINE_SPACING: Missing a blank line after declarations
#13: FILE: lib/uuid.c:197:
+ char dummy;
+ if (!is_uuid128(string))

WARNING:LONG_LINE: line over 80 characters
#16: FILE: lib/uuid.c:200:
+ return sscanf(string,
"0000%04hx-0000-1000-8000-00805%1[fF]9%1[bB]34%1[fF]%1[bB]",

WARNING:LINE_SPACING: Missing a blank line after declarations
#132: FILE: unit/test-uuid.c:266:
+ char *testpath;
+ testpath = g_strdup_printf("/uuid/compress/%s",

In case you are wondering this is the output of checkpatch.pl that you
can find in the kernel tree.



-- 
Luiz Augusto von Dentz
