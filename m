Return-Path: <cyrus@holtmann.org>
Date: Wed, 08 Jul 2009 10:36:09 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: RE: Does anybody know conn->power_save variable in hci_conn.c?
In-reply-to: <1246988209.3384.10.camel@localhost.localdomain>
To: 'Marcel Holtmann' <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-id: <004001c9ff6c$7838f7c0$68aae740$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <002e01c9fedc$f5fcb790$e1f626b0$%park@samsung.com>
 <1246988209.3384.10.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> /*bluetooth kernel hci_conn.c */
>> 382 void hci_conn_enter_active_mode(struct hci_conn *conn)
>> 383 {
>> 384         struct hci_dev *hdev = conn->hdev;
>> 385
>> 386         BT_DBG("conn %p mode %d", conn, conn->mode);
>> 387
>> 388         if (test_bit(HCI_RAW, &hdev->flags))
>> 389                 return;
>> 390
>> 391         if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
>> 392                 goto timer;
>> 393 
>> 394         if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND,
&conn->pend)) {
>> 395                 struct hci_cp_exit_sniff_mode cp;
>> 396                 cp.handle = __cpu_to_le16(conn->handle);
>> 397                 hci_send_cmd(hdev, OGF_LINK_POLICY,
>> 398                                 OCF_EXIT_SNIFF_MODE, sizeof(cp),
&cp);
>> 399         }
>> 400
>> 401 timer:
>> 402         if (hdev->idle_timeout > 0)
>> 403                 mod_timer(&conn->idle_timer,
>> 404                         jiffies +
msecs_to_jiffies(hdev->idle_timeout));
>> 405 }
>> 406 
>> 
>> If possible, could you explain why this code checks !conn->power_save
var.? 
>> 
>> Without this , if  conn->mode==HCI_CM_SNIFF , we simply exit sniff
>> mode,"OCF_EXIT_SNIFF_MODE".
>> 
>> As far as I understood, whenever conn->mode is HCI_CM_SNIFF
conn->power_save
>> is 0.
>> The reason is that  hci_mode_change_evt() set conn->power_save as "0"
when
>> conn->mode !=HCI_CM_ACTIVE.
>> 
>> Consequently we don't need to check that variable.
>
>we do need that variable, because otherwise devices like HID which do
>active sniff mode management fall over if we always try to exit sniff
>mode only for a few bytes.

In case of HID, active sniff mode could be no problem 
because its data rate is light compared to other profile.

But other case such as Sony Ericsson HBH-DS970,980 A2DP profile , it could
be problem.
As you may already know, 
they request sniff mode while HFP so their connection is too late...
It made AVDTP signal so slow..

Without conn->power_save variable check procedure, I found Sony Headset
works well! because they exit sniff mode 
Consequently, I think conn->power_save variable procedure should be removed
except only HID case.

If you think this is totally Sony headset problem, could you explain that?

Please comment my idea. 
 
Regards
Chanyeol




