Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361356092.2871.13.camel@dellpc>
References: <1361356092.2871.13.camel@dellpc>
Date: Wed, 20 Feb 2013 16:44:41 +0100
Message-ID: <CANq1E4Q+etVLVL6OxWdC=N+aodvS5sqjKY3ZqJwoGM5gCjdEFw@mail.gmail.com>
Subject: Re: hidp_get_raw_report source of 5 second delay in device removal
From: David Herrmann <dh.herrmann@gmail.com>
To: Karl Relton <karllinuxtest.relton@ntlworld.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karl

On Wed, Feb 20, 2013 at 11:28 AM, Karl Relton
<karllinuxtest.relton@ntlworld.com> wrote:
> Dear friends
>
> Any thoughts on my two patches:
> - [PATCH] hidp: Make hidp_get_raw_report abort if the session is
> terminating
> - RFC [PATCH] hci: Fix race between hidp_session and hci code
>
> originally sent 29th Jan and resent 18th Feb?
>
> There has been no reply to this list ...
>
> The first patch is critical, the second makes everything neat and tidy.

I'm confused. I think the second one is critical, not the first one,
right? At least according to the list above. Anyway, both bugs are
known and need to be fixed. I reviewed both of your patches and the
second one needs major rework as I think it's the wrong fix.

Some minor comments below:

> The following kernel log, using linux 3.8-rc6 and DEBUG turned on in the
> bluetooth & hidp modules illustrate the problem if neither of these
> patches are used. I added a couple of extra printks in the
> hidp_session() routine to show its progress. I also
> tweaked hidp_session to avoid a possible kernel OOPS caused by this same
> problem (which is avoided if the first patch was applied).
> Lines with *** are my annotations to describe what is happening.
>
> *** Kernel resuming - does usb reset as part of resume from suspend sequence ...
> Feb 20 09:31:15 laptop2 kernel: [  334.204082] usb 3-2: reset full-speed USB device number 2 using uhci_hcd
> Feb 20 09:31:15 laptop2 kernel: [  334.375693] btusb 3-2:1.0: no reset_resume for driver btusb?
> Feb 20 09:31:15 laptop2 kernel: [  334.375697] btusb 3-2:1.1: no reset_resume for driver btusb?
> Feb 20 09:31:15 laptop2 kernel: [  334.375710] hci_unregister_dev: f6119000 name hci0 bus 1
> Feb 20 09:31:15 laptop2 kernel: [  334.375712] hci_dev_do_close: hci0 f6119000
> Feb 20 09:31:15 laptop2 kernel: [  334.375716] hci_req_cancel: hci0 err 0x13
> Feb 20 09:31:15 laptop2 kernel: [  334.375719] hci_conn_hash_flush: hdev hci0
> Feb 20 09:31:15 laptop2 kernel: [  334.375722] l2cap_disconn_cfm: hcon e000bc00 reason 22
> Feb 20 09:31:15 laptop2 kernel: [  334.375725] l2cap_conn_del: hcon e000bc00 conn f3294800, err 103
> Feb 20 09:31:15 laptop2 kernel: [  334.375727] l2cap_chan_hold: chan e000a400 orig refcnt 3
> Feb 20 09:31:15 laptop2 kernel: [  334.375730] l2cap_chan_del: chan e000a400, conn f3294800, err 103
> Feb 20 09:31:15 laptop2 kernel: [  334.375732] l2cap_chan_put: chan e000a400 orig refcnt 4
> Feb 20 09:31:15 laptop2 kernel: [  334.375734] hci_conn_put: hcon e000bc00 orig refcnt 2
> Feb 20 09:31:15 laptop2 kernel: [  334.375742] l2cap_chan_put: chan e000a400 orig refcnt 3
> Feb 20 09:31:15 laptop2 kernel: [  334.375744] l2cap_chan_hold: chan e0009400 orig refcnt 3
> Feb 20 09:31:15 laptop2 kernel: [  334.375746] l2cap_chan_del: chan e0009400, conn f3294800, err 103
> Feb 20 09:31:15 laptop2 kernel: [  334.375748] l2cap_chan_put: chan e0009400 orig refcnt 4
> Feb 20 09:31:15 laptop2 kernel: [  334.375750] hci_conn_put: hcon e000bc00 orig refcnt 1
> Feb 20 09:31:15 laptop2 kernel: [  334.375754] l2cap_chan_put: chan e0009400 orig refcnt 3
> Feb 20 09:31:15 laptop2 kernel: [  334.375756] hci_chan_del: hci0 hcon e000bc00 chan e00d7dc0
> *** the l2cap_disonn_cfm/l2cap_chan_del above triggers the hidp_session
> *** thread, so hidp_session can now fall out its main loop.
> *** hidp_session then does hid_destroy_device(), which through code in the power_supply
> *** part of the kernel invokes a battery status lookup which requires a call to hidp_get_raw_report

