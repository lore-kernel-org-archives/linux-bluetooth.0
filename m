Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C143E06C
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496689; cv=none; b=fxzzuEdEbCwd/YKNdEb1avvDqI0BX58EZl5LV65qlpQCcGHY22KhkOk/UZBBH2Ghfn8bdkRxidzTmIK3paVg4POkvT4JqjAnR1eKKSYtgYzshxKhkUYo968O9b5wMj/S1FW1ctHtN+ozIZSYKS4iVUdC3M3RohRaYrKZ3Ds9ZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496689; c=relaxed/simple;
	bh=2JiT51OC3xgQGDdsYoSHaYo73eP4lt9aD50CWAKRihI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE4ptic1WwtDwik8IgwQmSVKwMxO7OBf8isYEYOs9c5zan9c4/MxwLol0QezuBis/YkdHSnIw+yq2su4XTq5fHA+UXKyrwKOQLcVpkNNNM5xsRRVg/1Amx+GowDnEkOuEgD4YNcSHOIo2n/C6LCRV0aSChAnboKOQFjoBTx+YcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1O4mq7E; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1O4mq7E"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-34e23e22666so155458eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791496687; x=1792101487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOSOLVmU4H+PRxV2QsiM4BJUnqmhgxRWloa/yF7DLjQ=;
        b=Z1O4mq7EH/jKKC2+91YodgGyFphk/jWrM3M2XzOsZ9LG84JD+677ox9NafKJxCJmvw
         tfOViBMvkTeBzPXNxLdionP2HqRTEJaDtNDCjgQYeC2Tr9k8fqiOck6lP9SqWO6Wq+nm
         SNYAw2ewM/ezT4ba799ccMX764nkX70WACwRDTejydF2P6OFqXNJsdrfIZtfURVlq2uG
         0g872uATtSxZ3Fz75FjMJ+y5h6/Qt4vXLDagmJC2Z15B6Wm4IdxjsSU+p+u/CjNNljon
         +yOw+xubDMpwKDyq10GCJ+WJepLNkvYcHaQjy3Mia4VjD9Wfb8opULvUTuKJUMWQl9b/
         K3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791496687; x=1792101487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GOSOLVmU4H+PRxV2QsiM4BJUnqmhgxRWloa/yF7DLjQ=;
        b=FVOksp32PFsynyUc/+CuYfw7dCDsSmJ1SF8Rq99UT89wSmJ1jKPnQd+uCGODT6tISI
         0cmUJZ4BhsHlidfL9iyivsXpa84lPfSFXmhzv7egryDRkqfQWRIk00/0qcqF87dY1jpK
         Vr8QN6EfSCvKo/fJsH4RoSycCTyy+A4Kp/wO9pgbPNJzBlyJoNc3wGlX84FL/698PnWk
         shgLZJW57PobtEmPO6za+yBqaAT9lrd/JUFLNDLmcU3iNDwd+BEksjkJ3WlTp2WeGvEg
         W84Gjmoj9OAgIDDZvsRW2YLqq/KPHpMyY2XEniClTuetWBv19YRfoAIQNo8zkZoklvK6
         UndQ==
X-Gm-Message-State: AFuF++m/sy69k7ugA/ymb7Awau7PQjCrGf6d30GntHjnE7dnMK7uIFd2
	May+2/x7S+Dv9MdrwhfDwFyrsfL+OBIfKWQEnvrntBjw4rXkxEZtiGzxfdBpHg==
X-Gm-Gg: AYBFou1hWZH8R0htLvABERcoVekTi+ds6uGQqJG9ybb18zwp4JqzNl4y9DpjIL7vJ4U
	wmj/5coj7VU02XY6m6LfhewUFHQmrh3QebIWgwhJIS2XaJZig0fmxmnZtD/VmebcVQpoWCDNV7H
	3h9DWrBz3VXMQiMglVNH6kFHa8c/+1xMimx4QQTY0780mIyFPP1qXfvuK3rAi3iZz5zpEIQSqH5
	Wkh6KfWIgAh6QPYjO2rtfhi5H0ruKVatoWrypkMgwjvZnzxv6PiUFiHkBeQFSyWw4im6wINUUKK
	XAsg8jEMIrA53EzIJjm4xzCx44i++dFzDGzbo6j4FINjhBcsu7dRhH0E84RR7v+yLaer55FwKXJ
	Hm+w7ZCFwOQ0eFNjqfq4qJDoQN+EXXcbqXIZSoMRccf3j3fHBS5jbZRsy4NuExdfp0wj/YCueB1
	D1trLVGtsqBlKn0D8IAXTyvMwAsHVh6zIKzAQNqUG9dnTS8k6t72UqJDTF0NInDiCHGAqBgsmc+
	pIpj8/NqQaZKnfARvbq5PrvZHoKtKbb9pb8ZQwT
X-Received: by 2002:a05:7022:f507:b0:143:8212:a43 with SMTP id a92af1059eb24-165896c95b8mr5545503c88.1.1791496686863;
        Thu, 08 Oct 2026 14:58:06 -0700 (PDT)
Received: from hitalo (208-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd5cb5sm899823c88.6.2026.10.08.14.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:58:06 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH BlueZ 1/2] tools/sco-tester: Add test closing the socket before the link is up
Date: Thu,  8 Oct 2026 17:57:55 -0400
Message-ID: <20261008215756.2710812-2-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008215756.2710812-1-enghitalo@gmail.com>
References: <20261008215756.2710812-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that closes the socket while the emulator holds the
Synchronous Connection Complete event of its setup, so that the kernel
aborts the connection before the link comes up. No connection takes the
link then, so the test expects the kernel to disconnect it, as the
controller would otherwise keep it and reject further setups for the
device.

eSCO CVSD - Close Before Complete

Assisted-by: Claude:claude-opus-5-5
---
 tools/sco-tester.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index fca99a9..2bc89b5 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -1309,6 +1309,48 @@ static void test_connect_acl_disc(const void *test_data)
 	test_connect(test_data);
 }
 
+static bool hook_close_sync_conn(const void *msg, uint16_t len,
+							void *user_data)
+{
+	const struct bt_hci_evt_sync_conn_complete *evt = msg;
+	struct test_data *data = tester_get_data();
+
+	if (len < sizeof(*evt) || evt->status) {
+		tester_warn("Bad event");
+		tester_test_failed();
+		return true;
+	}
+
+	data->handle = le16_to_cpu(evt->handle);
+	tester_print("Closing socket before SCO Handle %u is up",
+							data->handle);
+
+	/* Abort the connection while its link is coming up, and let the
+	 * kernel process it before the event is sent.
+	 */
+	shutdown(data->sk, SHUT_RDWR);
+
+	return hook_delay_evt(msg, len, user_data);
+}
+
+static void test_connect_close_complete(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	/* The link shall be disconnected, as no connection takes it */
+	data->step++;
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_SYNC_CONN_COMPLETE,
+					hook_close_sync_conn, NULL);
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_DISCONNECT_COMPLETE,
+					hook_disconnect_evt, NULL);
+
+	test_connect(test_data);
+}
+
 static void test_sco_ethtool_get_ts_info(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1512,6 +1554,9 @@ int main(int argc, char *argv[])
 	test_sco("eSCO CVSD - Close", &connect_close, setup_powered,
 						test_connect_delayed);
 
+	test_sco("eSCO CVSD - Close Before Complete", &connect_failure_reset,
+				setup_powered, test_connect_close_complete);
+
 	test_sco("eSCO mSBC - Success", &connect_success, setup_powered,
 							test_connect_transp);
 
-- 
2.55.0

