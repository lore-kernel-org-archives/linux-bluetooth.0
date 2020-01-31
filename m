Return-Path: <SRS0=covd=3U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0AC33CB2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 03:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398620CC7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 03:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTVL0cUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgAaD1u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:27:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54760 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgAaD1u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 22:27:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id g1so6238931wmh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 19:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSKruqJ/WQ9CFzLw+y2LqH6OAopvrDrbcN3JTRY3iMs=;
        b=uTVL0cUAvTSods/y86qFItSS2bYJuvaUaYZYjpioMSAg02jWuGPERKTw7e6/Thuvbb
         xKhxENSY6kN5vGOiqr/seLL3R3XyNGrUHdBqDv/EoDeArzysHred1/xC6DcYxcix3PvA
         Q0uzF1PIP5KvTAZLBtytv+YgS2HD4GasHuFFNf5yojCe5dEeaYUxgQSkn68VUInYtxwG
         7ckgLhOuUpyCu2eL2KQIPKCOABwzjs+XK/kZ2ZvQC7OKcgooaTvvJoRKVeS6fuFI282m
         DMCGmaw1bDrQy/M9gh8IvlrNsaU6Bub1uLOxRdqQNghSZRA4sm5966xj8eP2I9X68y/B
         bTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSKruqJ/WQ9CFzLw+y2LqH6OAopvrDrbcN3JTRY3iMs=;
        b=mhueBh4bsBDjga6rcGS/yReFm3wtoCagbU9dt46XdvnNQ5/4Gmbvd08YHsJSFZ47RS
         RaTzYuoObdJkTEyToJKta8aGGhz4leJve3qsNUrpE+PKoZP5bnn5vOn7xSbCCCiwYJ2T
         MIOCDStrrLH+vFc5qBFuzJbc3OZQX9B+FrNMkolR8P3+PyNeuq2ZmxsJHnCEdx4GqaTM
         drBGIFyfuc2YjH62mBqbqkgEFvKs+/8vblvrfDJCAJOM10BS0SZJN07S1H51KpVUUOsN
         nyG+gM5H/VbvhFr8m2sQxUZ2ZQoRH3VaekeNINFQYmIoGgCPfjb0YKk8o0FAEwh1lqqe
         +LaA==
X-Gm-Message-State: APjAAAUy6xhaoGB87gBGllDYHx+Dd79kNA6YEANc3Er3PajiDjjU7ic7
        s6PXfPmijxYfhbZSZuFBx+3GXND7IDEkdvvVox4RrA==
X-Google-Smtp-Source: APXvYqw7qMagR0Ug7lQAS8FgVAjNzQkmhWHIG93hRg4+MmpgSyMoid3ULiG90N0baL6XWEiJ24EZgj8ZIoJpnJPJPmg=
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr8895102wmj.18.1580441265943;
 Thu, 30 Jan 2020 19:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20200127164943.220776-1-marcel@holtmann.org> <CALWDO_ViEZsqAw-TA5rJ=NfrGpgQJsM2TCoZfoXPOghGi=9Vmg@mail.gmail.com>
In-Reply-To: <CALWDO_ViEZsqAw-TA5rJ=NfrGpgQJsM2TCoZfoXPOghGi=9Vmg@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 31 Jan 2020 11:27:34 +0800
Message-ID: <CAJQfnxHXDOhG-a7Q8BcsBZnib4wYY0L0GcJ6HpFOmj2NKZ1X_A@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Add debugfs option to enable runtime debug statements
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for the fantastic patch! My comments inline.

>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h | 10 ++++-
>  net/bluetooth/Kconfig             |  4 ++
>  net/bluetooth/af_bluetooth.c      |  2 +
>  net/bluetooth/lib.c               | 69 +++++++++++++++++++++++++++++++
>  4 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index e42bb8e03c09..d32d1f401efb 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -129,6 +129,8 @@ void bt_warn(const char *fmt, ...);
>  __printf(1, 2)
>  void bt_err(const char *fmt, ...);
>  __printf(1, 2)
> +void bt_dbg(const char *fmt, ...);
> +__printf(1, 2)
>  void bt_warn_ratelimited(const char *fmt, ...);
>  __printf(1, 2)
>  void bt_err_ratelimited(const char *fmt, ...);
> @@ -136,7 +138,11 @@ void bt_err_ratelimited(const char *fmt, ...);
>  #define BT_INFO(fmt, ...)      bt_info(fmt "\n", ##__VA_ARGS__)
>  #define BT_WARN(fmt, ...)      bt_warn(fmt "\n", ##__VA_ARGS__)
>  #define BT_ERR(fmt, ...)       bt_err(fmt "\n", ##__VA_ARGS__)
> -#define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
> +#if IS_ENABLED(CONFIG_BT_DEBUGFS_OPTION)
> +#define BT_DBG(fmt, ...)       bt_dbg(fmt "\n", ##__VA_ARGS__)
> +#else
> +#define BT_DBG(fmt, ...)       pr_debug(mt "\n", ##__VA_ARGS__)

