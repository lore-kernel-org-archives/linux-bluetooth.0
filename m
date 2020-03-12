Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854D7C1975A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC6D20736
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKc2lh46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCLKHQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:07:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44090 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLKHP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:07:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so2461159plo.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 03:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rzhdRm2fp7f9hQ3db6A/lbeobDKzou7qkzpbeUmHsp8=;
        b=rKc2lh46NqRlbqvtCMIy6IZFSjzC/NNtw2DyYUbqNup8mg1mZrotVzwXMND0fqx0cj
         AkdJReJaXqVAk5s/ZXBW1gaXCWnbQye1VT8pXGAybfoPDQ+zxNBcDqxg64M2ABOFha05
         usyOrqJ6NPOAgwuGzLP9Xh25N1lS0sHZxuxdDN9huTb/xdbFhnHKuc0sBiljttxYPUTW
         TnQ/BURI+eyV253Ea76daE9oCWL3HJ+w85uywI1yIGwp+BlQD136YEvj2YmANXkycw8d
         wwNBh4zKvUSAOFADKMNcxeFO8lhhDsS63GuQH7kdLNaSwJic+rG2FrbkZi1UnJhphauF
         HUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rzhdRm2fp7f9hQ3db6A/lbeobDKzou7qkzpbeUmHsp8=;
        b=ml7top9F4dAa5KICNtBfDmLJ6BcRpbGks9z0RNYhoE+jPEwC8yDWfzLhb+kqdSVYPd
         aBIc1vLPZe/RvvvkhiusMb6NiKEbOeF3WsyVYKyBP1QvUt+vYW3Vpobz4fEL2sePIGxb
         gODTeHQVvQGHVRcWBeRb6cf37y4SBoQxUOqFna3Hsssy3AsDksQyBNZFpglFwky00/NZ
         tRmAH/tcQnJ+kXilbfz6Jmx1/lms3LY7bQ4KPql8F1DaUXygy9fg04WgjjFjEVQ6rECF
         puU618vJ3cXN3Vpbqjbiwl3A9AYEbAFKWrqWUPpaFmoantQoPotWALk9DYPH13LVLSLA
         O+bQ==
X-Gm-Message-State: ANhLgQ1Tr8XZEoq7UVvqUYTnPrtFITS298bxCGok6eEJw5z5DRiXbQEV
        lOxBgG4+sHn47yI5GgEJOatM5MQs0WT5Rg==
X-Google-Smtp-Source: ADFU+vvVv2Q42csXG5ghBQyOGYuMlGi+A+kUhS6/TzRFimpMXRXKt7LWPrncMdRpZaq4tKlm2Z4krQ==
X-Received: by 2002:a17:90a:1912:: with SMTP id 18mr3347856pjg.124.1584007631969;
        Thu, 12 Mar 2020 03:07:11 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id e9sm10578295pfl.179.2020.03.12.03.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:07:11 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH 6/7] Bluetooth: Enable LL Privacy
Date:   Thu, 12 Mar 2020 15:37:53 +0530
Message-Id: <20200312100754.3445-7-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312100754.3445-1-sathish.narasimman@intel.com>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This enables Link Layer Privacy and sets RPA timeout to 900sec

< HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1
        Address resolution: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Address Resolution Enable (0x08|0x002d) ncmd 1d
        Status: Success (0x00)
< HCI Command: LE Set Resolvable Private Address Timeout (0x08|0x002e) plen 2
        Timeout: 900 seconds
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 1
        Status: Success (0x00)

During Successfull pairing adding the information to device Resolving
list

< HCI Command: LE Add Device To Resolving List (0x08|0x0027) plen 39
        Address type: Random (0x01)
        Address: D1:79:92:B1:83:DF (Static)
        Peer identity resolving key: ecc317056e5b385cda281b9c24a453e9
        Local identity resolving key: 00000000000000000000000000000000

< ACL Data TX: Handle 3585 flags 0x00 dlen 21
      SMP: Signing Information (0x0a) len 16
        Signature key: 37b6c45656c7e8b3ec8db062c3e0c2b2
> ACL Data RX: Handle 3585 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
> ACL Data RX: Handle 3585 flags 0x02 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000a-0xffff
        Attribute group type: Primary Service (0x2800)

