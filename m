Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D1EE49A8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Aug 2023 13:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjHSNdk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Aug 2023 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNdk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Aug 2023 09:33:40 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE99255E2
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 06:31:34 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RSflg22pVzydv;
        Sat, 19 Aug 2023 16:31:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1692451887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHkOP8ei0C/7dI72g+L6LTwouMqiFz34F6ZsMFxBN1s=;
        b=M2bYqHV9Ts/snNT86/tljL8RyEWldOmutr1hRwplsMzZbKk23eUxajhJn7uLgLiOQchpNQ
        0v3GsEFGQ5r5yQw9UJNdPZWgtFwfEfqj/Bxhsa0LYtbmXUyO7mAKy2U7OscIhS0BRiV8nV
        I3QUN+NbFm5CAM1VJ2PXNE5bhgUyk1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1692451887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHkOP8ei0C/7dI72g+L6LTwouMqiFz34F6ZsMFxBN1s=;
        b=u1EeQDYz22XY8b8BH9rUjfX18MzDrjrYopzbsuQ8l4GZA1Ysv2x5DbTd2XZB2GUn/MJzsf
        VkuiaJhYUubx+n/9Zq9W6glMFsiBDCKBZeyYSlAKcgx9ZskQ2Fh54q/0x6QT+NWbeStOVM
        NOw/jomMS8LqvddOP+LsAXHD5DaCSPs=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1692451887; a=rsa-sha256; cv=none;
        b=ie08uD0FHpUFJ1TwCsmGER78yn5TqwLumYNdiUidTcxGVRfDeOc1pLPxxwFMqRlBZv+tZr
        BdXnayPq5tfwdLygVmyVB4Mso1SHm3BiPfqXoKcOpnMsEIwLLbotmSKG6DHjWCDLelurlg
        lVl/ORwTzj7Ak30VeOTN2qJZe8U8b7o=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/4] sco-tester: add test for ACL disconnect before SCO established
Date:   Sat, 19 Aug 2023 16:31:22 +0300
Message-ID: <d5f409c7af4638a03af56a6083e0416a32f4b590.1692451184.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
References: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Simulate ACL being disconnected before SCO is established.  Kernel shall
not crash.

eSCO ACL Disconnect - Failure

Link: https://lore.kernel.org/linux-bluetooth/00000000000013b93805fbbadc50@google.com/
---

Notes:
    Current bluetooth-next/master crashes, similarly as what syzbot says.

 tools/sco-tester.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index f3de42c7b..ecc65e092 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -800,6 +800,36 @@ static void test_connect_simult_disc(const void *test_data)
 	test_connect(test_data);
 }
 
+static bool hook_acl_disc(const void *msg, uint16_t len, void *user_data)
+{
+	const struct bt_hci_evt_conn_complete *ev = msg;
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
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
+	/* ACL disconnected before SCO is established seen.
+	 * Kernel shall not crash, but <= 6.5-rc5 crash.
+	 */
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_CONN_COMPLETE,
+					hook_acl_disc, NULL);
+
+	test_connect(test_data);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -826,6 +856,10 @@ int main(int argc, char *argv[])
 					&connect_failure_reset, setup_powered,
 					test_connect_simult_disc);
 
+	test_sco("eSCO ACL Disconnect - Failure",
+					&connect_failure_reset, setup_powered,
+					test_connect_acl_disc);
+
 	test_sco_11("SCO CVSD 1.1 - Success", &connect_success, setup_powered,
 							test_connect);
 
-- 
2.41.0

