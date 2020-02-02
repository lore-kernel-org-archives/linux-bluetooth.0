Return-Path: <SRS0=QFyp=3W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA30C35240
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Feb 2020 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31228206E6
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Feb 2020 10:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAF6/ziW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgBBKcD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Feb 2020 05:32:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBBKcD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Feb 2020 05:32:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so14216534wru.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Feb 2020 02:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iw/jlpnFKgvGjPb/LDuHqevkQbtcEh7gdl9bjXy0GUQ=;
        b=VAF6/ziWcVxi2/k+VYwkLV1UnkRdnDHlJJuL7Lo9hBSC9RHDpNe5LEh9quzWpT6EOD
         WH0oqO7g9d+8B6Mw6eHvltkMWrEjTwIzl67YJ2xPbJYYLj/dCOA6ejkS2oHD3ohTykuG
         J0q0t66QKkmk3FiRnkJwLcUjXf4/Ra/aKeM5v46K4EDIMarmzLoYd544kfHIQP1ZLjoW
         3ICrGkn+kpX44BQBKYNUyuFjyo0QGg+xAY2giMX7CTeXQ8ErXkVpadnQHwqM874ij4k3
         LJliSrRz7Nn3pqLq8sAweHRJwWz4NsFHaJqQbmj3ReWqaOTZyq2/N8Xz6NO3Ooj6VRxV
         ql5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iw/jlpnFKgvGjPb/LDuHqevkQbtcEh7gdl9bjXy0GUQ=;
        b=VnLn/+ups6TwhZg9QlJPZ2Sxw0NPRiFnYPn+nUJZfxvXJ2TUUbDjfK+dfgbG7wRA9G
         zwogt+OuR5Fjs50PiOpRe408vpLIn06B//i+b4tf8E/u6rLQoeX88JL4681HDkFC/m3B
         M1CeaQ+iY98ulHwYMQLONhsIGqDENghLEKTL64jW9y6Mn/6gDh7x2GgFuxlyvQVZDCqx
         qONU9P8692GzK2dAkPe5/utyOJmQB2p9uqb/XVp3N+C0mYlFqAIdFLP+cbQ81PiNqXB2
         zZyg/1+bdyyoQl72qYwBfLFxLJvSt3iMAI7jqvITtmbS3gOJY390JJASrkH69iY7+2F/
         HSUg==
X-Gm-Message-State: APjAAAUmERl4MtDToy3cF6wvbwTD71OhpmE3C1UazQ7D7D4Sin/o8Cv6
        f/rcfH8KbNrU7qE7KxG4DS+Ap0QyjdDsvn23CxJQJKRU
X-Google-Smtp-Source: APXvYqylJE0I3A5NQo5+WCSIzhXA8GQQHtgiOEmYxvGToEq2K5v8R2vhY9VVt/WyWWNE83sZ3FyioS+i1b3kk0a+QDE=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr9627177wrs.365.1580639519796;
 Sun, 02 Feb 2020 02:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20200131220401.27520-1-marcel@holtmann.org>
In-Reply-To: <20200131220401.27520-1-marcel@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Sun, 2 Feb 2020 18:31:47 +0800
Message-ID: <CAJQfnxFssxREB5sOSsW5WM8bqLkrKk=ySZSnbZ7wojfBMFGyKA@mail.gmail.com>
Subject: Re: [RFC v2] Bluetooth: Add debugfs option to enable runtime debug statements
To:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainmichaud@google.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Alain,

Looks wonderful to me.

On Sat, 1 Feb 2020 at 06:04, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h |  8 ++++
>  net/bluetooth/Kconfig             |  7 +++
>  net/bluetooth/af_bluetooth.c      |  2 +
>  net/bluetooth/lib.c               | 71 +++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index e42bb8e03c09..04f122957314 100644
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
> +#if IS_ENABLED(CONFIG_BT_DEBUGFS_OPTION)
> +#define BT_DBG(fmt, ...)       bt_dbg(fmt "\n", ##__VA_ARGS__)
> +#else
>  #define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
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
> index 165148c7c4ce..2871d0770c11 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -128,4 +128,11 @@ config BT_DEBUGFS
>           Provide extensive information about internal Bluetooth states
>           in debugfs.
>
> +         When dynamic debug is not used, then this option also includes
> +         a switch to enable/disable internal debug statements.
> +
> +config BT_DEBUGFS_OPTION
> +       bool
> +       default y if BT_DEBUGFS && !DYNAMIC_DEBUG
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
> index c09e0a3a0ed9..47c7b0244d1d 100644
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
> @@ -135,6 +136,57 @@ int bt_to_errno(__u16 code)
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
> +void bt_lib_debugfs_init(void)
> +{
> +}
> +#endif
> +
>  void bt_info(const char *format, ...)
>  {
>         struct va_format vaf;
> @@ -183,6 +235,25 @@ void bt_err(const char *format, ...)
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
