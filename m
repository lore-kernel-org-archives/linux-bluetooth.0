Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ADFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 20:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4130120704
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 20:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slDYTtmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGQUhu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGQUht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 16:37:49 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481AC0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 13:37:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k22so9073037oib.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZjXVG2l5i2DD6yPzZJAldfDn0pgvSL/sEGJegxml2o=;
        b=slDYTtmTpopQryS4SlnBDOTING9sZQM/98abNQfvFBU8/TG+rJPXdoVoq7dMoVhvu0
         CiC/9DZNQ8EcSx9/hJp8ZuT0GQPh5Wf7kSfoKceVSOjc8pDiN4kxyFCS9jNqo5LYjiLz
         gPl09vcS0ckr6l/kYNXvL3F6HEhgn0sZ4ACpY7mXkZx3i8sW+mApA4JUnqQrOnxR61Xe
         RvBK9qs1OHZBWAhrvCsrwXfHO6vaDaIwmNP8jHdRgT/ttfXSfeu1zeGHhv+mCdGkJB8r
         F8UNrAwdM3c3Fi4ANbe6U5n5OsVsTHx0vmR1obpnxaMiTS0uXIGkqZIx+jypowy/pQLH
         V4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZjXVG2l5i2DD6yPzZJAldfDn0pgvSL/sEGJegxml2o=;
        b=q9evJTZM3gh3F7X0MK5KEKTL1nE8kTQdIKib/+rc39zLP+GLNrrf3mHvqK/H1Dmtyn
         KNZsHZmZFEVF3NQhueSj/vRPkI2iGweM48KCSFJ94s2sUWFbr2bho7od9ByRohoC+ync
         Gs/w5Zqam/N+VdVpPIenUicY0APCsxRamYxcHKFDPDtPwKoqehemBxXijTHstbFMsVdT
         n2qFOtSKCMnPvWIsWSIecAg+rK4ii3x1mBHhRCAPCe/85QvoDFtNZ4ZHgcqmtRiVA7CP
         hnaJiS8nHRWfAgpxZSfraTBqHdDE+JQD0g9bKO98V//e5jcszAHXbKi7Var0KuSDPW8L
         iJGg==
X-Gm-Message-State: AOAM531Xy3hK6Nyhj3p9St8ERWeX2fETO8lhVMe3L6HQfD8AR9qaWC8N
        bpbk1RFiLFXZ/nVMgmqhJNwOQOCbNSOsoj+AMIrCTxE9
X-Google-Smtp-Source: ABdhPJzkHNUUGITwy+5Ut2LM8hnwNgSMb5m4Pi3B3+d7R4DMcqdoLz6oaYu3Np6O5Rr1f9K9pxgWjAhJ1qVOU50Nvd4=
X-Received: by 2002:aca:cf81:: with SMTP id f123mr9339587oig.137.1595018268595;
 Fri, 17 Jul 2020 13:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200717144007.3160721-1-alainm@chromium.org>
In-Reply-To: <20200717144007.3160721-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Jul 2020 13:37:37 -0700
Message-ID: <CABBYNZ+VR5cNuVpTmJo0JTmxnyiwugQwpN5C8UOExu47OYJ3mA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] gatt: Support DeviceInfo Service when vid/pid is specified
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, Jul 17, 2020 at 7:43 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This patch adds support for the PNPID characteristic when configured in
> main.conf.
>
> This was validated as read correclty both by manually reading the valud
> and confirming in the Ellisys Analyzer.
>
> ATT Read (PnP ID: Source=Bluetooth ID, Vendor=224, Product=50181,
> ATT Read Response Packet (Source=Bluetooth ID, Vendor=224,
> Product=50181, Version=86)     | OK     | 7 bytes (01 E0 00 05 C4 56 00)
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> I admit I don't know how to quantify the compatibility risk with adding
> the Device Info Service if the DeviceID is specified.  I can see that
> some system may be configured with an app to publish the DIS and this
> may break it.
>
> If the community feels it is necessary, I can include a DeviceIdOverLE
> configuration which defaults to false in main.conf to address this
> compatibility risk.
>
> Changes in v2:
>  - Removing file I didn't intend to commit (peripheral/gatt.c)
>
>  src/gatt-database.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 95ba39897..07d567078 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -57,6 +57,7 @@
>
>  #define UUID_GAP       0x1800
>  #define UUID_GATT      0x1801
> +#define UUID_DIS       0x180a
>
>  #ifndef MIN
>  #define MIN(a, b) ((a) < (b) ? (a) : (b))
> @@ -1233,11 +1234,51 @@ static void populate_gatt_service(struct btd_gatt_database *database)
>         database_add_record(database, service);
>  }
>
> +static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, struct bt_att *att,
> +                                       void *user_data)
> +{
> +       uint8_t pdu[7];
> +
> +       pdu[0] = main_opts.did_source;
> +       put_le16(main_opts.did_vendor, &pdu[1]);
> +       put_le16(main_opts.did_product, &pdu[3]);
> +       put_le16(main_opts.did_version, &pdu[5]);
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, pdu, sizeof(pdu));
> +}
> +
> +static void populate_devinfo_service(struct btd_gatt_database *database)
> +{
> +       struct gatt_db_attribute *service;
> +       bt_uuid_t uuid;
> +
> +       bt_uuid16_create(&uuid, UUID_DIS);
> +       service = gatt_db_add_service(database->db, &uuid, true, 3);
> +
> +       if (main_opts.did_source > 0) {
> +               bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
> +               gatt_db_service_add_characteristic(service, &uuid,
> +                                               BT_ATT_PERM_READ,
> +                                               BT_GATT_CHRC_PROP_READ,
> +                                               device_info_read_pnp_id_cb,
> +                                               NULL, database);
> +       }
> +
> +       gatt_db_service_set_active(service, true);
> +
> +       database_add_record(database, service);
> +}
>
>  static void register_core_services(struct btd_gatt_database *database)
>  {
>         populate_gap_service(database);
>         populate_gatt_service(database);
> +
> +       if (main_opts.did_source > 0)
> +               populate_devinfo_service(database);
> +
>  }
>
>  static void conf_cb(void *user_data)
> --
> 2.28.0.rc0.105.gf9edc3c819-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
