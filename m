Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200701301135.53178.oliver@neukum.name>
References: <200701301135.53178.oliver@neukum.name>
Date: Tue, 30 Jan 2007 11:52:08 +0100
Message-Id: <1170154328.27519.27.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net, linux-kernel@vger.kernel.org, maxk@qualcomm.com
Subject: Re: [Bluez-devel] trouble with sysfs and bluetooth
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Oliver,

> I am constantly getting these messages in 2.6.20-rc6 Greg's tree:
> 
> Jan 30 11:26:42 valisk kernel: Bluetooth: Core ver 2.11
> Jan 30 11:26:42 valisk kernel: PM: Adding info for platform:bluetooth
> Jan 30 11:26:42 valisk kernel: kobject_add failed for bluetooth with -EEXIST, don't try to register things with the same name in the same directory.
> Jan 30 11:26:42 valisk kernel:
> Jan 30 11:26:42 valisk kernel: Call Trace:
> Jan 30 11:26:42 valisk kernel:  [<ffffffff802f4e3b>] kobject_shadow_add+0x147/0x17b
> Jan 30 11:26:42 valisk kernel:  [<ffffffff802f5162>] subsystem_register+0x1b/0x2a
> Jan 30 11:26:42 valisk kernel:  [<ffffffff803773db>] class_register+0xbf/0x1bd
> Jan 30 11:26:42 valisk kernel:  [<ffffffff80377a7e>] class_create+0x53/0x71
> Jan 30 11:26:42 valisk kernel:  [<ffffffff881c711c>] :bluetooth:bt_sysfs_init+0x5a/0x8b
> Jan 30 11:26:42 valisk kernel:  [<ffffffff881c701b>] :bluetooth:bt_init+0x1b/0x53
> Jan 30 11:26:42 valisk kernel:  [<ffffffff8023bf0a>] sys_init_module+0x1467/0x15c3
> Jan 30 11:26:42 valisk kernel:  [<ffffffff80208fee>] system_call+0x7e/0x83
> Jan 30 11:26:42 valisk kernel:
> Jan 30 11:26:42 valisk kernel: PM: Removing info for platform:bluetooth
> Jan 30 11:26:43 valisk kernel: Bluetooth: Core ver 2.11
> Jan 30 11:26:44 valisk kernel: PM: Adding info for platform:bluetooth
> Jan 30 11:26:44 valisk kernel: kobject_add failed for bluetooth with -EEXIST, don't try to register things with the same name in the same directory.
> Jan 30 11:26:44 valisk kernel:
> Jan 30 11:26:44 valisk kernel: Call Trace:
> Jan 30 11:26:45 valisk kernel:  [<ffffffff802f4e3b>] kobject_shadow_add+0x147/0x17b
> Jan 30 11:26:45 valisk kernel:  [<ffffffff802f5162>] subsystem_register+0x1b/0x2a
> Jan 30 11:26:45 valisk kernel:  [<ffffffff803773db>] class_register+0xbf/0x1bd
> Jan 30 11:26:45 valisk kernel:  [<ffffffff80377a7e>] class_create+0x53/0x71
> Jan 30 11:26:46 valisk kernel:  [<ffffffff881c711c>] :bluetooth:bt_sysfs_init+0x5a/0x8b
> Jan 30 11:26:46 valisk kernel:  [<ffffffff881c701b>] :bluetooth:bt_init+0x1b/0x53
> Jan 30 11:26:46 valisk kernel:  [<ffffffff8023bf0a>] sys_init_module+0x1467/0x15c3
> Jan 30 11:26:46 valisk kernel:  [<ffffffff80208fee>] system_call+0x7e/0x83
> Jan 30 11:26:46 valisk kernel:

do you see them also with the plain vanilla 2.6.20-rc6 kernel or are
these only coming up in Greg's tree?

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
