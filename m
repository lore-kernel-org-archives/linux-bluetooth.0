Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787DAC4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C54320578
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440820AbgLNSX7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 13:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440747AbgLNSXx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 13:23:53 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64218C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 10:23:13 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id d17so23886526ejy.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ae+kNVbH1aIpagPksgmhgRzMCj9B3moXQ7s6dQrtjoM=;
        b=e/D2EbdaLjs563ONQPXrvIDti+nIrxa8alEmD2li27wWudzdMTVTH27ruzg+RL7KXe
         ZMjv0G7CC731EwCv53OgOeuTGRXa/8i8elIa1zDttg2rfw44WDQE+gGbh1xjrvCEAq/F
         fD8fbacIBDJ3iRowTuA6vRGD+qKCaWMvWyQ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ae+kNVbH1aIpagPksgmhgRzMCj9B3moXQ7s6dQrtjoM=;
        b=cHHRxX0yRPmmmoJsr6AIKJJ8ak3/rYXpPLkOk1tnNlcVkt+dR2BD9BRBlVZjb+wQ7I
         AP9pMcqvX5YAPZfU0vTiThOS88AUW/jZxIlf2p8X3fx7IiadEyXROsMcyuO8KA98WApQ
         Tgw0E6aY0E7x1h4t+qr1t2NTV/GgRDg2h6DgcWyKgx4Pv/gHhXKNYE26TUnZff5lW1Xg
         m2z14Ij4JjL9XNUPdC4uqMy9cbTZ1fvpL0KWGPbThnb3MZpMtVZ2+xyq9lyJ7agE6xQp
         nGAvdooedBvslhyi1XAKSEKZYMImuf0tFWu6MlxzARZyzLoTPQX3zE0ggsIwmaBTMeBU
         S/vw==
X-Gm-Message-State: AOAM532Kf/x25o4W4Lc10fd95zP9eH/umAP5zfAtpvgG9sZIC+lUHlMf
        l+q9cIp21QpukflcD0yhTZgoimd8sgD5eg==
X-Google-Smtp-Source: ABdhPJxRJc61xyyiX7pf68h3mACZV+EpONHqsY9rvGmrJ8Khe2L7UancGSjGQpMYm69C0G5X8A5+pA==
X-Received: by 2002:a17:906:49c2:: with SMTP id w2mr22635142ejv.12.1607970191830;
        Mon, 14 Dec 2020 10:23:11 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id d3sm12487577edt.32.2020.12.14.10.23.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 10:23:11 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id r3so17435670wrt.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 10:23:11 -0800 (PST)
X-Received: by 2002:adf:c589:: with SMTP id m9mr30094227wrg.370.1607970190968;
 Mon, 14 Dec 2020 10:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20201211233047.108658-1-sonnysasaka@chromium.org>
 <20201211233047.108658-2-sonnysasaka@chromium.org> <CABBYNZ+LG8dPR57c-oY9mkFcy6uxfAvXQj8pTk68MT3Z_ZY3ig@mail.gmail.com>
