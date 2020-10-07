Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A197C4363C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 06:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055D9206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 06:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skXWPEOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgJGG0a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 02:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGG0a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 02:26:30 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B50FC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 23:26:30 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id w7so346012oow.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1TXGHjvZJ2M687Tpx7iKyXIN4ruPxyXzbVf2itvGJU=;
        b=skXWPEORhyt4BvlKvmX+SeYY97+KGT0UX4zAQseWv52xaNEdsKauUZWZALuXmYFy/I
         0bZBXt1jTe+q6lD9iDjdfavOgudr52lva9xRDwBLQNjfc7SS5ms3s6Xx6K0hnhMfZmOT
         Lamo5n1jFl/wHzRbPryJRCmuDeDmC7RuCInNkQDPurXNUJXUapGksPfOJmBGXfu9BPue
         kf0RUc9aQ27UzZlGOKln76XuvlZr9WX+iVx9miT87Ln4sCIMHgaP89X/B/WPAI/Cth9x
         A+5SYthNBnd7Nw+CQY107C2+u+wALXRlzDsWgzu6Fw5x1lZfttieAu0BDpmT7uavg6jk
         t+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1TXGHjvZJ2M687Tpx7iKyXIN4ruPxyXzbVf2itvGJU=;
        b=JEgVrCxqWknzmIeBCB+pcZfklkaNkbjHwiLW893t8fnP3hOatKD4SjIGgMZTMFQ9j4
         N8r2S1D9OZn8dBnWzM082gRxl4DxVPfmD7OLCD6aYXk4lBstkO9ilZ/EcxSXUN7JIlrK
         JvMyqQ8fHismFWCi++Q3onIrg8cEZ0nKlMpJSK/8saTFe/wrr9BryXUsKPks3CgyMIXn
         AXKz7NRToCTrPB2E0zCgbo5ColAc1wSgFv19H/7LQhc09Ea8ZZyMIqU7bKajh72D9PPu
         wBXXDrwK1Jn2+8GkRktCwcN6TuE6otMnVcVJXot6RghEJdA/mp6ZEMk1/83VAjUzhZNx
         he7w==
X-Gm-Message-State: AOAM531Ou5P3eXoJDw3O2BLycabWKhXnzfRpm4rCnXuM/CPf74G2LK0t
        pSU+wWv8vcAzwHOEAJQVr1K5LkhZcs1VO+MDD5s=
X-Google-Smtp-Source: ABdhPJxBRg4RsFMLxo2m6aroOIl9f9BELOl9cVbftidWsgdKR3whZMKKDYdIMhW97q1qDU+PKl73zWE31cJnV2fHPkg=
X-Received: by 2002:a4a:a787:: with SMTP id l7mr1086427oom.63.1602051989330;
 Tue, 06 Oct 2020 23:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
 <20201006171333.BlueZ.v6.4.Ibbcb11712b613ef95c31b41207c3ea945c830018@changeid>
In-Reply-To: <20201006171333.BlueZ.v6.4.Ibbcb11712b613ef95c31b41207c3ea945c830018@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 6 Oct 2020 23:26:16 -0700
Message-ID: <CABBYNZLPAuK4K3tRnMhon5FSytPbhW8UHKWdQap0n73pXke-5A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6 4/6] adv_monitor: Implement Add Adv Patterns
 Monitor cmd handler
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Tue, Oct 6, 2020 at 5:17 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> From: Howard Chung <howardchung@google.com>
>
> - Send the MGMT_OP command to kernel upon registration of a Adv patterns
> monitor.
> - Call Activate() or Release() to client depending on the reply from
>   kernel
>
> the call through syslog
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> ---
>
> (no changes since v1)
>
>  src/adv_monitor.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index fcb127cd4..582cc9a46 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -588,11 +588,59 @@ done:
>         return monitor->state != MONITOR_STATE_FAILED;
>  }
>
> +/* Handles the callback of Add Adv Patterns Monitor command */
> +static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
> +                                       const void *param, void *user_data)
> +{
> +       const struct mgmt_rp_add_adv_patterns_monitor *rp = param;
> +       struct adv_monitor *monitor = user_data;
> +       uint16_t adapter_id = monitor->app->manager->adapter_id;
> +
> +       if (status != MGMT_STATUS_SUCCESS || !param) {
> +               btd_error(adapter_id, "Failed to Add Adv Patterns Monitor "
> +                               "with status 0x%02x", status);
> +               monitor_release(monitor, NULL);
> +               return;
> +       }
> +
> +       if (length < sizeof(*rp)) {
> +               btd_error(adapter_id, "Wrong size of Add Adv Patterns Monitor "
> +                               "response");
> +               monitor_release(monitor, NULL);
> +               return;
> +       }
> +
> +       monitor->state = MONITOR_STATE_HONORED;

I would reword this state to ACTIVE instead of HONORED as it seems
more consistent.

> +       DBG("Calling Activate() on Adv Monitor of owner %s at path %s",
> +               monitor->app->owner, monitor->path);
> +
> +       g_dbus_proxy_method_call(monitor->proxy, "Activate", NULL, NULL, NULL,
> +                                       NULL);
> +
> +       DBG("Adv Monitor with handle:0x%04x added",
> +                                       le16_to_cpu(rp->monitor_handle));
> +}
> +
> +static void monitor_copy_patterns(void *data, void *user_data)
> +{
> +       struct btd_adv_monitor_pattern *pattern = data;
> +       struct mgmt_cp_add_adv_monitor *cp = user_data;
> +
> +       if (!pattern)
> +               return;
> +
> +       memcpy(cp->patterns + cp->pattern_count, pattern, sizeof(*pattern));
> +       cp->pattern_count++;
> +}
> +
>  /* Handles an Adv Monitor D-Bus proxy added event */
>  static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
>  {
>         struct adv_monitor *monitor;
>         struct adv_monitor_app *app = user_data;
> +       struct mgmt_cp_add_adv_monitor *cp = NULL;
> +       uint8_t pattern_count, cp_len;
>         uint16_t adapter_id = app->manager->adapter_id;
>         const char *path = g_dbus_proxy_get_path(proxy);
>         const char *iface = g_dbus_proxy_get_interface(proxy);
> @@ -625,7 +673,24 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
>
>         queue_push_tail(app->monitors, monitor);
>
> +       pattern_count = queue_length(monitor->patterns);
> +       cp_len = sizeof(struct mgmt_cp_add_adv_monitor) +
> +                       pattern_count * sizeof(struct mgmt_adv_pattern);
> +
> +       cp = malloc0(cp_len);
> +       queue_foreach(monitor->patterns, monitor_copy_patterns, cp);
> +
> +       if (!mgmt_send(app->manager->mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
> +                       adapter_id, cp_len, cp, add_adv_patterns_monitor_cb,
> +                       monitor, NULL)) {
> +               error("Unable to send Add Adv Patterns Monitor command");
> +               goto done;
> +       }
> +
>         DBG("Adv Monitor allocated for the object at path %s", path);
> +
> +done:
> +       free(cp);
>  }
>
>  /* Handles the removal of an Adv Monitor D-Bus proxy */
> @@ -1036,7 +1101,7 @@ static void adv_match_per_monitor(void *data, void *user_data)
>         struct adv_monitor *monitor = data;
>         struct adv_content_filter_info *info = user_data;
>
> -       if (!monitor && monitor->state != MONITOR_STATE_HONORED)
> +       if (!monitor || monitor->state != MONITOR_STATE_HONORED)
>                 return;
>
>         /* Reset the intermediate matched status */
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
