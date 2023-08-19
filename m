Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E32EE49A5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Aug 2023 13:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjHSNdd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Aug 2023 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNdc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Aug 2023 09:33:32 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974031A2A8
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 06:31:34 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RSflg30FMzyfN;
        Sat, 19 Aug 2023 16:31:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1692451887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CeyuORkRww/CWbLS26iE+78V82b5y9/EStIhVviNYA=;
        b=Z5NGIEHowI8I2Bm48J5yOVN4+3uEiGKi28rdzEYxIHB3+OWlHqsX27hDcVY2x6nvRZkyq/
        rwEH54lPZZbCN3CZuCWQELFA8RPN0SDbH/kC+et8glLdBrCV8QYbd8EqtjuLaFcpK3JMFU
        dnjTf3GwndNL1sDaI0ddjLlVMFAcMpg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1692451887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CeyuORkRww/CWbLS26iE+78V82b5y9/EStIhVviNYA=;
        b=y2cvH4Uz2DbRMVrgQf95Fq1g3jexyLhcX7FNZqCSMojPmVjoPjEVCH4/PiBvjy3QcyHzcL
        z8/gPZSs51ZiwndB9iOEssSLRnytoCI5hSocygdo4BOpwOpJWbUrdD+y0CT7+V/xlndmt1
        yGtcznSb6/ifE0xf7VaWLsIhHBnNgIg=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1692451887; a=rsa-sha256; cv=none;
        b=sS7pkbBeh/gwfiHjQPUt9/AuSIVGJvE3qlBndACbNXWAikj3z/cjCqDobZxAl3m5SsKYT3
        B0Vk1FO/mUmPRzs6o1NO2YXkM5ZkVuyzcpEFzUq5SyzRDAFvAEQsu42CVtiPKO3SPEOd1O
        Lr+qe6bcPNWhtFZQZ5ZDd8kUVCB/06w=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/4] iso-tester: add test for ACL disconnect before ISO created
Date:   Sat, 19 Aug 2023 16:31:23 +0300
Message-ID: <444c48235fb02ac68871236ce669fd02b4a4736d.1692451184.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
References: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Simulate ACL being disconnected when connecting ISO, before LE Create
CIS got sent.  The kernel shall indicate connection failure for the ISO
socket immediately when the ACL is gone, since connecting the ISO can no
longer proceed.

ISO Connect ACL Disconnect - Failure
---

Notes:
    Current bluetooth-next/master kernel fails this.

 tools/iso-tester.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index b1a2afba0..48c8ab52a 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2628,6 +2628,40 @@ static void test_connect_suspend(const void *test_data)
 	trigger_force_suspend((void *)test_data);
 }
 
+static bool hook_acl_disc(const void *msg, uint16_t len, void *user_data)
+{
+	const uint8_t *msg_data = msg;
+	const struct bt_hci_evt_le_enhanced_conn_complete *ev;
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+
+	if (msg_data[0] != BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE)
+		return true;
+
+	ev = (void *) &msg_data[1];
+
+	tester_print("Disconnect ACL");
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_hci_disconnect(bthost, le16_to_cpu(ev->handle), 0x13);
+
+	hciemu_flush_client_events(data->hciemu);
+
+	return true;
+}
+
+static void test_connect_acl_disc(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	/* ACL disconnected before ISO is created */
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_LE_META_EVENT,
+					hook_acl_disc, NULL);
+
+	test_connect(test_data);
+}
+
 static void test_bcast(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2850,6 +2884,10 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_connect2);
 
+	test_iso("ISO Connect ACL Disconnect - Failure", &connect_suspend,
+							setup_powered,
+							test_connect_acl_disc);
+
 	test_iso("ISO Defer Send - Success", &connect_16_2_1_defer_send,
 							setup_powered,
 							test_connect);
-- 
2.41.0

