Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159462638A0
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856729; cv=none; b=a7yP1CRzebsU6pklxLTiRMkLZK3tZlKPgIspEN/J7cYWsnNLzCYJ1v5CM+Ij4wRsD6NikHGsGYvJU3LdXNViyWqIKyhKq1ya6a7ZzOukSkt4QXt8Trt3rPqide2BxtE29LFxwDIpi5IYW+kPP6hHqNnTjo8kfDWOMUAd171AR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856729; c=relaxed/simple;
	bh=Pa+fbvcQc0MeOoMYLAfTHS6dVjC6+B35CcmKz2N1Z4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7XMcumG4kBGxVC9MAIzIjmraTdQBunjnnPK9YiFLoyJadK4oPBbNBIKTdCcSst0EyBE55GRvaxLNZ4RRPCg0zEtWWDi+hosOdPkc0I9eLRsjamPk34JVfPHDwXZiyHZICdZXAh4CHfY2WCbkjfQNdH6OAfw+Errz1D3kE3lrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fedjuNME; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fedjuNME"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 576133F47C
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741856723;
	bh=Y/1zSaXio8ktno98565TVG1CmeK2+Y0tNXCEIkGU9CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=fedjuNMEimDFG8xWJ4kjg+mYPLTMSxSrIzy4Ewobrn6SQboQ1nU46U4c2EUAlbW17
	 XUsXYol3D0U7WWamYl7MUuz+sKpdRw+OXqnZur1OzpspF6NiA3cmMI+WYIVRSR4scQ
	 C8zWmxkaXlPRI8H4ERDaNCHdg/ow70uPJkV6oN5cihJW36TO6nBALTWwmok6BoszSy
	 VY1dPAD8ouo/eWyyP5hAsYIclotukee78Se95OAPnG0VMSH7BEF+XNEPWFJ8oyl9jC
	 zk0TC2oDGoLNdrapihpGJLd+WERDnZLgVjGnH60C/iOno4YJhGVjBg4qGkfsJWhTgb
	 Qd0J4aKd87WYw==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225505d1ca5so14457265ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 02:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856722; x=1742461522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/1zSaXio8ktno98565TVG1CmeK2+Y0tNXCEIkGU9CQ=;
        b=D/12aR1C5QLQUm1GKBl9y4YBM2ARi8gAIEjLMtLsTUD2FdC+9cRHXf0Q84wTI9T5Mt
         l2He87nVKe/EzMcQEjU5d/qD4Af4ZI49X91zIUk892XitACJd1nvoV2Z7RCHQxpzLuDf
         PVwdEEd6gEtvc/wdQqBWTYB7WPfpIAMNYy7YKaW3ppK78nEmHuDc5LTNb0lEqx5L88mA
         2wpmO9xCr1DjEVTWhRXgXPfHuiVXk8RsM0L0/5F5aSbIIFyUmnIpHYamYIv5E26TlUBK
         fsfwu8tD0nRs/imVVgIzjcqfaOfLhFib8OQmUnm0X8lccXJkylxJohX1I4NVc1FKai/v
         lXYg==
X-Gm-Message-State: AOJu0YyXoiWW1gQRJ/0PwSGz4yAOiE28NFobM4dRv4gr2CM585rcwHCY
	XTFeXi3eZPJjVoJ/QDlsSeR+rtHWFItQoDt+DzCrb5euqKVFzfgXYaJ5f01jd560mgOC5Pu6HWg
	DFLePmHygxXvzlu2EmzWe2IdQqzsHaCSXVlus2Up0fekjcy9rePWOy+S26xztD9b2wpOOKEuELo
	u3sl1BxO2gZAx5aQ==
X-Gm-Gg: ASbGncs3i/UJ9IdCHtRDa2LW6WW/Yuue7mU1vDOTRJhDdb4afmD5Am0hy/CNg+syRsT
	qUZKeP9uhxslg07VSbvjGInZ0EBSdTWt+cy+QeEPSa4yhlNA0LOJkzAwfguwHAjRfevl6OGCoYp
	I+AJM3E1mHJGTWlVGEuObBtrAMTCXEwTKnrR51RDFHlngS80ALKdnKOokOryOGjSb8fUSPVKsr5
	vPB2UG+K+LARcHoZUI0Oh1QQ8Bz5y/QZvCmr3cPYc/04XkRIjKHCFVNAcYc22j7DzJuMvuVglb2
	eaEehFj9XjGkoG7wwAwIchkSdtwgDZ81bJ4RwM4C9u86W8dOV7sfLGXLJ7mEEyaCyJI=
X-Received: by 2002:a05:6a00:3d0c:b0:736:39d4:ccf6 with SMTP id d2e1a72fcca58-736eb7ca147mr17146076b3a.8.1741856721836;
        Thu, 13 Mar 2025 02:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7DN37PZ7n2fusW5S+cDMFBk1f/G/FFUXHgtBzh/zhE3MP3PgHz8TfvRO7BHGAyCWqqH9GUQ==
X-Received: by 2002:a05:6a00:3d0c:b0:736:39d4:ccf6 with SMTP id d2e1a72fcca58-736eb7ca147mr17146053b3a.8.1741856721506;
        Thu, 13 Mar 2025 02:05:21 -0700 (PDT)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529368sm864040b3a.8.2025.03.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:05:21 -0700 (PDT)
