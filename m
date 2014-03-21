Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+YY-eMy7dUA75343tDnbuXjjYco1MF5UTv_UEFaC=LXTxQ@mail.gmail.com>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
	<CAN_7+Yb0p2a+uPTdkz8Nf8F3NfWd1bgE_C4W0bgdhsucMO_WoQ@mail.gmail.com>
	<CAN_7+YY-eMy7dUA75343tDnbuXjjYco1MF5UTv_UEFaC=LXTxQ@mail.gmail.com>
Date: Fri, 21 Mar 2014 08:29:08 -0400
Message-ID: <CAJdJm_Pt24MQ5aoAo6=PXp5kkHNG00UR6Kvqprtf7BOUkLf0Dg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 00/62] Cleanup: Byte order
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Mar 21, 2014 at 8:00 AM, Lukasz Rymanowski
<lukasz.rymanowski@gmail.com> wrote:
>>>   * Which 128-bit UUID bit order is being used on android? See
>>>     android/gatt.c (primary_cb function)
>>
>> Android uses 128-bit little endian uuid.
>>
>
> Actually what I wrote is wrong. To be inline with UUID spec it is
> reverse big endian order :)

Actually, just to be precise, there is no such "reverse big endian
order". By the UUID spec, big endian is the canonical order for UUIDs
(I tend to think they are like a "packed" struct with several fields).
It is Bluetooth Core spec that, on GATT context, requires the UUID to
be reversed when sent over the air on ATT packets.

That said, I'm noticing some inconsistencies on the UUID handling
inside Android code, can you clarify/confirm each of them?

1) Profiles that are BR/EDR only (e.g. RFCOMM, PAN, A2DP etc.) are
using uuid_t from lib/sdp.c. This seems fine, as they are much like
existing non-Android code for these profiles.

2) HAL IPC is using "uint8_t[16]". I not sure about the byte order
here, but you confirm it is big endian right?

3) There are a few casts in android/hal-gatt.c: from the HAL IPC UUIDs
to bt_uuid_t (from Android). So it is safe to assume Android uses big
endian for bt_uuid_t?

4) android/gatt.c has a single usage of bt_uuid_t (now from
lib/uuid.h) where it just memcpy() the raw bytes. This is currently
broken upstream for 128-bit UUIDs because lib/uuid.c reverses bytes
internally on little endian systems, but it should be fixed once
remaining Claudio's patches are applied.

5) android/client/if-gatt.c has gatt_uuid_t2str()/gatt_str2bt_uuid_t()
which is assuming bt_uuid_t is in little endian order. This conflicts
with #3...

6) android/hal-utils.h has
bt_uuid_t2str()/btuuid2str()/str2bt_uuid_t() which assume big endian
for bt_uuid_t, so it agrees with #3. But they look very strange. They
are not following the UUID spec regarding UUID parsing.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
