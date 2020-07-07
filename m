Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F3520708
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rht8URpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgGGRv2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgGGRv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 13:51:28 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E822C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 10:51:28 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c25so17356226otf.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCVEYuJGviAWDatB6nt/gU/BOAlgCXbGWrHAbOwkPM8=;
        b=Rht8URpwxd9gX5PA5/JT+3uV5XL9oFaGK/Jao/JBHQppF7uaeAVNBYtpyjK2fsw6z2
         Fe+svI+i5aQ6woIvUpHIAdhqyu8iXNh749QLE2ABQspG+OLKSGMPAdemox+C4E1T8yi4
         I5dNHh5NIVxPQ+4NGocIqMObudiFOCFMK5tSxR7WLBWM2B6cCIatjD5iZ3XEWzobI2cZ
         vFD2SU2kDx/B7knd53xO4QPLj5rYZ+9mur6y+r48hEDN9S1rQ6jhlIE0mgHKcVY73rPt
         YX+IONEQO56nUcAEP8OIard2D+8KFq8MRRf/FZ/87anJJ3kptGf72oBdCRDH/phHLgb1
         rehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCVEYuJGviAWDatB6nt/gU/BOAlgCXbGWrHAbOwkPM8=;
        b=uSI0U5z2flJIdtSg2gtF4RJp6DEHHQc6CJ8brVxQPIUxHdViOHXFGDeAknsTiJOhlI
         e9cqGPYbeu/qVfJC1mEKMA7iGVho5o2AhqCuNRREneyjPZzFOf7h/xEMWLB8smZwE5ow
         XIxhO18xv7upRoFu+xxiTRxLEwKy54Vhgwn+wGF+92k6KYEyBKnPYa6dW0KkTbcZ7O5x
         l02Xc7HR0wvmcrr2WfBV0IykzXvN027AefVAoZEywn/YxfHmO10JYPdfMXRh1EcPXzVD
         MmN3PxYS4Ex+Wu93cE0vBrEjy75gp7AHuNAGB2h1pV/Omb1nXLfwJoaF6IrCOLl4eWq5
         h9QQ==
X-Gm-Message-State: AOAM533NQk1B6r4A11wYASG7cWACU7WroAotSrJoC9KXl9XOY6R3CM8a
        EZuDdS5PXVrFMxuASnepMiLXbXQKqWl7yy6D17k=
X-Google-Smtp-Source: ABdhPJytVQaekzSiypSjEbBEFmsiq2WgrZ3CHfbaBDCrGPA0fbJpODg4jKZIuvIoFG1pzw9ogrzMf4cSwQimOepYX9g=
X-Received: by 2002:a9d:5e18:: with SMTP id d24mr6700783oti.88.1594144287426;
 Tue, 07 Jul 2020 10:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200707021920.209213-1-alainm@chromium.org>
