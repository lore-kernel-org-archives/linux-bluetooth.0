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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E3EC2BB48
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 22:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D224122507
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 22:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408538AbgLNWRk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 17:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408556AbgLNWRW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 17:17:22 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D13C0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 14:16:41 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id n26so24787944eju.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OHMsrt9VvmbrZ3X7JEtcKIvv1O6GJ0Eukvgnz5HPcg=;
        b=XWm+hjnzr8n9gAIc82TpfkWMue+MYE9anIts2rLQd7js5k7x67sYF9YCcuVIAUTaoW
         +h6lWoJ4U9Tq/6jUi06p/meLyS9GefaRrUh5rMimd/UDIDsmWdxHNuTvJmMJITvmvZiH
         5CEBUuUL5wiR+NOY5eWExDvvVKCSeM0Bgllis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OHMsrt9VvmbrZ3X7JEtcKIvv1O6GJ0Eukvgnz5HPcg=;
        b=dwBeDYmzgCeozO3fZOOEf3S09zDZsQzonPCuoX5P0Iwk9glZlawTRU0nHp83F8A3Pt
         cKxakXfQhVI7t2SSP+QQFRMutSqdrlOGQwOwUH5Si7e7uNMXDZFT0ekeXy/6Pb7cEjFx
         hOhWjCMafOniZ2Drvvjz/tcEpU/BxxUW7vh3lqBzFEN+DaMJeY/a6Sa1Ru+I3apm3de7
         hyuoLQckfpGvG0NrUsy3YDol0jA6UlBRzlq5KoM9edc+TYIREBT9u3qKrss2zFX2Q1Y3
         Ul0BP8TPLiM/VvOt6G+3jxctrZdW+IheoUEW6HBMGBA4Kn7btTYL8OcLlvxvkO71awPS
         tsDw==
X-Gm-Message-State: AOAM530dnYibIVjYpSefAwW+k/UUrV1NFHiiTYvbhNhqSkh9sJd1CsLj
        3695CxQkOcbAib7hS+qstcXFq0fvmj20Ng==
X-Google-Smtp-Source: ABdhPJxVMnFYo8GNxwJFMY3qK8/c6TqEVfZoIx4mHgKrZkwCiTkkUrgzBbKNIQmyk6XSE8QQBGgC8w==
X-Received: by 2002:a17:907:2116:: with SMTP id qn22mr24545016ejb.483.1607984200320;
        Mon, 14 Dec 2020 14:16:40 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id dk16sm14868574ejb.85.2020.12.14.14.16.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:16:39 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id a6so15159909wmc.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 14:16:39 -0800 (PST)
X-Received: by 2002:a1c:bdc1:: with SMTP id n184mr30155931wmf.125.1607984199422;
 Mon, 14 Dec 2020 14:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20201211233047.108658-1-sonnysasaka@chromium.org>
 <20201211233047.108658-2-sonnysasaka@chromium.org> <CABBYNZ+LG8dPR57c-oY9mkFcy6uxfAvXQj8pTk68MT3Z_ZY3ig@mail.gmail.com>
 <CAO271m=9+2rxgGmBtLKrRgf8qfk8GDoD-Wrp3N7C_2+Uk-X3qw@mail.gmail.com>
