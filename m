Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8212D748
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537682; cv=none; b=F8v5AeK14IjT4RNcFNWVoaOlguMVv2CDO7YA+pSpqXHLyTIvLxkketO0OrD8dTVj9iodtKVS7y2FQpTHLwoDNLDxGu11QDmpvNUxHfRVYUemgNx8rOwnUY0dW4OjQCrYeywil4s/Hg7AI6/8dCs/uefLvhfcj9f37QLRMcTZuhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537682; c=relaxed/simple;
	bh=Ad2lvrgHtTYIetMJjQ3wKYvL2QoGqa4BhcvYBK/AvBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QTGKSnTaWvNh1rEkIFUJOj9PtCXTFn19JrUC1Uzf412XdtQy9xUE497Cz5PiAL5puXDC/I8PIUd/wYAgIzmlg+ApORltnmI/HLWqxxSKnCp4fBlH3TCjfgIpHMGFbaIbxgeC0hjF7US1R4PxW881QvCKtkiraYJf3+umc5YXVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa+Zrsuh; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa+Zrsuh"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7eb7f34f36dso764254241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713537679; x=1714142479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3PeU1+usO8ws1DBtFkax+X2vcgbttHSfpqUg6GNY2E=;
        b=Fa+ZrsuhSoi70DJ6G0DPl5R370BPsQYmSk7DWF4PcisH13epDzIDpWtczQJ3EFVoPj
         5UMgWEOylghvokWan01UQkXD/B9i7MNy+FbCl5gV30uAgv3CiDQ4bP9zMV+fQ8HCuEu0
         /3qX37WeDyjasGavUvLFaWQAK8SapmTvChxi2Wv0XmikO7IUIBFzMr6dtxvSdBp1euxd
         1rVJbM116w1hbgtN3s2a2bIkix18gz6maVPPvPInmgJPA+x0jF18hfi5NWOSKM+T+8z4
         YgX0CbhxkQg5+StkawaeqRJGQMIkm+aSiAbq1rqgtCI9Z6GRFniKv0iiUxcoyZcs0DSY
         Aw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537679; x=1714142479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3PeU1+usO8ws1DBtFkax+X2vcgbttHSfpqUg6GNY2E=;
        b=PlMXb90crYWDzJF3W7nNFHr9BP4NXhr0rrQ28k6m0xxHhMCjMFJonFeQbjJ8fBURHK
         Vhe+NhhsH9qMNn8phRWvKYiaJMlOoXAYI9VnrbLeal6Qqw7smn45cooUx2sTwoKcsqcs
         5eUMHAMUTC7eZFyHKgup23AcKsJp335mnho9O2/CG5UAe/6FaRrbAagM/dSkKlcV/adc
         nYKo5NkZ/tvreg3f7Pi6QypqPE8TzZdIjrAHCrML66mfR3E1OwyAdWeceStus3z9dp3N
         hDLbnA5Dnqp3KQtFtwy25O8IezGXcbIQ9jkunfSaaGzNydS9ML60VPRZ5SF9ImIt6Udp
         W1NQ==
X-Gm-Message-State: AOJu0Yy3YC8nUWM2W+MQKr3DeoaPl3eFOGtY33vfK351rEP2FiJE8v5i
	cigvmaLZP2/tcRf60GqvGfvbgBPk8+T4vOQjBnmEUcV9KixnYnVHjqTNpQ==
X-Google-Smtp-Source: AGHT+IGb6l17qw5LCoLKlT+ExKScsAzUbwREeDVOIkFBW5nVq7PEPkvelPnp5do4lDJaSpo6PU7R0g==
X-Received: by 2002:a05:6122:ca6:b0:4d3:31fc:4839 with SMTP id ba38-20020a0561220ca600b004d331fc4839mr2015102vkb.2.1713537679396;
        Fri, 19 Apr 2024 07:41:19 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id i20-20020ac5c2d4000000b004d88f58e243sm459696vkk.42.2024.04.19.07.41.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:41:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/advertising: Add flag to mark if data is valid
Date: Fri, 19 Apr 2024 10:41:17 -0400
Message-ID: <20240419144117.1554291-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allows the use of type 0x00 which otherwise could not be selected
since the property would not be exposed even though the data could be
set.
---
 client/advertising.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index a7474d6a2984..a9b865a65e37 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -43,6 +43,7 @@ struct manufacturer_data {
 };
 
 struct data {
+	bool valid;
 	uint8_t type;
 	struct ad_data data;
 };
@@ -157,7 +158,7 @@ static void print_ad(void)
 						ad.manufacturer.data.len);
 	}
 
-	if (ad.data.data.len) {
+	if (ad.data.valid) {
 		bt_shell_printf("Data Type: 0x%02x\n", ad.data.type);
 		bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
 	}
@@ -395,7 +396,7 @@ static gboolean get_timeout(const GDBusPropertyTable *property,
 
 static gboolean data_exists(const GDBusPropertyTable *property, void *data)
 {
-	return ad.data.type != 0;
+	return ad.data.valid;
 }
 
 static gboolean get_data(const GDBusPropertyTable *property,
@@ -757,7 +758,7 @@ void ad_disable_manufacturer(DBusConnection *conn)
 
 static void ad_clear_data(void)
 {
-	memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
+	memset(&ad.data, 0, sizeof(ad.data));
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -787,6 +788,7 @@ void ad_advertise_data(DBusConnection *conn, int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	ad_clear_data();
+	ad.data.valid = true;
 	ad.data.type = val;
 	ad.data.data = data;
 
-- 
2.44.0