In-Reply-To: <20200707021920.209213-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jul 2020 10:51:16 -0700
Message-ID: <CABBYNZLmF5r2RQ94mNti3Q=4zO_eahg1wDV=AiGSDqPn1NiDJg@mail.gmail.com>
Subject: Re: [BlueZ PATCH 1/2] adapter: add support for the Roles property
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Mon, Jul 6, 2020 at 7:22 PM Alain Michaud <alainm@chromium.org> wrote:
>
> This patch adds support for the Roles property as defined in
> adapter-api.txt.
>
> ---
>
>  src/adapter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 9ce351893..7afd6980c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -122,6 +122,8 @@ static bool kernel_blocked_keys_supported = false;
>
>  static bool kernel_set_system_config = false;
>
> +static bool kernel_exp_features = false;
> +
>  static GList *adapter_list = NULL;
>  static unsigned int adapter_remaining = 0;
>  static bool powering_down = false;
> @@ -293,6 +295,8 @@ struct btd_adapter {
>         unsigned int db_id;             /* Service event handler for GATT db */
>
>         bool is_default;                /* true if adapter is default one */
> +
> +       bool le_simult_roles_supported;
>  };
>
>  typedef enum {
> @@ -3199,6 +3203,35 @@ static gboolean property_get_modalias(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static gboolean property_get_roles(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *user_data)
> +{
> +       struct btd_adapter *adapter = user_data;
> +       DBusMessageIter entry;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_TYPE_STRING_AS_STRING, &entry);
> +
> +       if (adapter->supported_settings & MGMT_SETTING_LE) {
> +               const char *str = "central";
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
> +       }
> +
> +       if (adapter->supported_settings & MGMT_SETTING_ADVERTISING) {
> +               const char *str = "peripheral";
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
> +       }
> +
> +       if (adapter->le_simult_roles_supported) {
> +               const char *str = "central-peripheral";
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
> +       }
> +
> +       dbus_message_iter_close_container(iter, &entry);
> +
> +       return TRUE;
> +}
> +
>  static int device_path_cmp(gconstpointer a, gconstpointer b)
>  {
>         const struct btd_device *device = a;
> @@ -3479,6 +3512,7 @@ static const GDBusPropertyTable adapter_properties[] = {
>         { "UUIDs", "as", property_get_uuids },
>         { "Modalias", "s", property_get_modalias, NULL,
>                                         property_exists_modalias },
> +       { "Roles", "as", property_get_roles },
>         { }
>  };
>
> @@ -9023,6 +9057,56 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
>                                                 adapter, NULL);
>  }
>
> +static void read_exp_features_complete(uint8_t status, uint16_t length,
> +                                       const void *param, void *user_data)
> +{
> +       struct btd_adapter *adapter = user_data;
> +       const struct mgmt_rp_read_exp_features_info *rp = param;
> +       size_t feature_count = 0;
> +       size_t i = 0;
> +
> +       DBG("index %u status 0x%02x", adapter->dev_id, status);
> +
> +       if (status != MGMT_STATUS_SUCCESS) {
> +               btd_error(adapter->dev_id,
> +                               "Failed to read exp features info: %s (0x%02x)",
> +                               mgmt_errstr(status), status);
> +               return;
> +       }
> +
> +       if (length < sizeof(*rp)) {
> +               btd_error(adapter->dev_id, "Response too small");
> +               return;
> +       }
> +
> +       feature_count = le16_to_cpu(rp->feature_count);
> +       for (i = 0; i < feature_count; ++i) {
> +
> +               /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
> +               static const uint8_t le_simult_central_peripheral[16] = {
> +                       0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
> +                       0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
> +               };
> +
> +               if (memcmp(rp->features[i].uuid, le_simult_central_peripheral,
> +                               sizeof(le_simult_central_peripheral)) == 0) {
> +                       uint32_t flags = le32_to_cpu(rp->features[i].flags);
> +
> +                       adapter->le_simult_roles_supported = flags & 0x01;
> +               }
> +       }
> +}
> +
> +static void read_exp_features(struct btd_adapter *adapter)
> +{
> +       if (mgmt_send(adapter->mgmt, MGMT_OP_READ_EXP_FEATURES_INFO,
> +                       adapter->dev_id, 0, NULL, read_exp_features_complete,
> +                       adapter, NULL) > 0)
> +               return;
> +
> +       btd_error(adapter->dev_id, "Failed to read exp features info");
> +}
> +
>  static void read_info_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> @@ -9132,6 +9216,9 @@ static void read_info_complete(uint8_t status, uint16_t length,
>                         (missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
>                 set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
>
> +       if (kernel_exp_features)
> +               read_exp_features(adapter);
> +
>         err = adapter_register(adapter);
>         if (err < 0) {
>                 btd_error(adapter->dev_id, "Unable to register new adapter");
> @@ -9447,6 +9534,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
>                         DBG("kernel supports set system confic");
>                         kernel_set_system_config = true;
>                         break;
> +               case MGMT_OP_READ_EXP_FEATURES_INFO:
> +                       DBG("kernel supports exp features");
> +                       kernel_exp_features = true;
> +                       break;
>                 default:
>                         break;
>                 }
> --
> 2.27.0.212.ge8ba1cc988-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