> HCI Event: Command Complete (0x0e) plen 4
      LE Add Device To Resolving List (0x08|0x0027) ncmd 1
        Status: Success (0x00)

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_conn.c    | 32 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c    | 20 +++++++++++++++++++-
 net/bluetooth/hci_event.c   | 32 +++++++++++++++++++++++++-------
 net/bluetooth/hci_request.c | 16 +++++++++++++---
 net/bluetooth/mgmt.c        | 10 +++++++++-
 net/bluetooth/smp.c         | 11 +++++++++++
 7 files changed, 111 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 352bc43940ff..d8431ebb8baa 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1617,6 +1617,8 @@ struct hci_rp_le_read_resolv_list_size {
 
 #define HCI_OP_LE_SET_ADDR_RESOLV_ENABLE 0x202d
 
+#define HCI_OP_LE_SET_RPA_TIMEOUT 	 0x202e
+
 #define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
 struct hci_rp_le_read_max_data_len {
 	__u8	status;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e245bc155cc2..06067c0852a6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -830,6 +830,14 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 
 		plen = sizeof(*cp);
 
+		/* If the own_addr_type is 0x03 or 0x02 and peer is present
+		 * in Kernel IRK list, but not in resolving add the peer to
+		 * the resolving list.
+		 */
+		if (own_addr_type == 0x03 || own_addr_type == 0x02)
+			hci_req_check_and_update_resolving_list(hdev, conn->dst_type,
+								&conn->dst);
+
 		if (scan_1m(hdev)) {
 			cp->phys |= LE_SCAN_PHY_1M;
 			set_ext_conn_params(conn, p);
@@ -866,6 +874,14 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 		cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 		cp.scan_window = cp.scan_interval;
 
+		/* If the own_addr_type is 0x03 or 0x02 and peer is present
+		 * in Kernel IRK list, but not in resolving add the peer to
+		 * the resolving list.
+		 */
+		if (own_addr_type == 0x03 || own_addr_type == 0x02)
+			hci_req_check_and_update_resolving_list(hdev, conn->dst_type,
+								&conn->dst);
+
 		bacpy(&cp.peer_addr, &conn->dst);
 		cp.peer_addr_type = conn->dst_type;
 		cp.own_address_type = own_addr_type;
@@ -901,6 +917,14 @@ static void hci_req_directed_advertising(struct hci_request *req,
 					   &own_addr_type, &random_addr) < 0)
 			return;
 
+		/* If the own_addr_type is 0x03 or 0x02 and peer is present
+		 * in Kernel IRK list, but not in resolving add the peer to
+		 * the resolving list.
+		 */
+		if (own_addr_type == 0x03 || own_addr_type == 0x03)
+			hci_req_check_and_update_resolving_list(hdev, conn->dst_type,
+								&conn->dst);
+
 		memset(&cp, 0, sizeof(cp));
 
 		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_DIRECT_IND);
@@ -959,6 +983,14 @@ static void hci_req_directed_advertising(struct hci_request *req,
 					      &own_addr_type) < 0)
 			return;
 
+		/* If the own_addr_type is 0x03 or 0x02 and peer is present
+		 * in Kernel IRK list, but not in resolving add the peer to
+		 * the resolving list.
+		 */
+		if (own_addr_type == 0x03 || own_addr_type == 0x02)
+			hci_req_check_and_update_resolving_list(hdev, conn->dst_type,
+								&conn->dst);
+
 		memset(&cp, 0, sizeof(cp));
 
 		/* Some controllers might reject command if intervals are not
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dbd2ad3a26ed..7727be922084 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -713,7 +713,7 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 		/* If the controller supports the LE Extended Create Connection
 		 * command, enable the corresponding event.
 		 */
-		if (use_ext_conn(hdev))
+		if (use_ext_conn(hdev) || hdev->le_features[0] & HCI_LE_LL_PRIVACY)
 			events[1] |= 0x02;      /* LE Enhanced Connection
 						 * Complete
 						 */
@@ -762,6 +762,24 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_CLEAR_RESOLV_LIST, 0, NULL);
 		}
 
+		if (hdev->commands[35] & 0x02) {
+			u8 addr_resoln_enable = 0x01;
+
+			/* Enable Address Resolution in controller */
+			hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE,
+				    sizeof(addr_resoln_enable),
+				    &addr_resoln_enable);
+		}
+
+		if (hdev->commands[35] & 0x40) {
+			__le16 rpa_timeout = cpu_to_le16(hdev->rpa_timeout);
+
+			/* Set RPA timeout */
+			hci_req_add(req, HCI_OP_LE_SET_RPA_TIMEOUT, 2,
+				    &rpa_timeout);
+
+		}
+
 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 			/* Read LE Maximum Data Length */
 			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 20408d386268..d5ce1921fadd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1684,7 +1684,11 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	hci_dev_lock(hdev);
-	hdev->adv_addr_type = cp->own_address_type;
+
+	if (cp->own_address_type == ADDR_LE_DEV_PUBLIC)
+		hdev->adv_addr_type = ADDR_LE_DEV_PUBLIC;
+	else
+		hdev->adv_addr_type = ADDR_LE_DEV_RANDOM;
 	hci_dev_unlock(hdev);
 }
 