In-Reply-To: <CAO271m=9+2rxgGmBtLKrRgf8qfk8GDoD-Wrp3N7C_2+Uk-X3qw@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 14 Dec 2020 14:16:27 -0800
X-Gmail-Original-Message-ID: <CAO271mk94sjede=5tGwysvEiVq6HWYuFXCR3RC5jse8QmsfbpQ@mail.gmail.com>
Message-ID: <CAO271mk94sjede=5tGwysvEiVq6HWYuFXCR3RC5jse8QmsfbpQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] input/hog: Cache the HID report map
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, Dec 14, 2020 at 10:22 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> On Mon, Dec 14, 2020 at 10:20 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Sat, Dec 12, 2020 at 9:57 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > To optimize BLE HID devices reconnection response, we can cache the
> > > report map so that the subsequent reconnections do not need round trip
> > > time to read the report map.
> > >
> > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > >
> > > ---
> > >  profiles/input/hog-lib.c | 142 ++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 118 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > > index ee811d301..e5fef4c7c 100644
> > > --- a/profiles/input/hog-lib.c
> > > +++ b/profiles/input/hog-lib.c
> > > @@ -95,6 +95,13 @@ struct bt_hog {
> > >         struct queue            *bas;
> > >         GSList                  *instances;
> > >         struct queue            *gatt_op;
> > > +       struct gatt_db          *gatt_db;
> > > +       struct gatt_db_attribute        *report_map_attr;
> > > +};
> > > +
> > > +struct report_map {
> > > +       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> > > +       size_t  length;
> > >  };
> > >
> > >  struct report {
> > > @@ -924,33 +931,16 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
> > >         return str;
> > >  }
> > >
> > > -static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > > -                                                       gpointer user_data)
> > > +static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> > > +                                                       ssize_t report_map_len)
> > >  {
> > > -       struct gatt_request *req = user_data;
> > > -       struct bt_hog *hog = req->user_data;
> > > -       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> > > +       uint8_t *value = report_map;
> > >         struct uhid_event ev;
> > > -       ssize_t vlen;
> > > +       ssize_t vlen = report_map_len;
> > >         char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> > >         int i, err;
> > >         GError *gerr = NULL;
> > >
> > > -       destroy_gatt_req(req);
> > > -
> > > -       DBG("HoG inspecting report map");
> > > -
> > > -       if (status != 0) {
> > > -               error("Report Map read failed: %s", att_ecode2str(status));
> > > -               return;
> > > -       }
> > > -
> > > -       vlen = dec_read_resp(pdu, plen, value, sizeof(value));
> > > -       if (vlen < 0) {
> > > -               error("ATT protocol error");
> > > -               return;
> > > -       }
> > > -
> > >         DBG("Report MAP:");
> > >         for (i = 0; i < vlen;) {
> > >                 ssize_t ilen = 0;
> > > @@ -1022,6 +1012,43 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > >         DBG("HoG created uHID device");
> > >  }
> > >
> > > +static void db_report_map_write_value_cb(struct gatt_db_attribute *attr,
> > > +                                               int err, void *user_data)
> > > +{
> > > +       if (err)
> > > +               error("Error writing report map value to gatt db");
> > > +}
> > > +
> > > +static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > > +                                                       gpointer user_data)
> > > +{
> > > +       struct gatt_request *req = user_data;
> > > +       struct bt_hog *hog = req->user_data;
> > > +       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> > > +       ssize_t vlen;
> > > +
> > > +       destroy_gatt_req(req);
> > > +
> > > +       DBG("HoG inspecting report map");
> > > +
> > > +       if (status != 0) {
> > > +               error("Report Map read failed: %s", att_ecode2str(status));
> > > +               return;
> > > +       }
> > > +
> > > +       vlen = dec_read_resp(pdu, plen, value, sizeof(value));
> > > +       if (vlen < 0) {
> > > +               error("ATT protocol error");
> > > +               return;
> > > +       }
> > > +
> > > +       uhid_create(hog, value, vlen);
> > > +
> > > +       /* Cache the report map to optimize reconnection */
> > > +       gatt_db_attribute_write(hog->report_map_attr, 0, value, vlen, 0, NULL,
> > > +                                       db_report_map_write_value_cb, NULL);
> > > +}
> > > +
> > >  static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> > >                                                         gpointer user_data)
> > >  {
> > > @@ -1269,12 +1296,32 @@ static void foreach_hog_external(struct gatt_db_attribute *attr,
> > >                                         external_report_reference_cb, hog);
> > >  }
> > >
> > > +static void db_report_map_read_value_cb(struct gatt_db_attribute *attrib,
> > > +                                               int err, const uint8_t *value,
> > > +                                               size_t length, void *user_data)
> > > +{
> > > +       struct report_map *map = user_data;
> > > +
> > > +       if (err) {
> > > +               error("Error reading report map from gatt db %s",
> > > +                                                               strerror(-err));
> > > +               return;
> > > +       }
> > > +
> > > +       if (!length)
> > > +               return;
> > > +
> > > +       map->length = length < sizeof(map->value) ? length : sizeof(map->value);
> > > +       memcpy(map->value, value, map->length);
> > > +}
> > > +
> > >  static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
> > >  {
> > >         struct bt_hog *hog = user_data;
> > >         bt_uuid_t uuid, report_uuid, report_map_uuid, info_uuid;
> > >         bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
> > >         uint16_t handle, value_handle;
> > > +       struct report_map report_map = {0};
> > >
> > >         gatt_db_attribute_get_char_data(attr, &handle, &value_handle, NULL,
> > >                                         NULL, &uuid);
> > > @@ -1288,8 +1335,24 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
> > >
> > >         bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
> > >         if (!bt_uuid_cmp(&report_map_uuid, &uuid)) {
> > > -               read_char(hog, hog->attrib, value_handle, report_map_read_cb,
> > > -                                                                       hog);
> > > +
> > > +               hog->report_map_attr = gatt_db_get_attribute(hog->gatt_db,
> > > +                                                               value_handle);
> > > +               gatt_db_attribute_read(hog->report_map_attr, 0,
> > > +                                       BT_ATT_OP_READ_REQ, NULL,
> > > +                                       db_report_map_read_value_cb,
> > > +                                       &report_map);
> > > +
> > > +               if (report_map.length) {
> > > +                       /* Report map found in the cache, straight to creating
> > > +                        * UHID to optimize reconnection.
> > > +                        */
> > > +                       uhid_create(hog, report_map.value, report_map.length);
> > > +               } else {
> > > +                       read_char(hog, hog->attrib, value_handle,
> > > +                                               report_map_read_cb, hog);
> > > +               }
> > > +
> > >                 gatt_db_service_foreach_desc(attr, foreach_hog_external, hog);
> > >                 return;
> > >         }
> > > @@ -1417,6 +1480,8 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
> > >                         hog->dis = bt_dis_new(db);
> > >                         bt_dis_set_notification(hog->dis, dis_notify, hog);
> > >                 }
> > > +
> > > +               hog->gatt_db = db;
> >
> > Is this really supposed to be a weak reference?
> Yes, I intended it to be a weak reference, I was assuming that gatt_db
> is alive as long as hog is alive. Is this assumption not true? Is it
> safer to think otherwise?
Hi Luiz, as we agreed in an offline thread, I added ref counting to
this field so it is guaranteed that we don't use an already freed
gatt_db. Please take another look at v3. Thanks!

