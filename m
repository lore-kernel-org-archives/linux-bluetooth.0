Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394814A3D
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372561; cv=none; b=lYkI/tXGkq0R1VGvEpa+W6R0j5BFpujHt7q4hEDK4fC7+qPODxeoLdf+ZeHJ4tfeDyCIpMQHOQsdp03JKO4YigXLxC9f6ed5FIp1zRNMk52lsJEeOVTdOKQ+K9eiqcpuhrNYv4j+yBqdkZZIyKMy28h2xrr4i6Ap2z6ARRSNjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372561; c=relaxed/simple;
	bh=ET59JROdK2mUo/LbGtqPPiZ+3mvi2iOksOmM3xB7fhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmY5D12EzoTMoW7rIQpSApc23CEjP/zXsMTFIyKnedgmGjMdWXEIPeyTvc/E8gPI/4URzfqKFzfSEqESfq1deoHLMtSQs4fqzgilpLSuxqvsuCyiqWePdxYKGlcICZhB3hjLWt8q6Z3HAYRInNP99YTMjv1Wt2wC7Fz6nhudVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knJA6Zs3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knJA6Zs3"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso2912797a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718372558; x=1718977358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh2QKX/ZYKM23lTnd346PtGL9+PPj5AjtEo0ar7uZK8=;
        b=knJA6Zs3Y1k2T2OAc+c+J6aEPz5GSHrzmD0QeJVw1/tkIdGm7L8Pm91fBock+kEvNJ
         u94qRHYZcQ6edET/+VhD7TUQIydn6ny/rPlLeNI33JjbvSDNNdQi2rK6X96MsS5K8M2U
         om6BjP+h7Gu967QPw/1NB4BjiSYdD1EHXwrUvN2knSBD1i+6f7IVmUtsB7Pj4lSLjzW3
         32o+8jyQap/z8csHRWBcUtRBFbHPPtIlfoay/xpjafIyTjf2vJbXZxjnZHksqjLG+oKe
         83bqbBYvM7PdErf5U6e4ElPBOKZC/vM8RPHFGG/mtH2pqNe+LtXN7iReTSdUaPSV+kXS
         U9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372558; x=1718977358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh2QKX/ZYKM23lTnd346PtGL9+PPj5AjtEo0ar7uZK8=;
        b=fSRXnIhYJHp0JlX4T4WEs02W97a/DYbMveLEwNKQO3RS1DH4vXDV9CNt4LnmfwYFcI
         ArTPZz6TvJhVCLzvi0KDkcdbI3PRZIshTBHDh2vG0EsgubtDUSW3AJ08mbyQjqa5pSVT
         NjeqIM01sTKtgw6yMPBdjjF5hdj+Aquc/V1iIG0n8tvhzSQi0peom4shmQ5F6Wxh9IA1
         ChhyGL79Z7hXXp26hu2Qch8hC+IYdiPnpZzntgJ6iTMB7QX9y1JHLonHbsovmX3cNDDq
         RO7aGfz7a0fuHvJzShsAmMKfgSLpakWqc/Xo+ZSByJGHnj6HQ1zeXOYN2h60R91umrYm
         18uw==
X-Gm-Message-State: AOJu0YwpV1dhqwDuhJDdEH5h2q3JSJcl+FjuIOPjliImmFi9DRk1KDC6
	RulstXVtohCmHXR1Lh9lk4ab+d1TPIzCZEVSsw6WjUJrBlboxgtS0Gucpw==
X-Google-Smtp-Source: AGHT+IGndddZezVZTUeozajUqBrHkN6jqfaOHXU+rVFk4fgjeEy7K9r7qn3KEuhWs3u4JLuiJy1t8Q==
X-Received: by 2002:a50:9fe9:0:b0:57c:a4d5:4d04 with SMTP id 4fb4d7f45d1cf-57cbd69e90bmr1658606a12.17.1718372558031;
        Fri, 14 Jun 2024 06:42:38 -0700 (PDT)
Received: from raspberrypi.home (46.205.193.11.nat.ftth.dynamic.t-mobile.pl. [46.205.193.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7439606sm2295916a12.90.2024.06.14.06.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:42:37 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v2] shared/util: Update SDO defined UUIDs
Date: Fri, 14 Jun 2024 15:42:28 +0200
Message-Id: <20240614134228.1299692-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614133024.1299311-1-arkadiusz.bokowy@gmail.com>
References: <20240614133024.1299311-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list of SDO defined UUIDs taken from section 3.10 of:
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Assigned_Numbers/out/en/Assigned_Numbers.pdf
---
 src/shared/util.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index ee59b94a0..6a29b5068 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1566,9 +1566,23 @@ static const struct {
 	{ 0xfd60, "Sercomm Corporation"				},
 	{ 0xfd5f, "Oculus VR, LLC"				},
 	/* SDO defined */
-	{ 0xfffc, "AirFuel Alliance"				},
-	{ 0xfffe, "Alliance for Wireless Power (A4WP)"		},
-	{ 0xfffd, "Fast IDentity Online Alliance (FIDO)"	},
+	{ 0xfccc, "Wi-Fi Easy Connect Specification"		},
+	{ 0xffef, "Wi-Fi Direct Specification"			},
+	{ 0xfff0, "Public Key Open Credential (PKOC)"		},
+	{ 0xfff1, "ICCE Digital Key"				},
+	{ 0xfff2, "Aliro"					},
+	{ 0xfff3, "FiRa Consortium"				},
+	{ 0xfff4, "FiRa Consortium"				},
+	{ 0xfff5, "Car Connectivity Consortium, LLC"		},
+	{ 0xfff6, "Matter Profile ID"				},
+	{ 0xfff7, "Zigbee Direct"				},
+	{ 0xfff8, "Mopria Alliance BLE"				},
+	{ 0xfff9, "FIDO2 Secure Client-To-Authenticator Transport" },
+	{ 0xfffa, "ASTM Remote ID"				},
+	{ 0xfffb, "Direct Thread Commissioning"			},
+	{ 0xfffc, "Wireless Power Transfer (WPT)"		},
+	{ 0xfffd, "Universal Second Factor Authenticator"	},
+	{ 0xfffe, "Wireless Power Transfer"			},
 	{ }
 };
 
-- 
2.39.2