Yeah, same procedure applies to device-unplug. The calltrace is
totally valid and understandable. Your "atomic_inc(&hidp->terminate)"
patch fixes this problem properly.

> Feb 20 09:31:15 laptop2 kernel: [  334.375765] hidp_session Out of main loop
> Feb 20 09:31:15 laptop2 kernel: [  334.375767] hidp_session About to do hid_destroy_device
> Feb 20 09:31:15 laptop2 kernel: [  334.375857] hidp_get_raw_report: Entering hidp_get_raw_report
> Feb 20 09:31:15 laptop2 kernel: [  334.375860] __hidp_send_ctrl_message: session f3294f00 data e0115d36 size 1
> *** hidp_get_raw_report sends a ctrl message and then waits. Meanwhile the main kernel gets
> *** on with running the hci driver code ...
> Feb 20 09:31:15 laptop2 kernel: [  334.376725] hci_conn_put: hcon e000bc00 orig refcnt 0
> Feb 20 09:31:15 laptop2 kernel: [  334.376729] hci_conn_del: hci0 hcon e000bc00 handle 46
> Feb 20 09:31:15 laptop2 kernel: [  334.376732] hci_chan_list_flush: hcon e000bc00
> Feb 20 09:31:15 laptop2 kernel: [  334.376832] hci_dev_put: hci0 orig refcnt 12
> Feb 20 09:31:15 laptop2 kernel: [  334.376835] hci_sock_dev_event: hdev hci0 event 4
> Feb 20 09:31:15 laptop2 kernel: [  334.376839] hci_send_to_sock: hdev   (null) len 8
> Feb 20 09:31:15 laptop2 kernel: [  334.376850] hci_dev_put: hci0 orig refcnt 11
> Feb 20 09:31:15 laptop2 kernel: [  334.376854] hci_send_to_control: len 6
> Feb 20 09:31:15 laptop2 kernel: [  334.376856] hci_sock_dev_event: hdev hci0 event 2
> Feb 20 09:31:15 laptop2 kernel: [  334.376859] hci_send_to_sock: hdev   (null) len 8
> Feb 20 09:31:15 laptop2 kernel: [  334.376864] hci_dev_put: hci0 orig refcnt 10
> Feb 20 09:31:15 laptop2 kernel: [  334.376910] hci_del_sysfs: f6119000 name hci0 bus 1
> Feb 20 09:31:15 laptop2 kernel: [  334.376994] hci_dev_put: hci0 orig refcnt 5
> *** the 'hci' device is the sysfs tree has now just been removed - yet the various devices
> *** dependent on it have yet to be removed (input, event, hidraw, hci_conn)


This is a bug, indeed. We need to notify all child devices first so
they can get deleted. However, delaying the HCI removal is _wrong_!
The HCI device must be deleted here.
But we must simply forward the delete-request to the childs before
doing the deletion.

