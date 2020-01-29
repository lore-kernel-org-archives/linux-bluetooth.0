Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B181C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 00:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396312073A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 00:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsxp2EYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgA2AvJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 19:51:09 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:41036 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgA2AvJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 19:51:09 -0500
Received: by mail-lj1-f174.google.com with SMTP id h23so16652235ljc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4SzeRN4tb4Oag8moFSgx4wSvDhrlGrkBPGrQoZ+aJug=;
        b=fsxp2EYICztXBGUeivluOm+Jh6Xcz8sw3Yw+YnrQuvJPRrnWpKs29/mlkxftYCVCFV
         meFf7h+5W9dimflgnp1BCN6R3IICMVR+/Yja1+BwKXoERrg118L6UhpaSvizvQE4NjIf
         343WjhWHLgqpSYsSld4zNJjg7SvWfQKNN+rSRd8qG+iRnX61ZX1ldAg5TcpKXy8CPv3m
         9FudjxKV0wlyYofUyeL3c8jyJpN8SMFfTWsvUrS/M9G8vSBRUS9hwH418wOVoQIy/D6a
         uqGosNj3Dfc2l2pM5/kKmRKooHSFXhwo/gKqWtPRUxG1CGE1HbDJ7HyezYQ6ulFrIs2T
         qSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SzeRN4tb4Oag8moFSgx4wSvDhrlGrkBPGrQoZ+aJug=;
        b=olBeaWWUEZJKvZXtMbVMVC1xqpow2os/QESS0w96//oXziodNzLrewTj5VYOMO5zK5
         mrYSIFCmAn3FY4zAvy8GkBpBs/CFqh6voHmPhUDZlEYwW3zvgPkwLlUKZx9nEdKlrT2Y
         S9RioyNwWNCiuAz5mELu7oZDL9opeJNQFp5hPdKgXmcyK9s33S7/4ELvl5/Aoiq04ogE
         cFv/J89BosBpxXYGyqx3soHCieGOHjlrbKdKDC+5xY7pMUB6mLRPOwQz1wNMaRKe2cz6
         9cNNTACJclpe2peaaJDb3o5oCsIASHXTwPHGPp9sKvUWrrdYtpWz99cPVGBRfZcj6Izn
         5Xyg==
X-Gm-Message-State: APjAAAWCZgiI4NkQFUrv9c9oIDHjYEqGGWAA+ye14fhfS5hCROK207Bh
        5AIMajaE57hLy4LJj47eFs5n2j+sMoHpJBUEKLphji6yGoI=
X-Google-Smtp-Source: APXvYqz7vp8YfrpnOSQSHzMOXUwP2ROYBa8ddtbxhSWh4LdgnXYUjc8yNlIhOM4PKGH8WW0OwnDp2tQ47ULmScCgmkE=
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr14867557ljk.186.1580259066682;
 Tue, 28 Jan 2020 16:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20200127164943.220776-1-marcel@holtmann.org> <CALWDO_Vbd=KNhjGDEiHSaSDyZh2gc+nJVSaf3ZwN4pVMjaW9sg@mail.gmail.com>
In-Reply-To: <CALWDO_Vbd=KNhjGDEiHSaSDyZh2gc+nJVSaf3ZwN4pVMjaW9sg@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 28 Jan 2020 19:50:54 -0500
Message-ID: <CALWDO_WBQmzDj4RF4iaCp2+Qhz3X6nQqX_bpAF87bmZvuE3Ckg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Add debugfs option to enable runtime debug statements
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Resending in plain text... Sorry, old dog, new tricks... (or is it the
opposite? :))


