Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+Yb0p2a+uPTdkz8Nf8F3NfWd1bgE_C4W0bgdhsucMO_WoQ@mail.gmail.com>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
	<CAN_7+Yb0p2a+uPTdkz8Nf8F3NfWd1bgE_C4W0bgdhsucMO_WoQ@mail.gmail.com>
Date: Fri, 21 Mar 2014 13:00:42 +0100
Message-ID: <CAN_7+YY-eMy7dUA75343tDnbuXjjYco1MF5UTv_UEFaC=LXTxQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 00/62] Cleanup: Byte order
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Mar 21, 2014 at 12:16 PM, Lukasz Rymanowski
<lukasz.rymanowski@gmail.com> wrote:
> Hi Claudio,
>
> On Thu, Mar 20, 2014 at 3:42 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Apply after "[PATCH BlueZ v5 00/16] Add basic GATT characteristics"
>>
>> This patchset contains the following changes:
>>   * Replace att_get_* and att_put_* by util.h helpers
>>   * Replace bt_get_* and bt_put_* by util.h helpers
>>   * Represent 128-bit bt_uuid_t using BIG-ENDIAN format
>>     (human-readable format)
>>
>> Open issues:
>>   * Remove bt_get_* and bt_put_* from bluetooth.h? ("lib: Remove"
>>     patches can be ignored)
>>   * Which 128-bit UUID bit order is being used on android? See
>>     android/gatt.c (primary_cb function)
>
> Android uses 128-bit little endian uuid.
>

Actually what I wrote is wrong. To be inline with UUID spec it is
reverse big endian order :)

