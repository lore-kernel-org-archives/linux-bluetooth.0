Return-Path: <SRS0=ihQD=NM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1404ECDE46
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6FC2064C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhQYghlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6FC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeKAXU7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:20:59 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45996 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeKAXU7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Nov 2018 19:20:59 -0400
Received: by mail-ed1-f46.google.com with SMTP id t10-v6so16668628eds.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Nov 2018 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=jh23genbQIjSiN894Oy1IuabHZdDEvXYJuy8A202Gl0=;
        b=mhQYghlD1w+EomrJf4aTTnzQtxSyXFXD65kLQf+ksE4uoDl99MbbaiO7Q5plqMD6aP
         Li5aF9H2WrNOld9rCzU8ygQuYguN/scDi4txUBMIINuqRluZZiEfoTxEvh5qeA3nTLwq
         OVgFUFbbrjqUjCApSfrrY6Lwgu7GmVsTg+3vQ0fke+3JxE86kFbHOshYw2fpz9xSbmKQ
         QTmk99hW4dQ7TxSXR174Ga5Ifx9JZz4E2qFN3E/d9yRnG0m6+xdMgeooBNxWM+FZH2Oy
         05dXXeQmbCDKBH+1ca1lGTCCz2sjBb+Z7ernW5Veg3CMiqOSv5XYC4vwjCSpnMzGZmPD
         K4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=jh23genbQIjSiN894Oy1IuabHZdDEvXYJuy8A202Gl0=;
        b=ZESkiY0VaLdskXnh0ndfUTKYkCBvGbSEAKTQ4k5KgHQr+OuX1jJN3Y3xziyt9TnSrE
         tfGQY91ovQimckw8SjrtYyXU/LBkiI7IdkRQ5fhJ16jKDjGfHg1b4ZTfmTYto9toJxtm
         ysByck90qi8d05K+h4GZPp0fVRyBKfhpqj/4kjGWQto6E9KkCm2hUM9QSYiEfNNFRQUB
         2J41aWDRdl+xnmeKFsl4c1TnyKtVSgbynTCxPoORbbucAMIPtSPvz75CB5Ca4nxF4KDo
         2yFnZaXUMsO5Fwy3rSefN2HSQo5gcxKPueYm9M8h5ktSR1jhILjuL4Vm7a8VNGe5d3oy
         d06g==
X-Gm-Message-State: AGRZ1gJutLC+TZML3/RvaaYOjaHD5jyu4G2M29MEPthErZ+Ijwk6WoFB
        RF6nrzrhVQStzu49l4q/kOieZvUS
X-Google-Smtp-Source: AJdET5eiXiw442ylZMluBecfI0LVu6If/MAX3aR8s3gS9T550sWRV0mLRR8KFaZJ10jccxr0uOwotg==
X-Received: by 2002:a50:d1d7:: with SMTP id i23-v6mr5360414edg.34.1541081867667;
        Thu, 01 Nov 2018 07:17:47 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id g15-v6sm5452219ejj.67.2018.11.01.07.17.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:17:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] unit/test-sdp: Add robustness test for continuation state
Date:   Thu,  1 Nov 2018 16:17:41 +0200
Message-Id: <20181101141741.11449-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181101141741.11449-1-luiz.dentz@gmail.com>
References: <20181101141741.11449-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a test for invalid continuation state:

/TP/SERVER/SA/ROB/BI-01-C - init
/TP/SERVER/SA/ROB/BI-01-C - setup
/TP/SERVER/SA/ROB/BI-01-C - setup complete
/TP/SERVER/SA/ROB/BI-01-C - run
  test-sdp: < 02 00 01 00 16 35 11 1c 00 00 01 00 00 00 10 00  .....5..........
  test-sdp:   80 00 00 80 5f 9b 34 fb 00 01 00                 ...._.4....
bluetoothd[26193]: process_request: Got a svc srch req
bluetoothd[26193]: extract_des: Seq type : 53
bluetoothd[26193]: extract_des: Data size : 17
bluetoothd[26193]: extract_des: Data type: 0x1c
bluetoothd[26193]: extract_des: No of elements : 1
bluetoothd[26193]: service_search_req: Expected count: 1
bluetoothd[26193]: service_search_req: Bytes scanned : 19
bluetoothd[26193]: sdp_cstate_get: Continuation State size : 0
bluetoothd[26193]: service_search_req: Checking svcRec : 0x0
bluetoothd[26193]: service_search_req: Checking svcRec : 0x1
bluetoothd[26193]: service_search_req: Checking svcRec : 0x10000
bluetoothd[26193]: service_search_req: Match count: 1
bluetoothd[26193]: process_request: Sending rsp. status 0
bluetoothd[26193]: process_request: Bytes Sent : 14
  test-sdp: > 03 00 01 00 09 00 01 00 01 00 01 00 00 00        ..............
  test-sdp: < 04 00 01 00 0f 00 01 00 00 00 07 35 06 09 00 00  ...........5....
  test-sdp:   09 00 01 00                                      ....