> >
> > >         }
> > >
> > >         return bt_hog_ref(hog);
> > > @@ -1612,9 +1677,14 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
> > >                                         hog->primary->range.start,
> > >                                         hog->primary->range.end, NULL,
> > >                                         char_discovered_cb, hog);
> > > -               return true;
> > >         }
> > >
> > > +       if (!hog->uhid_created)
> > > +               return true;
> > > +
> > > +       /* If UHID is already created, set up the report value handlers to
> > > +        * optimize reconnection.
> > > +        */
> > >         for (l = hog->reports; l; l = l->next) {
> > >                 struct report *r = l->data;
> > >
> > > @@ -1627,6 +1697,29 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
> > >         return true;
> > >  }
> > >
> > > +static void uhid_destroy(struct bt_hog *hog)
> > > +{
> > > +       int err;
> > > +       struct uhid_event ev;
> > > +
> > > +       if (!hog->uhid_created)
> > > +               return;
> > > +
> > > +       bt_uhid_unregister_all(hog->uhid);
> > > +
> > > +       memset(&ev, 0, sizeof(ev));
> > > +       ev.type = UHID_DESTROY;
> > > +
> > > +       err = bt_uhid_send(hog->uhid, &ev);
> > > +
> > > +       if (err < 0) {
> > > +               error("bt_uhid_send: %s", strerror(-err));
> > > +               return;
> > > +       }
> > > +
> > > +       hog->uhid_created = false;
> > > +}
> > > +
> > >  void bt_hog_detach(struct bt_hog *hog)
> > >  {
> > >         GSList *l;
> > > @@ -1660,6 +1753,7 @@ void bt_hog_detach(struct bt_hog *hog)
> > >         queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
> > >         g_attrib_unref(hog->attrib);
> > >         hog->attrib = NULL;
> > > +       uhid_destroy(hog);
> > >  }
> > >
> > >  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
> > > --
> > > 2.26.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
