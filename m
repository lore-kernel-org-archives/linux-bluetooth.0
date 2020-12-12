Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8854C4361B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 01:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F772343E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 01:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406208AbgLLBQz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Dec 2020 20:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406035AbgLLBQf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Dec 2020 20:16:35 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33049C0613D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 17:15:55 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q16so11257646edv.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 17:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpOmdNt+E6WQacXryqpvH+UTgJOreSO+9yVAc8yRMxg=;
        b=aPe+clfMLLWzcMyZJz5jPWf+0gb6y48SKLkk1SUUXIe+a5keGIZWnuBz172XGG+KLj
         F+oYweHHZdk0qRFKSNxvSXVFPONmbUEyw2RhDUATypGeKUnUfuKnWUTQJOWm8TZaqb+5
         NC8fZlzSJD8cWkbZrDz/iSAUsfkOs/Ob/uvjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpOmdNt+E6WQacXryqpvH+UTgJOreSO+9yVAc8yRMxg=;
        b=NVUqyjRV2W5G8xISixcT1vPPhRmjQSY4/Z4kMZmLFASKuspS17Hteros83h74n2vWn
         KG4X1TSBI76PttLGdxl/aGO5QqVT4r0OZPVI4RB+OH7bQ3O8RAx508kn+MIW3YPBbaRD
         nLckX1IG4qccAMPj8J7CgktdnRolTVvbwRqyTxG4gGy6GbQgq2bNTfTmafHljwplm69e
         5/g0JPnAoilnag5+8Y9Er8Xf9hCSSmxQ6/3LyenfCsKonDdW0qveRpGrbPQlD/QC7sq0
         CZKoXnf/Bj5Pc5tzkZ97js9AC5l9Vta3i9TjL6O3wFiv6VQW7nXgN5wtd3sJfrf0iuQH
         WVOg==
X-Gm-Message-State: AOAM531DGIueKhOTeXtawcbuWVsVORJBOwysHW5lcq1jUexrO8zHSiY0
        wnRMqpN3pw7ohwhkR/YOSpcMiGuuPHIIqQ==
X-Google-Smtp-Source: ABdhPJzShZQa9wEl7Cw49usbai55aM7UHT5IuDvknALQRluQ/RIw4QZEwGVbSy0P7GUl4hIG+F65tw==
X-Received: by 2002:a05:6402:1692:: with SMTP id a18mr14338484edv.321.1607735753693;
        Fri, 11 Dec 2020 17:15:53 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id s24sm7884757ejb.20.2020.12.11.17.15.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 17:15:53 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id r7so10764699wrc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 17:15:53 -0800 (PST)
X-Received: by 2002:a5d:554a:: with SMTP id g10mr16972516wrw.253.1607735752861;
 Fri, 11 Dec 2020 17:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20201209010030.342632-1-sonnysasaka@chromium.org>
 <20201209010030.342632-2-sonnysasaka@chromium.org> <CABBYNZ+OrbUb8YT8tYuFLVuhuTp9nhMdp_Jc0UyUO2a71rcBbw@mail.gmail.com>
 <CAO271mm503ya0+jcA1u84m-pFsVqk3A+ZWMjUJKitgz8kDreUg@mail.gmail.com> <CABBYNZKBp50EjUKi3fabrLYsctwrvhHvjvEYWCCp_R-132SqCQ@mail.gmail.com>
In-Reply-To: <CABBYNZKBp50EjUKi3fabrLYsctwrvhHvjvEYWCCp_R-132SqCQ@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 11 Dec 2020 17:15:41 -0800
X-Gmail-Original-Message-ID: <CAO271mmV3KeN8VqLro2SmZj9z5ZcsUA2Mfz7BzMPvYT_gjSRfA@mail.gmail.com>
Message-ID: <CAO271mmV3KeN8VqLro2SmZj9z5ZcsUA2Mfz7BzMPvYT_gjSRfA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] input/hog: Cache the HID report map
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

It's already here:
https://patchwork.kernel.org/project/bluetooth/patch/20201211233047.108658-2-sonnysasaka@chromium.org/.

