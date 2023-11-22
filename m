Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOnHzxFf"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D4DD
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:06:53 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7788f513872so3570785a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680012; x=1701284812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9L3RVtYohgGGbQz/96kvey3bQHCTTJXpo42ThDVUdw=;
        b=LOnHzxFf65xs65bUmUmi3iCiKYwrOs8boqUM7ueOP6wVMSdI8N9Qo65NyKhuWMG4EZ
         K7HQXimqkGVcf/MIeCvP4YQjQ0dt0KAZd/jiD2qbZct0aOIdxvBVy417NahLU3Y6YD+Z
         cKEZWke0U9lkk6cunxtM4kOgN+UkS/t+U4KynOTzfNs/92+Nu9CUDJLybAOouXdrff6J
         rzQkl+8GiS31Uv6oQfDDY0zpMGtl2LxjSlac0piRIqWS0wfml77gi5Yzoad/zXHlEHRR
         X1DXk74rBDWj9hpR6v18y3L/JaCZ4whqQZrxGsSJSjv4t6P4KPNFMaYhC65Rrsvd/csL
         wZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680012; x=1701284812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9L3RVtYohgGGbQz/96kvey3bQHCTTJXpo42ThDVUdw=;
        b=hcTHsmPpLiGPUNMlHyz41O5QRDH4P84EJ30rSqgAxjA/b/DPLwIDYxdY1nz1ccTtng
         EUfHFl7HHBvn1yjoMU+trUwLYSYTC/cksPPIkJUVPuZwfxBY82Kx0n7168ZQNte9GhSk
         /r7ActTm+AM0kIhk67Cfjnu61BPkRdLChVwjnc3tEvK1PqY6n20MZsEdEqVlNg0aAuIe
         zUKdEHoHiPa/sGbZUH9NiHMUCoJhHlb1StlHGKBecDFITznod4zaCIoJQv1cZRM4zv70
         RoK3duGm9vPaRkj8JCR3fKhFcNhATHu5qrXJ41OhK9tE/vWHtkzczi1mSbHQFADoTTln
         FVmw==
X-Gm-Message-State: AOJu0YynlERfz4qfgu0uA6/3Z0nU/zhpfZL6G2qy/fuHzSf6gbHJNUiB
	MQsvrTI6jEIMLEdPZu6rI4CHdhra047+PCHs
X-Google-Smtp-Source: AGHT+IHDPCJxHl62mV5m93Enz9oKF9fzMiZYIfKB5P/p1aJfi7S3j0CmEPH4TlivtbYdSX/EMqXtOQ==
X-Received: by 2002:a05:620a:25c8:b0:76f:14fc:6d2f with SMTP id y8-20020a05620a25c800b0076f14fc6d2fmr3699729qko.1.1700680011832;
        Wed, 22 Nov 2023 11:06:51 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b32-20020a05620a272000b0076d25b11b62sm97885qkp.38.2023.11.22.11.06.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:06:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] shared/util: Add GMAP related UUIDs
Date: Wed, 22 Nov 2023 14:06:45 -0500
Message-ID: <20231122190649.879386-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds GMAP 1.0[1] UUIDs following the assigned numbers[2].

[1] https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=576496
[2] https://www.bluetooth.com/wp-content/uploads/Files/Specification/Assigned_Numbers.pdf?id=3
---
 src/shared/util.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index bf37fce364ed..47efff750e30 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -773,6 +773,7 @@ static const struct {
 	{ 0x1854, "Hearing Aid"					},
 	{ 0x1855, "Telephony and Media Audio"			},
 	{ 0x1856, "Public Broadcast Announcement"		},
+	{ 0x1858, "Gaming Audio"				},
 	/* 0x1857 to 0x27ff undefined */
 	{ 0x2800, "Primary Service"				},
 	{ 0x2801, "Secondary Service"				},
@@ -1081,6 +1082,11 @@ static const struct {
 	{ 0x2bda, "Hearing Aid Features"			},
 	{ 0x2bdb, "Hearing Aid Preset Control Point"		},
 	{ 0x2bdc, "Active Preset Index"				},
+	{ 0x2c00, "GMAP Role"					},
+	{ 0x2c01, "UGG Features"				},
+	{ 0x2c02, "UGT Features"				},
+	{ 0x2c03, "BGS Features"				},
+	{ 0x2c03, "BGR Features"				},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.42.0