>>   * Should src/shared/util.h be included by lib/ files? IMO, lib should
>>     be "self contained"
>>
>> TODO:
>>   * Replace uint128_t by uint8_t[16]
>>
>> attrib/gatt-service.c and src/attrib-server.c should be removed in the
>> future, there are some repeated definitions of put_uuid_le() that can
>> be moved to a common header file IF necessary.
>>
>> Changing the 128-bit UUID representation makes bt_uuid_t similar to
>> uuid_t. This patchset allows replacing uuid_t in the future.
>>
>> Claudio Takahasi (62):
>>   shared: Add put_le64()
>>   shared: Add get_le16()
>>   shared: Add get_le32()
>>   shared: Add get_le64()
>>   shared: Add get_be16()
>>   shared: Add get_be32()
>>   shared: Add get_be64()
>>   shared: Add put_be16()
>>   shared: Add put_be32()
>>   shared: Add put_be64()
>>   Replace bt_get_le16() by get_le16()
>>   Replace bt_get_le32() by get_le32()
>>   Replace bt_get_le64() by get_le64()
>>   Replace bt_get_be16() by get_be16()
>>   Replace bt_get_be32() by get_be32()
>>   Replace bt_get_be64() by get_be64()
>>   Replace bt_put_be16() by put_be16()
>>   Replace bt_put_be32() by put_be32()
>>   Replace bt_put_be64() by get_be64()
>>   lib: Remove bt_put_le16()
>>   lib: Remove bt_put_le32()
>>   lib: Remove bt_put_le64()
>>   lib: Remove bt_get_le16()
>>   lib: Remove bt_get_le32()
>>   lib: Remove bt_get_le64()
>>   lib: Remove bt_get_be16()
>>   lib: Remove bt_get_be32()
>>   lib: Remove bt_get_be64()
>>   lib: Remove bt_put_be16()
>>   lib: Remove bt_put_be32()
>>   lib: Remove bt_put_be64()
>>   lib: Remove ntoh128() from bt_string_to_uuid128()
>>   lib: Remove hton128() from bt_uuid_to_string()
>>   lib: Fix UUID 16/32-bits to 128-bit conversion
>>   unit: Use lower-case for 128-bit UUIDs
>>   unit: Fix 128-bit UUID format
>>   attrib: Use LE helpers defined in src/shared/util.h
>>   Replace att_get_u32() by get_le32()
>>   Replace att_put_u32() by put_le32()
>>   Replace att_put_uuid16() by put_le16()
>>   Replace att_get_uuid16() by get_le16()
>>   Replace att_get_u16() by get_le16()
>>   Replace att_get_uuid128() by bswap_128()
>>   Replace att_put_uuid() by util.h helpers
>>   Replace att_put_u16() by put_le16()
>>   attrib: Remove att_get_u8()
>>   attrib: Remove att_put_u8()
>>   attrib: Remove att_get_u32()
>>   attrib: Remove att_put_u32()
>>   attrib: Remove att_get_uuid16()
>>   attrib: Remove att_get_u16()
>>   attrib: Remove att_get_uuid128()
>>   attrib: Remove att_get_u128()
>>   attrib: Remove att_put_uuid()
>>   attrib: Remove att_put_uuid128()
>>   attrib: Remove att_put_u128()
>>   attrib: Remove att_put_uuid16()
>>   attrib: Remove att_put_u16()
>>   lib: Use get_unaligned() instead of bt_get_unaligned()
>>   tools: Use unaligned access macros from util.h
>>   lib: Remove bt_get_unaligned()
>>   lib: Remove bt_put_unaligned()
>>
>>  android/android-tester.c             |   3 +-
>>  android/avrcp-lib.c                  |  23 +++---
>>  android/avrcp.c                      |   7 +-
>>  android/bluetooth.c                  |   3 +-
>>  attrib/att.c                         | 148 +++++++++++++++++++++--------------
>>  attrib/att.h                         |  89 ---------------------
>>  attrib/gatt-service.c                |  24 +++---
>>  attrib/gatt.c                        | 112 ++++++++++++++++----------
>>  attrib/gattrib.c                     |   3 +-
>>  attrib/gatttool.c                    |  18 +++--
>>  attrib/interactive.c                 |  18 +++--
>>  lib/bluetooth.h                      | 142 ---------------------------------
>>  lib/sdp.c                            |  83 ++++++++++----------
>>  lib/uuid.c                           |  40 ++++------
>>  monitor/control.c                    |   2 +-
>>  monitor/l2cap.c                      |  92 +++++++++++-----------
>>  monitor/packet.c                     |  46 +++++------
>>  monitor/sdp.c                        |  62 ++++++++-------
>>  plugins/gatt-example.c               |  73 ++++++++---------
>>  profiles/audio/avrcp.c               |  75 +++++++++---------
>>  profiles/cyclingspeed/cyclingspeed.c |  27 ++++---
>>  profiles/deviceinfo/deviceinfo.c     |   5 +-
>>  profiles/gatt/gas.c                  |  13 +--
>>  profiles/heartrate/heartrate.c       |  19 ++---
>>  profiles/input/hog.c                 |   9 ++-
>>  profiles/network/bnep.c              |   9 ++-
>>  profiles/proximity/reporter.c        |   9 ++-
>>  profiles/sap/server.c                |   5 +-
>>  profiles/scanparam/scan.c            |  11 +--
>>  profiles/thermometer/thermometer.c   |  29 +++----
>>  profiles/time/server.c               |   3 +-
>>  src/adapter.c                        |   4 +-
>>  src/attrib-server.c                  |  42 ++++++----
>>  src/eir.c                            |   8 +-
>>  src/sdpd-request.c                   |  40 +++++-----
>>  src/sdpd-service.c                   |  19 ++---
>>  src/shared/util.h                    |  50 ++++++++++++
>>  tools/btmgmt.c                       |  32 ++++----
>>  tools/hciconfig.c                    |   3 +-
>>  tools/l2test.c                       |   4 +-
>>  tools/mgmt-tester.c                  |   3 +-
>>  tools/parser/hci.c                   |   2 +-
>>  tools/parser/l2cap.c                 |  24 +++---
>>  tools/parser/parser.h                |   9 +--
>>  tools/parser/ppp.c                   |   2 +-
>>  unit/test-uuid.c                     |  13 +--
>>  46 files changed, 689 insertions(+), 768 deletions(-)
>>
>> --
>> 1.8.3.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> \Lukasz

\Lukasz
