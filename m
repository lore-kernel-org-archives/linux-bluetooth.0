Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474C398D.1000701@pracucci.com>
Date: Tue, 27 Nov 2007 16:36:45 +0100
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: Dave Young <hidave.darkstar@gmail.com>,
        Bluez Development ML <bluez-devel@lists.sourceforge.net>
References: <4746EC10.5080509@pracucci.com>
	<20071127103239.GA4477@darkstar.te-china.tietoenator.com>
In-Reply-To: <20071127103239.GA4477@darkstar.te-china.tietoenator.com>
Subject: Re: [Bluez-devel] 2.6.23.8: kernel panic
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Dave,
> This problem is caused by the workqueue in hci_sysfs.c, the del_conn
> is scheduled after the add_conn with same bluetooth address.
> Please try this patch:
> ----------------------------
>
> The bluetooth hci conn sysfs add/del executed in the default workqueue. If the conn del function is executed after the new conn add function with same bluetooth target address, the connection add will failed and warning about same kobject name.
>
> Here add a btconn workqueue, and flush the workqueue in the add_conn function to avoid the above issue. 
>   
I have applied your patch against kernel 2.6.24-rc3 and I've got the
following error:

Jan 1 00:13:01 user.warn kernel: run_workqueue: recursion depth exceeded: 4
Jan 1 00:13:01 user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from
[<c00485cc>] (run_workqueue+0x4c/0x144)
Jan 1 00:13:01 user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144)
from [<c00486f8>] (flush_cpu_workqueue+0x34/0x94)
Jan 1 00:13:01 user.warn kernel: r6:c020d624 r5:c05bc088 r4:00000001
Jan 1 00:13:01 user.warn kernel: [<c00486c4>]
(flush_cpu_workqueue+0x0/0x94) from [<c0048cc0>] (flush_workqueue+0x14/0x18)
Jan 1 00:13:01 user.warn kernel: r4:c03c9420
Jan 1 00:13:01 user.warn kernel: [<c0048cac>] (flush_workqueue+0x0/0x18)
from [<c020d640>] (add_conn+0x1c/0x80)
Jan 1 00:13:01 user.warn kernel: [<c020d624>] (add_conn+0x0/0x80) from
[<c0048634>] (run_workqueue+0xb4/0x144)
Jan 1 00:13:01 user.warn kernel: r5:c0340000 r4:c03c9420
Jan 1 00:13:01 user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144)
from [<c00486f8>] (flush_cpu_workqueue+0x34/0x94)
Jan 1 00:13:01 user.warn kernel: r6:c020d624 r5:c1051e88 r4:00000001
Jan 1 00:13:01 user.warn kernel: [<c00486c4>]
(flush_cpu_workqueue+0x0/0x94) from [<c0048cc0>] (flush_workqueue+0x14/0x18)
Jan 1 00:13:01 user.warn kernel: r4:c03c9420
Jan 1 00:13:01 user.warn kernel: [<c0048cac>] (flush_workqueue+0x0/0x18)
from [<c020d640>] (add_conn+0x1c/0x80)
Jan 1 00:13:01 user.warn kernel: [<c020d624>] (add_conn+0x0/0x80) from
[<c0048634>] (run_workqueue+0xb4/0x144)
Jan 1 00:13:01 user.warn kernel: r5:c0340000 r4:c03c9420
Jan 1 00:13:01 user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144)
from [<c00486f8>] (flush_cpu_workqueue+0x34/0x94)
Jan 1 00:13:01 user.warn kernel: r6:c020d624 r5:c042ca88 r4:00000001
Jan 1 00:13:01 user.warn kernel: [<c00486c4>]
(flush_cpu_workqueue+0x0/0x94) from [<c0048cc0>] (flush_workqueue+0x14/0x18)
Jan 1 00:13:01 user.warn kernel: r4:c03c9420
Jan 1 00:13:01 user.warn kernel: [<c0048cac>] (flush_workqueue+0x0/0x18)
from [<c020d640>] (add_conn+0x1c/0x80)
Jan 1 00:13:01 user.warn kernel: [<c020d624>] (add_conn+0x0/0x80) from
[<c0048634>] (run_workqueue+0xb4/0x144)
Jan 1 00:13:01 user.warn kernel: r5:c0340000 r4:c03c9420
Jan 1 00:13:01 user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144)
from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan 1 00:13:01 user.warn kernel: r6:c00487e4 r5:c03c9420 r4:c03c9428
Jan 1 00:13:01 user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8)
from [<c004c598>] (kthread+0x5c/0x90)
Jan 1 00:13:01 user.warn kernel: r5:c03c9420 r4:c0340000
Jan 1 00:13:01 user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from
[<c003b348>] (do_exit+0x0/0x690)
Jan 1 00:13:01 user.warn kernel: r6:00000000 r5:00000000 r4:00000000

Marco Pracucci


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
