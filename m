Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB0C5ACC6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F35620869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx2D8duc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F35620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJQEKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:10:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43525 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQEKz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:10:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id p34-v6so18002516lfg.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LMnsTS8t+Cstb+pgqnJXIooMr60ZxSckREZCIOjJjnM=;
        b=Jx2D8duc7TDmi2oqg9U5DPR1O7qhg+Csn0DqLUr/IUwBBZxKq6rCsZcPHNa0qvVjPP
         4pisl1K887nwZ05TpVlZZ5ZSAOhd3885mWUF6Ek0uyhrddSXMXZDUNzKjXrIiwQMHKZo
         Sx907VZm5YVwEIS6Ib8TV/rubOoi4XSzmVCb6+7mZ4bc1COzQNjK0pyTdktODcKU2kNU
         +RhfVQ4zAE5oJ02zvgNV3XNNMR9sDilrAMQaSQm5ZFZS+6t1CFrm7CuwhZMYpuE4bYaQ
         GDHozjY0cUNJXqqeWkFCC0I/afV+kjzIRbTbdBXQCXXWsizBiQaIPE5d65WxGbwjvSFX
         9yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LMnsTS8t+Cstb+pgqnJXIooMr60ZxSckREZCIOjJjnM=;
        b=jIKtL/n650UNsngbFp5VDC33IU1hUTy+qvRi8GEcoNjCmNms3P8f7IVLbk9TkgSgNK
         i8S9kkxhMPO+tERC0AAb+YPL++O1XgZj4maZhTr9gH5VgmJnBqQvB38y5FIhyY+VMvA4
         3FImF2HUn6s8Ciaz//5+s7Ii0XNUj76GoVfFsip+dMLa9kYA3l/R4gaf6Mp5uKGx1sGt
         nwDSf7ilcbPaduO8mT7Ae2xL25E5l1yYvu88iKpqLKKD2N7QvI0Ryuw+RM+NIsU5HYR6
         vStfOdI/Il6AQkqhkbVeM4GgCgNG8QapiMw5ChoUuD+p51AfgvwFXGYCKJHz38QMlEK9
         sSlQ==
X-Gm-Message-State: ABuFfoiIiZd5Ey8PDcaEPO1ew2S0d0Q2VTnVd/zxf0i/Zhmktx1QfLv6
        SOYJbMiG49sXITBrp7BB2+pa6GCjt+A=
X-Google-Smtp-Source: ACcGV63cWJ0zqtGC2W0ZprN1i86QVLS55QVfy5Vqi3SDTk1DwuQGu6HB25RfhOPicGL2Roj+m39whQ==
X-Received: by 2002:a19:41c9:: with SMTP id o192-v6mr2298267lfa.93.1539721128328;
        Tue, 16 Oct 2018 13:18:48 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id b10-v6sm3404218lje.47.2018.10.16.13.18.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:18:47 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:22:16 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/12] btmon: fix multiple segfaults
Message-ID: <20181016202216.GA85010@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix multiple segfaults caused by buffer over-read in packet_hci_command,
packet_hci_event and packet_hci_acldata. Fix is to check that index is
not bigger than MAX_INDEX before accessing index_list.

Crashes were found by fuzzing btmon with AFL.
---
 monitor/packet.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 8f7464b1f..abdc18aa2 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9949,13 +9949,17 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 	char extra_str[25], vendor_str[150];
 	int i;
 
+	if (index > MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
 	index_list[index].frame++;
 
-	if (size < HCI_COMMAND_HDR_SIZE) {
+	if (size < HCI_COMMAND_HDR_SIZE || size > BTSNOOP_MAX_PACKET_SIZE) {
 		sprintf(extra_str, "(len %d)", size);
 		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
 			"Malformed HCI Command packet", NULL, extra_str);
-		packet_hexdump(data, size);
 		return;
 	}
 
@@ -10052,6 +10056,12 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 	char extra_str[25];
 	int i;
 
+	if (index > MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
+
 	index_list[index].frame++;
 
 	if (size < HCI_EVENT_HDR_SIZE) {
@@ -10126,6 +10136,11 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint8_t flags = acl_flags(handle);
 	char handle_str[16], extra_str[32];
 
+	if (index > MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
 	index_list[index].frame++;
 
 	if (size < HCI_ACL_HDR_SIZE) {
-- 
2.17.1

