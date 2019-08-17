Return-Path: <SRS0=BOCR=WN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887F3C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 22:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584A920880
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 22:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHQWmH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 18:42:07 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:34720 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfHQWmH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 18:42:07 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EA28F288EE
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Aug 2019 22:42:06 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id DECC6288F6; Sat, 17 Aug 2019 22:42:06 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 17 Aug 2019 22:42:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arthur@life.net.br
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-f9gP804l7u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #35 from Arthur Fragoso (arthur@life.net.br) ---

The code for these devices are bellow.

You are right, the patch is way too old for this.

I will probably buy a different device while we wait for someone with more
knowledge to fix this.


/linux/drivers/bluetooth/btusb.c

kenel 5.2.8

static const struct usb_device_id blacklist_table[] = {
        /* CSR BlueCore devices */
        { USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },


static int btusb_setup_csr(struct hci_dev *hdev)
{
        struct hci_rp_read_local_version *rp;
        struct sk_buff *skb;

        BT_DBG("%s", hdev->name);

        skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
                             HCI_INIT_TIMEOUT);
        if (IS_ERR(skb)) {
                int err = PTR_ERR(skb);
                bt_dev_err(hdev, "CSR: Local version failed (%d)", err);
                return err;
        }

        if (skb->len != sizeof(struct hci_rp_read_local_version)) {
                bt_dev_err(hdev, "CSR: Local version length mismatch");
                kfree_skb(skb);
                return -EIO;
        }

        rp = (struct hci_rp_read_local_version *)skb->data;

        /* Detect controllers which aren't real CSR ones. */
        if (le16_to_cpu(rp->manufacturer) != 10 ||
            le16_to_cpu(rp->lmp_subver) == 0x0c5c) {
                /* Clear the reset quirk since this is not an actual
                 * early Bluetooth 1.1 device from CSR.
                 */
                clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);

                /* These fake CSR controllers have all a broken
                 * stored link key handling and so just disable it.
                 */
                set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
        }

        kfree_skb(skb);

        return 0;
}

-- 
You are receiving this mail because:
You are the assignee for the bug.