> *** Note the 5 SECOND gap ... thats the timeout value in hidp_get_raw_report!
> *** having timed out, the hidp_session thread gets underway again
> *** the various devices are now removed (input, event, hidraw, hci_conn)
> *** and life can go on
> Feb 20 09:31:15 laptop2 kernel: [  339.372148] hidp_get_raw_report timed out!
> Feb 20 09:31:15 laptop2 kernel: [  339.372153] power_supply hid-60:c5:47:1b:07:b8-battery: driver failed to report `capacity' property: -5
> Feb 20 09:31:15 laptop2 kernel: [  339.376347] PM: resume of devices complete after 5491.694 msecs
> Feb 20 09:31:15 laptop2 kernel: [  339.376362] hidp_session Done hid_destry_device
> Feb 20 09:31:15 laptop2 kernel: [  339.376366] hci_conn_del_sysfs: conn e000bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.376392] hci_dev_put: hci0 orig refcnt 1
> *** a new hci device is registered, and a new hci_conn, and sub-tree of input devices
> *** will be added, which is normal and to be expected.
> *** NOTE though whilst the new registration occurs here in this log, I have seen it
> *** occur much earlier in other logs (different versions of kernel), leading to
> *** various problems when a new hci_conn is added whilst the old one has yet to be deleted.

No! There is no problem with adding a new hci_conn while another one
is still to be removed. This totally normal and _must_ be supported.
As long as both hci_conn objects have different IDs this is correctly
understood by user-space, too.

We fixed the ID issue two years ago and this is no longer a problem
here. If you see a bug where a hci_conn with an equal ID is
registered, please report it. This would be a bug then.

> Feb 20 09:31:15 laptop2 kernel: [  339.376424] hci_register_dev: f3367000 name hci0 bus 1
> Feb 20 09:31:15 laptop2 kernel: [  339.376475] hci_add_sysfs: f3367000 name hci0 bus 1
> Feb 20 09:31:15 laptop2 kernel: [  339.376561] hci_sock_dev_event: hdev hci0 event 1
> Feb 20 09:31:15 laptop2 kernel: [  339.376564] hci_send_to_sock: hdev   (null) len 8
> Feb 20 09:31:15 laptop2 kernel: [  339.376568] hci_dev_hold: hci0 orig refcnt 5
> Feb 20 09:31:15 laptop2 kernel: [  339.378210] bt_sock_poll: sock ef627500, sk f30afe00
> Feb 20 09:31:15 laptop2 kernel: [  339.384283] bt_sock_poll: sock f2d95380, sk f675a600
> Feb 20 09:31:15 laptop2 kernel: [  339.384291] bt_sock_poll: sock f5be0c00, sk f673f600
> Feb 20 09:31:15 laptop2 kernel: [  339.384295] bt_sock_poll: sock f5be0180, sk f600ac00
> Feb 20 09:31:15 laptop2 kernel: [  339.384298] bt_sock_poll: sock f5b30180, sk f66c4400
> Feb 20 09:31:15 laptop2 kernel: [  339.384301] bt_sock_poll: sock f5b30300, sk f6691e00
> Feb 20 09:31:15 laptop2 kernel: [  339.384303] bt_sock_poll: sock f5b30480, sk f673e000
> Feb 20 09:31:15 laptop2 kernel: [  339.384306] bt_sock_poll: sock f5b30600, sk f673e600
> Feb 20 09:31:15 laptop2 kernel: [  339.384309] bt_sock_poll: sock f5b30780, sk f675b800
> Feb 20 09:31:15 laptop2 kernel: [  339.384311] bt_sock_poll: sock f5b30900, sk f675bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.384314] bt_sock_poll: sock f5b30a80, sk f675a800
> Feb 20 09:31:15 laptop2 kernel: [  339.384320] bt_sock_poll: sock f2d94180, sk f66c4800
> Feb 20 09:31:15 laptop2 kernel: [  339.384323] bt_sock_poll: sock f5b30000, sk f66c5200
> Feb 20 09:31:15 laptop2 kernel: [  339.384325] bt_sock_poll: sock df8a8300, sk e968c800
> Feb 20 09:31:15 laptop2 kernel: [  339.384328] bt_sock_poll: sock df8a8180, sk e968d600
> Feb 20 09:31:15 laptop2 kernel: [  339.384357] hci_sock_recvmsg: sock f5be0780, sk f673ea00
> Feb 20 09:31:15 laptop2 kernel: [  339.384574] l2cap_sock_release: sock df8a8300, sk e968c800
> Feb 20 09:31:15 laptop2 kernel: [  339.384578] l2cap_sock_shutdown: sock df8a8300, sk e968c800
> Feb 20 09:31:15 laptop2 kernel: [  339.384582] l2cap_chan_close: chan e000a400 state BT_CLOSED sk e968c800
> Feb 20 09:31:15 laptop2 kernel: [  339.384586] l2cap_sock_kill: sk e968c800 state BT_CLOSED
> Feb 20 09:31:15 laptop2 kernel: [  339.384589] l2cap_chan_put: chan e000a400 orig refcnt 2
> Feb 20 09:31:15 laptop2 kernel: [  339.384592] l2cap_sock_destruct: sk e968c800
> Feb 20 09:31:15 laptop2 kernel: [  339.384594] l2cap_chan_put: chan e000a400 orig refcnt 1
> Feb 20 09:31:15 laptop2 kernel: [  339.384597] l2cap_chan_destroy: chan e000a400
> Feb 20 09:31:15 laptop2 kernel: [  339.384656] l2cap_sock_release: sock df8a8180, sk e968d600
> Feb 20 09:31:15 laptop2 kernel: [  339.384659] l2cap_sock_shutdown: sock df8a8180, sk e968d600
> Feb 20 09:31:15 laptop2 kernel: [  339.384663] l2cap_chan_close: chan e0009400 state BT_CLOSED sk e968d600
> Feb 20 09:31:15 laptop2 kernel: [  339.384666] l2cap_sock_kill: sk e968d600 state BT_CLOSED
> Feb 20 09:31:15 laptop2 kernel: [  339.384668] l2cap_chan_put: chan e0009400 orig refcnt 2
> Feb 20 09:31:15 laptop2 kernel: [  339.384670] l2cap_sock_destruct: sk e968d600
> Feb 20 09:31:15 laptop2 kernel: [  339.384673] l2cap_chan_put: chan e0009400 orig refcnt 1
> Feb 20 09:31:15 laptop2 kernel: [  339.384675] l2cap_chan_destroy: chan e0009400
> Feb 20 09:31:15 laptop2 kernel: [  339.384707] bt_sock_poll: sock f2d95380, sk f675a600
> Feb 20 09:31:15 laptop2 kernel: [  339.384710] bt_sock_poll: sock f5be0c00, sk f673f600
> Feb 20 09:31:15 laptop2 kernel: [  339.384713] bt_sock_poll: sock f5be0180, sk f600ac00
> Feb 20 09:31:15 laptop2 kernel: [  339.384715] bt_sock_poll: sock f5b30180, sk f66c4400
> Feb 20 09:31:15 laptop2 kernel: [  339.384718] bt_sock_poll: sock f5b30300, sk f6691e00
> Feb 20 09:31:15 laptop2 kernel: [  339.384720] bt_sock_poll: sock f5b30480, sk f673e000
> Feb 20 09:31:15 laptop2 kernel: [  339.384722] bt_sock_poll: sock f5b30600, sk f673e600
> Feb 20 09:31:15 laptop2 kernel: [  339.384725] bt_sock_poll: sock f5b30780, sk f675b800
> Feb 20 09:31:15 laptop2 kernel: [  339.384727] bt_sock_poll: sock f5b30900, sk f675bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.384729] bt_sock_poll: sock f5b30a80, sk f675a800
> Feb 20 09:31:15 laptop2 kernel: [  339.384733] bt_sock_poll: sock f2d94180, sk f66c4800
> Feb 20 09:31:15 laptop2 kernel: [  339.384735] bt_sock_poll: sock f5b30000, sk f66c5200
> Feb 20 09:31:15 laptop2 kernel: [  339.384743] hci_sock_recvmsg: sock f5be0780, sk f673ea00
> Feb 20 09:31:15 laptop2 kernel: [  339.384771] hci_sock_release: sock f5be0600 sk f673e800
> Feb 20 09:31:15 laptop2 kernel: [  339.384829] hci_sock_create: sock df4b0000
> Feb 20 09:31:15 laptop2 kernel: [  339.384838] hci_sock_ioctl: cmd 800448d2 arg b885cb00
> Feb 20 09:31:15 laptop2 kernel: [  339.384843] hci_sock_release: sock df4b0000 sk f1b82600
> Feb 20 09:31:15 laptop2 kernel: [  339.385167] bt_accept_dequeue: parent f675a800
> Feb 20 09:31:15 laptop2 kernel: [  339.385191] l2cap_sock_release: sock f5b30900, sk f675bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.385194] l2cap_sock_shutdown: sock f5b30900, sk f675bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.385197] l2cap_chan_close: chan f303b800 state BT_LISTEN sk f675bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.385200] l2cap_sock_cleanup_listen: parent f675bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.385202] bt_accept_dequeue: parent f675bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.385205] l2cap_sock_kill: sk f675bc00 state BT_CLOSED
> Feb 20 09:31:15 laptop2 kernel: [  339.385208] l2cap_chan_put: chan f303b800 orig refcnt 2
> Feb 20 09:31:15 laptop2 kernel: [  339.385210] l2cap_sock_destruct: sk f675bc00
> Feb 20 09:31:15 laptop2 kernel: [  339.385213] l2cap_chan_put: chan f303b800 orig refcnt 1
> Feb 20 09:31:15 laptop2 kernel: [  339.385215] l2cap_chan_destroy: chan f303b800
> Feb 20 09:31:15 laptop2 kernel: [  339.385343] l2cap_sock_release: sock f5b30780, sk f675b800
> Feb 20 09:31:15 laptop2 kernel: [  339.385346] l2cap_sock_shutdown: sock f5b30780, sk f675b800
> Feb 20 09:31:15 laptop2 kernel: [  339.385350] l2cap_chan_close: chan f303b400 state BT_LISTEN sk f675b800
> Feb 20 09:31:15 laptop2 kernel: [  339.385352] l2cap_sock_cleanup_listen: parent f675b800
> Feb 20 09:31:15 laptop2 kernel: [  339.385354] bt_accept_dequeue: parent f675b800
> Feb 20 09:31:15 laptop2 kernel: [  339.385357] l2cap_sock_kill: sk f675b800 state BT_CLOSED
> Feb 20 09:31:15 laptop2 kernel: [  339.385360] l2cap_chan_put: chan f303b400 orig refcnt 2
> Feb 20 09:31:15 laptop2 kernel: [  339.385362] l2cap_sock_destruct: sk f675b800
> Feb 20 09:31:15 laptop2 kernel: [  339.385364] l2cap_chan_put: chan f303b400 orig refcnt 1
> Feb 20 09:31:15 laptop2 kernel: [  339.385367] l2cap_chan_destroy: chan f303b400
> Feb 20 09:31:15 laptop2 kernel: [  339.385386] bt_accept_dequeue: parent f673e600
> Feb 20 09:31:15 laptop2 kernel: [  339.385397] bt_accept_dequeue: parent f6691e00
> Feb 20 09:31:15 laptop2 kernel: [  339.385408] bt_accept_dequeue: parent f673e000
> Feb 20 09:31:15 laptop2 kernel: [  339.394097] hci_rfkill_set_block: f3367000 name hci0 blocked 0
> Feb 20 09:31:15 laptop2 kernel: [  339.394103] hci_power_on: hci0
> Feb 20 09:31:15 laptop2 kernel: [  339.394106] hci_dev_get: 0
> Feb 20 09:31:15 laptop2 kernel: [  339.394109] hci_dev_hold: hci0 orig refcnt 6
> Feb 20 09:31:15 laptop2 kernel: [  339.394112] hci_dev_open: hci0 f3367000
> Feb 20 09:31:15 laptop2 kernel: [  339.394136] __hci_request: hci0 start
> Feb 20 09:31:15 laptop2 kernel: [  339.394139] hci_init_req: hci0 0
> Feb 20 09:31:15 laptop2 kernel: [  339.394142] hci_reset_req: hci0 0
> Feb 20 09:31:15 laptop2 kernel: [  339.394145] hci_send_cmd: hci0 opcode 0x0c03 plen 0
> Feb 20 09:31:15 laptop2 kernel: [  339.394147] hci_send_cmd: skb len 3
> Feb 20 09:31:15 laptop2 kernel: [  339.394155] hci_send_cmd: hci0 opcode 0x1003 plen 0
> Feb 20 09:31:15 laptop2 kernel: [  339.394157] hci_send_cmd: skb len 3
> Feb 20 09:31:15 laptop2 kernel: [  339.394160] hci_send_cmd: hci0 opcode 0x1001 plen 0
> Feb 20 09:31:15 laptop2 kernel: [  339.394162] hci_send_cmd: skb len 3
> Feb 20 09:31:15 laptop2 kernel: [  339.394168] hci_cmd_work: hci0 cmd_cnt 1 cmd queued 3
> Feb 20 09:31:15 laptop2 kernel: [  339.394172] hci_send_frame: hci0 type 1 len 3
> Feb 20 09:31:15 laptop2 kernel: [  339.395843] hci_rx_work: hci0
> Feb 20 09:31:15 laptop2 kernel: [  339.395850] hci_rx_work: hci0 Event packet
> Feb 20 09:31:15 laptop2 kernel: [  339.395854] hci_cmd_status_evt: hci0 opcode 0x0000
> Feb 20 09:31:15 laptop2 kernel: [  339.376989] Restarting tasks ... done.
>
> The result of the above is the following from udevadm monitor (i.e. the kernel udev events):
> KERNEL - the kernel uevent
> KERNEL[339.393586] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/rfkill0 (rfkill)
> KERNEL[339.393605] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0 (bluetooth)
> KERNEL[339.393627] change   /devices/pci0000:00/0000:00:02.0/drm/card0 (drm)
> KERNEL[339.393645] remove   /hci0/hci0:46/input10/event10 (input)
> KERNEL[339.393673] remove   /hci0/hci0:46/input10 (input)
> KERNEL[339.393692] remove   /hci0/hci0:46/0005:05AC:0256.0001/hidraw/hidraw0 (hidraw)
> KERNEL[339.393711] remove   /hci0/hci0:46/0005:05AC:0256.0001 (hid)
> KERNEL[339.393727] remove   /hci0/hci0:46 (bluetooth)
> KERNEL[339.393743] add      /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0 (bluetooth)
> KERNEL[339.393761] add      /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/rfkill2 (rfkill)
> KERNEL[345.114360] add      /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46 (bluetooth)
> KERNEL[345.384580] add      /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46/0005:05AC:0256.0002 (hid)
> KERNEL[345.424395] add      /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46/input11 (input)
> KERNEL[345.425001] add      /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46/input11/event10 (input)
> KERNEL[345.425312] add      /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46/0005:05AC:0256.0002/hidraw/hidraw0 (hidraw)
>
> Note the lines starting /hci0/hci0:46 ...
>
> These lines are incorrect - the sysfs path is truncated, caused by device removal in the wrong order.
> This can play havoc with userspace tools (like Xorg input device driver) that depends on these events.
>
> The two patches posted resolve this. The first by avoiding the 5 second
> timeout penalty (a trival fix). The second by delaying hci removal until
> hci_conn references to it have all gone.
>
> The bluetooth kernel code in its current form is problematic - hence all
> kind of bug reports by users against their distributions.

I am currently reworking the HIDP layer. The whole module is _very_
buggy. I will base my rework on your patches so feel free to resend
them. If you don't resend them, I will fix it myself, but this will
mean they get not applied right away as I will probably include them
in my rework which might take longer.

Also, please CC the bluetooth kernel maintainers when sending patches!
This includes Marcel Holtmann, Johan Hedberg and Gustavo Padovan, I
think.

Thanks
David
