Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B4AC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 01:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA19F238E5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 01:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgLIB6t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgLIB6t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 20:58:49 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30746C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 17:58:09 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s2so110886oij.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 17:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itO6wBmMEIvvxCPB2jdnrIvFtKk4ZeNEmMfmnvkNpT0=;
        b=g9v/lDlYpTlbqsg+fXyv6hmOrOmMA2VmoqeGRWJ5EE5WxFlqM25UdfZeaMDmbBDC2t
         l03oqgM4OzW9mb9kiJlqD1E4dnSluLHb9WaogqhK76nPyXqWLKZJgXszlFeCxRAVbJDD
         9AKQ4Bbi6VfXW9aMahMGDn219J9V4xk4CDIzcJ5dkRPWqUVEc4C85GPeEnhsoQOAxvQm
         j2kVk2aIJLKB+rzIpWAP+o/xq8v82vH3P9TJSTK0Pl9P8/vUIuyLn2YN5noLHN2xbHyr
         /kp9yWDkT3Np++UmHtO6FhtVoT6dEJM9LxP5/Ivh9RULTQ+CN8UvUwWCOEguhsot6JQo
         LPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itO6wBmMEIvvxCPB2jdnrIvFtKk4ZeNEmMfmnvkNpT0=;
        b=RV+AOwm7ImPutY/WGJj8r4/+jARNg7lIeXi07teMplQIOB/Dic/pOhCxZL/lMTWD3w
         CPdzWt1zQU7ObJAlv4SkbcGccdYdNlQFeTOya/ThI1b3rO9jcHf5uL312TqwFEZb4gOE
         NhiFhFDg7e3+58EPM1I0anEhuc8k6PnR80bH5tU+1V2/+U8B+8/kAJPKDoumukK631HG
         JdT0XX5tStE8v3/sK6x9HzWUY98UTachmHCiurMdFnc63q/pwQEI8E/s5x6kkBcliiRZ
         HLlUZngYTMTy5da6npD/wBcLyat2iyCy/sgCTf1iXfkLWin2E/lfLsDKdGKlzXBGQpgT
         WHgA==
X-Gm-Message-State: AOAM531JqLCMdKvSTJ4VP6eoR6ExWbrZBG3HmDvoLjQLj6ykFeWSx8Aw
        3NGmFX4DLm3caFJ+7fw8pb66MkgwJ0R/uLfwQTFG5W1q
X-Google-Smtp-Source: ABdhPJwybus+luxQOk2fVZGzubAVn27hGzNKHD4E402Zw2ZXbzhZLY2f6pvn9PABI27tPiLlb0Iw89MeGMbOVKyiKrc=
X-Received: by 2002:aca:f456:: with SMTP id s83mr242025oih.58.1607479088479;
 Tue, 08 Dec 2020 17:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20201209010030.342632-1-sonnysasaka@chromium.org> <20201209010030.342632-2-sonnysasaka@chromium.org>
In-Reply-To: <20201209010030.342632-2-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Dec 2020 17:57:57 -0800
Message-ID: <CABBYNZ+OrbUb8YT8tYuFLVuhuTp9nhMdp_Jc0UyUO2a71rcBbw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] input/hog: Cache the HID report map
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Dec 8, 2020 at 5:16 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> To optimize BLE HID devices reconnection response, we can cache the
> report map so that the subsequent reconnections do not need round trip
> time to read the report map.

While the idea is pretty good we need to find a way to persist it
across reboots/restarts. In theory we could save the value on the
gatt_db instance and then make changes to device.c:store_desc to
attempt to read if there is a value stored in the db save it on file
as well so the next time the cache is loaded it should restore the
report map, or any other descriptor that have its value saved in the
database. That said we may need to introduce some sort of property for
values stored in the db since normally the values store in the
database shall not be persisted on file, in fact it would cause a lot
of fime access updating the cache if we were to trigger updates
everytime the db is updated with a value.

