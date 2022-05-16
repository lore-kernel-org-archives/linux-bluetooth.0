Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F29C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 21:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348509AbiEPVBk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348877AbiEPVA6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 17:00:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764036161
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 13:35:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id a191so15163881pge.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LRm1FMjn/Xh+iHc9zJ9/GDuc1FS7dkjMjq0HsFo7vJE=;
        b=EvZX1jCjl/8b9SMEehBwMD/JWXtfTvt0Fc3G1oTqFT18tABZKSPykvIavdNqPTxhba
         Iakf4L5IkMvdIi/ySzauS0jmYZAWSMZWmugdIpxWo9qsG/JNh4n5LXJYzvxvYsk0XpMF
         K3edUMbj7LZSfW+HinqFFUOWABKF97KC5rg+GWI610KW4F+1uH7t9Sx+Gy8F8hn78HNf
         QxlVaGPlqfDmZlIZoZ18CmnRjpsaAPgXicioS0OkEDX98Vyxjk/NSFf4JQrdW49P2ZCU
         PWCzqjsRWahmvutlF4lSUwX3dM6vt59/AAJ1gm555SB206SIHQo0/CtcOSun0L8eIK8h
         L70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LRm1FMjn/Xh+iHc9zJ9/GDuc1FS7dkjMjq0HsFo7vJE=;
        b=4BRi/V3OPwVYRPsOUN5kX5yVQBiNIOBDLUemD/AIKomHmvyJHCu07HqKJeJrgdz9kG
         hPhMDRAuA1DktqhKxHhVGxXD1bfq5zQv01WSC7ajuPOlXkX9KfXMW0tzFwAHr2jHjkB6
         x9zq0HUWgmAdj5aDZr/CEsutrzB6Ej+tsSTxn0tM7mdV3dsSac22Fh3UJojwF4kf6gDF
         zCs3SUcBOFWkMndSik+f0M0sQON/FQNQvlxm0O7X6rJKAeWz3MMsoXKzWUZwhbeWTTMs
         35mV2qMQAIXwoR51NByOygew+6huDVytkKL4uC/xZ2X+C7v+ypHipkCCGoIAkd9lt4Wr
         LRRw==
X-Gm-Message-State: AOAM531AGRMIBWyCS9OzNGf1T7IXASDvPJcvnxmC2cg0njqphw/r7zUZ
        CzSNs5Ij58y9xcw9HlaogYPEPC6xCBk=
X-Google-Smtp-Source: ABdhPJwNTL04O7FhXUTR+Q982zrIOPW8JWkjYssozgH2MKEjUMY1+1+cw7xr2ORTO0WWsj39gN1nEg==
X-Received: by 2002:a63:28c:0:b0:3c1:6f72:7288 with SMTP id 134-20020a63028c000000b003c16f727288mr16590623pgc.564.1652733346203;
        Mon, 16 May 2022 13:35:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090ae50f00b001dc1e6db7c2sm92852pjy.57.2022.05.16.13.35.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:35:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGMT: Fix uses of bitmap_from_u64
Date:   Mon, 16 May 2022 13:35:39 -0700
Message-Id: <20220516203539.1708251-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bitmap_from_u64 expects at least 8 bytes to be declared since it doesn't
take any parameter regarding the number of bits causing the following
warnings:

In file included from include/linux/cpumask.h:12,
                 from include/linux/mm_types_task.h:14,
                 from include/linux/mm_types.h:5,
                 from include/linux/buildid.h:5,
                 from include/linux/module.h:14,
                 from net/bluetooth/mgmt.c:27:
In function 'bitmap_copy',
    inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:270:2,
    inlined from 'bitmap_from_u64' at include/linux/bitmap.h:622:2,
    inlined from 'set_device_flags' at net/bluetooth/mgmt.c:4534:4:
include/linux/bitmap.h:261:9: warning: 'memcpy' forming offset [4, 7] is
out of the bounds [0, 4] of object 'flags' with type
'long unsigned int[1]' [-Warray-bounds]
  261 |         memcpy(dst, src, len);
      |         ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:248,
                 from include/linux/build_bug.h:5,
                 from include/linux/container_of.h:5,
                 from include/linux/list.h:5,
                 from include/linux/module.h:12,
                 from net/bluetooth/mgmt.c:27:
net/bluetooth/mgmt.c: In function 'set_device_flags':
net/bluetooth/mgmt.c:4532:40: note: 'flags' declared here
 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
      |                                        ^~~~~
