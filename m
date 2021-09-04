Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962EDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E4461051
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 10:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350899AbhIDKDJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Sep 2021 06:03:09 -0400
Received: from mout01.posteo.de ([185.67.36.141]:40523 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235973AbhIDKDI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Sep 2021 06:03:08 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Sep 2021 06:03:08 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 44DB8240027
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Sep 2021 11:54:57 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4H1qlN5NfJz9rxT
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Sep 2021 11:54:56 +0200 (CEST)
Message-ID: <bb969660ab4fac16395cd9796cb1b3b745911789.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/2] shared/util: use 64-bit bitmap in
 util_get/clear_uid
From:   Pauli Virtanen <pav@iki.fi>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Sat, 04 Sep 2021 09:54:56 +0000
In-Reply-To: <CABBYNZKpq5ZjL2JxT2kssOOS1XYqTE7Hm66npst8FbLCd4hvpQ@mail.gmail.com>
References: <20210829155012.164880-1-pav@iki.fi>
         <20210829155012.164880-2-pav@iki.fi>
         <CABBYNZKpq5ZjL2JxT2kssOOS1XYqTE7Hm66npst8FbLCd4hvpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

pe, 2021-09-03 kello 15:59 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Sun, Aug 29, 2021 at 8:52 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > The util_get/clear_uid functions use int type for bitmap, and are used
> > e.g. for SEID allocation. However, valid SEIDs are in range 1 to 0x3E
> > (AVDTP spec v1.3, 8.20.1), and 8*sizeof(int) is often smaller than 0x3E.
> > 
> > The function is also used in src/advertising.c, but an explicit maximum
> > value is always provided, so growing the bitmap size is safe there.
> > 
> > Use 64-bit bitmap instead, to be able to cover the valid range.
> > ---
> >  android/avdtp.c        |  2 +-
> >  profiles/audio/avdtp.c |  2 +-
> >  src/advertising.c      |  2 +-
> >  src/shared/util.c      | 27 +++++++++++++++------------
> >  src/shared/util.h      |  4 ++--
> >  unit/test-avdtp.c      |  2 +-
> >  6 files changed, 21 insertions(+), 18 deletions(-)
> > 
> > diff --git a/android/avdtp.c b/android/avdtp.c
> > index 8c2930ec1..a261a8e5f 100644
> > --- a/android/avdtp.c
> > +++ b/android/avdtp.c
> > @@ -34,7 +34,7 @@
> >  #include "../profiles/audio/a2dp-codecs.h"
> > 
> >  #define MAX_SEID 0x3E
> > -static unsigned int seids;
> > +static uint64_t seids;
> > 
> >  #ifndef MAX
> >  # define MAX(x, y) ((x) > (y) ? (x) : (y))
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index 946231b71..25520ceec 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -44,7 +44,7 @@
> >  #define AVDTP_PSM 25
> > 
> >  #define MAX_SEID 0x3E
> > -static unsigned int seids;
> > +static uint64_t seids;
> > 
> >  #ifndef MAX
> >  # define MAX(x, y) ((x) > (y) ? (x) : (y))
> > diff --git a/src/advertising.c b/src/advertising.c
> > index bd79454d5..41b818650 100644
> > --- a/src/advertising.c
> > +++ b/src/advertising.c
> > @@ -48,7 +48,7 @@ struct btd_adv_manager {
> >         uint8_t max_scan_rsp_len;
> >         uint8_t max_ads;
> >         uint32_t supported_flags;
> > -       unsigned int instance_bitmap;
> > +       uint64_t instance_bitmap;
> >         bool extended_add_cmds;
> >         int8_t min_tx_power;
> >         int8_t max_tx_power;
> > diff --git a/src/shared/util.c b/src/shared/util.c
> > index 244756456..723dedd75 100644
> > --- a/src/shared/util.c
> > +++ b/src/shared/util.c
> > @@ -124,30 +124,33 @@ unsigned char util_get_dt(const char *parent, const char *name)
> > 
> >  /* Helpers for bitfield operations */
> > 
> > -/* Find unique id in range from 1 to max but no bigger then
> > - * sizeof(int) * 8. ffs() is used since it is POSIX standard
> > - */
> > -uint8_t util_get_uid(unsigned int *bitmap, uint8_t max)
> > +/* Find unique id in range from 1 to max but no bigger than 64. */
> > +uint8_t util_get_uid(uint64_t *bitmap, uint8_t max)
> >  {
> >         uint8_t id;
> > 
> > -       id = ffs(~*bitmap);
> 
> Can't we use ffsll instead of using a for loop testing every bit?
> Afaik long long should be at least 64 bits.

Ok, I now see GNU extensions are fine here. I'll use ffsll to make it
simpler.

> > +       if (max > 64)
> > +               max = 64;
> > 
> > -       if (!id || id > max)
> > -               return 0;
> > +       for (id = 1; id <= max; ++id) {
> > +               uint64_t mask = ((uint64_t)1) << (id - 1);
> > 
> > -       *bitmap |= 1u << (id - 1);
> > +               if (!(*bitmap & mask)) {
> > +                       *bitmap |= mask;
> > +                       return id;
> > +               }
> > +       }
> > 
> > -       return id;
> > +       return 0;
> >  }
> > 
> >  /* Clear id bit in bitmap */
> > -void util_clear_uid(unsigned int *bitmap, uint8_t id)
> > +void util_clear_uid(uint64_t *bitmap, uint8_t id)
> >  {
> > -       if (!id)
> > +       if (id == 0 || id > 64)
> >                 return;
> > 
> > -       *bitmap &= ~(1u << (id - 1));
> > +       *bitmap &= ~(((uint64_t)1) << (id - 1));
> >  }
> > 
> >  static const struct {
> > diff --git a/src/shared/util.h b/src/shared/util.h
> > index 9920b7f76..60908371d 100644
> > --- a/src/shared/util.h
> > +++ b/src/shared/util.h
> > @@ -102,8 +102,8 @@ void util_hexdump(const char dir, const
> > unsigned char *buf, size_t len,
> > 
> >  unsigned char util_get_dt(const char *parent, const char *name);
> > 
> > -uint8_t util_get_uid(unsigned int *bitmap, uint8_t max);
> > -void util_clear_uid(unsigned int *bitmap, uint8_t id);
> > +uint8_t util_get_uid(uint64_t *bitmap, uint8_t max);
> > +void util_clear_uid(uint64_t *bitmap, uint8_t id);
> > 
> >  const char *bt_uuid16_to_str(uint16_t uuid);
> >  const char *bt_uuid32_to_str(uint32_t uuid);
> > diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
> > index f5340d6f3..4e8a68c6b 100644
> > --- a/unit/test-avdtp.c
> > +++ b/unit/test-avdtp.c
> > @@ -550,7 +550,7 @@ static void test_server_seid(gconstpointer
> > data)
> >         struct avdtp_local_sep *sep;
> >         unsigned int i;
> > 
> > -       for (i = 0; i < sizeof(int) * 8; i++) {
> > +       for (i = 0; i < MAX_SEID; i++) {
> >                 sep = avdtp_register_sep(context->lseps,
> > AVDTP_SEP_TYPE_SINK,
> >                                                 AVDTP_MEDIA_TYPE_AU
> > DIO,
> >                                                 0x00, TRUE,
> > &sep_ind, NULL,
> > --
> > 2.31.1
> > 
> 
> 



