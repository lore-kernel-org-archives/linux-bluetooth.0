Return-Path: <SRS0=GIG2=4C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2451C3B197
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 11:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE13624649
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 11:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQAkM9Mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgBNLQv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:16:51 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:37212 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgBNLQu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Feb 2020 06:16:50 -0500
Received: by mail-vs1-f73.google.com with SMTP id n129so675205vsd.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2020 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c3okqhGXbbn+0UGnWI89nn927kUSh19dp4ivRMVKM2U=;
        b=iQAkM9MjICHpGcWO1za9HTHfLgysGmX4AvNhv0qrE8Eyc53ngdh1T8OpbzVHWkZ0fo
         KXNxqzuGBpFGVRu6EGDu2mxLR0mSVHjrqSUBirnlt6TtXajhTXSJzPQN561gCblVT/Bm
         d9O2k3B5DaTnJAJp0+Uqkkj3DsaCIjuER6vwEbnL9WeFAg5PoyCzy6tVwlZ0NRSe6DXP
         a6wDsljFgIyHhEKyFUHsfdZgua/fcyGPgCG3RcScdrCZTj6P15ukbzTPk6xjHhIjHzo/
         +3bn0EzWxXjzTivBC5zTYDoqdIGI63+qWx2PwA0Qdm2jglKCm5R1JWJPtZISzQNrKglc
         jexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c3okqhGXbbn+0UGnWI89nn927kUSh19dp4ivRMVKM2U=;
        b=Fvj5LmY/dahIk5AXIWjsmp5R/YHA+RYonSN10UH4v7ct5FizbJX5DLPWu4tvE8DV50
         Hmu8mJabbwv78IEJ5chVCKJ62GhdMfRHKW51TGrY30Af1t5Sgqy3LYB4fzXa77c5yLWa
         k11u41uUlYDY2NMRJ3grJ1UDNBBZqX/q2joAi2C7w3PRitx8YIssOmk+kYziXBz2BNW8
         BNskDn4kP7VPDjIEYjvK388sMJs1gNMNdayW8bBL7IzbdFxyACshxvMmHIL6Q69+sDZR
         lKdn3wr4nVu3QhPetYgusQvPCK+sQLUKIJqvDi2MP3yrzS7pr+SLCWpTfwBVi6vI7tWT
         TQcA==
X-Gm-Message-State: APjAAAWvi7jGQ1KJqIxkmXq7ct4fKaVhBWVFzJI2nzokiD3AeRKhqE5s
        CWsg7JY/OA8F/qQ/WgDRvJNdu75prHThBTyYkZG+uBjmIY6NjLmzNDrKBoOCdd7u4C2tLDN2SD8
        gX24KDwnrvuTvFuFr9JKM2+ue4BHVnn1c3MC+7pEnsKFFOeuPDRUrxagq0i9bq94s9LkxqyxuX2
        QKzC+dFx/3sNk=
X-Google-Smtp-Source: APXvYqzsIA3nUi3NBbhp5dI9jRoSYsoMZCDaMZ07OVCCBOj8uKzTu0JiMAsaZ8k19Z0h13CTZjvl3d3xNuD/pHp54g==
X-Received: by 2002:ab0:2859:: with SMTP id c25mr1216302uaq.79.1581679007748;
 Fri, 14 Feb 2020 03:16:47 -0800 (PST)
Date:   Fri, 14 Feb 2020 19:16:41 +0800
Message-Id: <20200214191609.Bluez.v5.1.Ia71869d2f3e19a76a6a352c61088a085a1d41ba6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [Bluez PATCH v5] bluetooth: secure bluetooth stack from bluedump attack
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Attack scenario:
1. A Chromebook (let's call this device A) is paired to a legitimate
   Bluetooth classic device (e.g. a speaker) (let's call this device
   B).
2. A malicious device (let's call this device C) pretends to be the
   Bluetooth speaker by using the same BT address.
3. If device A is not currently connected to device B, device A will
   be ready to accept connection from device B in the background
   (technically, doing Page Scan).
4. Therefore, device C can initiate connection to device A
   (because device A is doing Page Scan) and device A will accept the
   connection because device A trusts device C's address which is the
   same as device B's address.
5. Device C won't be able to communicate at any high level Bluetooth
   profile with device A because device A enforces that device C is
   encrypted with their common Link Key, which device C doesn't have.
   But device C can initiate pairing with device A with just-works
   model without requiring user interaction (there is only pairing
   notification). After pairing, device A now trusts device C with a
   new different link key, common between device A and C.
6. From now on, device A trusts device C, so device C can at anytime
   connect to device A to do any kind of high-level hijacking, e.g.
   speaker hijack or mouse/keyboard hijack.

Since we don't know whether the repairing is legitimate or not,
leave the decision to user space if all the conditions below are met.
- the pairing is initialized by peer
- the authorization method is just-work
- host already had the link key to the peer

Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v5:
- Rephrase the comment

Changes in v4:
- optimise the check in smp.c.

Changes in v3:
- Change confirm_hint from 2 to 1
- Fix coding style (declaration order)

Changes in v2:
- Remove the HCI_PERMIT_JUST_WORK_REPAIR debugfs option
- Fix the added code in classic
- Add a similar fix for LE

 net/bluetooth/hci_event.c | 10 ++++++++++
 net/bluetooth/smp.c       | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2c833dae9366..e6982f4f51ea 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4571,6 +4571,16 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 			goto confirm;
 		}
 
+		/* If there already exists link key in local host, leave the
+		 * decision to user space since the remote device could be
+		 * legitimate or malicious.
+		 */
+		if (hci_find_link_key(hdev, &ev->bdaddr)) {
+			bt_dev_warn(hdev, "Local host already has link key");
+			confirm_hint = 1;
+			goto confirm;
+		}
+
 		BT_DBG("Auto-accept of user confirmation with %ums delay",
 		       hdev->auto_accept_delay);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2cba6e07c02b..25dbf77d216b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2192,6 +2192,25 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
+
+		/* Only Just-Works pairing requires extra checks */
+		if (smp->method != JUST_WORKS)
+			goto mackey_and_ltk;
+
+		/* If there already exists link key in local host, leave the
+		 * decision to user space since the remote device could be
+		 * legitimate or malicious.
+		 */
+		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
+				 hcon->role)) {
+			err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+							hcon->type,
+							hcon->dst_type, passkey,
+							1);
+			if (err)
+				return SMP_UNSPECIFIED;
+			set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
+		}
 	}
 
 mackey_and_ltk:
-- 
2.25.0.265.gbab2e86ba0-goog

