Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=yuqTG1MiqN3FHM+2m0OX9QNajq8+xJG_D1-EG@mail.gmail.com>
References: <AANLkTi=yuqTG1MiqN3FHM+2m0OX9QNajq8+xJG_D1-EG@mail.gmail.com>
Date: Fri, 11 Feb 2011 17:07:56 -0600
Message-ID: <AANLkTi=qB6WcjkQcp0teuL5DTKKBSSK0ydWD1EtwCh=n@mail.gmail.com>
Subject: HCI core error recovery.
From: Andrei Warkentin <andreiw@motorola.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear List,

I've run into an interesting problem. Excuse me in advance if this was
already covered here, or for my explanations, since I'm not too
familiar with overall flow within BlueZ or Bluetooth specifics...
We've had some hardware config issues that resulted in garbage/malformed
messages arriving via H4 into the HCI layer. We've since resolved
these, but it got me thinking. The issues would result in certain HCI
messages being missed, including occasionally disconnect events being
missed, and a subsequent connect event would result in a double add.

I was thinking about how to fix at the very least the crash. The sysfs
object is created as a last step after getting a "connection
completed" HCI message, I think. What I am unsure about is if it's
safe to just ignore the add if there is already a sysfs entry...

So I would think the HCI core needs some resiliency against
bad/malignant bluetooth controllers, and perform error
recovery/resynchronization. Perhaps maybe there is room for a virtual
hci controller that just injects various message types to see how well
the core can cope?

Thanks in advance,
A

[60197.080512] ------------[ cut here ]------------
[60197.085805] WARNING: at lib/list_debug.c:30 __list_add+0x60/0x80()
[60197.092426] list_add corruption. prev->next should be next
(da77fce8), but was cad1c39c. (prev=cad1c39c).
[60197.102778] Modules linked in: [last unloaded: bcm4329]
[60197.110097] [<c003a5f0>] (unwind_backtrace+0x0/0xf0) from
[<c006f774>] (warn_slowpath_common+0x4c/0x64)
[60197.120668] [<c006f774>] (warn_slowpath_common+0x4c/0x64) from
[<c006f80c>] (warn_slowpath_fmt+0x2c/0x3c)
[60197.130896] [<c006f80c>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c01c9d18>] (__list_add+0x60/0x80)
[60197.140758] [<c01c9d18>] (__list_add+0x60/0x80) from [<c03e0920>]
(klist_add_tail+0x30/0x3c)
[60197.149903] [<c03e0920>] (klist_add_tail+0x30/0x3c) from
[<c0207868>] (device_add+0x35c/0x4b4)
[60197.159190] [<c0207868>] (device_add+0x35c/0x4b4) from [<c03ca444>]
(add_conn+0x38/0x100)
[60197.167754] [<c03ca444>] (add_conn+0x38/0x100) from [<c0081bec>]
(process_one_work+0x214/0x378)
[60197.177063] [<c0081bec>] (process_one_work+0x214/0x378) from
[<c0082130>] (worker_thread+0x224/0x39c)
[60197.187011] [<c0082130>] (worker_thread+0x224/0x39c) from
[<c0087180>] (kthread+0x80/0x88)
[60197.196052] [<c0087180>] (kthread+0x80/0x88) from [<c0035c04>]
(kernel_thread_exit+0x0/0x8)
[60197.205072] ---[ end trace 4576f4f7aba96cc4 ]---
[60197.214585] ------------[ cut here ]------------
[60197.219714] WARNING: at lib/list_debug.c:30 __list_add+0x60/0x80()
[60197.226507] list_add corruption. prev->next should be next
(ee1af820), but was e8a102d0. (prev=e8a102d0).
[60197.236701] Modules linked in: [last unloaded: bcm4329]
[60197.243157] [<c003a5f0>] (unwind_backtrace+0x0/0xf0) from
[<c006f774>] (warn_slowpath_common+0x4c/0x64)
[60197.253266] [<c006f774>] (warn_slowpath_common+0x4c/0x64) from
[<c006f80c>] (warn_slowpath_fmt+0x2c/0x3c)
[60197.263803] [<c006f80c>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c01c9d18>] (__list_add+0x60/0x80)
[60197.273243] [<c01c9d18>] (__list_add+0x60/0x80) from [<c03e0920>]
(klist_add_tail+0x30/0x3c)
[60197.282069] [<c03e0920>] (klist_add_tail+0x30/0x3c) from
[<c0207894>] (device_add+0x388/0x4b4)
[60197.291356] [<c0207894>] (device_add+0x388/0x4b4) from [<c03ca444>]
(add_conn+0x38/0x100)
[60197.300269] [<c03ca444>] (add_conn+0x38/0x100) from [<c0081bec>]
(process_one_work+0x214/0x378)
[60197.309629] [<c0081bec>] (process_one_work+0x214/0x378) from
[<c0082130>] (worker_thread+0x224/0x39c)
[60197.319238] [<c0082130>] (worker_thread+0x224/0x39c) from
[<c0087180>] (kthread+0x80/0x88)
[60197.328179] [<c0087180>] (kthread+0x80/0x88) from [<c0035c04>]
(kernel_thread_exit+0x0/0x8)
[60197.337101] ---[ end trace 4576f4f7aba96cc5 ]---
