Return-Path: <SRS0=+je2=2F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4540C43603
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 21:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853012467A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 21:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmJnsLuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfLOVeh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Dec 2019 16:34:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43252 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOVeh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Dec 2019 16:34:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so6373622oth.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2019 13:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5AsqwdP0uYxZ4XaJqxpq9WXiXyHLn0Gp0jA/MfXLS0=;
        b=HmJnsLuXA/wVjZHoQUKGH9xhx6E4TXIQ52oxPgJcU1O4+XMJ3IpjLhuvbrl7Rp+/HF
         HQDOGopQbQN8DNZ6kMdZKOLFJJIRtgqL5KjP7av9fiEv/IQ9qZIvxt1n6UTZBScdRKe9
         54eIH9i18Y6Mht9BVXHHw62gCr6KZE1yv4SHTAGp7L7JyWn5er1oqEy+7fLmMFERPWL2
         2e2QNy17/6GmWeVrcbOKltLrIVdhHqxPLb8zclT+qBOjYOv81ivHWskaeX0zGT/YPvzv
         NZFXQNXZr5jMYvOto0pcPOTTHa26Mbi+oX9KV9E5Q6hrPc49Q3EFXHkMXc6p3+c3bnDm
         lTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5AsqwdP0uYxZ4XaJqxpq9WXiXyHLn0Gp0jA/MfXLS0=;
        b=BA7bkmynoEnc+VG2k5eR1jtrGpXEjTpN7yOXe9BIl4o5UK5jF/F1ypJX9myjVrgJlo
         IJsWHSSooqKkwfY34kaInSV6zSQBNACPZmgSB1rJJ+bv08ol9L6wSw8mdsc8URjRfDSC
         8VRb+c+ZSfmYBhcPAowtHyT/Xg26opMB4eoQTUCc2IIpSZao+gZzcZS05QXnI+WOeWvQ
         ybEWJNDTTvMY7V40L40QfN3vyBO3wJzgy6hH3Q/lkbgowXQj8KFpBRM8bAtfseOBOhpG
         vHgL4sTGIEQ6tQxJvM5QreeOMXRjcrk7R23Cm8bwkhvOn0iALV7sRt4pPePlw6TAFD21
         bv/g==
X-Gm-Message-State: APjAAAXIEykM61NwSDD+1Uc0TjXcVTlvbEma6TccVtlCD8Z9klDuh5sR
        vGgFlbAXXp6AWK6v5wYNpMBZvh1QXEeygoAl0yo=
X-Google-Smtp-Source: APXvYqwCqdAxglHXC5TPYhO/KJc6ohUBve9QOkljl1htF3u7MvvPDrb2pIq0tJkPOoJJAki0MJ9pIUv5tolrKEcQ3Os=
X-Received: by 2002:a9d:eea:: with SMTP id 97mr26563841otj.177.1576445676052;
 Sun, 15 Dec 2019 13:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20191210175901.31161-1-alainm@chromium.org>
In-Reply-To: <20191210175901.31161-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 15 Dec 2019 23:34:23 +0200
Message-ID: <CABBYNZ+_4z9WNy_gWfcNhsYp4tzTXNWmAhPNE9S-fxPyPSAmWg@mail.gmail.com>
Subject: Re: [PATCH v2] Loading keys that should be blocked from bluetoothd.
To:     Alain Michaud <alainm@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Tue, Dec 10, 2019 at 8:00 PM Alain Michaud <alainm@chromium.org> wrote:
>
> This changes will send a list of known bad keys that should be blocked
> if supported by the kernel.
>
> In particular keys from the Google Titan Security key are being blocked.
> For additional information, please see
> https://security.googleblog.com/2019/05/titan-keys-update.html
>
> Signed-off-by: Alain Michaud <alainm@chromium.org>

Signed off by is not used for userspace, also in the future please
prefix the userspace patches with BlueZ to make it easier to identify
them:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING#n118
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING#n136

> ---
>
>  lib/mgmt.h    | 16 ++++++++++++
>  src/adapter.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 570dec997..a99b18c88 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -583,6 +583,22 @@ struct mgmt_cp_set_phy_confguration {
>         uint32_t        selected_phys;
>  } __packed;
>
> +#define MGMT_OP_SET_BLOCKED_KEYS       0x0046
> +
> +#define HCI_BLOCKED_KEY_TYPE_LINKKEY   0x00
> +#define HCI_BLOCKED_KEY_TYPE_LTK               0x01
> +#define HCI_BLOCKED_KEY_TYPE_IRK               0x02
> +
> +struct mgmt_blocked_key_info {
> +       uint8_t type;
> +       uint8_t val[16];
> +} __packed;
> +
> +struct mgmt_cp_set_blocked_keys {
> +       uint16_t key_count;
> +       struct mgmt_blocked_key_info keys[0];
> +} __packed;
> +#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0

