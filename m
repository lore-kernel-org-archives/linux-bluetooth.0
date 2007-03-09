Return-Path: <SRS0+4f1e0d28af8560107a14+1293+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [Bluez-devel] HID disconnect oops with 2.6.21-rc3
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Cc: marcel@holtmann.org
In-Reply-To: <1173430940.3461.557.camel@pmac.infradead.org>
References: <1173429077.3461.554.camel@pmac.infradead.org>
	 <1173430940.3461.557.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 11:13:49 +0000
Message-Id: <1173438829.3461.585.camel@pmac.infradead.org>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2007-03-09 at 09:02 +0000, David Woodhouse wrote:
> 0xc01ccf04 is in class_uevent (drivers/base/class.c:388).
> 383                     return 0;
> 384
> 385             /* add device, backing this class device (deprecated) */
> 386             path = kobject_get_path(&dev->kobj, GFP_KERNEL);
> 387
> 388             add_uevent_var(envp, num_envp, cur_index, buffer, buffer_size,
> 389                            cur_len, "PHYSDEVPATH=%s", path);
> 390             kfree(path);
> 391
> 392             if (dev->bus)

Reverting commits f5ffd4620aba9e55656483ae1ef5c79ba81f5403 and
e1aaadd4d8162a2c33e41dd5a72234ea4d3b014f (my first suspects) didn't fix
the oops. It just makes it looks like this instead:

NIP [C001890C] strlen+0x4/0x18
LR [C012C760] kobject_get_path+0x34/0xc4
Call Trace:
[EEFCFE80] [C0092884] __kmalloc_track_caller+0x144/0x164 (unreliable)
[EEFCFEA0] [C01CCF04] class_uevent+0x48/0x1c0
[EEFCFEE0] [C012CED8] kobject_uevent_env+0x278/0x490
[EEFCFF30] [C01CC6A0] class_device_del+0x178/0x1a0
[EEFCFF50] [C01CC6E0] class_device_unregister+0x18/0x30
[EEFCFF70] [C021DD38] input_unregister_device+0x13c/0x178
[EEFCFF90] [F25CF490] hidp_session+0x4d8/0x50c [hidp]
[EEFCFFF0] [C0013F7C] kernel_thread+0x44/0x60

-- 
dwmw2
