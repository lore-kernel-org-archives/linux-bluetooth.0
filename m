Return-Path: <cyrus@holtmann.org>
References: <20130724045756.GC14367@x220.p-661hnu-f1> <1374651156-19959-1-git-send-email-djcb.bulk@gmail.com> <CAJdJm_P-Zgg+r1Nc2OevfyQ1QkbpgbSYdVV9B-33WEZm=V553w@mail.gmail.com> <87ob9r7vuq.fsf@djcbsoftware.nl> <CAJdJm_Op5rnFqxXq7dVN0m9hWr-Dtt1iwK4KnnGN9YcOGrZ3+A@mail.gmail.com>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib/gatt_service_add: support 128-bit uuids for characteristics
In-reply-to: <CAJdJm_Op5rnFqxXq7dVN0m9hWr-Dtt1iwK4KnnGN9YcOGrZ3+A@mail.gmail.com>
Date: Wed, 24 Jul 2013 21:04:41 +0300
Message-ID: <87li4v7s1y.fsf@djcbsoftware.nl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Was a bit too quick with my updated patch! Anyway...

On 2013-07-24 20:38, anderson.lizardo@openbossa.org wrote:

 > Yes, but 128-bit == 16 bytes, so it should have been 19... but using
 > ATT_MAX_VALUE_LEN is better so you don't have to worry about the exact
 > buffer size anyway (it just needs to fit the data).

 > > ATT_MAX_VALUE_LEN is 512, but it seems to be the maximum size of a
 > > value, rather than the UUID. It's more than enough at least :)

 > The UUID is being saved into an attribute, and attributes have maximum
 > value size of 512, that's why I proposed using this define instead of
 > a hardcoded size.

Oh, I see your point. I'll update the patch.

 > >  > > -       g_assert(h - start_handle == (uint16_t) size);
 > >  > > +       g_assert((uint16_t) (h - start_handle) == (uint16_t) size);
 > >
 > >  > This actually seems unrelated to the patch. Can you put it into a
 > >  > separate patch with the compilation error you got?
 > >
 > > When using 128-bit UUIDs, the start handle ultimately comes from
 > > find_uuid128_avail, which returns 0xffff - nitems + 1 (for the first
 > > item). If I don't explicitly cast it, h - start_handle will be negative
 > > number. So, my patch doesn't really work without this.

 > Ok, the problem is clearer now. "h" is overflowing for 128-bit
 > services because the handle is incremented after each attribute is
 > added so at the end we have: 0xffff + 1 == 0 (h is uint16_t).

 > As it seems more complex to try to remove the overflow without
 > affecting the logic too much, can you try the following change
 > instead:

 > -       g_assert(h - start_handle == (uint16_t) size);
 > +       g_assert(h == 0 || (h - start_handle == (uint16_t) size));

 > In my opinion, the cast you added is dangerous because it will hide
 > the programming bugs that this g_assert() was supposed to catch.

 Sure, will do that, too.
 
 > Given this is a bug on the existing code and not part of the
 > implementation of GATT_OPT_CHR_UUID, please put it into a separate
 > patch. This means you should send 2 patches, the first with this fix
 > and the second with the remaining changes.

Okidoki. I actually split the original patch in two, so their separately
applicable.

Cheers,
Dirk.
  

-- 
Dirk-Jan C. Binnema                  Helsinki, Finland
e:djcb@djcbsoftware.nl           w:www.djcbsoftware.nl
pgp: D09C E664 897D 7D39 5047 A178 E96A C7A1 017D DA3C
