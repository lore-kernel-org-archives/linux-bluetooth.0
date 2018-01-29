Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: BUG: KASAN: use-after-free in
 xhci_trb_virt_to_dma.part.24+0x1c/0x80
To: Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        "Holtmann, Marcel" <marcel.holtmann@intel.com>
References: <7eaef814-e4a2-0760-f9bc-72c738835c3c@molgen.mpg.de>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <0ef83a14-bdac-0d27-ebcb-6482a55300af@linux.intel.com>
Date: Mon, 29 Jan 2018 13:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <7eaef814-e4a2-0760-f9bc-72c738835c3c@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 28.01.2018 23:43, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Using Linux 4.15-rc9+ with KASAN enabled on the TUXEDO Book 1406, playing with Bluetooth – disabling a device – I was able to trigger the warning below.
> 

Thanks, first guess is that btusb calls usb_set_interface() with URBs still scheduled for a endpoint.
So something like this happens:

btusb_work [btusb]
   usb_set_interface
     usb_hcd_alloc_bandwidth
       xhci_check_bandwidth
          xhci_free_endpoint_ring   -> frees xhci endpoint ring.
     usb_disable_interface
       usb_disable_endpoint
         usb_hcd_flush_endpoint
           unlink1
             xhci_urb_dequeue       -> tries to access xhci endpoint ring in URB

description for usb_set_interface() says:
* This call is synchronous, and may not be used in an interrupt context.
* Also, drivers must not change altsettings while urbs are scheduled for
* endpoints in that interface; all such urbs must first be completed
* (perhaps forced by unlinking).

Adding some bluetooth people

-Mathias


