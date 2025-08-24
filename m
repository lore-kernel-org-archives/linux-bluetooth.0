Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CED1CD1F
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756066183; cv=none; b=ZwURj9pGrKuVkmUsz4lbvcr1SMx3gwJ/Cl9Wn0pnTDahx8aHBFl9ROHjpK4kka0AAW9K9OAK3cutxaJ5LdmmN3C4Mk4jsn+MDc3AAwdhN4YLVd4iuJHQpNHM23fBUdkR12IgRQsFwlil51GNqUlsycQAS8V1nLp5RRSf9tWSx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756066183; c=relaxed/simple;
	bh=8dLHl/telMOYvv0kprbaFfhulU54UPIffosQP7ZJSyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKrSd/S3OXx0RyLnIw299f3Wmcm3owpXyvKUZIf5YW9M8sxIlpReUm2I/1AR28FTADDtGPzMCXjdXaI1vdkUNddmvHhENAzZquc+XaDXeZAbJEhgNNt/S2MKrr77ODgnQkXuAGSqoYvqtCLukBl8FUpAE8hxdwn+KNgKcpQIayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRUrNOCY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRUrNOCY"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ace3baso663316366b.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756066180; x=1756670980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ3VggeknuzAnQIAgU+7ELnI6FLXXSF9X8QFDvQfm2c=;
        b=FRUrNOCYvLXbOxwWkLRe58saCipNMbf4mHSk3L8/3CmQ/FbZdp58Tl3h5+kgvJ6Nk5
         gHdYCtaHPWqpug8CxejgJ983QNPpJrCJy0HEzX45yPj676iA5C4fMnPwBwV8xYvbKlPa
         bBGVR1LhHmlEsOgy2BBBWC0FMw2sZ++ccCSRFv12NGjdelljH8HqlfahhG7KzXVdIict
         yDpy0A3QfNU5hNQJBD0mhphaRrmeSGkqCKgfzSQQB/WjYKtQ8Nm/43m319mvAv7MD9fs
         n4HXv2uz2UJWXvvdxHeq10QlT+N8KtHBrp095nJ7iHddJPvSnbKG2zQyxP7vpiR3H8Lh
         1ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756066180; x=1756670980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ3VggeknuzAnQIAgU+7ELnI6FLXXSF9X8QFDvQfm2c=;
        b=AwEvGEfw92RMpvHqDAUuKE1VSbZlqFBewuSJ2uxXPeWZjYwj+mmjA51IQTylSt8TzA
         aPHflZ2GJSpw0BPTBw8I4Un30NF8NIuE+9fKUeKlywzwoXvAlW5gTHcF4CH65uEBOv7Z
         WURAH8L/W9x7kBqWEvrAdulGeoHyWDCJSyl1LmlqIfWyA6/MizyrGsxjr1bk+Ud1uqGk
         9wqBRshsuFd7oB0lGF4OxwyNTDCUmxlAYGQ5dmpcx+4NN1ZpGgJtrSbqjxc7aDOHHA5g
         dhxUgOrpgkPbuRMv3+mBomHR8jeoDo5QsPvgtmlBVqLH/ePA+yStrohGpbGt1Elzs6uh
         uvTw==
X-Gm-Message-State: AOJu0YxMQ+AbsiC9Yi4DlFDvzSjTI+3/2Jn9MiMwycp0a+tkW3GT6YRW
	kpNp4ALmZzAuhqbM3aCeKz/LSbyx/X6olloHQfYpAJMRpCu1hbgJfeSkfzA04A==