Should be fmt instead of mt.

> +#endif
>
>  #define bt_dev_info(hdev, fmt, ...)                            \
>         BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> @@ -393,6 +399,8 @@ void bt_procfs_cleanup(struct net *net, const char *name);
>
>  extern struct dentry *bt_debugfs;
>
> +void bt_lib_debugfs_init(void);
> +
>  int l2cap_init(void);
>  void l2cap_exit(void);
>
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 165148c7c4ce..64833640bf3d 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -128,4 +128,8 @@ config BT_DEBUGFS
>           Provide extensive information about internal Bluetooth states
>           in debugfs.
>
> +config BT_DEBUGFS_OPTION
> +       bool
> +       default y if BT_DEBUGFS && !DYNAMIC_DEBUG

If I understand it correctly, setting BT_DEBUGFS_OPTION to true
will cause all of the BT_DBG logs to be loaded into the resulting
build. Prior to the introduction of this config setting, the logs by
default are discarded from the build. Therefore, by introducing this
option, there will be an increase in the size of the build.

Shouldn't this option defaults to false instead?

> +
>  source "drivers/bluetooth/Kconfig"
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 3fd124927d4d..fa0cd665f32a 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -731,6 +731,8 @@ static int __init bt_init(void)
>
>         bt_debugfs = debugfs_create_dir("bluetooth", NULL);
>
> +       bt_lib_debugfs_init();
> +
>         bt_leds_init();
>
>         err = bt_sysfs_init();
> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> index c09e0a3a0ed9..28cfc3fd8fbe 100644
> --- a/net/bluetooth/lib.c
> +++ b/net/bluetooth/lib.c
> @@ -27,6 +27,7 @@
>  #define pr_fmt(fmt) "Bluetooth: " fmt
>
>  #include <linux/export.h>
> +#include <linux/debugfs.h>
>
>  #include <net/bluetooth/bluetooth.h>
>
> @@ -135,6 +136,55 @@ int bt_to_errno(__u16 code)
>  }
>  EXPORT_SYMBOL(bt_to_errno);
>
> +#ifdef CONFIG_BT_DEBUGFS_OPTION
> +static bool debug_enable;
> +
> +static ssize_t debug_enable_read(struct file *file, char __user *user_buf,
> +                                size_t count, loff_t *ppos)
> +{
> +       char buf[3];
> +
> +       buf[0] = debug_enable ? 'Y': 'N';
> +       buf[1] = '\n';
> +       buf[2] = '\0';
> +       return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t debug_enable_write(struct file *file,
> +                                 const char __user *user_buf,
> +                                 size_t count, loff_t *ppos)
> +{
> +       bool enable;
> +       int err;
> +
> +       err = kstrtobool_from_user(user_buf, count, &enable);
> +       if (err)
> +               return err;
> +
> +       if (enable == debug_enable)
> +               return -EALREADY;
> +
> +       debug_enable = enable;
> +
> +       return count;
> +}
> +
> +static const struct file_operations debug_enable_fops = {
> +       .open           = simple_open,
> +       .read           = debug_enable_read,
> +       .write          = debug_enable_write,
> +       .llseek         = default_llseek,
> +};
> +
> +void bt_lib_debugfs_init(void)
> +{
> +       debugfs_create_file("debug_enable", 0644, bt_debugfs, NULL,
> +                           &debug_enable_fops);
> +}
> +#else
> +void bt_lib_debugfs_init(void);

Should be the empty function
bt_lib_debugfs_init(void)
{
}

> +#endif
> +
>  void bt_info(const char *format, ...)
>  {
>         struct va_format vaf;
> @@ -183,6 +233,25 @@ void bt_err(const char *format, ...)
>  }
>  EXPORT_SYMBOL(bt_err);
>
> +void bt_dbg(const char *format, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
> +
> +       if (likely(!debug_enable))
> +               return;
> +
> +       va_start(args, format);
> +
> +       vaf.fmt = format;
> +       vaf.va = &args;
> +
> +       printk(KERN_DEBUG pr_fmt("%pV"), &vaf);
> +
> +       va_end(args);
> +}
> +EXPORT_SYMBOL(bt_dbg);
> +
>  void bt_warn_ratelimited(const char *format, ...)
>  {
>         struct va_format vaf;
> --
> 2.24.1
>

Thanks,
Archie
