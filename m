Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Apr 2011 02:11:24 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andrej Podzimek <andrej@podzimek.org>
Cc: linux-bluetooth@vger.kernel.org, stable@kernel.org, greg@kroah.com
Subject: Re: btusb not working in 2.6.38.4
Message-ID: <20110428051124.GC2214@joana>
References: <4DB8A51A.8080608@podzimek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DB8A51A.8080608@podzimek.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrej,

* Andrej Podzimek <andrej@podzimek.org> [2011-04-28 01:22:02 +0200]:

> Hello,
> 
> after a recent kernel update on Arch Linux (2.6.38.4), I can see the following problem in dmesg:
> 
> ------------[ cut here ]------------
> WARNING: at lib/kobject.c:595 kobject_put+0x40/0x50()
> Hardware name: To Be Filled By O.E.M.
> kobject: '(null)' (ffff88023f60d5a0): is not initialized, yet kobject_put() is being called.
> Modules linked in: btusb(+) bluetooth rfkill usbhid hid button i2c_i801 i2c_core r8169 mii iTCO_wdt iTCO_vendor_support psmouse sg serio_raw evdev pcspkr ip_tables ip6_tables x_tables tpm_tis tpm tpm_bios w83627ehf hwmon_vid coretemp ext4 mbcache jbd2 crc16 dm_mod usb_storage raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx md_mod uhci_hcd xhci_hcd ehci_hcd usbcore sd_mod crc_t10dif ahci libahci libata scsi_mod cpufreq_ondemand acpi_cpufreq freq_table processor mperf i7core_edac edac_core
> Pid: 1820, comm: modprobe Not tainted 2.6.38-ARCH #1
> Call Trace:
>   [<ffffffff8103a86b>] ? warn_slowpath_common+0x7b/0xc0
>   [<ffffffff8103a965>] ? warn_slowpath_fmt+0x45/0x50
>   [<ffffffff81248d3f>] ? skb_dequeue+0x5f/0x80
>   [<ffffffff8116b6f0>] ? kobject_put+0x40/0x50
>   [<ffffffffa025f85c>] ? btusb_probe+0x57c/0x5e0 [btusb]
>   [<ffffffffa00b85d5>] ? usb_probe_interface+0xe5/0x1e0 [usbcore]
>   [<ffffffff81215aaf>] ? driver_probe_device+0x6f/0x190
>   [<ffffffff81215c63>] ? __driver_attach+0x93/0xa0
>   [<ffffffff81215bd0>] ? __driver_attach+0x0/0xa0
>   [<ffffffff81214b23>] ? bus_for_each_dev+0x53/0x80
>   [<ffffffff812153f8>] ? bus_add_driver+0x188/0x260
>   [<ffffffff81215e3a>] ? driver_register+0x6a/0x130
>   [<ffffffffa00b748a>] ? usb_register_driver+0x8a/0x180 [usbcore]
>   [<ffffffffa011c000>] ? btusb_init+0x0/0x1000 [btusb]
>   [<ffffffff810001dc>] ? do_one_initcall+0x3c/0x170
>   [<ffffffff8106db3a>] ? sys_init_module+0xda/0x230
>   [<ffffffff8100243b>] ? system_call_fastpath+0x16/0x1b
> ---[ end trace 9c4648061ddb0b67 ]---
> 
> Presumably, Bluetooth does not seem to work at all (i.e., hciconfig -a does not output anything).
> 
> The output from lsusb -v relevant to the specific device is attached.
> 
> The device worked 100% flawlessly with 2.6.38.3. I had an a2dp headset and a mouse paired with it, both of which worked perfectly fine in parallel.

The only Bluetooth change in 2.6.38.4 is: https://lkml.org/lkml/2011/4/19/406
However I don't think this patch is causing this issue. Do you care to patch -R it
and test?
If the problem is somewhere else we have to go with a bisect, there are only
70 patches, so it shouldn't take to long.

Greg, any idea on that? Are there similar reports of warnings for 2.6.38.4?

-- 
Gustavo F. Padovan
http://profusion.mobi