bluetoothd[26193]: process_request: Got a svc attr req
bluetoothd[26193]: extract_des: Seq type : 53
bluetoothd[26193]: extract_des: Data size : 6
bluetoothd[26193]: extract_des: Data type: 0x09
bluetoothd[26193]: extract_des: No of elements : 1
bluetoothd[26193]: extract_des: Data type: 0x09
bluetoothd[26193]: extract_des: No of elements : 2
bluetoothd[26193]: sdp_cstate_get: Continuation State size : 0
bluetoothd[26193]: service_attr_req: SvcRecHandle : 0x10000
bluetoothd[26193]: service_attr_req: max_rsp_size : 7
bluetoothd[26193]: extract_attrs: Entries in attr seq : 2
bluetoothd[26193]: extract_attrs: AttrDataType : 9
bluetoothd[26193]: extract_attrs: AttrDataType : 9
bluetoothd[26193]: service_attr_req: Creating continuation state of size : 18
bluetoothd[26193]: sdp_set_cstate_pdu: Non null sdp_cstate_t id : 0x5bdb0511
bluetoothd[26193]: process_request: Sending rsp. status 0
bluetoothd[26193]: process_request: Bytes Sent : 23
  test-sdp: > 05 00 01 00 12 00 07 35 10 09 00 00 0a 00 08 11  .......5........
  test-sdp:   05 db 5b 07 00 00 00                             ..[....
  test-sdp: < 04 00 02 00 17 00 01 00 00 00 07 35 06 09 00 00  ...........5....
  test-sdp:   09 00 01 08 11 05 db 5b ff ff 00 00              .......[....
bluetoothd[26193]: process_request: Got a svc attr req
bluetoothd[26193]: extract_des: Seq type : 53
bluetoothd[26193]: extract_des: Data size : 6
bluetoothd[26193]: extract_des: Data type: 0x09
bluetoothd[26193]: extract_des: No of elements : 1
bluetoothd[26193]: extract_des: Data type: 0x09
bluetoothd[26193]: extract_des: No of elements : 2
bluetoothd[26193]: sdp_cstate_get: Continuation State size : 8
bluetoothd[26193]: sdp_cstate_get: Cstate TS : 0x5bdb0511
bluetoothd[26193]: sdp_cstate_get: Bytes sent : 65535
bluetoothd[26193]: service_attr_req: SvcRecHandle : 0x10000
bluetoothd[26193]: service_attr_req: max_rsp_size : 7
bluetoothd[26193]: NULL cache buffer and non-NULL continuation state
bluetoothd[26193]: process_request: Sending rsp. status 5
bluetoothd[26193]: process_request: Bytes Sent : 7
  test-sdp: > 01 00 02 00 02 00 05                             .......
/TP/SERVER/SA/ROB/BI-01-C - test passed
/TP/SERVER/SA/ROB/BI-01-C - teardown
/TP/SERVER/SA/ROB/BI-01-C - teardown complete
/TP/SERVER/SA/ROB/BI-01-C - done
---
 unit/test-sdp.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index b67a55189..5a50cbbf1 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -45,7 +45,7 @@ struct sdp_pdu {
 	bool valid;
 	const void *raw_data;
 	size_t raw_size;
-	uint8_t cont_len;
+	uint16_t cont_len;
 };
 
 struct test_data {
@@ -86,6 +86,7 @@ struct test_data {
 #define define_sa(name, args...) define_test("/TP/SERVER/SA/" name, 48, args)
 #define define_ssa(name, args...) define_test("/TP/SERVER/SSA/" name, 48, args)
 #define define_brw(name, args...) define_test("/TP/SERVER/BRW/" name, 672, args)
+#define define_rob(name, args...) define_test("/TP/SERVER/ROB/" name, 48, args)
 
 /* SDP Data Element (DE) tests */
 struct test_data_de {
@@ -202,9 +203,13 @@ static gboolean send_pdu(gpointer user_data)
 
 	memcpy(buf, req_pdu->raw_data, req_pdu->raw_size);
 
-	if (context->cont_size > 0)
+	if (context->cont_size > 0) {
 		memcpy(buf + req_pdu->raw_size, context->cont_data,
-							context->cont_size);
+						context->cont_size);
+		if (context->cont_size != req_pdu->cont_len)
+			put_be16(req_pdu->cont_len,
+					buf + req_pdu->raw_size + 4);
+	}
 
 	len = write(context->fd, buf, pdu_len);
 
@@ -2803,5 +2808,28 @@ int main(int argc, char *argv[])
 						0x00, 0x00, 0x00, 0x00, 0x00,
 						0x00, 0x00, 0x00, 0x00, 0x00)));
 
+	/*
+	 * Service Attribute Request
+	 *
+	 * Verify the correct behaviour of the IUT when searching
+	 * for existing Attribute, using invalid continuation state.
+	 */
+	define_rob("BI-01-C",
+		raw_pdu(0x02, 0x00, 0x01, 0x00, 0x16, 0x35, 0x11, 0x1c,
+			0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb,
+			0x00, 0x01, 0x00),
+		raw_pdu(0x03, 0x00, 0x01, 0x00, 0x09, 0x00, 0x01, 0x00,
+			0x01, 0x00, 0x01, 0x00, 0x00, 0x00),
+		raw_pdu(0x04, 0x00, 0x01, 0x00, 0x0f, 0x00, 0x01, 0x00,
+			0x00, 0x00, 0x07, 0x35, 0x06, 0x09, 0x00, 0x00,
+			0x09, 0x00, 0x01, 0x00),
+		raw_pdu_cont(8, 0x05, 0x00, 0x01, 0x00, 0x12, 0x00, 0x07, 0x35,
+				0x10, 0x09, 0x00, 0x00, 0x0a, 0x00, 0x08),
+		raw_pdu_cont(0xffff, 0x04, 0x00, 0x02, 0x00, 0x17, 0x00, 0x01,
+				0x00, 0x00, 0x00, 0x07, 0x35, 0x06, 0x09, 0x00,
+				0x00, 0x09, 0x00, 0x01, 0x08),
+		raw_pdu(0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x05));
+
 	return tester_run();
 }
-- 
2.17.2