X-Gm-Gg: ASbGnctC18BVJ+5+kHgwIxj57Q6adFyOT7kDQuH3xLTHIYZOr/MLjv6IslH2PVeDPkm
	ZddBIZmxsNFi/8sfzDm5qoEXySMj6nTfrlBkGL9xB/pX1MfK3TL14hhqC6dok94s071ONYUw7q8
	rwrt+ckrD9nrt97Cq2jd/kuFx1NSWReNG7FMgGD/Z8m5jtVIKquQLBdunn17+0a8QwW63L1p9IZ
	j0z2aN14KjTi5q6m4eGrI0kLYzsnZJTw62MZcakFXEGEII9X3CZQargfOZSZF6DiGYXDVx7QPI+
	PN57D0AiYSfBeJV+6Mgf+Xs4XrTerAERG4S0wfWpc0MrC1tX5mP6Ttol4p6ElsNvolYc+G9gNq+
	tvCNbw/2Qsty3Znuv7Ojm06e7qp29S8/zumSc/lxBPyfuqLRipU9LHBDRG9QYk6Qd5dk0n75wxh
	U1jT3buldt1qPknsfCiA==
X-Google-Smtp-Source: AGHT+IEEH5owOm3bbe4+0fxBP8Z0uF18wuMUaioDtdOpWoVNBeuYLH/6C47h2OeE/8+vYcm5guvanQ==
X-Received: by 2002:a17:906:298b:b0:afe:6fdf:c26e with SMTP id a640c23a62f3a-afe6fdfc6d4mr204116566b.50.1756066179437;
        Sun, 24 Aug 2025 13:09:39 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49310e9asm425492766b.81.2025.08.24.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 13:09:39 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ 2/2] lib: Synchronize supported commands with Core Spec 6.0
Date: Sun, 24 Aug 2025 22:09:20 +0200
Message-ID: <20250824200921.308503-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250824200921.308503-1-arkadiusz.bokowy@gmail.com>
References: <20250824200921.308503-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commands marked as "Previously used" in the Bluetooth Core Specification
Version 6.0 were not updated to keep the library compatible with old HCI
controllers.
---
 lib/bluetooth/hci.c | 253 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 218 insertions(+), 35 deletions(-)

diff --git a/lib/bluetooth/hci.c b/lib/bluetooth/hci.c
index a1eccaf1e..402aee441 100644
--- a/lib/bluetooth/hci.c
+++ b/lib/bluetooth/hci.c
@@ -333,7 +333,10 @@ int hci_strtolm(char *str, unsigned int *val)
 	return ret;
 }
 
