Return-Path: <cyrus@holtmann.org>
References: <20130724045756.GC14367@x220.p-661hnu-f1> <1374651156-19959-1-git-send-email-djcb.bulk@gmail.com> <CAJdJm_P-Zgg+r1Nc2OevfyQ1QkbpgbSYdVV9B-33WEZm=V553w@mail.gmail.com>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib/gatt_service_add: support 128-bit uuids for characteristics
Message-ID: <87ob9r7vuq.fsf@djcbsoftware.nl>
In-reply-to: <CAJdJm_P-Zgg+r1Nc2OevfyQ1QkbpgbSYdVV9B-33WEZm=V553w@mail.gmail.com>
Date: Wed, 24 Jul 2013 19:43:06 +0300
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

Thanks for the comments!

On 2013-07-24 13:55, anderson.lizardo@openbossa.org wrote:

 > Hi Dirk-Jan,

 > On Wed, Jul 24, 2013 at 3:32 AM, Dirk-Jan C. Binnema
 > <djcb.bulk@gmail.com> wrote:
 > > @@ -183,10 +189,11 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 > >         uint16_t h = *handle;
 > >         struct attribute *a;
 > >         bt_uuid_t bt_uuid;
 > > -       uint8_t atval[5];
 > > +       uint8_t atval[131];

 > Where "131" comes from? A UUID has 128 bits (i.e. 16 bytes). Anyway, I
 > suggest using atval[ATT_MAX_VALUE_LEN] and not worry about the size
 > here, as long as you pass the exact site to atttrib_db_add(), as you
 > do below.

Well, a little bit below that, there is:
    att_put_uuid(info->uuid, &atval[3]);
so I guessed I need to reserve the three extra bytes; this is also why
it was 5 before, I think. Or?

ATT_MAX_VALUE_LEN is 512, but it seems to be the maximum size of a
value, rather than the UUID. It's more than enough at least :)

 > > -       g_assert(h - start_handle == (uint16_t) size);
 > > +       g_assert((uint16_t) (h - start_handle) == (uint16_t) size);

 > This actually seems unrelated to the patch. Can you put it into a
 > separate patch with the compilation error you got?

When using 128-bit UUIDs, the start handle ultimately comes from
find_uuid128_avail, which returns 0xffff - nitems + 1 (for the first
item). If I don't explicitly cast it, h - start_handle will be negative
number. So, my patch doesn't really work without this.
 
 > My suggestion would be to rename the old one to GATT_OPT_CHR_UUID16
 > and this could be GATT_OPT_CHR_UUID. But as Johan said, this could be
 > in a separate patch.

 > >         GATT_OPT_CHR_PROPS,
 > >         GATT_OPT_CHR_VALUE_CB,
 > >         GATT_OPT_CHR_AUTHENTICATION,

That makes sense -- but as the newcomer here, I'll happily let the
others reach some consensus on what the best naming would be, and I'll
make a patch after that :-)

Cheers,
Dirk.
 
-- 
Dirk-Jan C. Binnema                  Helsinki, Finland
e:djcb@djcbsoftware.nl           w:www.djcbsoftware.nl
pgp: D09C E664 897D 7D39 5047 A178 E96A C7A1 017D DA3C
