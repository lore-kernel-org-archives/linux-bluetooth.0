Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61900C4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BD8224D1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440811AbgLNSVj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 13:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440814AbgLNSVd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 13:21:33 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA2C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 10:20:52 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id q205so7470925oig.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gjih683JRQ7JFd+2Mzx9vjhUKIQ5BUh8eGqtl9YmGGI=;
        b=JxJMtrsxrxM6nvCyOw6L1ip6TZF+jki5ZuHMDJg7z1cqgbqW/zp9i4iRbhDbJxLDVq
         Ou08Pb28ov9fgCjkCQTD2GHTXQVkV4oSz4Y8aXyEiEBrRbe7+Ko3ljHih14LEeAnTwD7
         rQnz7qRfhQQio4VnNQxigZKGNyp5vy6xiFXudtm88cUpKEPImWmDPbZmFpYFB5zzUBgr
         i5h5CWn5jebXnpSWuFm0UkDpdKSTvsVEr28k5Xzc4cUNZHhNFw3MtyrjXvbQ5/UPYx8m
         dgJ8CT5PkLpjpRPGCaBr1lEkm8ZHwn9ReiAFHFqVkW+5EfjrrbEwsw06z1qB8bfnP/sW
         p9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gjih683JRQ7JFd+2Mzx9vjhUKIQ5BUh8eGqtl9YmGGI=;
        b=i6q9vn+hOzF+0Ho18Yf32z46SvKWYU+f3Aj4BhcY0s+Manra5T4daeahO53epiU+si
         +hhitdyj7Dr9kkKT19XRKGbJwWNYVIJ3CZ+odFpeIfAM9Q4Hva83u1WGkqDEG8WvcWbg
         3ohCelb2zxJlIZK5AC4MzSQJRd3amHWi/IFni7KfciUbUJkcnKb9G6DUTMlh+PXOn3LY
         tg5g2gCvsFQpUNvTOx0WUN0dIpPuqdfTCarQCKsq3F1FwIuL28si0mL8Gg7GbXigRJBj
         QT5QY1It4XzWTKy0rkqGibIvzXBFxKV2Kba9SGZFU0KMeyqP/hUjL2MqFoVlwZ6yPnee
         TUIA==
X-Gm-Message-State: AOAM530uCNR9PA+YUA75n8UFceVCGLu6IRIKosTJwr6HPg3Es+XTbAjs
        01EU9cSG0hkubbAIcFVFYWTDI72uy1QMHOYWThk=
X-Google-Smtp-Source: ABdhPJxT/7KIZn1qPQCqe7W2lDJ05fK3SXKacSMN620qi3xe9RnNiq9zwml/5tr58hGJ0Am6FPCthifBuu2sQyOwtB4=
X-Received: by 2002:aca:f456:: with SMTP id s83mr18937924oih.58.1607970052283;
 Mon, 14 Dec 2020 10:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20201211233047.108658-1-sonnysasaka@chromium.org> <20201211233047.108658-2-sonnysasaka@chromium.org>
