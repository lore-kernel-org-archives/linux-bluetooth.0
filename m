Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F06CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50507205CB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 17:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap9fFUbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgE2RFd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 13:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2RFd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 13:05:33 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB714C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 10:05:31 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id r24so2459333ota.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZI/TxP1vNUmaqs2AXU4+iZ9e5em8gDkxuch+PMhHnDg=;
        b=ap9fFUbo0WzdNzT0QowPLWMRdo8H4qCMpAb0sbAiuUSQvWusCmDFIW2jMYq0yz+54M
         qOgq64jWofoGfR6pOXXAv7XK0PIpktGDMcgwEOmuAueOBUFXuQeZe8K21nR7rp6eOC/j
         FDcy79u68KqsqqiAioO9M5jHx5qKbuz6uMCRqvGO0DAbF1nrum+q89IH/ePhCgaiC1zF
         wkzlA8nkn9AvGLRe6MtUuQ/VkMnzUz48kiRCCoVTEvn2j7ofeuo/tJWvSg+D+tXQuCrw
         Y7aw7k+BNRcmfLIyD1A91xcAGU+OSi3UzGhEeJ/nFpukGOgr2GZLUQGimMEVnC+pFJg1
         pZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZI/TxP1vNUmaqs2AXU4+iZ9e5em8gDkxuch+PMhHnDg=;
        b=KduBDOOwMF5XyB+0SK3v5zN5Xh4MlR7kCflbJsySJ9S562pbIzxsOSrtHqph1zni0t
         U4LFlZ7ZOcu18FM4HThUeALGYfoSQszp9F0RCq0igW06iarcBdirriH31Nx4yDUhJb2u
         7ZFSzNT+6fFmueaKtpBp0LfBDMNH0XZjCA3/IElnmVzYxY/YNLsUj7UrAHzvTiI9nWBk
         SYp+Xmyfb2Qi0aCujQO/PwnHly7Y/Z3IU2V+aF0G7bl/frJFfquteRW9BATE+503pIK8
         zJgzYsLy8frqQLZdim5nYK+KNZ746FDCjDPD8Wrw3pSrx4jvZ+3fuOqe4Y4BenbZrsJ2
         xF1g==
X-Gm-Message-State: AOAM532/qTwu7eO/lmuuBp8yOXXWSvoMF1URPay6iokpX4LsC3dWvkg8
        3KMpOwPMYJsj+idcoNgeR86hCokhrK2tTEAdcOY=
X-Google-Smtp-Source: ABdhPJzJ+pyxvsEYgWVc57B9MPKzq4mAY0CTufvsDwu2geJ0NZPJ18GP2a3cncixsYXcfXSsUwrg+KO1A7SBstA3bm0=
X-Received: by 2002:a05:6830:14c4:: with SMTP id t4mr7190522otq.79.1590771931031;
 Fri, 29 May 2020 10:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200529153814.213125-1-alainm@chromium.org> <20200529153814.213125-3-alainm@chromium.org>
