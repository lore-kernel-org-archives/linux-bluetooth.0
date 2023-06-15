Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16FEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jun 2023 20:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjFOUDB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jun 2023 16:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFOUDA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jun 2023 16:03:00 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFF4296E
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 13:02:58 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QhtWM1bcdz49Psb;
        Thu, 15 Jun 2023 23:02:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1686859375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9OqlOWEk4wywvweTYmBeXjJNRK11sOp9CwxXPKctcPM=;
        b=AqspiCO7ddUiNcoGfoP4qRlS7K33Fk2CKHZ9MWKWkogfiC5lt2HzwJWR8iCqaQxpSit90N
        imOVQaatOmisZt2MXJL2aGiiOxTF9UnRTQDre7rMl0ncTsSLlH6Yrvjezry55zO9GPUtQO
        lsVKJH3l5gKzezf99ZSEwIXQkX4of5JpSNfZcIVUrta5MA6fPlCoDq5BIGcdAhQUqmvlh+
        xAfb8at2vgr/ei0FegdQJgPqu5rPg/IJ6IngBn4QgwfbqlkXYGBqyDx+pYVT9JHvYr7tEk
        rjA7gdYJFJf4ac9zgS7UCdX3jwvR/1nnq9mIODYCQ6Ys14gdpNmpyi5+bOvRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1686859375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9OqlOWEk4wywvweTYmBeXjJNRK11sOp9CwxXPKctcPM=;
        b=FihN7vJba/rzqWJQyCTVEq1Hmk3cWLGurDYV0blyYMdEPgs3wyu9NVpxDf+0cDczlQINYw
        j9xsEAvpAWjkbzMtrP01UihIPWQJ1eKK7DktGf909W20wdgJzQakUkzlAzQ472QynUosEv
        /ZU0F5U5rnWcSf0jqwNtmm1DQ/u+ibME4eacDJiBfeyIiQ5H9oKmhDKKJWFww5dYxR4t/V
        VS+pfiZST4GARiRQ1rSyjSwtD8ibUnA3fRG25ITZ+os5p2Eul967sMLb/oIOdyIIDx/CIr
        szgvLs7ZL9A87djACwYUMhutidnA5r6067ojJCsE2rRS5Q/a9nmgC5mPWoQ4kw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1686859375; a=rsa-sha256;
        cv=none;
        b=Ts/+TdE+gWu3m/lNzhtroPjOx3T1MmC1dBrVEojSI8/54bKGXlNzwov6XhLH3J3T+LieCe
        LYLUVCKH1GXeTqqIltWzOZ2JCBgR0sISshEElX7U4yzWliv2U3G/rgGIejPXzCbGd/E+y4
        bBsM7NrvNlZ6VI/9p/KqtrrHB0KyPKizmHOyKMTScB6zzQdnANMVBCga4iuTT4KxcaW2/b
        f8OF0ix2brMeaNUq4eVRNAUM/WWqgKe4fSpfPvjIsRFNWmaPY2x/+az0+1R4c28yjVrPg3
        wbCI8KdawM4aCIaZEeGkbf8RmFna0gC+HmidRFMuDTT0fOCX8WZO4aCHogSk0A==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] mgmt-tester: Add a regression test hitting hci_sync bug
Date:   Thu, 15 Jun 2023 23:02:51 +0300
Message-Id: <482831b8629d9f4f98ef88c769371a03a872d1b7.1686859345.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a test "Add + Remove Device Nowait - Success" that hits a race
condition in kernel hci_sync.c.  On current kernels this causes

BUG: KASAN: slab-use-after-free in hci_update_passive_scan_sync+0x857/0x1230

due to unsafe iteration of hdev->pend_le_conns (in Linux <= 6.4-rc4).

This seems to hit the race condition also without the added emulator
delay (since the emulator runs in the same thread), but it's better to
add the delay since otherwise it'll depend on timings on kernel side.
---
 tools/mgmt-tester.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index b819bccbc..aec91fb41 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4682,6 +4682,16 @@ static const struct generic_data remove_device_success_6 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
+static const struct generic_data add_remove_device_nowait = {
+	.setup_settings = settings_powered_le,
+	.expect_param = remove_device_param_2,
+	.expect_len = sizeof(remove_device_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
+	.expect_alt_ev_param = remove_device_param_2,
+	.expect_alt_ev_len = sizeof(remove_device_param_2),
+};
+
 static const struct generic_data read_adv_features_invalid_param_test = {
 	.send_opcode = MGMT_OP_READ_ADV_FEATURES,
 	.send_param = dummy_data,
@@ -11460,6 +11470,41 @@ static void test_remove_device(const void *test_data)
 	test_add_condition(data);
 }
 
+static bool hook_delay_cmd(const void *data, uint16_t len, void *user_data)
+{
+	tester_print("Delaying emulator response...");
+	g_usleep(250000);
+	tester_print("Delaying emulator response... Done.");
+	return true;
+}
+
+static void test_add_remove_device_nowait(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	/* Add and remove LE device with autoconnect without waiting for reply,
+	 * while delaying emulator response to better hit a race condition.
+	 * This shall not crash the kernel (but eg Linux 6.4-rc4 crashes).
+	 */
+
+	tester_print("Adding and removing a device");
+
+	test_add_condition(data);
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
+					hook_delay_cmd, NULL);
+
+	mgmt_send_nowait(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+				sizeof(add_device_success_param_3),
+				add_device_success_param_3, NULL, NULL, NULL);
+
+	mgmt_send_nowait(data->mgmt, MGMT_OP_REMOVE_DEVICE, data->mgmt_index,
+				sizeof(remove_device_param_2),
+				remove_device_param_2,
+				command_generic_callback, NULL, NULL);
+}
+
 static void trigger_device_found(void *user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -13540,6 +13585,10 @@ int main(int argc, char *argv[])
 				&remove_device_success_6,
 				setup_add_device, test_remove_device);
 
+	test_le("Add + Remove Device Nowait - Success",
+				&add_remove_device_nowait,
+				NULL, test_add_remove_device_nowait);
+
 	test_bredrle("Read Advertising Features - Invalid parameters",
 				&read_adv_features_invalid_param_test,
 				NULL, test_command_generic);
-- 
2.40.1

