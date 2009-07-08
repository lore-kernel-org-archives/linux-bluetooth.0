Return-Path: <cyrus@holtmann.org>
Subject: RE: Does anybody know conn->power_save variable in hci_conn.c?
From: Marcel Holtmann <marcel@holtmann.org>
To: Chan-Yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <004601c9ff87$2f239a20$8d6ace60$%park@samsung.com>
References: <002e01c9fedc$f5fcb790$e1f626b0$%park@samsung.com>
	 <1246988209.3384.10.camel@localhost.localdomain>
	 <004001c9ff6c$7838f7c0$68aae740$%park@samsung.com>
	 <1247024290.3384.26.camel@localhost.localdomain>
	 <004601c9ff87$2f239a20$8d6ace60$%park@samsung.com>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 22:09:43 -0700
Message-Id: <1247029783.3384.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-Yeol,

> >>> >> /*bluetooth kernel hci_conn.c */
> >>> >> 382 void hci_conn_enter_active_mode(struct hci_conn *conn)
> >>> >> 390
> >>> >> 391         if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
> >>> >> 392                 goto timer;
> >>> >> 393 
> >>> >> 394         if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND,
> >>> &conn->pend)) {
> >>> >> 395                 struct hci_cp_exit_sniff_mode cp;
> >>> >> 396                 cp.handle = __cpu_to_le16(conn->handle);
> >>> >> 397                 hci_send_cmd(hdev, OGF_LINK_POLICY,
> >>> >> 398                                 OCF_EXIT_SNIFF_MODE, sizeof(cp),
> >>> >> 
> >>> >> If possible, could you explain why this code checks !conn->power_save
> >>> var.? 
> >>> >> 
> >>> >> Without this , if  conn->mode==HCI_CM_SNIFF , we simply exit sniff
> >>> >> mode,"OCF_EXIT_SNIFF_MODE".
> >>> >> 
> >>> >> As far as I understood, whenever conn->mode is HCI_CM_SNIFF
> >>> conn->power_save
> >>> >> is 0.
> >>> >> The reason is that  hci_mode_change_evt() set conn->power_save as "0"
> >>> when
> >>> >> conn->mode !=HCI_CM_ACTIVE.
> >>> >> 
> >>> >> Consequently we don't need to check that variable.
> >>> >
> >>> >we do need that variable, because otherwise devices like HID which do
> >>> >active sniff mode management fall over if we always try to exit sniff
> >>> >mode only for a few bytes.
> >>> 
> >>> In case of HID, active sniff mode could be no problem 
> >>> because its data rate is light compared to other profile.
> >>> 
> >>> But other case such as Sony Ericsson HBH-DS970,980 A2DP profile , it
> could
> >>> be problem.
> >>> As you may already know, 
> >>> they request sniff mode while HFP so their connection is too late...
> >>> It made AVDTP signal so slow..
> >>> 
> >>> Without conn->power_save variable check procedure, I found Sony Headset
> >>> works well! because they exit sniff mode 
> >>> Consequently, I think conn->power_save variable procedure should be
> removed
> >>> except only HID case.
> >>> 
> >>> If you think this is totally Sony headset problem, could you explain
> that?
> >>
> >>it is a headset problem since it is too stupid to get out of sniff mode
> >>even when it put itself into it and then tries to actively transmit
> >>data. However we can ensure to leave sniff mode in that case, but that
> >>needs to be a per socket option.
> >>
> >>As I said, if you have a HID device, you have to let the HID device
> >>control the sniff mode since it knows best anyway.
> >>
> 
> Thanks to you
> I could conclude this problem is from the stupid headset.
> 
> But we can't ignore these kind of headset-.-;, 
> As you know this headset is so popular and their family model has the same
> problem unfortunately.
> Moreover I check another phone[CSR or commercial stack] wakes up sniff mode.
> 
> So I have a plan to patch our kernel like below,
> 
> 1. Simply remove conn->power_save check procedure:
> This option is only used for HID profile(as far as I know) and currently we
> don't support HID.
> But I worry about this, because another profiles may need this option and
> this patch apply to all the ACL connection...
> 
> Could you tell me the side effect of this patch except HID profile case? 

it might and if it does, don't come here and ask us for debugging your
kernel.

> 2. Socket Option by Febien Chevalier:
> I think this is similar with your recommendation.
> 
> In BlueZ-dev mailing list, socket option patch is already proposed by Fabien
> Chevalier [fabchevalier@free.fr]
> But I couldn't find the conclusion ,its patch and your comments.
> 
> His last patch is located on "
> http://marc.info/?l=linux-bluetooth&m=122142307223008&w=2"
> 
> I think this option is more safe, because this patch is only for
> user-selected connection.
> 
> On a long term view, it's recommended to accept this kind of problem and
> path BlueZ kernel. 
> because many user may suffer from this headset , and they don't think this
> problem due to the headset.
> [The reason is that another commercial stack device supports this well]

We are using SOL_BLUETOOTH now. So that needs fixing and some other
aspects of the patch are not good enough for upstream inclusion.

Regards

Marcel