In-Reply-To: <20200529153814.213125-3-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 29 May 2020 10:05:19 -0700
Message-ID: <CABBYNZ+DmKdwepmYAaKjEJ5qWsK6NnTMp9JEamej0BgUGJcRCg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 2/4] adapter:set default system configuration if available
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, May 29, 2020 at 8:41 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change loads any specified system configuration if provided and
> supported by the kernel.
>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  src/adapter.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/hcid.h    |  39 ++++++++
>  2 files changed, 290 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 972d88772..da3777cba 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -120,6 +120,8 @@ static bool kernel_conn_control = false;
>
>  static bool kernel_blocked_keys_supported = false;
>
> +static bool kernel_set_system_params = false;
> +
>  static GList *adapter_list = NULL;
>  static unsigned int adapter_remaining = 0;
>  static bool powering_down = false;
> @@ -4157,6 +4159,250 @@ static void probe_devices(void *user_data)
>         device_probe_profiles(device, btd_device_get_uuids(device));
>  }
>
> +static void load_default_system_params(struct btd_adapter *adapter)
> +{
> +       /* note: for now all params are 2 bytes, if varying size params are
> +        * added, calculating the right size of buffer will be necessary first.
> +        */
> +       struct controller_params_tlv {
> +               uint16_t parameter_type;
> +               uint8_t length;
> +               uint16_t value;
> +       } __packed;

Don't we have a definition of the tlv entry on mgmt.h? Id use that
instead of redefining it here.

> +       struct controller_params_tlv *params = NULL;
> +       uint16_t i = 0;
> +       size_t cp_size;
> +
> +       if (!main_opts.default_params.num_set_params ||
> +               !kernel_set_system_params)
> +               return;
> +
> +       cp_size = sizeof(struct controller_params_tlv) *
> +                               main_opts.default_params.num_set_params;
> +       params = g_try_malloc0(cp_size);

For new code we prefer to use new0 instead of glib allocation.

> +       if (!params)
> +               return;
> +
> +       if (main_opts.default_params.br_page_scan_type != 0xFFFF) {
> +               params[i].parameter_type = 0x0000;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value = main_opts.default_params.br_page_scan_type;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_page_scan_interval) {
> +               params[i].parameter_type = 0x0001;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                               main_opts.default_params.br_page_scan_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_page_scan_window) {
> +               params[i].parameter_type = 0x0002;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value = main_opts.default_params.br_page_scan_window;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_inquiry_scan_type != 0xFFFF) {
> +               params[i].parameter_type = 0x0003;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value = main_opts.default_params.br_inquiry_scan_type;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_inquiry_scan_interval) {
> +               params[i].parameter_type = 0x0004;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.br_inquiry_scan_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_inquiry_scan_window) {
> +               params[i].parameter_type = 0x0005;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                               main_opts.default_params.br_inquiry_scan_window;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_link_supervision_timeout) {
> +               params[i].parameter_type = 0x0006;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.br_link_supervision_timeout;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_page_timeout) {
> +               params[i].parameter_type = 0x0007;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value = main_opts.default_params.br_page_timeout;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_min_sniff_interval) {
> +               params[i].parameter_type = 0x0008;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                               main_opts.default_params.br_min_sniff_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.br_max_sniff_interval) {
> +               params[i].parameter_type = 0x0009;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                               main_opts.default_params.br_max_sniff_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_min_adv_interval) {
> +               params[i].parameter_type = 0x000a;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value = main_opts.default_params.le_min_adv_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_max_adv_interval) {
> +               params[i].parameter_type = 0x000b;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value = main_opts.default_params.le_max_adv_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_multi_adv_rotation_interval) {
> +               params[i].parameter_type = 0x000c;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_multi_adv_rotation_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_interval_autoconnect) {
> +               params[i].parameter_type = 0x000d;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_interval_autoconnect;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_window_autoconnect) {
> +               params[i].parameter_type = 0x000e;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_window_autoconnect;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_interval_suspend) {
> +               params[i].parameter_type = 0x000f;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_interval_suspend;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_window_suspend) {
> +               params[i].parameter_type = 0x0010;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_window_suspend;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_interval_discovery) {
> +               params[i].parameter_type = 0x0011;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_interval_discovery;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_window_discovery) {
> +               params[i].parameter_type = 0x0012;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_window_discovery;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_interval_adv_monitor) {
> +               params[i].parameter_type = 0x0013;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_interval_adv_monitor;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_window_adv_monitor) {
> +               params[i].parameter_type = 0x0014;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_window_adv_monitor;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_interval_connect) {
> +               params[i].parameter_type = 0x0015;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_scan_interval_connect;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_scan_window_connect) {
> +               params[i].parameter_type = 0x0016;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                               main_opts.default_params.le_scan_window_connect;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_min_connection_interval) {
> +               params[i].parameter_type = 0x0017;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_min_connection_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_max_connection_interval) {
> +               params[i].parameter_type = 0x0018;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_max_connection_interval;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_connection_latency) {
> +               params[i].parameter_type = 0x0019;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value =
> +                       main_opts.default_params.le_connection_latency;
> +               ++i;
> +       }
> +
> +       if (main_opts.default_params.le_connection_lsto) {
> +               params[i].parameter_type = 0x001a;
> +               params[i].length = sizeof(params[i].value);
> +               params[i].value = main_opts.default_params.le_connection_lsto;
> +               ++i;
> +       }
> +
> +       mgmt_send(adapter->mgmt, MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
> +                       adapter->dev_id, cp_size, params, NULL, NULL, NULL);
> +
> +       btd_error(adapter->dev_id,
> +                               "Failed to set default system params for hci%u",
> +                               adapter->dev_id);

I guess we are missing a if statement above otherwise this will always
be printing an error.

> +
> +       g_free(params);
> +}
> +
>  static void load_devices(struct btd_adapter *adapter)
>  {
>         char dirname[PATH_MAX];
> @@ -8265,6 +8511,7 @@ load:
>         load_drivers(adapter);
>         btd_profile_foreach(probe_profile, adapter);
>         clear_blocked(adapter);
> +       load_default_system_params(adapter);
>         load_devices(adapter);
>
>         /* restore Service Changed CCC value for bonded devices */
> @@ -9158,6 +9405,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
>                         DBG("kernel supports the set_blocked_keys op");
>                         kernel_blocked_keys_supported = true;
>                         break;
> +               case MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS:
> +                       DBG("kernel supports set system params");
> +                       kernel_set_system_params = true;
> +                       break;
>                 default:
>                         break;
>                 }
> diff --git a/src/hcid.h b/src/hcid.h
> index 1bf93784d..e6d966c58 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -49,6 +49,45 @@ struct main_opts {
>         uint32_t        discovto;
>         uint8_t         privacy;
>
> +       struct {
> +               uint16_t        num_set_params;
> +
> +               uint16_t        br_page_scan_type;
> +               uint16_t        br_page_scan_interval;
> +               uint16_t        br_page_scan_window;
> +
> +               uint16_t        br_inquiry_scan_type;
> +               uint16_t        br_inquiry_scan_interval;
> +               uint16_t        br_inquiry_scan_window;
> +
> +               uint16_t        br_link_supervision_timeout;
> +               uint16_t        br_page_timeout;
> +
> +               uint16_t        br_min_sniff_interval;
> +               uint16_t        br_max_sniff_interval;
> +
> +               uint16_t        le_min_adv_interval;
> +               uint16_t        le_max_adv_interval;
> +               uint16_t        le_multi_adv_rotation_interval;
> +
> +               uint16_t        le_scan_interval_autoconnect;
> +               uint16_t        le_scan_window_autoconnect;
> +               uint16_t        le_scan_interval_suspend;
> +               uint16_t        le_scan_window_suspend;
> +               uint16_t        le_scan_interval_discovery;
> +               uint16_t        le_scan_window_discovery;
> +               uint16_t        le_scan_interval_adv_monitor;
> +               uint16_t        le_scan_window_adv_monitor;
> +               uint16_t        le_scan_interval_connect;
> +               uint16_t        le_scan_window_connect;
> +
> +               uint16_t        le_min_connection_interval;
> +               uint16_t        le_max_connection_interval;
> +               uint16_t        le_connection_latency;
> +               uint16_t        le_connection_lsto;
> +       } default_params;
> +
> +
>         gboolean        reverse_discovery;
>         gboolean        name_resolv;
>         gboolean        debug_keys;
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>


-- 
Luiz Augusto von Dentz
