Return-Path: <cyrus@holtmann.org>
Date: Tue, 07 Jul 2009 17:28:53 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: Does anybody know conn->power_save variable in hci_conn.c?
To: linux-bluetooth@vger.kernel.org
Message-id: <002e01c9fedc$f5fcb790$e1f626b0$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear bluez developer!

/*bluetooth kernel hci_conn.c */
382 void hci_conn_enter_active_mode(struct hci_conn *conn)
383 {
384         struct hci_dev *hdev = conn->hdev;
385
386         BT_DBG("conn %p mode %d", conn, conn->mode);
387
388         if (test_bit(HCI_RAW, &hdev->flags))
389                 return;
390
391         if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
392                 goto timer;
393 
394         if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
395                 struct hci_cp_exit_sniff_mode cp;
396                 cp.handle = __cpu_to_le16(conn->handle);
397                 hci_send_cmd(hdev, OGF_LINK_POLICY,
398                                 OCF_EXIT_SNIFF_MODE, sizeof(cp), &cp);
399         }
400
401 timer:
402         if (hdev->idle_timeout > 0)
403                 mod_timer(&conn->idle_timer,
404                         jiffies + msecs_to_jiffies(hdev->idle_timeout));
405 }
406 

If possible, could you explain why this code checks !conn->power_save var.? 

Without this , if  conn->mode==HCI_CM_SNIFF , we simply exit sniff
mode,"OCF_EXIT_SNIFF_MODE".

As far as I understood, whenever conn->mode is HCI_CM_SNIFF conn->power_save
is 0.
The reason is that  hci_mode_change_evt() set conn->power_save as "0" when
conn->mode !=HCI_CM_ACTIVE.

Consequently we don't need to check that variable.

Regards 
Chanyeol.