On Fri, Dec 11, 2020 at 5:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Fri, Dec 11, 2020 at 3:32 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > I sent a v2 that changes the cache to use gatt_db. Please take another
> > look. Thanks!
>
> It doesn't seem to have reached the list yet, or perhaps my mail
> server is playing tricks on me.
>
> >
> > On Tue, Dec 8, 2020 at 5:58 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Tue, Dec 8, 2020 at 5:16 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > To optimize BLE HID devices reconnection response, we can cache the
> > > > report map so that the subsequent reconnections do not need round trip
> > > > time to read the report map.
> > >
> > > While the idea is pretty good we need to find a way to persist it
> > > across reboots/restarts. In theory we could save the value on the
> > > gatt_db instance and then make changes to device.c:store_desc to
> > > attempt to read if there is a value stored in the db save it on file
> > > as well so the next time the cache is loaded it should restore the
> > > report map, or any other descriptor that have its value saved in the
> > > database. That said we may need to introduce some sort of property for
> > > values stored in the db since normally the values store in the
> > > database shall not be persisted on file, in fact it would cause a lot
> > > of fime access updating the cache if we were to trigger updates
> > > everytime the db is updated with a value.
> > >
> > > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > >
> > > > ---
> > > >  profiles/input/hog-lib.c | 142 ++++++++++++++++++++++++++-------------
> > > >  1 file changed, 96 insertions(+), 46 deletions(-)
> > > >
> > > > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > > > index ee811d301..1e198ea64 100644
> > > > --- a/profiles/input/hog-lib.c
> > > > +++ b/profiles/input/hog-lib.c
> > > > @@ -95,6 +95,8 @@ struct bt_hog {
> > > >         struct queue            *bas;
> > > >         GSList                  *instances;
> > > >         struct queue            *gatt_op;
> > > > +       uint8_t                 report_map[HOG_REPORT_MAP_MAX_SIZE];
> > > > +       ssize_t                 report_map_len;
> > > >  };
> > > >
> > > >  struct report {
> > > > @@ -276,6 +278,8 @@ static void find_included(struct bt_hog *hog, GAttrib *attrib,
> > > >         free(req);
> > > >  }
> > > >
> > > > +static void uhid_create(struct bt_hog *hog);
> > > > +
> > > >  static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
> > > >  {
> > > >         struct report *report = user_data;
> > > > @@ -924,57 +928,17 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
> > > >         return str;
> > > >  }
> > > >
> > > > -static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > > > -                                                       gpointer user_data)
> > > > +static void uhid_create(struct bt_hog *hog)
> > > >  {
> > > > -       struct gatt_request *req = user_data;
> > > > -       struct bt_hog *hog = req->user_data;
> > > > -       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> > > >         struct uhid_event ev;
> > > > -       ssize_t vlen;
> > > > -       char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> > > > -       int i, err;
> > > >         GError *gerr = NULL;
> > > > +       int i, err;
> > > >
> > > > -       destroy_gatt_req(req);
> > > > -
> > > > -       DBG("HoG inspecting report map");
> > > > -
> > > > -       if (status != 0) {
> > > > -               error("Report Map read failed: %s", att_ecode2str(status));
> > > > -               return;
> > > > -       }
> > > > -
> > > > -       vlen = dec_read_resp(pdu, plen, value, sizeof(value));
> > > > -       if (vlen < 0) {
> > > > -               error("ATT protocol error");
> > > > +       if (!hog->report_map_len) {
> > > > +               warn("Failed to initiate UHID_CREATE without report map");
> > > >                 return;
> > > >         }
> > > >
> > > > -       DBG("Report MAP:");
> > > > -       for (i = 0; i < vlen;) {
> > > > -               ssize_t ilen = 0;
> > > > -               bool long_item = false;
> > > > -
> > > > -               if (get_descriptor_item_info(&value[i], vlen - i, &ilen,
> > > > -                                                               &long_item)) {
> > > > -                       /* Report ID is short item with prefix 100001xx */
> > > > -                       if (!long_item && (value[i] & 0xfc) == 0x84)
> > > > -                               hog->has_report_id = TRUE;
> > > > -
> > > > -                       DBG("\t%s", item2string(itemstr, &value[i], ilen));
> > > > -
> > > > -                       i += ilen;
> > > > -               } else {
> > > > -                       error("Report Map parsing failed at %d", i);
> > > > -
> > > > -                       /* Just print remaining items at once and break */
> > > > -                       DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
> > > > -                       break;
> > > > -               }
> > > > -       }
> > > > -
> > > > -       /* create uHID device */
> > > >         memset(&ev, 0, sizeof(ev));
> > > >         ev.type = UHID_CREATE;
> > > >
> > > > @@ -1004,8 +968,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > > >         ev.u.create.version = hog->version;
> > > >         ev.u.create.country = hog->bcountrycode;
> > > >         ev.u.create.bus = BUS_BLUETOOTH;
> > > > -       ev.u.create.rd_data = value;
> > > > -       ev.u.create.rd_size = vlen;
> > > > +       ev.u.create.rd_data = hog->report_map;
> > > > +       ev.u.create.rd_size = hog->report_map_len;
> > > >
> > > >         err = bt_uhid_send(hog->uhid, &ev);
> > > >         if (err < 0) {
> > > > @@ -1018,6 +982,62 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > > >         bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
> > > >
> > > >         hog->uhid_created = true;
> > > > +}
> > > > +
> > > > +static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > > > +                                                       gpointer user_data)
> > > > +{
> > > > +       struct gatt_request *req = user_data;
> > > > +       struct bt_hog *hog = req->user_data;
> > > > +       ssize_t vlen;
> > > > +       char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> > > > +       int i;
> > > > +
> > > > +       destroy_gatt_req(req);
> > > > +
> > > > +       DBG("HoG inspecting report map");
> > > > +
> > > > +       if (status != 0) {
> > > > +               error("Report Map read failed: %s", att_ecode2str(status));
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       vlen = dec_read_resp(pdu, plen, hog->report_map,
> > > > +                                               sizeof(hog->report_map));
> > > > +       if (vlen < 0) {
> > > > +               error("ATT protocol error");
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       hog->report_map_len = vlen;
> > > > +
> > > > +       DBG("Report MAP:");
> > > > +       for (i = 0; i < vlen;) {
> > > > +               ssize_t ilen = 0;
> > > > +               bool long_item = false;
> > > > +
> > > > +               if (get_descriptor_item_info(&hog->report_map[i], vlen - i,
> > > > +                                               &ilen, &long_item)) {
> > > > +                       /* Report ID is short item with prefix 100001xx */
> > > > +                       if (!long_item && (hog->report_map[i] & 0xfc) == 0x84)
> > > > +                               hog->has_report_id = TRUE;
> > > > +
> > > > +                       DBG("\t%s", item2string(itemstr, &hog->report_map[i],
> > > > +                                                                       ilen));
> > > > +
> > > > +                       i += ilen;
> > > > +               } else {
> > > > +                       error("Report Map parsing failed at %d", i);
> > > > +
> > > > +                       /* Just print remaining items at once and break */
> > > > +                       DBG("\t%s", item2string(itemstr, &hog->report_map[i],
> > > > +                                               vlen - i));
> > > > +                       break;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       /* create uHID device */
> > > > +       uhid_create(hog);
> > > >
> > > >         DBG("HoG created uHID device");
> > > >  }
> > > > @@ -1602,6 +1622,12 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
> > > >                 bt_hog_attach(instance, gatt);
> > > >         }
> > > >
> > > > +       /* Try to initiate UHID_CREATE if we already have the report map to
> > > > +        * avoid re-reading the report map from the peer device.
> > > > +        */
> > > > +       if (hog->report_map_len > 0)
> > > > +               uhid_create(hog);
> > > > +
> > > >         if (!hog->uhid_created) {
> > > >                 DBG("HoG discovering characteristics");
> > > >                 if (hog->attr)
> > > > @@ -1627,6 +1653,29 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
> > > >         return true;
> > > >  }
> > > >
> > > > +static void uhid_destroy(struct bt_hog *hog)
> > > > +{
> > > > +       int err;
> > > > +       struct uhid_event ev;
> > > > +
> > > > +       if (!hog->uhid_created)
> > > > +               return;
> > > > +
> > > > +       bt_uhid_unregister_all(hog->uhid);
> > > > +
> > > > +       memset(&ev, 0, sizeof(ev));
> > > > +       ev.type = UHID_DESTROY;
> > > > +
> > > > +       err = bt_uhid_send(hog->uhid, &ev);
> > > > +
> > > > +       if (err < 0) {
> > > > +               error("bt_uhid_send: %s", strerror(-err));
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       hog->uhid_created = false;
> > > > +}
> > > > +
> > > >  void bt_hog_detach(struct bt_hog *hog)
> > > >  {
> > > >         GSList *l;
> > > > @@ -1660,6 +1709,7 @@ void bt_hog_detach(struct bt_hog *hog)
> > > >         queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
> > > >         g_attrib_unref(hog->attrib);
> > > >         hog->attrib = NULL;
> > > > +       uhid_destroy(hog);
> > > >  }
> > > >
> > > >  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
> > > > --
> > > > 2.26.2
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