On Tue, Jan 28, 2020 at 7:48 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Marcel,
>
> Just a quick ack from me.
>
> It looks good for me, but I'd like to get feedback from our team which has implemented the earlier proposal.  The team however in Taipei aren't due back in from holiday until next week, so it may take some time before we get back to you.
>
> Thanks,
> Alain
>
> On Mon, Jan 27, 2020 at 11:49 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>>
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>>  include/net/bluetooth/bluetooth.h | 10 ++++-
>>  net/bluetooth/Kconfig             |  4 ++
>>  net/bluetooth/af_bluetooth.c      |  2 +
>>  net/bluetooth/lib.c               | 69 +++++++++++++++++++++++++++++++
>>  4 files changed, 84 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index e42bb8e03c09..d32d1f401efb 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -129,6 +129,8 @@ void bt_warn(const char *fmt, ...);
>>  __printf(1, 2)
>>  void bt_err(const char *fmt, ...);
>>  __printf(1, 2)
>> +void bt_dbg(const char *fmt, ...);
>> +__printf(1, 2)
>>  void bt_warn_ratelimited(const char *fmt, ...);
>>  __printf(1, 2)
>>  void bt_err_ratelimited(const char *fmt, ...);
>> @@ -136,7 +138,11 @@ void bt_err_ratelimited(const char *fmt, ...);
>>  #define BT_INFO(fmt, ...)      bt_info(fmt "\n", ##__VA_ARGS__)
>>  #define BT_WARN(fmt, ...)      bt_warn(fmt "\n", ##__VA_ARGS__)
>>  #define BT_ERR(fmt, ...)       bt_err(fmt "\n", ##__VA_ARGS__)
>> -#define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
>> +#if IS_ENABLED(CONFIG_BT_DEBUGFS_OPTION)
>> +#define BT_DBG(fmt, ...)       bt_dbg(fmt "\n", ##__VA_ARGS__)
>> +#else
>> +#define BT_DBG(fmt, ...)       pr_debug(mt "\n", ##__VA_ARGS__)
>> +#endif
>>
>>  #define bt_dev_info(hdev, fmt, ...)                            \
>>         BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
>> @@ -393,6 +399,8 @@ void bt_procfs_cleanup(struct net *net, const char *name);
>>
>>  extern struct dentry *bt_debugfs;
>>
>> +void bt_lib_debugfs_init(void);
>> +
>>  int l2cap_init(void);
>>  void l2cap_exit(void);
>>
>> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
>> index 165148c7c4ce..64833640bf3d 100644
>> --- a/net/bluetooth/Kconfig
>> +++ b/net/bluetooth/Kconfig
>> @@ -128,4 +128,8 @@ config BT_DEBUGFS
>>           Provide extensive information about internal Bluetooth states
>>           in debugfs.
>>
>> +config BT_DEBUGFS_OPTION
>> +       bool
>> +       default y if BT_DEBUGFS && !DYNAMIC_DEBUG
>> +
>>  source "drivers/bluetooth/Kconfig"
>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>> index 3fd124927d4d..fa0cd665f32a 100644
>> --- a/net/bluetooth/af_bluetooth.c
>> +++ b/net/bluetooth/af_bluetooth.c
>> @@ -731,6 +731,8 @@ static int __init bt_init(void)
>>
>>         bt_debugfs = debugfs_create_dir("bluetooth", NULL);
>>
>> +       bt_lib_debugfs_init();
>> +
>>         bt_leds_init();
>>
>>         err = bt_sysfs_init();
>> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
>> index c09e0a3a0ed9..28cfc3fd8fbe 100644
>> --- a/net/bluetooth/lib.c
>> +++ b/net/bluetooth/lib.c
>> @@ -27,6 +27,7 @@
>>  #define pr_fmt(fmt) "Bluetooth: " fmt
>>
>>  #include <linux/export.h>
>> +#include <linux/debugfs.h>
>>
>>  #include <net/bluetooth/bluetooth.h>
>>
>> @@ -135,6 +136,55 @@ int bt_to_errno(__u16 code)
>>  }
>>  EXPORT_SYMBOL(bt_to_errno);
>>
>> +#ifdef CONFIG_BT_DEBUGFS_OPTION
>> +static bool debug_enable;
>> +
>> +static ssize_t debug_enable_read(struct file *file, char __user *user_buf,
>> +                                size_t count, loff_t *ppos)
>> +{
>> +       char buf[3];
>> +
>> +       buf[0] = debug_enable ? 'Y': 'N';
>> +       buf[1] = '\n';
>> +       buf[2] = '\0';
>> +       return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
>> +}
>> +
>> +static ssize_t debug_enable_write(struct file *file,
>> +                                 const char __user *user_buf,
>> +                                 size_t count, loff_t *ppos)
>> +{
>> +       bool enable;
>> +       int err;
>> +
>> +       err = kstrtobool_from_user(user_buf, count, &enable);
>> +       if (err)
>> +               return err;
>> +
>> +       if (enable == debug_enable)
>> +               return -EALREADY;
>> +
>> +       debug_enable = enable;
>> +
>> +       return count;
>> +}
>> +
>> +static const struct file_operations debug_enable_fops = {
>> +       .open           = simple_open,
>> +       .read           = debug_enable_read,
>> +       .write          = debug_enable_write,
>> +       .llseek         = default_llseek,
>> +};
>> +
>> +void bt_lib_debugfs_init(void)
>> +{
>> +       debugfs_create_file("debug_enable", 0644, bt_debugfs, NULL,
>> +                           &debug_enable_fops);
>> +}
>> +#else
>> +void bt_lib_debugfs_init(void);
>> +#endif
>> +
>>  void bt_info(const char *format, ...)
>>  {
>>         struct va_format vaf;
>> @@ -183,6 +233,25 @@ void bt_err(const char *format, ...)
>>  }
>>  EXPORT_SYMBOL(bt_err);
>>
>> +void bt_dbg(const char *format, ...)
>> +{
>> +       struct va_format vaf;
>> +       va_list args;
>> +
>> +       if (likely(!debug_enable))
>> +               return;
>> +
>> +       va_start(args, format);
>> +
>> +       vaf.fmt = format;
>> +       vaf.va = &args;
>> +
>> +       printk(KERN_DEBUG pr_fmt("%pV"), &vaf);
>> +
>> +       va_end(args);
>> +}
>> +EXPORT_SYMBOL(bt_dbg);
>> +
>>  void bt_warn_ratelimited(const char *format, ...)
>>  {
>>         struct va_format vaf;
>> --
>> 2.24.1
>>