@@ -1704,7 +1708,12 @@ static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	hci_dev_lock(hdev);
-	hdev->adv_addr_type = cp->own_addr_type;
+
+	if (cp->own_addr_type == ADDR_LE_DEV_PUBLIC)
+		hdev->adv_addr_type = ADDR_LE_DEV_PUBLIC;
+	else
+		hdev->adv_addr_type = ADDR_LE_DEV_RANDOM;
+
 	if (!hdev->cur_adv_instance) {
 		/* Store in hdev for instance 0 */
 		hdev->adv_tx_power = rp->tx_power;
@@ -2267,11 +2276,13 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 	 * is needed for SMP. These values will not change during the
 	 * lifetime of the connection.
 	 */
-	conn->init_addr_type = own_address_type;
-	if (own_address_type == ADDR_LE_DEV_RANDOM)
+	if (own_address_type == 0x03 || own_address_type == 0x01) {
+		conn->init_addr_type = ADDR_LE_DEV_RANDOM;
 		bacpy(&conn->init_addr, &hdev->random_addr);
-	else
+	} else {
+		conn->init_addr_type = ADDR_LE_DEV_PUBLIC;
 		bacpy(&conn->init_addr, &hdev->bdaddr);
+	}
 
 	conn->resp_addr_type = peer_addr_type;
 	bacpy(&conn->resp_addr, peer_addr);
@@ -5141,6 +5152,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		}
 	}
 
+	hci_req_check_and_update_resolving_list(hdev, (conn->dst_type), &conn->dst);
+
 unlock:
 	hci_update_background_scan(hdev);
 	hci_dev_unlock(hdev);
@@ -5365,8 +5378,13 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		/* Only resolvable random addresses are valid for these
 		 * kind of reports and others can be ignored.
 		 */
-		if (!hci_bdaddr_is_rpa(direct_addr, direct_addr_type))
-			return;
+		if (!hci_bdaddr_is_rpa(direct_addr, direct_addr_type)) {
+			/* Controller with LL Privacy Supported tend to resolve
+			 * the RPA. In that case we should ignore this condition
+			 */
+			if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY))
+				return;
+		}
 
 		/* If the controller is not using resolvable random
 		 * addresses, then this report can be ignored.
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 6b685cdc7de5..12868caf50ea 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1916,7 +1916,12 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 	if (use_rpa) {
 		int to;
 
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		if (hdev->le_features[0] & HCI_LE_LL_PRIVACY) {
+			/*if there is no resolving list used in the controller
+			 * use the bd_addr from latest Le_set_random_address*/
+			*own_addr_type = 0x03;
+		} else
+			*own_addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (adv_instance) {
 			if (!adv_instance->rpa_expired &&
@@ -2074,7 +2079,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 
 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
 
-	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
+	if (((own_addr_type == ADDR_LE_DEV_RANDOM) || (own_addr_type == 0x03)) &&
 	    bacmp(&random_addr, BDADDR_ANY)) {
 		struct hci_cp_le_set_adv_set_rand_addr cp;
 
@@ -2341,7 +2346,12 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	if (use_rpa) {
 		int to;
 
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		if (hdev->le_features[0] & HCI_LE_LL_PRIVACY) {
+			/*if there is no resolving list used in the controller
+			 * use the bd_addr from latest Le_set_random_address*/
+			*own_addr_type = 0x03;
+		} else
+			*own_addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
 		    !bacmp(&hdev->random_addr, &hdev->rpa))
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6552003a170e..2b2bc011a130 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5084,8 +5084,10 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 	if (err < 0)
 		goto unlock;
 
-	if (changed)
+	if (changed) {
 		err = new_settings(hdev, sk);
+		hci_req_update_resolving_list_local_irk(hdev);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5227,6 +5229,8 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			    BDADDR_ANY);
 	}
 
+	/* Load the resolving list with entries from IRK list.*/
+	hci_load_resolving_list(hdev);
 	hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_IRKS, 0, NULL, 0);
@@ -7213,6 +7217,10 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
 	if (match.sk)
 		sock_put(match.sk);
 
+	/* If load _irk was called when controller was powered down,
+	 * then the resolving list has to be updated now.
+	 */
+	hci_load_resolving_list(hdev);
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1476a91ce935..85be3f5d869a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2425,6 +2425,8 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct smp_chan *smp;
 	int err;
 
+	hci_req_del_from_resolving_list(hdev, addr_type, bdaddr);
+
 	err = hci_remove_ltk(hdev, bdaddr, addr_type);
 	hci_remove_irk(hdev, bdaddr, addr_type);
 
@@ -2619,6 +2621,15 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	smp->remote_irk = hci_add_irk(conn->hcon->hdev, &smp->id_addr,
 				      smp->id_addr_type, smp->irk, &rpa);
 
+	/* Add the device to the resolving list.*/
+	hci_req_update_resolving_list(conn->hcon->hdev,
+					      smp->remote_irk->addr_type,
+					      &smp->remote_irk->bdaddr,
+					      smp->remote_irk->val);
+
+
+	/*TODO:  Check remote device Supports LL Privacy. If not set the device
+	 * with IRK to Device-privacy Mode - Should be discussed - Based on */
 distribute:
 	if (!(smp->remote_key_dist & KEY_DIST_MASK))
 		smp_distribute_keys(smp);
-- 
2.17.1