include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
   11 |         unsigned long name[BITS_TO_LONGS(bits)]
      |                       ^~~~

In order to fix the above this initializes a variable using
DECLARE_BITMAP with the current_flags and then uses bitmap_subset to
check if the flags being set are a subset of hdev->conn_flags that way
all the checks are performed using bitmap APIs and conversion to u32
only happen when really needed.

Fixes: a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 74937a834648..24a779b706b5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4476,9 +4476,16 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 
 static void device_flags_changed(struct sock *sk, struct hci_dev *hdev,
 				 bdaddr_t *bdaddr, u8 bdaddr_type,
-				 u32 supported_flags, u32 current_flags)
+				 unsigned long *flags)
 {
 	struct mgmt_ev_device_flags_changed ev;
+	u32 supported_flags, current_flags = 0;
+
+	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
+			__HCI_CONN_NUM_FLAGS);
+
+	if (flags)
+		bitmap_to_arr32(&current_flags, flags, __HCI_CONN_NUM_FLAGS);
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = bdaddr_type;
@@ -4495,19 +4502,15 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct bdaddr_list_with_flags *br_params;
 	struct hci_conn_params *params;
 	u8 status = MGMT_STATUS_INVALID_PARAMS;
-	u32 supported_flags;
 	u32 current_flags = __le32_to_cpu(cp->current_flags);
+	DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS) = { current_flags };
 
 	bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
-		   &cp->addr.bdaddr, cp->addr.type,
-		   __le32_to_cpu(current_flags));
+		   &cp->addr.bdaddr, cp->addr.type, current_flags);
 
-	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
-			__HCI_CONN_NUM_FLAGS);
-
-	if ((supported_flags | current_flags) != supported_flags) {
-		bt_dev_warn(hdev, "Bad flag given (0x%x) vs supported (0x%0x)",
-			    current_flags, supported_flags);
+	if (bitmap_subset(hdev->conn_flags, flags, __HCI_CONN_NUM_FLAGS)) {
+		bt_dev_warn(hdev, "Bad flag given (0x%lx) vs supported (0x%lx)",
+			    *hdev->conn_flags, *flags);
 		goto done;
 	}
 
@@ -4519,7 +4522,8 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 							      cp->addr.type);
 
 		if (br_params) {
-			bitmap_from_u64(br_params->flags, current_flags);
+			bitmap_copy(br_params->flags, flags,
+				    __HCI_CONN_NUM_FLAGS);
 			status = MGMT_STATUS_SUCCESS;
 		} else {
 			bt_dev_warn(hdev, "No such BR/EDR device %pMR (0x%x)",
@@ -4529,10 +4533,6 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
 		if (params) {
-			DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
-
-			bitmap_from_u64(flags, current_flags);
-
 			/* Devices using RPAs can only be programmed in the
 			 * acceptlist LL Privacy has been enable otherwise they
 			 * cannot mark HCI_CONN_FLAG_REMOTE_WAKEUP.
@@ -4546,7 +4546,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 				goto unlock;
 			}
 
-			bitmap_from_u64(params->flags, current_flags);
+			bitmap_copy(params->flags, flags, __HCI_CONN_NUM_FLAGS);
 			status = MGMT_STATUS_SUCCESS;
 
 			/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
@@ -4568,7 +4568,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 done:
 	if (status == MGMT_STATUS_SUCCESS)
 		device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
-				     supported_flags, current_flags);
+				     flags);
 
 	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_FLAGS, status,
 				 &cp->addr, sizeof(cp->addr));
@@ -7081,8 +7081,6 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	u8 auto_conn, addr_type;
 	struct hci_conn_params *params;
 	int err;
-	u32 current_flags = 0;
-	u32 supported_flags;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
@@ -7153,9 +7151,6 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	} else {
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						addr_type);
-		if (params)
-			bitmap_to_arr32(&current_flags, params->flags,
-					__HCI_CONN_NUM_FLAGS);
 	}
 
 	err = hci_cmd_sync_queue(hdev, add_device_sync, NULL, NULL);
@@ -7164,10 +7159,8 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 
 added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
-	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
-			__HCI_CONN_NUM_FLAGS);
 	device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
-			     supported_flags, current_flags);
+			     params ? params->flags : NULL);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 				MGMT_STATUS_SUCCESS, &cp->addr,
-- 
2.35.1