In-Reply-To: <CABBYNZ+LG8dPR57c-oY9mkFcy6uxfAvXQj8pTk68MT3Z_ZY3ig@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 14 Dec 2020 10:22:59 -0800
X-Gmail-Original-Message-ID: <CAO271m=9+2rxgGmBtLKrRgf8qfk8GDoD-Wrp3N7C_2+Uk-X3qw@mail.gmail.com>
Message-ID: <CAO271m=9+2rxgGmBtLKrRgf8qfk8GDoD-Wrp3N7C_2+Uk-X3qw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] input/hog: Cache the HID report map
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, Dec 14, 2020 at 10:20 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Sat, Dec 12, 2020 at 9:57 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > To optimize BLE HID devices reconnection response, we can cache the
> > report map so that the subsequent reconnections do not need round trip
> > time to read the report map.
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> >
> > ---
> >  profiles/input/hog-lib.c | 142 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 118 insertions(+), 24 deletions(-)
> >
> > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > index ee811d301..e5fef4c7c 100644
> > --- a/profiles/input/hog-lib.c
> > +++ b/profiles/input/hog-lib.c
> > @@ -95,6 +95,13 @@ struct bt_hog {
> >         struct queue            *bas;
> >         GSList                  *instances;
> >         struct queue            *gatt_op;
> > +       struct gatt_db          *gatt_db;
> > +       struct gatt_db_attribute        *report_map_attr;
> > +};
> > +
> > +struct report_map {
> > +       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> > +       size_t  length;
> >  };
> >
> >  struct report {
> > @@ -924,33 +931,16 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
> >         return str;
> >  }
> >
> > -static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > -                                                       gpointer user_data)
> > +static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> > +                                                       ssize_t report_map_len)
> >  {
> > -       struct gatt_request *req = user_data;
> > -       struct bt_hog *hog = req->user_data;
> > -       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> > +       uint8_t *value = report_map;
> >         struct uhid_event ev;
> > -       ssize_t vlen;
> > +       ssize_t vlen = report_map_len;
> >         char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> >         int i, err;
> >         GError *gerr = NULL;
> >
> > -       destroy_gatt_req(req);
> > -
> > -       DBG("HoG inspecting report map");
> > -
> > -       if (status != 0) {
> > -               error("Report Map read failed: %s", att_ecode2str(status));
> > -               return;
> > -       }
> > -
> > -       vlen = dec_read_resp(pdu, plen, value, sizeof(value));
> > -       if (vlen < 0) {
> > -               error("ATT protocol error");
> > -               return;
> > -       }
> > -
> >         DBG("Report MAP:");
> >         for (i = 0; i < vlen;) {
> >                 ssize_t ilen = 0;
> > @@ -1022,6 +1012,43 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> >         DBG("HoG created uHID device");
> >  }
> >
> > +static void db_report_map_write_value_cb(struct gatt_db_attribute *attr,
> > +                                               int err, void *user_data)
> > +{
> > +       if (err)
> > +               error("Error writing report map value to gatt db");
> > +}
> > +
> > +static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > +                                                       gpointer user_data)
> > +{
> > +       struct gatt_request *req = user_data;
> > +       struct bt_hog *hog = req->user_data;
> > +       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> > +       ssize_t vlen;
> > +
> > +       destroy_gatt_req(req);
> > +
> > +       DBG("HoG inspecting report map");
> > +
> > +       if (status != 0) {
> > +               error("Report Map read failed: %s", att_ecode2str(status));
> > +               return;
> > +       }
> > +
> > +       vlen = dec_read_resp(pdu, plen, value, sizeof(value));
> > +       if (vlen < 0) {
> > +               error("ATT protocol error");
> > +               return;
> > +       }
> > +
> > +       uhid_create(hog, value, vlen);
> > +
> > +       /* Cache the report map to optimize reconnection */
> > +       gatt_db_attribute_write(hog->report_map_attr, 0, value, vlen, 0, NULL,
> > +                                       db_report_map_write_value_cb, NULL);
> > +}
> > +
> >  static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> >                                                         gpointer user_data)
> >  {
> > @@ -1269,12 +1296,32 @@ static void foreach_hog_external(struct gatt_db_attribute *attr,
> >                                         external_report_reference_cb, hog);
> >  }
> >
> > +static void db_report_map_read_value_cb(struct gatt_db_attribute *attrib,
> > +                                               int err, const uint8_t *value,
> > +                                               size_t length, void *user_data)
> > +{
> > +       struct report_map *map = user_data;
> > +
> > +       if (err) {
> > +               error("Error reading report map from gatt db %s",
> > +                                                               strerror(-err));
> > +               return;
> > +       }
> > +
> > +       if (!length)
> > +               return;
> > +
> > +       map->length = length < sizeof(map->value) ? length : sizeof(map->value);
> > +       memcpy(map->value, value, map->length);
> > +}
> > +
> >  static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
> >  {
> >         struct bt_hog *hog = user_data;
> >         bt_uuid_t uuid, report_uuid, report_map_uuid, info_uuid;
> >         bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
> >         uint16_t handle, value_handle;
> > +       struct report_map report_map = {0};
> >
> >         gatt_db_attribute_get_char_data(attr, &handle, &value_handle, NULL,
> >                                         NULL, &uuid);
> > @@ -1288,8 +1335,24 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
> >
> >         bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
> >         if (!bt_uuid_cmp(&report_map_uuid, &uuid)) {
> > -               read_char(hog, hog->attrib, value_handle, report_map_read_cb,
> > -                                                                       hog);
> > +
> > +               hog->report_map_attr = gatt_db_get_attribute(hog->gatt_db,
> > +                                                               value_handle);
> > +               gatt_db_attribute_read(hog->report_map_attr, 0,
> > +                                       BT_ATT_OP_READ_REQ, NULL,
> > +                                       db_report_map_read_value_cb,
> > +                                       &report_map);
> > +
> > +               if (report_map.length) {
> > +                       /* Report map found in the cache, straight to creating
> > +                        * UHID to optimize reconnection.
> > +                        */
> > +                       uhid_create(hog, report_map.value, report_map.length);
> > +               } else {
> > +                       read_char(hog, hog->attrib, value_handle,
> > +                                               report_map_read_cb, hog);
> > +               }
> > +
> >                 gatt_db_service_foreach_desc(attr, foreach_hog_external, hog);
> >                 return;
> >         }
> > @@ -1417,6 +1480,8 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
> >                         hog->dis = bt_dis_new(db);
> >                         bt_dis_set_notification(hog->dis, dis_notify, hog);
> >                 }
> > +
> > +               hog->gatt_db = db;
>
> Is this really supposed to be a weak reference?
Yes, I intended it to be a weak reference, I was assuming that gatt_db
is alive as long as hog is alive. Is this assumption not true? Is it
safer to think otherwise?
>
> >         }
> >
> >         return bt_hog_ref(hog);
> > @@ -1612,9 +1677,14 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
> >                                         hog->primary->range.start,
> >                                         hog->primary->range.end, NULL,
> >                                         char_discovered_cb, hog);
> > -               return true;
> >         }
> >
> > +       if (!hog->uhid_created)
> > +               return true;
> > +
> > +       /* If UHID is already created, set up the report value handlers to
> > +        * optimize reconnection.
> > +        */
> >         for (l = hog->reports; l; l = l->next) {
> >                 struct report *r = l->data;
> >
> > @@ -1627,6 +1697,29 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
> >         return true;
> >  }
> >
> > +static void uhid_destroy(struct bt_hog *hog)
> > +{
> > +       int err;
> > +       struct uhid_event ev;
> > +
> > +       if (!hog->uhid_created)
> > +               return;
> > +
> > +       bt_uhid_unregister_all(hog->uhid);
> > +
> > +       memset(&ev, 0, sizeof(ev));
> > +       ev.type = UHID_DESTROY;
> > +
> > +       err = bt_uhid_send(hog->uhid, &ev);
> > +
> > +       if (err < 0) {
> > +               error("bt_uhid_send: %s", strerror(-err));
> > +               return;
> > +       }
> > +
> > +       hog->uhid_created = false;
> > +}
> > +
> >  void bt_hog_detach(struct bt_hog *hog)
> >  {
> >         GSList *l;
> > @@ -1660,6 +1753,7 @@ void bt_hog_detach(struct bt_hog *hog)
> >         queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
> >         g_attrib_unref(hog->attrib);
> >         hog->attrib = NULL;
> > +       uhid_destroy(hog);
> >  }
> >
> >  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
