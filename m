Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <87ob9r7vuq.fsf@djcbsoftware.nl>
References: <20130724045756.GC14367@x220.p-661hnu-f1>
	<1374651156-19959-1-git-send-email-djcb.bulk@gmail.com>
	<CAJdJm_P-Zgg+r1Nc2OevfyQ1QkbpgbSYdVV9B-33WEZm=V553w@mail.gmail.com>
	<87ob9r7vuq.fsf@djcbsoftware.nl>
Date: Wed, 24 Jul 2013 13:38:50 -0400
Message-ID: <CAJdJm_Op5rnFqxXq7dVN0m9hWr-Dtt1iwK4KnnGN9YcOGrZ3+A@mail.gmail.com>
Subject: Re: [PATCH] attrib/gatt_service_add: support 128-bit uuids for characteristics
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dirk-Jan,

On Wed, Jul 24, 2013 at 12:43 PM, Dirk-Jan C. Binnema
<djcb.bulk@gmail.com> wrote:
>  > On Wed, Jul 24, 2013 at 3:32 AM, Dirk-Jan C. Binnema
>  > <djcb.bulk@gmail.com> wrote:
>  > > @@ -183,10 +189,11 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
>  > >         uint16_t h = *handle;
>  > >         struct attribute *a;
>  > >         bt_uuid_t bt_uuid;
>  > > -       uint8_t atval[5];
>  > > +       uint8_t atval[131];
>
>  > Where "131" comes from? A UUID has 128 bits (i.e. 16 bytes). Anyway, I
>  > suggest using atval[ATT_MAX_VALUE_LEN] and not worry about the size
>  > here, as long as you pass the exact site to atttrib_db_add(), as you
>  > do below.
>
> Well, a little bit below that, there is:
>     att_put_uuid(info->uuid, &atval[3]);
> so I guessed I need to reserve the three extra bytes; this is also why
> it was 5 before, I think. Or?

Yes, but 128-bit == 16 bytes, so it should have been 19... but using
ATT_MAX_VALUE_LEN is better so you don't have to worry about the exact
buffer size anyway (it just needs to fit the data).

>
> ATT_MAX_VALUE_LEN is 512, but it seems to be the maximum size of a
> value, rather than the UUID. It's more than enough at least :)

The UUID is being saved into an attribute, and attributes have maximum
value size of 512, that's why I proposed using this define instead of
a hardcoded size.

>
>  > > -       g_assert(h - start_handle == (uint16_t) size);
>  > > +       g_assert((uint16_t) (h - start_handle) == (uint16_t) size);
>
>  > This actually seems unrelated to the patch. Can you put it into a
>  > separate patch with the compilation error you got?
>
> When using 128-bit UUIDs, the start handle ultimately comes from
> find_uuid128_avail, which returns 0xffff - nitems + 1 (for the first
> item). If I don't explicitly cast it, h - start_handle will be negative
> number. So, my patch doesn't really work without this.

Ok, the problem is clearer now. "h" is overflowing for 128-bit
services because the handle is incremented after each attribute is
added so at the end we have: 0xffff + 1 == 0 (h is uint16_t).

As it seems more complex to try to remove the overflow without
affecting the logic too much, can you try the following change
instead:

-       g_assert(h - start_handle == (uint16_t) size);
+       g_assert(h == 0 || (h - start_handle == (uint16_t) size));

In my opinion, the cast you added is dangerous because it will hide
the programming bugs that this g_assert() was supposed to catch.

Given this is a bug on the existing code and not part of the
implementation of GATT_OPT_CHR_UUID, please put it into a separate
patch. This means you should send 2 patches, the first with this fix
and the second with the remaining changes.

>
>  > My suggestion would be to rename the old one to GATT_OPT_CHR_UUID16
>  > and this could be GATT_OPT_CHR_UUID. But as Johan said, this could be
>  > in a separate patch.
>
>  > >         GATT_OPT_CHR_PROPS,
>  > >         GATT_OPT_CHR_VALUE_CB,
>  > >         GATT_OPT_CHR_AUTHENTICATION,
>
> That makes sense -- but as the newcomer here, I'll happily let the
> others reach some consensus on what the best naming would be, and I'll
> make a patch after that :-)

Johan agreed with the name, so feel free to change the existing
occurrences on the code to use CHR_UUID16 instead.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