From: =?UTF-8?q?Yao=20Wei=20=28=E9=AD=8F=E9=8A=98=E5=BB=B7=29?= <yao.wei@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Yao=20Wei=20=28=E9=AD=8F=E9=8A=98=E5=BB=B7=29?= <yao.wei@canonical.com>
Subject: [PATCH BlueZ 1/1] policy: connect HSP/HFP when A2DP is connected
Date: Thu, 13 Mar 2025 17:05:11 +0800
Message-ID: <20250313090511.57938-2-yao.wei@canonical.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313090511.57938-1-yao.wei@canonical.com>
References: <20250313090511.57938-1-yao.wei@canonical.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When A2DP is connected, also connect HSP/HFP if it is not connected.
---
 plugins/policy.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 9a449da61..38dac9a45 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -37,10 +37,12 @@
 #define CONTROL_CONNECT_TIMEOUT 2
 #define SOURCE_RETRY_TIMEOUT 2
 #define SINK_RETRY_TIMEOUT SOURCE_RETRY_TIMEOUT
+#define HS_RETRY_TIMEOUT SOURCE_RETRY_TIMEOUT
 #define CT_RETRY_TIMEOUT 1
 #define TG_RETRY_TIMEOUT CT_RETRY_TIMEOUT
 #define SOURCE_RETRIES 1
 #define SINK_RETRIES SOURCE_RETRIES
+#define HS_RETRIES SOURCE_RETRIES
 #define CT_RETRIES 1
 #define TG_RETRIES CT_RETRIES
 
@@ -88,6 +90,8 @@ struct policy_data {
 	uint8_t ct_retries;
 	unsigned int tg_timer;
 	uint8_t tg_retries;
+	unsigned int hs_timer;
+	uint8_t hs_retries;
 };
 
 static struct reconnect_data *reconnect_find(struct btd_device *dev)
@@ -183,6 +187,9 @@ static void policy_remove(void *user_data)
 	if (data->tg_timer > 0)
 		timeout_remove(data->tg_timer);
 
+	if (data->hs_timer > 0)
+		timeout_remove(data->hs_timer);
+
 	g_free(data);
 }
 
@@ -202,6 +209,33 @@ static struct policy_data *policy_get_data(struct btd_device *dev)
 	return data;
 }
 
+static bool policy_connect_hs(gpointer user_data)
+{
+	struct policy_data *data = user_data;
+	struct btd_service *service;
+
+	data->hs_timer = 0;
+	data->hs_retries++;
+
+	service = btd_device_get_service(data->dev, HFP_HS_UUID);
+	if (service == NULL)
+		service = btd_device_get_service(data->dev, HSP_HS_UUID);
+	if (service != NULL)
+		policy_connect(data, service);
+
+	return FALSE;
+}
+
+static void policy_set_hs_timer(struct policy_data *data)
+{
+	if (data->hs_timer > 0)
+		timeout_remove(data->hs_timer);
+
+	data->hs_timer = timeout_add_seconds(HS_RETRY_TIMEOUT,
+							policy_connect_hs,
+							data, NULL);
+}
+
 static bool policy_connect_sink(gpointer user_data)
 {
 	struct policy_data *data = user_data;
@@ -232,11 +266,14 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 {
 	struct btd_device *dev = btd_service_get_device(service);
 	struct policy_data *data;
-	struct btd_service *controller;
+	struct btd_service *controller, *hs;
 
 	controller = btd_device_get_service(dev, AVRCP_REMOTE_UUID);
 	if (controller == NULL)
 		return;
+	hs = btd_device_get_service(dev, HFP_HS_UUID);
+	if (hs == NULL)
+		hs = btd_device_get_service(dev, HSP_HS_UUID);
 
 	data = policy_get_data(dev);
 
@@ -286,6 +323,16 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 		else if (btd_service_get_state(controller) !=
 						BTD_SERVICE_STATE_CONNECTED)
 			policy_set_ct_timer(data, CONTROL_CONNECT_TIMEOUT);
+
+		/* Also try connecting HSP/HFP if it is not connected */
+		if (hs != NULL) {
+			if (btd_service_is_initiator(service))
+				policy_connect(data, hs);
+			else if (btd_service_get_state(hs) !=
+						BTD_SERVICE_STATE_CONNECTED)
+				policy_set_hs_timer(data);
+		}
+
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
@@ -308,8 +355,26 @@ static void hs_cb(struct btd_service *service, btd_service_state_t old_state,
 
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
+		if (data->hs_timer > 0) {
+			timeout_remove(data->hs_timer);
+			data->hs_timer = 0;
+		}
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTED:
+		if (old_state == BTD_SERVICE_STATE_CONNECTING) {
+			int err = btd_service_get_error(service);
+
+			if (err == -EAGAIN) {
+				if (data->hs_retries < HS_RETRIES)
+					policy_set_hs_timer(data);
+				else
+					data->hs_retries = 0;
+				break;
+			} else if (data->hs_timer > 0) {
+				timeout_remove(data->hs_timer);
+				data->hs_timer = 0;
+			}
+		}
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
 		break;
-- 
2.47.2