lib/ changes should probably be in a separate patch.

>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
> diff --git a/src/adapter.c b/src/adapter.c
> index cef25616f..2958870e6 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -99,10 +99,27 @@
>  #define DISTANCE_VAL_INVALID   0x7FFF
>  #define PATHLOSS_MAX           137
>
> +/*
> + * These are known security keys that have been compromised.
> + * If this grows or there are needs to be platform specific, it is
> + * conceivable that these could be read from a config file.
> + */
> +static const struct mgmt_blocked_key_info blocked_keys[] = {
> +       /* Google Titan Security Keys */
> +       { HCI_BLOCKED_KEY_TYPE_LTK,
> +               {0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
> +                0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
> +       { HCI_BLOCKED_KEY_TYPE_IRK,
> +               {0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
> +                0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
> +};
> +
>  static DBusConnection *dbus_conn = NULL;
>
>  static bool kernel_conn_control = false;
>
> +static bool kernel_blocked_keys_supported = false;
> +

I guess in the long run we would probably have a single
kernel_features and then use bits instead of a bool for each of the
kernel features.

>  static GList *adapter_list = NULL;
>  static unsigned int adapter_remaining = 0;
>  static bool powering_down = false;
> @@ -8568,6 +8585,40 @@ static bool set_static_addr(struct btd_adapter *adapter)
>         return false;
>  }
>
> +static void set_blocked_keys_complete(uint8_t status, uint16_t length,
> +                                       const void *param, void *user_data)
> +{
> +       struct btd_adapter *adapter = user_data;
> +
> +       if (status != MGMT_STATUS_SUCCESS) {
> +               btd_error(adapter->dev_id,
> +                               "Failed to set blocked keys: %s (0x%02x)",
> +                               mgmt_errstr(status), status);
> +               return;
> +       }
> +
> +       DBG("Successfully set blocked keys for index %u", adapter->dev_id);
> +}
> +
> +static bool set_blocked_keys(struct btd_adapter *adapter)
> +{
> +       uint8_t buffer[sizeof(struct mgmt_cp_set_blocked_keys) +
> +                                       sizeof(blocked_keys)] = { 0 };
> +       struct mgmt_cp_set_blocked_keys *cp =
> +                                       (struct mgmt_cp_set_blocked_keys *)buffer;
> +       int i;
> +
> +       cp->key_count = G_N_ELEMENTS(blocked_keys);

At some point we would be converting to use libell, might take a while
though, so if we could perhaps use something like:

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

Perhaps it could be added to src/shared/util.h that way we don't have
to keep adding it all the time.

> +       for (i = 0; i < cp->key_count; ++i) {
> +               cp->keys[i].type = blocked_keys[i].type;
> +               memcpy(cp->keys[i].val, blocked_keys[i].val, sizeof(cp->keys[i].val));
> +       }
> +
> +       return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, adapter->dev_id,
> +                                       sizeof(buffer), buffer, set_blocked_keys_complete,
> +                                       adapter, NULL);
> +}
> +
>  static void read_info_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> @@ -8795,6 +8846,12 @@ static void read_info_complete(uint8_t status, uint16_t length,
>
>         set_name(adapter, btd_adapter_get_name(adapter));
>
> +       if (kernel_blocked_keys_supported && !set_blocked_keys(adapter)) {
> +               btd_error(adapter->dev_id,
> +                       "Failed to set blocked keys for index %u", adapter->dev_id);
> +               goto failed;
> +       }
> +
>         if (main_opts.pairable &&
>                         !(adapter->current_settings & MGMT_SETTING_BONDABLE))
>                 set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
> @@ -8972,9 +9029,17 @@ static void read_commands_complete(uint8_t status, uint16_t length,
>         for (i = 0; i < num_commands; i++) {
>                 uint16_t op = get_le16(rp->opcodes + i);
>
> -               if (op == MGMT_OP_ADD_DEVICE) {
> +               switch (op) {
> +               case MGMT_OP_ADD_DEVICE:
>                         DBG("enabling kernel-side connection control");
>                         kernel_conn_control = true;
> +                       break;
> +               case MGMT_OP_SET_BLOCKED_KEYS:
> +                       DBG("kernel supports the set_blocked_keys op");
> +                       kernel_blocked_keys_supported = true;
> +                       break;
> +               default:
> +                       break;
>                 }
>         }
>  }
> --
> 2.24.0.525.g8f36a354ae-goog

Other than that it looks pretty good, Im just missing the changes to
the documentation that would be great to have in the same set.

-- 
Luiz Augusto von Dentz