>> [ 7384.326627] ==================================================================
>> [ 7384.326644] BUG: KASAN: use-after-free in xhci_trb_virt_to_dma.part.24+0x1c/0x80
>> [ 7384.326652] Read of size 8 at addr ffff88068c491c00 by task kworker/0:3/17280
>>
>> [ 7384.326669] CPU: 0 PID: 17280 Comm: kworker/0:3 Not tainted 4.15.0-rc9+ #20
>> [ 7384.326675] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 07/07/2017
>> [ 7384.326690] Workqueue: events btusb_work [btusb]
>> [ 7384.326699] Call Trace:
>> [ 7384.326711]  dump_stack+0xaf/0x125
>> [ 7384.326722]  ? dma_virt_map_sg+0x14b/0x14b
>> [ 7384.326733]  ? show_regs_print_info+0xa/0xa
>> [ 7384.326753]  print_address_description+0x7a/0x440
>> [ 7384.326768]  ? xhci_trb_virt_to_dma.part.24+0x1c/0x80
>> [ 7384.326778]  kasan_report+0x1dc/0x450
>> [ 7384.326796]  ? xhci_trb_virt_to_dma.part.24+0x1c/0x80
>> [ 7384.326811]  xhci_trb_virt_to_dma.part.24+0x1c/0x80
>> [ 7384.326824]  xhci_urb_dequeue+0x987/0xd70
>> [ 7384.326850]  ? ret_from_fork+0x35/0x40
>> [ 7384.326864]  ? xhci_get_endpoint_flag+0x80/0x80
>> [ 7384.326884]  ? trace_graph_entry+0x178/0x380
>> [ 7384.326891]  ? xhci_get_endpoint_flag+0x80/0x80
>> [ 7384.326905]  ? xhci_get_endpoint_flag+0x80/0x80
>> [ 7384.326926]  ? prepare_ftrace_return+0x1c5/0x2c0
>> [ 7384.326939]  ? usb_hcd_flush_endpoint+0x185/0x440
>> [ 7384.326949]  ? addr_from_call+0xe0/0xe0
>> [ 7384.326957]  ? ftrace_lookup_ip+0x154/0x250
>> [ 7384.326965]  ? xhci_get_endpoint_flag+0x80/0x80
>> [ 7384.326975]  ? is_ftrace_trampoline+0x10/0x10
>> [ 7384.327007]  ? ftrace_graph_caller+0x62/0xa0
>> [ 7384.327018]  ? usb_disable_endpoint+0x76/0x110
>> [ 7384.327025]  ? rcu_sched_qs.part.49+0x70/0x70
>> [ 7384.327033]  ? xhci_get_endpoint_flag+0x80/0x80
>> [ 7384.327038]  ? unlink1+0x79/0x270
>> [ 7384.327052]  usb_hcd_flush_endpoint+0x185/0x440
>> [ 7384.327064]  ? usb_hcd_unlink_urb+0x210/0x210
>> [ 7384.327069]  ? ftrace_graph_caller+0x62/0xa0
>> [ 7384.327076]  ? ftrace_graph_caller+0x62/0xa0
>> [ 7384.327087]  ? usb_disable_endpoint+0x64/0x110
>> [ 7384.327101]  usb_disable_endpoint+0x76/0x110
>> [ 7384.327110]  usb_disable_interface+0x98/0xf0
>> [ 7384.327124]  usb_set_interface+0x29d/0x630
>> [ 7384.327143]  btusb_work+0x400/0x881 [btusb]
>> [ 7384.327158]  process_one_work+0x677/0xd70
>> [ 7384.327174]  ? create_worker+0x360/0x360
>> [ 7384.327180]  ? compat_start_thread+0x70/0x70
>> [ 7384.327185]  ? __switch_to_asm+0x34/0x70
>> [ 7384.327196]  ? finish_task_switch+0x12b/0x540
>> [ 7384.327201]  ? ftrace_graph_caller+0x62/0xa0
>> [ 7384.327206]  ? __switch_to_asm+0x40/0x70
>> [ 7384.327211]  ? __switch_to_asm+0x34/0x70
>> [ 7384.327220]  ? trace_event_raw_event_sched_wake_idle_without_ipi+0x160/0x160
>> [ 7384.327226]  ? __switch_to_asm+0x34/0x70
>> [ 7384.327234]  ? ftrace_lookup_ip+0x154/0x250
>> [ 7384.327247]  ? __schedule+0x4f3/0x12f0
>> [ 7384.327267]  ? create_worker+0x360/0x360
>> [ 7384.327277]  ? create_worker+0x360/0x360
>> [ 7384.327285]  ? worker_thread+0x1f8/0xf70
>> [ 7384.327292]  ? addr_from_call+0xe0/0xe0
>> [ 7384.327298]  ? task_change_group_fair+0x5c0/0x5c0
>> [ 7384.327303]  ? create_worker+0x360/0x360
>> [ 7384.327315]  ? schedule+0xe5/0x2c0
>> [ 7384.327320]  ? move_linked_works+0x2e9/0x460
>> [ 7384.327326]  ? __schedule+0x12f0/0x12f0
>> [ 7384.327338]  ? ftrace_graph_caller+0x62/0xa0
>> [ 7384.327353]  ? worker_thread+0x6c5/0xf70
>> [ 7384.327367]  worker_thread+0x1f8/0xf70
>> [ 7384.327394]  ? process_one_work+0xd70/0xd70
>> [ 7384.327401]  ? trace_graph_entry+0x178/0x380
>> [ 7384.327406]  ? trace_event_raw_event_sched_wake_idle_without_ipi+0x160/0x160
>> [ 7384.327416]  ? prepare_ftrace_return+0x1c5/0x2c0
>> [ 7384.327424]  ? __schedule+0x4cb/0x12f0
>> [ 7384.327430]  ? addr_from_call+0xe0/0xe0
>> [ 7384.327437]  ? trace_event_raw_event_sched_wake_idle_without_ipi+0x160/0x160
>> [ 7384.327444]  ? __switch_to+0x443/0xad0
>> [ 7384.327457]  ? compat_start_thread+0x70/0x70
>> [ 7384.327462]  ? __switch_to_asm+0x34/0x70
>> [ 7384.327474]  ? finish_task_switch+0x12b/0x540
>> [ 7384.327480]  ? ftrace_graph_caller+0x62/0xa0
>> [ 7384.327488]  ? __switch_to_asm+0x40/0x70
>> [ 7384.327496]  ? __switch_to_asm+0x34/0x70
>> [ 7384.327508]  ? trace_event_raw_event_sched_wake_idle_without_ipi+0x160/0x160
>> [ 7384.327521]  ? ftrace_lookup_ip+0x154/0x250
>> [ 7384.327535]  ? __schedule+0x4f3/0x12f0
>> [ 7384.327555]  ? process_one_work+0xd70/0xd70
>> [ 7384.327565]  ? process_one_work+0xd70/0xd70
>> [ 7384.327573]  ? kthread+0x205/0x2d0
>> [ 7384.327579]  ? addr_from_call+0xe0/0xe0
>> [ 7384.327586]  ? process_one_work+0xd70/0xd70
>> [ 7384.327597]  ? schedule+0xe5/0x2c0
>> [ 7384.327605]  ? __schedule+0x12f0/0x12f0
>> [ 7384.327615]  ? process_one_work+0xd70/0xd70
>> [ 7384.327621]  ? ftrace_graph_caller+0x62/0xa0
>> [ 7384.327628]  ? kasan_kmalloc+0xa0/0xd0
>> [ 7384.327640]  ? __kthread_parkme+0xac/0x110
>> [ 7384.327652]  ? process_one_work+0xd70/0xd70
>> [ 7384.327658]  kthread+0x205/0x2d0
>> [ 7384.327665]  ? kthread_create_worker_on_cpu+0xc0/0xc0
>> [ 7384.327675]  ret_from_fork+0x35/0x40
>>
>> [ 7384.327702] Allocated by task 13479:
>> [ 7384.327709]  kasan_kmalloc+0xa0/0xd0
>> [ 7384.327714]  kmem_cache_alloc_trace+0x139/0x360
>> [ 7384.327719]  xhci_segment_alloc+0x9e/0x270
>> [ 7384.327724]  xhci_alloc_segments_for_ring+0x37/0x160
>> [ 7384.327729]  xhci_ring_alloc.constprop.19+0x176/0x410
>> [ 7384.327733]  xhci_endpoint_init+0x313/0x8f0
>> [ 7384.327738]  xhci_add_endpoint+0x214/0x5c0
>> [ 7384.327743]  usb_hcd_alloc_bandwidth+0x5fa/0x800
>> [ 7384.327748]  usb_set_interface+0x174/0x630
>> [ 7384.327756]  btusb_work+0x210/0x881 [btusb]
>> [ 7384.327761]  process_one_work+0x677/0xd70
>> [ 7384.327765]  worker_thread+0x1f8/0xf70
>> [ 7384.327769]  kthread+0x205/0x2d0
>> [ 7384.327774]  ret_from_fork+0x35/0x40
>>
>> [ 7384.327782] Freed by task 17280:
>> [ 7384.327788]  kasan_slab_free+0x71/0xc0
>> [ 7384.327793]  kfree+0xd2/0x390
>> [ 7384.327798]  xhci_ring_free.part.15+0xe5/0x2b0
>> [ 7384.327803]  xhci_free_endpoint_ring+0x4b/0xb0
>> [ 7384.327808]  xhci_check_bandwidth+0x2e7/0x590
>> [ 7384.327813]  usb_hcd_alloc_bandwidth+0x43d/0x800
>> [ 7384.327818]  usb_set_interface+0x174/0x630
>> [ 7384.327825]  btusb_work+0x400/0x881 [btusb]
>> [ 7384.327830]  process_one_work+0x677/0xd70
>> [ 7384.327834]  worker_thread+0x1f8/0xf70
>> [ 7384.327838]  kthread+0x205/0x2d0
>> [ 7384.327843]  ret_from_fork+0x35/0x40
>>
>> [ 7384.327851] The buggy address belongs to the object at ffff88068c491c00
>>                 which belongs to the cache kmalloc-64 of size 64
>> [ 7384.327859] The buggy address is located 0 bytes inside of
>>                 64-byte region [ffff88068c491c00, ffff88068c491c40)
>> [ 7384.327865] The buggy address belongs to the page:
>> [ 7384.327872] page:ffffea001a312440 count:1 mapcount:0 mapping:          (null) index:0xffff88068c491300
>> [ 7384.327881] flags: 0x17fff8000000100(slab)
>> [ 7384.327889] raw: 017fff8000000100 0000000000000000 ffff88068c491300 00000001002a0028
>> [ 7384.327896] raw: ffffea001ab82460 ffffea001aed5ee0 ffff88080c8036c0 0000000000000000
>> [ 7384.327901] page dumped because: kasan: bad access detected
>>
>> [ 7384.327909] Memory state around the buggy address:
>> [ 7384.327928]  ffff88068c491b00: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
>> [ 7384.327933]  ffff88068c491b80: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
>> [ 7384.327938] >ffff88068c491c00: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
>> [ 7384.327943]                    ^
>> [ 7384.327948]  ffff88068c491c80: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
>> [ 7384.327953]  ffff88068c491d00: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
>> [ 7384.327958] ==================================================================
> 
> 
> Kind regards,
> 
> Paul
