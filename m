Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A633B964
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541688; cv=none; b=sCS4ojTtL1TWCf+YNGGmT4FKE6Xju1lWcCG0hTAsCJb08xgATX0gtWpKiPe5iYPDyOSp/qzwXc2iPCwfnBdlCWiAjuBBZOif8xNg6AvUsiB1tA1Bvu4JBUW4CE1oMIplDcQzsRHnKg17zVwPLSuVuP9AZ8iuyf0cfyvyjl4lPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541688; c=relaxed/simple;
	bh=6Iy9026tNC+FBPgnw747572svxg5Us0eBfvh2fVkAJk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdJ5ESuwwuLeglHfA718JxSfOjvrfnjclEgmctevtcdlEcGZp9AGAbD/vZntUJBH58Q4ytVGwpf6BQ+S0Z5lCuCIQV3P/RkUsBHcuO73ybwcXhZboeZm32KtlAyBS+6zRsC6vKdcePil1fXk0fk+EsbvXfxQTxQWyOKaA8vqy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOqvA2No; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOqvA2No"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dd8a02e808so891703137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541685; x=1763146485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuWOHa2Fe+Tof96Dgq9pDFL2C+PpZDu1m+K1OJnpcRw=;
        b=VOqvA2No5eV5tsTe+OKC3UWu0vRs2d8XxZjKaziJow9C5qySKkLP3ftGFISGqlnn8m
         +/urF7KBzGzkNpJQi9mkvqbCYONwsvBi/QJZH2UwVHiU9B41yH1zhGnGnL4e/2X+s0C7
         Pm2qgnezOXJ2PWxYVLuMxCO49Tyklep9DL9Fo5TMofajGnYOLJTvdP+xvNVpSAHkmUwv
         y+DlHBcZ7lReC3Hy2ALMnoCnBTcGyuJQUswAIBzTOn8dL4GiS5SRNOH1vV09sSUcQEdC
         cW64IXIlYRFDbNAGgz00VKb9hABRJMW3mZ7txW/2YFzSmXh0O10fWmllwwR9KBfTrnnf
         KQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541685; x=1763146485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CuWOHa2Fe+Tof96Dgq9pDFL2C+PpZDu1m+K1OJnpcRw=;
        b=SK2wWdUR4X90CmuorPJ32839LUVMqkN5hOXkRf2W6E8My+CZQpE0d2eVMb0ahM0g56
         Cv7ynYWkOJUbrRdMFPk4tt0LP4Vn7zpLHw+1MzUC1E7UQwgeMS1794lULst8icAgkIu1
         hDdGM1Huqp8SIUo3aICboZKZbsVtc4HV3PB2BOKt9XwBGx9l2LRju8KR0Yi4XX9sAcre
         uOeTk6GpkH6BVMHqSkdvpUCk0wSQ7EIBlr/sJo1K01tJ3QFKduLbLdRHgBhnN+n4fsJO
         SfP7UqPwtcf9R1h1UPRDy7SuD1NtXdj9DQrH6PxPnPNcdD5ymUxhRE6SsMbaQ5q79zrQ
         KZ4g==
X-Gm-Message-State: AOJu0YwXsuYQ2ZWksrQBQhBs/j4rRmey7DIVB3f3YQRl/fUpQ4cP1Si2
	FdIVrDp9Iu0SrGb+JeoNlyyU4Z+I6K8dhEL+4r2Ygbgj7maQuSjHPKWtp/hpSw==
