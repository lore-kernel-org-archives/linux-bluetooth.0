Return-Path: <cyrus@holtmann.org>
Message-ID: <1361380641.5261.11.camel@dellpc>
Subject: Re: hidp_get_raw_report source of 5 second delay in device removal
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 20 Feb 2013 17:17:21 +0000
In-Reply-To: <CANq1E4Q+etVLVL6OxWdC=N+aodvS5sqjKY3ZqJwoGM5gCjdEFw@mail.gmail.com>
References: <1361356092.2871.13.camel@dellpc>
	 <CANq1E4Q+etVLVL6OxWdC=N+aodvS5sqjKY3ZqJwoGM5gCjdEFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2013-02-20 at 16:44 +0100, David Herrmann wrote:
> >
> > The first patch is critical, the second makes everything neat and tidy.
> 
> I'm confused. I think the second one is critical, not the first one,
> right? At least according to the list above. Anyway, both bugs are
> known and need to be fixed. I reviewed both of your patches and the
> second one needs major rework as I think it's the wrong fix.
> 

Well its semantics and one's point of view. The 5 second delay is a big
hit ... and can have other side effects such as making hidp_session race
against the sock structure eventually being orphaned (which leads to a
kernel OOPS). Anyway - at least we are both on the same page now.

> Some minor comments below:
> 
> > Feb 20 09:31:15 laptop2 kernel: [  334.375756] hci_chan_del: hci0 hcon e000bc00 chan e00d7dc0
> > *** the l2cap_disonn_cfm/l2cap_chan_del above triggers the hidp_session
> > *** thread, so hidp_session can now fall out its main loop.
> > *** hidp_session then does hid_destroy_device(), which through code in the power_supply
> > *** part of the kernel invokes a battery status lookup which requires a call to hidp_get_raw_report
> 
> Yeah, same procedure applies to device-unplug. The calltrace is
> totally valid and understandable. Your "atomic_inc(&hidp->terminate)"
> patch fixes this problem properly.
> 

Yep - I'll resend with your comment there taken on board.

> > Feb 20 09:31:15 laptop2 kernel: [  334.375765] hidp_session Out of main loop
> > Feb 20 09:31:15 laptop2 kernel: [  334.375767] hidp_session About to do hid_destroy_device
> > Feb 20 09:31:15 laptop2 kernel: [  334.375857] hidp_get_raw_report: Entering hidp_get_raw_report
> > Feb 20 09:31:15 laptop2 kernel: [  334.375860] __hidp_send_ctrl_message: session f3294f00 data e0115d36 size 1
> > *** hidp_get_raw_report sends a ctrl message and then waits. Meanwhile the main kernel gets
> > *** on with running the hci driver code ...
> > Feb 20 09:31:15 laptop2 kernel: [  334.376725] hci_conn_put: hcon e000bc00 orig refcnt 0
> > Feb 20 09:31:15 laptop2 kernel: [  334.376729] hci_conn_del: hci0 hcon e000bc00 handle 46
> > Feb 20 09:31:15 laptop2 kernel: [  334.376732] hci_chan_list_flush: hcon e000bc00
> > Feb 20 09:31:15 laptop2 kernel: [  334.376832] hci_dev_put: hci0 orig refcnt 12
> > Feb 20 09:31:15 laptop2 kernel: [  334.376835] hci_sock_dev_event: hdev hci0 event 4
> > Feb 20 09:31:15 laptop2 kernel: [  334.376839] hci_send_to_sock: hdev   (null) len 8
> > Feb 20 09:31:15 laptop2 kernel: [  334.376850] hci_dev_put: hci0 orig refcnt 11
> > Feb 20 09:31:15 laptop2 kernel: [  334.376854] hci_send_to_control: len 6
> > Feb 20 09:31:15 laptop2 kernel: [  334.376856] hci_sock_dev_event: hdev hci0 event 2
> > Feb 20 09:31:15 laptop2 kernel: [  334.376859] hci_send_to_sock: hdev   (null) len 8
> > Feb 20 09:31:15 laptop2 kernel: [  334.376864] hci_dev_put: hci0 orig refcnt 10
> > Feb 20 09:31:15 laptop2 kernel: [  334.376910] hci_del_sysfs: f6119000 name hci0 bus 1
> > Feb 20 09:31:15 laptop2 kernel: [  334.376994] hci_dev_put: hci0 orig refcnt 5
> > *** the 'hci' device is the sysfs tree has now just been removed - yet the various devices
> > *** dependent on it have yet to be removed (input, event, hidraw, hci_conn)
> 
> 
> This is a bug, indeed. We need to notify all child devices first so
> they can get deleted. However, delaying the HCI removal is _wrong_!
> The HCI device must be deleted here.
> But we must simply forward the delete-request to the childs before
> doing the deletion.
> 

Why 'HCI device must be deleted here'? I guess there is a reason, but it
is not obvious to me.

My suggested fix simply follows the same logic as hci_conn_put_device,
which only does sysfs removal once all users of the HCI_CONN device have
finished.


> > *** Note the 5 SECOND gap ... thats the timeout value in hidp_get_raw_report!
> > *** having timed out, the hidp_session thread gets underway again
> > *** the various devices are now removed (input, event, hidraw, hci_conn)
> > *** and life can go on
> > Feb 20 09:31:15 laptop2 kernel: [  339.372148] hidp_get_raw_report timed out!
> > Feb 20 09:31:15 laptop2 kernel: [  339.372153] power_supply hid-60:c5:47:1b:07:b8-battery: driver failed to report `capacity' property: -5
> > Feb 20 09:31:15 laptop2 kernel: [  339.376347] PM: resume of devices complete after 5491.694 msecs
> > Feb 20 09:31:15 laptop2 kernel: [  339.376362] hidp_session Done hid_destry_device
> > Feb 20 09:31:15 laptop2 kernel: [  339.376366] hci_conn_del_sysfs: conn e000bc00
> > Feb 20 09:31:15 laptop2 kernel: [  339.376392] hci_dev_put: hci0 orig refcnt 1
> > *** a new hci device is registered, and a new hci_conn, and sub-tree of input devices
> > *** will be added, which is normal and to be expected.
> > *** NOTE though whilst the new registration occurs here in this log, I have seen it
> > *** occur much earlier in other logs (different versions of kernel), leading to
> > *** various problems when a new hci_conn is added whilst the old one has yet to be deleted.
> 
> No! There is no problem with adding a new hci_conn while another one
> is still to be removed. This totally normal and _must_ be supported.
> As long as both hci_conn objects have different IDs this is correctly
> understood by user-space, too.
> 
> We fixed the ID issue two years ago and this is no longer a problem
> here. If you see a bug where a hci_conn with an equal ID is
> registered, please report it. This would be a bug then.
> 

Fair enough - I have seen a new hci_conn with an equal ID, but I have
been playing with different kernels between 3.2 and 3.8. So unless I see
it again with 3.8 or later I'll trust that particular issue is indeed
resolved.

> > The bluetooth kernel code in its current form is problematic - hence all
> > kind of bug reports by users against their distributions.
> 
> I am currently reworking the HIDP layer. The whole module is _very_
> buggy. I will base my rework on your patches so feel free to resend
> them. If you don't resend them, I will fix it myself, but this will
> mean they get not applied right away as I will probably include them
> in my rework which might take longer.
> 
> Also, please CC the bluetooth kernel maintainers when sending patches!
> This includes Marcel Holtmann, Johan Hedberg and Gustavo Padovan, I
> think.
> 
Thankyou David. I'll do the minor alter to the first patch. I'll take up
discussion on the 2nd in that email thread later.

Karl