In-Reply-To: <20201211233047.108658-2-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Dec 2020 10:20:41 -0800
Message-ID: <CABBYNZ+LG8dPR57c-oY9mkFcy6uxfAvXQj8pTk68MT3Z_ZY3ig@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] input/hog: Cache the HID report map
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Sat, Dec 12, 2020 at 9:57 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> To optimize BLE HID devices reconnection response, we can cache the
> report map so that the subsequent reconnections do not need round trip
> time to read the report map.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
>
> ---
>  profiles/input/hog-lib.c | 142 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 118 insertions(+), 24 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index ee811d301..e5fef4c7c 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -95,6 +95,13 @@ struct bt_hog {
>         struct queue            *bas;
>         GSList                  *instances;
>         struct queue            *gatt_op;
> +       struct gatt_db          *gatt_db;
> +       struct gatt_db_attribute        *report_map_attr;
> +};
> +
> +struct report_map {
> +       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> +       size_t  length;
>  };
>
>  struct report {
> @@ -924,33 +931,16 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
>         return str;
>  }
>
> -static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> -                                                       gpointer user_data)
> +static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> +                                                       ssize_t report_map_len)
>  {
> -       struct gatt_request *req = user_data;
> -       struct bt_hog *hog = req->user_data;
> -       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> +       uint8_t *value = report_map;
>         struct uhid_event ev;
> -       ssize_t vlen;
> +       ssize_t vlen = report_map_len;
>         char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
>         int i, err;
>         GError *gerr = NULL;
>
> -       destroy_gatt_req(req);
> -
> -       DBG("HoG inspecting report map");
> -
> -       if (status != 0) {
> -               error("Report Map read failed: %s", att_ecode2str(status));
> -               return;
> -       }
> -
> -       vlen = dec_read_resp(pdu, plen, value, sizeof(value));
> -       if (vlen < 0) {
> -               error("ATT protocol error");
> -               return;
> -       }
> -
>         DBG("Report MAP:");
>         for (i = 0; i < vlen;) {
>                 ssize_t ilen = 0;
> @@ -1022,6 +1012,43 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>         DBG("HoG created uHID device");
>  }
>
> +static void db_report_map_write_value_cb(struct gatt_db_attribute *attr,
> +                                               int err, void *user_data)
> +{
> +       if (err)
> +               error("Error writing report map value to gatt db");
> +}
> +
> +static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> +                                                       gpointer user_data)
> +{
> +       struct gatt_request *req = user_data;
> +       struct bt_hog *hog = req->user_data;
> +       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
> +       ssize_t vlen;
> +
> +       destroy_gatt_req(req);
> +
> +       DBG("HoG inspecting report map");
> +
> +       if (status != 0) {
> +               error("Report Map read failed: %s", att_ecode2str(status));
> +               return;
> +       }
> +
> +       vlen = dec_read_resp(pdu, plen, value, sizeof(value));
> +       if (vlen < 0) {
> +               error("ATT protocol error");
> +               return;
> +       }
> +
> +       uhid_create(hog, value, vlen);
> +
> +       /* Cache the report map to optimize reconnection */
> +       gatt_db_attribute_write(hog->report_map_attr, 0, value, vlen, 0, NULL,
> +                                       db_report_map_write_value_cb, NULL);
> +}
> +
>  static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                                                         gpointer user_data)
>  {
> @@ -1269,12 +1296,32 @@ static void foreach_hog_external(struct gatt_db_attribute *attr,
>                                         external_report_reference_cb, hog);
>  }
>
> +static void db_report_map_read_value_cb(struct gatt_db_attribute *attrib,
> +                                               int err, const uint8_t *value,
> +                                               size_t length, void *user_data)
> +{
> +       struct report_map *map = user_data;
> +
> +       if (err) {
> +               error("Error reading report map from gatt db %s",
> +                                                               strerror(-err));
> +               return;
> +       }
> +
> +       if (!length)
> +               return;
> +
> +       map->length = length < sizeof(map->value) ? length : sizeof(map->value);
> +       memcpy(map->value, value, map->length);
> +}
> +
>  static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
>  {
>         struct bt_hog *hog = user_data;
>         bt_uuid_t uuid, report_uuid, report_map_uuid, info_uuid;
>         bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
>         uint16_t handle, value_handle;
> +       struct report_map report_map = {0};
>
>         gatt_db_attribute_get_char_data(attr, &handle, &value_handle, NULL,
>                                         NULL, &uuid);
> @@ -1288,8 +1335,24 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
>
>         bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
>         if (!bt_uuid_cmp(&report_map_uuid, &uuid)) {
> -               read_char(hog, hog->attrib, value_handle, report_map_read_cb,
> -                                                                       hog);
> +
> +               hog->report_map_attr = gatt_db_get_attribute(hog->gatt_db,
> +                                                               value_handle);
> +               gatt_db_attribute_read(hog->report_map_attr, 0,
> +                                       BT_ATT_OP_READ_REQ, NULL,
> +                                       db_report_map_read_value_cb,
> +                                       &report_map);
> +
> +               if (report_map.length) {
> +                       /* Report map found in the cache, straight to creating
> +                        * UHID to optimize reconnection.
> +                        */
> +                       uhid_create(hog, report_map.value, report_map.length);
> +               } else {
> +                       read_char(hog, hog->attrib, value_handle,
> +                                               report_map_read_cb, hog);
> +               }
> +
>                 gatt_db_service_foreach_desc(attr, foreach_hog_external, hog);
>                 return;
>         }
> @@ -1417,6 +1480,8 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
>                         hog->dis = bt_dis_new(db);
>                         bt_dis_set_notification(hog->dis, dis_notify, hog);
>                 }
> +
> +               hog->gatt_db = db;

Is this really supposed to be a weak reference?

>         }
>
>         return bt_hog_ref(hog);
> @@ -1612,9 +1677,14 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>                                         hog->primary->range.start,
>                                         hog->primary->range.end, NULL,
>                                         char_discovered_cb, hog);
> -               return true;
>         }
>
> +       if (!hog->uhid_created)
> +               return true;
> +
> +       /* If UHID is already created, set up the report value handlers to
> +        * optimize reconnection.
> +        */
>         for (l = hog->reports; l; l = l->next) {
>                 struct report *r = l->data;
>
> @@ -1627,6 +1697,29 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>         return true;
>  }
>
> +static void uhid_destroy(struct bt_hog *hog)
> +{
> +       int err;
> +       struct uhid_event ev;
> +
> +       if (!hog->uhid_created)
> +               return;
> +
> +       bt_uhid_unregister_all(hog->uhid);
> +
> +       memset(&ev, 0, sizeof(ev));
> +       ev.type = UHID_DESTROY;
> +
> +       err = bt_uhid_send(hog->uhid, &ev);
> +
> +       if (err < 0) {
> +               error("bt_uhid_send: %s", strerror(-err));
> +               return;
> +       }
> +
> +       hog->uhid_created = false;
> +}
> +
>  void bt_hog_detach(struct bt_hog *hog)
>  {
>         GSList *l;
> @@ -1660,6 +1753,7 @@ void bt_hog_detach(struct bt_hog *hog)
>         queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
>         g_attrib_unref(hog->attrib);
>         hog->attrib = NULL;
> +       uhid_destroy(hog);
>  }
>
>  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