X-Gm-Gg: ASbGnctVU+FoD5mthCnlOZSpAr2PMDqamnVfU/Mq9U2TXjM5ykThZvB9yys/POM0ZH0
	S+Fd0yr8FICtQql8C+XanQJ6Bq1hWVQket8weNa8DXJrygh28506Cm7/mBOFEV3Va51TYsl3+wn
	I30pC4/r/Ppkq1+s3xbOzTSldgt0fSwMVRIz/4oGLsg9TXsi26zBBW28f23XpJOg65YTg0XzWoB
	YoLW1RhFDe3zq6RWq05nbERPMtK3vYUI8sz2BLriV5or1uOYtEQHLoQJOorLCkA7HSyAGsxsF5/
	VimX/DkZZa7J1+D/1cjW1R5OlphDLKnA4ym4UUPwNz8zeC03/xiHFuxBEaaPlaIjDq7KbYPdsQ4
	VDF3Pmk0wGYxXfCslqF+D5QJQC/8FNvkvWpeJqY24dwmMynJ36NTpGD0khKC2VkeFhR5HJiPN1r
	ccOgD2jGKp/c18/A==
X-Google-Smtp-Source: AGHT+IFSH3pnBM7ITglIcaX6BmbwC3PJe82OMjNM9sqBJwKkKQ0mrHMpWlk7YJrl4Lm+jQGj4qtFCQ==
X-Received: by 2002:a05:6102:5106:b0:5db:23d4:feb1 with SMTP id ada2fe7eead31-5ddc4678ae4mr281427137.2.1762541685254;
        Fri, 07 Nov 2025 10:54:45 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708522abcsm2738698241.0.2025.11.07.10.54.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:54:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] iso-tester: Add tests for checking proper handling of Sync Lost
Date: Fri,  7 Nov 2025 13:54:26 -0500
Message-ID: <20251107185428.1161318-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185428.1161318-1-luiz.dentz@gmail.com>
References: <20251107185428.1161318-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the following tests to check if BIG/PA Sync Lost are
handled properly:

ISO Broadcaster Receiver Sync Lost - Success
ISO Broadcaster PAST Receiver Sync Lost - Success
---
 tools/iso-tester.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 4bf1a287bc68..ff5c85ae410c 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -502,6 +502,7 @@ struct iso_client_data {
 	bool listen_bind;
 	bool pa_bind;
 	bool big;
+	bool terminate;
 
 	/* Enable BT_PKT_SEQNUM for RX packet sequence numbers */
 	bool pkt_seqnum;
@@ -1578,6 +1579,27 @@ static const struct iso_client_data bcast_16_2_1_recv_defer_get_base = {
 	.base_len = sizeof(base_lc3_ac_12),
 };
 
+static const struct iso_client_data bcast_16_2_1_recv_terminate = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+	.terminate = true,
+};
+
+static const struct iso_client_data past_16_2_1_recv_terminate = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.past = true,
+	.server = true,
+	.big = true,
+	.terminate = true,
+};
+
 static const struct iso_client_data bcast_ac_12 = {
 	.qos = BCAST_AC_12,
 	.expect_err = 0,
@@ -2389,6 +2411,21 @@ static void iso_shutdown(struct test_data *data, GIOChannel *io)
 	tester_print("Disconnecting...");
 }
 
+static void iso_terminate(struct test_data *data, GIOChannel *io)
+{
+	struct bthost *host;
+
+	/* Setup watcher to check if fd is closed properly after termination */
+	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_disconnected, data);
+
+	tester_print("Terminating...");
+
+	host = hciemu_client_get_host(data->hciemu);
+
+	bthost_set_pa_enable(host, 0x00);
+	bthost_terminate_big(host, BT_HCI_ERR_LOCAL_HOST_TERM);
+}
+
 static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -2498,6 +2535,8 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		return TRUE;
 	else if (isodata->disconnect)
 		iso_shutdown(data, io);
+	else if (isodata->terminate)
+		iso_terminate(data, io);
 	else
 		tester_test_passed();
 
@@ -4311,6 +4350,16 @@ int main(int argc, char *argv[])
 					setup_powered,
 					test_bcast_recv);
 
+	test_iso("ISO Broadcaster Receiver Sync Lost - Success",
+					&bcast_16_2_1_recv_terminate,
+					setup_powered,
+					test_bcast_recv);
+
+	test_iso("ISO Broadcaster PAST Receiver Sync Lost - Success",
+					&past_16_2_1_recv_terminate,
+					setup_powered,
+					test_bcast_recv);
+
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
 
-- 
2.51.1