-/* Command mapping */
+/* Command mapping
+ * Core Specification Version 6.0 | Vol 4, Part E
+ * 6.27. Supported commands
+ */
 static const hci_map commands_map[] = {
 	{ "Inquiry",					0   },
 	{ "Inquiry Cancel",				1   },
@@ -355,7 +358,7 @@ static const hci_map commands_map[] = {
 
 	{ "Set Connection Encryption",			16  },
 	{ "Change Connection Link Key",			17  },
-	{ "Temporary Link Key",				18  },
+	{ "Link Key Selection",				18  },
 	{ "Remote Name Request",			19  },
 	{ "Cancel Remote Name Request",			20  },
 	{ "Read Remote Supported Features",		21  },
@@ -430,13 +433,13 @@ static const hci_map commands_map[] = {
 	{ "Read Transmit Power Level",			82  },
 	{ "Read Synchronous Flow Control Enable",	83  },
 	{ "Write Synchronous Flow Control Enable",	84  },
-	{ "Set Host Controller To Host Flow Control",	85  },
+	{ "Set Controller To Host Flow Control",	85  },
 	{ "Host Buffer Size",				86  },
 	{ "Host Number Of Completed Packets",		87  },
 
 	{ "Read Link Supervision Timeout",		88  },
 	{ "Write Link Supervision Timeout",		89  },
-	{ "Read Number of Supported IAC",		90  },
+	{ "Read Number Of Supported IAC",		90  },
 	{ "Read Current IAC LAP",			91  },
 	{ "Write Current IAC LAP",			92  },
 	{ "Read Page Scan Period Mode",			93  },
@@ -444,9 +447,9 @@ static const hci_map commands_map[] = {
 	{ "Read Page Scan Mode",			95  },
 
 	{ "Write Page Scan Mode",			96  },
-	{ "Set AFH Channel Classification",		97  },
-	{ "Reserved",					98  },
-	{ "Reserved",					99  },
+	{ "Set AFH Host Channel Classification",	97  },
+	{ "LE CS Read Remote FAE Table",		98  },
+	{ "LE CS Write Cached Remote FAE Table",	99  },
 	{ "Read Inquiry Scan Type",			100 },
 	{ "Write Inquiry Scan Type",			101 },
 	{ "Read Inquiry Mode",				102 },
@@ -474,19 +477,19 @@ static const hci_map commands_map[] = {
 	{ "Read BD ADDR",				121 },
 	{ "Read Failed Contact Counter",		122 },
 	{ "Reset Failed Contact Counter",		123 },
-	{ "Get Link Quality",				124 },
+	{ "Read Link Quality",				124 },
 	{ "Read RSSI",					125 },
 	{ "Read AFH Channel Map",			126 },
-	{ "Read BD Clock",				127 },
+	{ "Read Clock",					127 },
 
 	{ "Read Loopback Mode",				128 },
 	{ "Write Loopback Mode",			129 },
-	{ "Enable Device Under Test Mode",		130 },
-	{ "Setup Synchronous Connection",		131 },
-	{ "Accept Synchronous Connection",		132 },
-	{ "Reject Synchronous Connection",		133 },
-	{ "Reserved",					134 },
-	{ "Reserved",					135 },
+	{ "Enable Implementation Under Test Mode",	130 },
+	{ "Setup Synchronous Connection Request",	131 },
+	{ "Accept Synchronous Connection Request",	132 },
+	{ "Reject Synchronous Connection Request",	133 },
+	{ "LE CS Create Config",			134 },
+	{ "LE CS Remove Config",			135 },
 
 	{ "Read Extended Inquiry Response",		136 },
 	{ "Write Extended Inquiry Response",		137 },
@@ -520,9 +523,9 @@ static const hci_map commands_map[] = {
 	{ "Send Keypress Notification",			162 },
 	{ "IO Capability Request Negative Reply",	163 },
 	{ "Read Encryption Key Size",			164 },
-	{ "Reserved",					165 },
-	{ "Reserved",					166 },
-	{ "Reserved",					167 },
+	{ "LE CS Read Local Supported Capabilities",	165 },
+	{ "LE CS Read Remote Supported Capabilities",	166 },
+	{ "LE CS Write Cached Remote Supported Capabilities", 167 },
 
 	{ "Create Physical Link",			168 },
 	{ "Accept Physical Link",			169 },
@@ -545,56 +548,236 @@ static const hci_map commands_map[] = {
 	{ "Read Flow Control Mode",			184 },
 	{ "Write Flow Control Mode",			185 },
 	{ "Read Data Block Size",			186 },
-	{ "Reserved",					187 },
-	{ "Reserved",					188 },
+	{ "LE CS Test",					187 },
+	{ "LE CS Test End",				188 },
 	{ "Enable AMP Receiver Reports",		189 },
 	{ "AMP Test End",				190 },
 	{ "AMP Test Command",				191 },
 
 	{ "Read Enhanced Transmit Power Level",		192 },
-	{ "Reserved",					193 },
+	{ "LE CS Security Enable",			193 },
 	{ "Read Best Effort Flush Timeout",		194 },
 	{ "Write Best Effort Flush Timeout",		195 },
 	{ "Short Range Mode",				196 },
 	{ "Read LE Host Support",			197 },
 	{ "Write LE Host Support",			198 },
-	{ "Reserved",					199 },
+	{ "LE CS Set Default Settings",			199 },
 
 	{ "LE Set Event Mask",				200 },
-	{ "LE Read Buffer Size",			201 },
-	{ "LE Read Local Supported Features",		202 },
+	{ "LE Read Buffer Size [v1]",			201 },
+	{ "LE Read Local Supported Features Page 0",	202 },
 	{ "Reserved",					203 },
 	{ "LE Set Random Address",			204 },
 	{ "LE Set Advertising Parameters",		205 },
-	{ "LE Read Advertising Channel TX Power",	206 },
+	{ "LE Read Advertising Physical Channel Tx Power", 206 },
 	{ "LE Set Advertising Data",			207 },
 
 	{ "LE Set Scan Response Data",			208 },
-	{ "LE Set Advertise Enable",			209 },
+	{ "LE Set Advertising Enable",			209 },
 	{ "LE Set Scan Parameters",			210 },
 	{ "LE Set Scan Enable",				211 },
 	{ "LE Create Connection",			212 },
 	{ "LE Create Connection Cancel",		213 },
-	{ "LE Read Accept List Size",			214 },
-	{ "LE Clear Accept List",			215 },
+	{ "LE Read Filter Accept List Size",		214 },
+	{ "LE Clear Filter Accept List",		215 },
 
-	{ "LE Add Device To Accept List",		216 },
-	{ "LE Remove Device From Accept List",		217 },
+	{ "LE Add Device To Filter Accept List",	216 },
+	{ "LE Remove Device From Filter Accept List",	217 },
 	{ "LE Connection Update",			218 },
 	{ "LE Set Host Channel Classification",		219 },
 	{ "LE Read Channel Map",			220 },
-	{ "LE Read Remote Used Features",		221 },
+	{ "LE Read Remote Features Page 0",		221 },
 	{ "LE Encrypt",					222 },
 	{ "LE Rand",					223 },
 
-	{ "LE Start Encryption",			224 },
+	{ "LE Enable Encryption",			224 },
 	{ "LE Long Term Key Request Reply",		225 },
 	{ "LE Long Term Key Request Negative Reply",	226 },
 	{ "LE Read Supported States",			227 },
-	{ "LE Receiver Test",				228 },
-	{ "LE Transmitter Test",			229 },
+	{ "LE Receiver Test [v1]",			228 },
+	{ "LE Transmitter Test [v1]",			229 },
 	{ "LE Test End",				230 },
-	{ "Reserved",					231 },
+	{ "LE Enable Monitoring Advertisers",		231 },
+
+	{ "LE CS Set Channel Classification",		232 },
+	{ "LE CS Set Procedure Parameters",		233 },
+	{ "LE CS Procedure Enable",			234 },
+	{ "Enhanced Setup Synchronous Connection",	235 },
+	{ "Enhanced Accept Synchronous Connection",	236 },
+	{ "Read Local Supported Codecs [v1]",		237 },
+	{ "Set MWS Channel Parameters",			238 },
+	{ "Set External Frame Configuration",		239 },
+
+	{ "Set MWS Signaling",				240 },
+	{ "Set MWS Transport Layer",			241 },
+	{ "Set MWS Scan Frequency Table",		242 },
+	{ "Get MWS Transport Layer Configuration",	243 },
+	{ "Set MWS PATTERN Configuration",		244 },
+	{ "Set Triggered Clock Capture",		245 },
+	{ "Truncated Page",				246 },
+	{ "Truncated Page Cancel",			247 },
+
+	{ "Set Connectionless Peripheral Broadcast",	248 },
+	{ "Set Connectionless Peripheral Broadcast Receive", 249 },
+	{ "Start Synchronization Train",		250 },
+	{ "Receive Synchronization Train",		251 },
+	{ "Set Reserved LT ADDR",			252 },
+	{ "Delete Reserved LT ADDR",			253 },
+	{ "Set Connectionless Peripheral Broadcast Data", 254 },
+	{ "Read Synchronization Train Parameters",	255 },
+
+	{ "Write Synchronization Train Parameters",	256 },
+	{ "Remote OOB Extended Data Request Reply",	257 },
+	{ "Read Secure Connections Host Support",	258 },
+	{ "Write Secure Connections Host Support",	259 },
+	{ "Read Authenticated Payload Timeout",		260 },
+	{ "Write Authenticated Payload Timeout",	261 },
+	{ "Read Local OOB Extended Data",		262 },
+	{ "Write Secure Connections Test Mode",		263 },
+
+	{ "Read Extended Page Timeout",			264 },
+	{ "Write Extended Page Timeout",		265 },
+	{ "Read Extended Inquiry Length",		266 },
+	{ "Write Extended Inquiry Length",		267 },
+	{ "LE Remote Connection Parameter Request Reply", 268 },
+	{ "LE Remote Connection Parameter Request Negative Reply", 269 },
+	{ "LE Set Data Length",				270 },
+	{ "LE Read Suggested Default Data Length",	271 },
+
+	{ "LE Write Suggested Default Data Length",	272 },
+	{ "LE Read Local P-256 Public Key",		273 },
+	{ "LE Generate DHKey [v1]",			274 },
+	{ "LE Add Device To Resolving List",		275 },
+	{ "LE Remove Device From Resolving List",	276 },
+	{ "LE Clear Resolving List",			277 },
+	{ "LE Read Resolving List Size",		278 },
+	{ "LE Read Peer Resolvable Address",		279 },
+
+	{ "LE Read Local Resolvable Address",		280 },
+	{ "LE Set Address Resolution Enable",		281 },
+	{ "LE Set Resolvable Private Address Timeout",	282 },
+	{ "LE Read Maximum Data Length",		283 },
+	{ "LE Read PH",					284 },
+	{ "LE Set Default PHY",				285 },
+	{ "LE Set PHY",					286 },
+	{ "LE Receiver Test [v2]",			287 },
+
+	{ "LE Transmitter Test [v2]",			288 },
+	{ "LE Set Advertising Set Random Address",	289 },
+	{ "LE Set Extended Advertising Parameters [v1]", 290 },
+	{ "LE Set Extended Advertising Data",		291 },
+	{ "LE Set Extended Scan Response Data",		292 },
+	{ "LE Set Extended Advertising Enable",		293 },
+	{ "LE Read Maximum Advertising Data Length",	294 },
+	{ "LE Read Number of Supported Advertising Sets", 295 },
+
+	{ "LE Remove Advertising Set",			296 },
+	{ "LE Clear Advertising Sets",			297 },
+	{ "LE Set Periodic Advertising Parameters [v1]", 298 },
+	{ "LE Set Periodic Advertising Data",		299 },
+	{ "LE Set Periodic Advertising Enable",		300 },
+	{ "LE Set Extended Scan Parameters",		301 },
+	{ "LE Set Extended Scan Enable",		302 },
+	{ "LE Extended Create Connection [v1]",		303 },
+
+	{ "LE Periodic Advertising Create Sync",	304 },
+	{ "LE Periodic Advertising Create Sync Cancel",	305 },
+	{ "LE Periodic Advertising Terminate Sync",	306 },
+	{ "LE Add Device To Periodic Advertiser List",	307 },
+	{ "LE Remove Device From Periodic Advertiser List", 308 },
+	{ "LE Clear Periodic Advertiser List",		309 },
+	{ "LE Read Periodic Advertiser List Size",	310 },
+	{ "LE Read Transmit Power",			311 },
+
+	{ "LE Read RF Path Compensation",		312 },
+	{ "LE Write RF Path Compensation",		313 },
+	{ "LE Set Privacy Mode",			314 },
+	{ "LE Receiver Test [v3]",			315 },
+	{ "LE Transmitter Test [v3]",			316 },
+	{ "LE Set Connectionless CTE Transmit Parameters", 317 },
+	{ "LE Set Connectionless CTE Transmit Enable",	318 },
+	{ "LE Set Connectionless IQ Sampling Enable",	319 },
+
+	{ "LE Set Connection CTE Receive Parameters",	320 },
+	{ "LE Set Connection CTE Transmit Parameters",	321 },
+	{ "LE Connection CTE Request Enable",		322 },
+	{ "LE Connection CTE Response Enable",		323 },
+	{ "LE Read Antenna Information",		324 },
+	{ "LE Set Periodic Advertising Receive Enable",	325 },
+	{ "LE Periodic Advertising Sync Transfer",	326 },
+	{ "LE Periodic Advertising Set Info Transfer",	327 },
+
+	{ "LE Set Periodic Advertising Sync Transfer Parameters", 328 },
+	{ "LE Set Default Periodic Advertising Sync Transfer Parameters", 329 },
+	{ "LE Generate DHKey [v2]",			330 },
+	{ "Read Local Simple Pairing Options",		331 },
+	{ "LE Modify Sleep Clock Accuracy",		332 },
+	{ "LE Read Buffer Size [v2]",			333 },
+	{ "LE Read ISO TX Sync",			334 },
+	{ "LE Set CIG Parameters",			335 },
+
+	{ "LE Set CIG Parameters Test",			336 },
+	{ "LE Create CIS",				337 },
+	{ "LE Remove CIG",				338 },
+	{ "LE Accept CIS Request",			339 },
+	{ "LE Reject CIS Request",			340 },
+	{ "LE Create BIG",				341 },
+	{ "LE Create BIG Test",				342 },
+	{ "LE Terminate BIG",				343 },
+
+	{ "LE BIG Create Sync",				344 },
+	{ "LE BIG Terminate Sync",			345 },
+	{ "LE Request Peer SCA",			346 },
+	{ "LE Setup ISO Data Path",			347 },
+	{ "LE Remove ISO Data Path",			348 },
+	{ "LE ISO Transmit Test",			349 },
+	{ "LE ISO Receive Test",			350 },
+	{ "LE ISO Read Test Counters",			351 },
+
+	{ "LE ISO Test End",				352 },
+	{ "LE Set Host Feature [v1]",			353 },
+	{ "LE Read ISO Link Quality",			354 },
+	{ "LE Enhanced Read Transmit Power Level",	355 },
+	{ "LE Read Remote Transmit Power Level",	356 },
+	{ "LE Set Path Loss Reporting Parameters",	357 },
+	{ "LE Set Path Loss Reporting Enable",		358 },
+	{ "LE Set Transmit Power Reporting Enable",	359 },
+
+	{ "LE Transmitter Test [v4]",			360 },
+	{ "Set Ecosystem Base Interval",		361 },
+	{ "Read Local Supported Codecs [v2]",		362 },
+	{ "Read Local Supported Codec Capabilities",	363 },
+	{ "Read Local Supported Controller Delay",	364 },
+	{ "Configure Data Path",			365 },
+	{ "LE Set Data Related Address Changes",	366 },
+	{ "Set Min Encryption Key Size",		367 },
+
+	{ "LE Set Default Subrate command",		368 },
+	{ "LE Subrate Request command",			369 },
+	{ "LE Set Extended Advertising Parameters [v2]", 370 },
+	{ "LE Set Decision Data",			371 },
+	{ "LE Set Decision Instructions",		372 },
+	{ "LE Set Periodic Advertising Subevent Data",	373 },
+	{ "LE Set Periodic Advertising Response Data",	374 },
+	{ "LE Set Periodic Sync Subevent",		375 },
+
+	{ "LE Extended Create Connection [v2]",		376 },
+	{ "LE Set Periodic Advertising Parameters [v2]", 377 },
+	{ "LE Read All Local Supported Features",	378 },
+	{ "LE Read All Remote Features",		379 },
+	{ "LE Set Host Feature [v2]",			380 },
+	{ "LE Add Device To Monitored Advertisers List", 381 },
+	{ "LE Remove Device From Monitored Advertisers List", 382 },
+	{ "LE Clear Monitored Advertisers List",	383 },
+
+	{ "LE Read Monitored Advertisers List Size",	384 },
+	{ "LE Frame Space Update",			385 },
+	{ "Reserved",					386 },
+	{ "Reserved",					387 },
+	{ "Reserved",					388 },
+	{ "Reserved",					389 },
+	{ "Reserved",					390 },
+	{ "Reserved",					391 },
 
 	{ NULL }
 };
-- 
2.47.2

