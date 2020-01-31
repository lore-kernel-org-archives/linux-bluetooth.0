Return-Path: <SRS0=covd=3U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410F7C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 15:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBA820661
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 15:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAaPRa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:17:30 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57189 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgAaPRa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jan 2020 10:17:30 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7203BCECE6;
        Fri, 31 Jan 2020 16:26:49 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [RFC] Bluetooth: Add debugfs option to enable runtime debug
 statements
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJQfnxHXDOhG-a7Q8BcsBZnib4wYY0L0GcJ6HpFOmj2NKZ1X_A@mail.gmail.com>
Date:   Fri, 31 Jan 2020 16:17:28 +0100
Cc:     Alain Michaud <alainmichaud@google.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6805A59F-9B5F-44A7-842D-307F4BA815FD@holtmann.org>
References: <20200127164943.220776-1-marcel@holtmann.org>
 <CALWDO_ViEZsqAw-TA5rJ=NfrGpgQJsM2TCoZfoXPOghGi=9Vmg@mail.gmail.com>
 <CAJQfnxHXDOhG-a7Q8BcsBZnib4wYY0L0GcJ6HpFOmj2NKZ1X_A@mail.gmail.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> Thanks for the fantastic patch! My comments inline.
> 
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> include/net/bluetooth/bluetooth.h | 10 ++++-
>> net/bluetooth/Kconfig             |  4 ++
>> net/bluetooth/af_bluetooth.c      |  2 +
>> net/bluetooth/lib.c               | 69 +++++++++++++++++++++++++++++++
>> 4 files changed, 84 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index e42bb8e03c09..d32d1f401efb 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -129,6 +129,8 @@ void bt_warn(const char *fmt, ...);
>> __printf(1, 2)
>> void bt_err(const char *fmt, ...);
>> __printf(1, 2)
>> +void bt_dbg(const char *fmt, ...);
>> +__printf(1, 2)
>> void bt_warn_ratelimited(const char *fmt, ...);
>> __printf(1, 2)
>> void bt_err_ratelimited(const char *fmt, ...);
>> @@ -136,7 +138,11 @@ void bt_err_ratelimited(const char *fmt, ...);
>> #define BT_INFO(fmt, ...)      bt_info(fmt "\n", ##__VA_ARGS__)
>> #define BT_WARN(fmt, ...)      bt_warn(fmt "\n", ##__VA_ARGS__)
>> #define BT_ERR(fmt, ...)       bt_err(fmt "\n", ##__VA_ARGS__)
>> -#define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
>> +#if IS_ENABLED(CONFIG_BT_DEBUGFS_OPTION)
>> +#define BT_DBG(fmt, ...)       bt_dbg(fmt "\n", ##__VA_ARGS__)
>> +#else
>> +#define BT_DBG(fmt, ...)       pr_debug(mt "\n", ##__VA_ARGS__)
> 
> Should be fmt instead of mt.

Indeed.

> 
>> +#endif
>> 
>> #define bt_dev_info(hdev, fmt, ...)                            \
>>        BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
>> @@ -393,6 +399,8 @@ void bt_procfs_cleanup(struct net *net, const char *name);
>> 
>> extern struct dentry *bt_debugfs;
>> 
>> +void bt_lib_debugfs_init(void);
>> +
>> int l2cap_init(void);
>> void l2cap_exit(void);
>> 
>> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
>> index 165148c7c4ce..64833640bf3d 100644
>> --- a/net/bluetooth/Kconfig
>> +++ b/net/bluetooth/Kconfig
>> @@ -128,4 +128,8 @@ config BT_DEBUGFS
>>          Provide extensive information about internal Bluetooth states
>>          in debugfs.
>> 
>> +config BT_DEBUGFS_OPTION
>> +       bool
>> +       default y if BT_DEBUGFS && !DYNAMIC_DEBUG
> 
> If I understand it correctly, setting BT_DEBUGFS_OPTION to true
> will cause all of the BT_DBG logs to be loaded into the resulting
> build. Prior to the introduction of this config setting, the logs by
> default are discarded from the build. Therefore, by introducing this
> option, there will be an increase in the size of the build.
> 
> Shouldn't this option defaults to false instead?

It defaults to y only if you a) selected BT_DEBUGFS and b) have disabled DYNAMIC_DEBUG. Otherwise it is off and defaults back to using pr_debug. Which is in case of disabled DYNAMIC_DEBUG results in disabled debug statement.

So it is not worth than with dynamic debug. We could tweak the bt_dbg part a bit to reduce the overhead, but it is not as bad. However what we can add is an extra comment in the BT_DEBUGFS help text to mention that case with DYNAMIC_DEBUG disabled.

>> +
>> source "drivers/bluetooth/Kconfig"
>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>> index 3fd124927d4d..fa0cd665f32a 100644
>> --- a/net/bluetooth/af_bluetooth.c
>> +++ b/net/bluetooth/af_bluetooth.c
>> @@ -731,6 +731,8 @@ static int __init bt_init(void)
>> 
>>        bt_debugfs = debugfs_create_dir("bluetooth", NULL);
>> 
>> +       bt_lib_debugfs_init();
>> +
>>        bt_leds_init();
>> 
>>        err = bt_sysfs_init();
>> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
>> index c09e0a3a0ed9..28cfc3fd8fbe 100644
>> --- a/net/bluetooth/lib.c
>> +++ b/net/bluetooth/lib.c
>> @@ -27,6 +27,7 @@
>> #define pr_fmt(fmt) "Bluetooth: " fmt
>> 
>> #include <linux/export.h>
>> +#include <linux/debugfs.h>
>> 
>> #include <net/bluetooth/bluetooth.h>
>> 
>> @@ -135,6 +136,55 @@ int bt_to_errno(__u16 code)
>> }
>> EXPORT_SYMBOL(bt_to_errno);
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
> 
> Should be the empty function
> bt_lib_debugfs_init(void)
> {
> }
> 

Correct. I screwed this up.

Regards

Marcel