> Reviewed-by: Alain Michaud <alainm@chromium.org>
>
> ---
>  profiles/input/hog-lib.c | 142 ++++++++++++++++++++++++++-------------
>  1 file changed, 96 insertions(+), 46 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index ee811d301..1e198ea64 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -95,6 +95,8 @@ struct bt_hog {
>         struct queue            *bas;
>         GSList                  *instances;
>         struct queue            *gatt_op;
> +       uint8_t                 report_map[HOG_REPORT_MAP_MAX_SIZE];
> +       ssize_t                 report_map_len;
>  };
>
>  struct report {
> @@ -276,6 +278,8 @@ static void find_included(struct bt_hog *hog, GAttrib *attrib,
>         free(req);
>  }
>
> +static void uhid_create(struct bt_hog *hog);
> +
>  static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
>  {
>         struct report *report = user_data;
> @@ -924,57 +928,17 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
>         return str;
>  }
>
> -static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> -                                                       gpointer user_data)
> +static void uhid_create(struct bt_hog *hog)
>  {
> -       struct gatt_request *req = user_data;
> -       struct bt_hog *hog = req->user_data;
> -       uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
>         struct uhid_event ev;
> -       ssize_t vlen;
> -       char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> -       int i, err;
>         GError *gerr = NULL;
> +       int i, err;
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
> +       if (!hog->report_map_len) {
> +               warn("Failed to initiate UHID_CREATE without report map");
>                 return;
>         }
>
> -       DBG("Report MAP:");
> -       for (i = 0; i < vlen;) {
> -               ssize_t ilen = 0;
> -               bool long_item = false;
> -
> -               if (get_descriptor_item_info(&value[i], vlen - i, &ilen,
> -                                                               &long_item)) {
> -                       /* Report ID is short item with prefix 100001xx */
> -                       if (!long_item && (value[i] & 0xfc) == 0x84)
> -                               hog->has_report_id = TRUE;
> -
> -                       DBG("\t%s", item2string(itemstr, &value[i], ilen));
> -
> -                       i += ilen;
> -               } else {
> -                       error("Report Map parsing failed at %d", i);
> -
> -                       /* Just print remaining items at once and break */
> -                       DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
> -                       break;
> -               }
> -       }
> -
> -       /* create uHID device */
>         memset(&ev, 0, sizeof(ev));
>         ev.type = UHID_CREATE;
>
> @@ -1004,8 +968,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>         ev.u.create.version = hog->version;
>         ev.u.create.country = hog->bcountrycode;
>         ev.u.create.bus = BUS_BLUETOOTH;
> -       ev.u.create.rd_data = value;
> -       ev.u.create.rd_size = vlen;
> +       ev.u.create.rd_data = hog->report_map;
> +       ev.u.create.rd_size = hog->report_map_len;
>
>         err = bt_uhid_send(hog->uhid, &ev);
>         if (err < 0) {
> @@ -1018,6 +982,62 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>         bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
>
>         hog->uhid_created = true;
> +}
> +
> +static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
> +                                                       gpointer user_data)
> +{
> +       struct gatt_request *req = user_data;
> +       struct bt_hog *hog = req->user_data;
> +       ssize_t vlen;
> +       char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> +       int i;
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
> +       vlen = dec_read_resp(pdu, plen, hog->report_map,
> +                                               sizeof(hog->report_map));
> +       if (vlen < 0) {
> +               error("ATT protocol error");
> +               return;
> +       }
> +
> +       hog->report_map_len = vlen;
> +
> +       DBG("Report MAP:");
> +       for (i = 0; i < vlen;) {
> +               ssize_t ilen = 0;
> +               bool long_item = false;
> +
> +               if (get_descriptor_item_info(&hog->report_map[i], vlen - i,
> +                                               &ilen, &long_item)) {
> +                       /* Report ID is short item with prefix 100001xx */
> +                       if (!long_item && (hog->report_map[i] & 0xfc) == 0x84)
> +                               hog->has_report_id = TRUE;
> +
> +                       DBG("\t%s", item2string(itemstr, &hog->report_map[i],
> +                                                                       ilen));
> +
> +                       i += ilen;
> +               } else {
> +                       error("Report Map parsing failed at %d", i);
> +
> +                       /* Just print remaining items at once and break */
> +                       DBG("\t%s", item2string(itemstr, &hog->report_map[i],
> +                                               vlen - i));
> +                       break;
> +               }
> +       }
> +
> +       /* create uHID device */
> +       uhid_create(hog);
>
>         DBG("HoG created uHID device");
>  }
> @@ -1602,6 +1622,12 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>                 bt_hog_attach(instance, gatt);
>         }
>
> +       /* Try to initiate UHID_CREATE if we already have the report map to
> +        * avoid re-reading the report map from the peer device.
> +        */
> +       if (hog->report_map_len > 0)
> +               uhid_create(hog);
> +
>         if (!hog->uhid_created) {
>                 DBG("HoG discovering characteristics");
>                 if (hog->attr)
> @@ -1627,6 +1653,29 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
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
> @@ -1660,6 +1709,7 @@ void bt_hog_detach(struct bt_hog *hog)
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
