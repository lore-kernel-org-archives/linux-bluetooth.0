Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205B152E02
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069210; cv=none; b=JiyuUylbc7eazJIUCbGIrjYwvBgHWeFW1O1kXnAf9vxe1QpsTjqkSsQT1phNnarGU+sOiP4sU5zRUort1fUNkMMK7hu/FgMjyC9yDNB5c3vAuwityFxdaNlFb86z31wexiFN11WXicel85UZDjR52E7ZNQnpLcgtEwKqll3EIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069210; c=relaxed/simple;
	bh=InpyyDxXL8y2iMlaegpYqRnVVGhPW05fMmkULA2oobY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4ytHp4rNC1w6ekYw7yKkMsXQn89DJbtWoRElclkevg/QObO6m8tf1ZV/8z6oI0x9JdZuW2o26cpY/pYFLQPA1nl9zZWSaBg+riaobJEf/j6PC3or+aIyg2Aebme7lAakhrIA/sLKB+5k9ewFjcZeWgbvxXoXJmZEhDMzFD6BJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFNkG3I6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFNkG3I6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso3322813a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 22:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069207; x=1741674007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp193A+JhluCv8qP5l/ChkEEc6RaIoQRNQJIvejeTA4=;
        b=FFNkG3I6l0F40LoYsm87XL01O9+/RtP3Uo8tGCJr5thheqmv4/y4eY0w0y2fgmcIhO
         THUA/1vvD2wt0Hl8zzC7RaRZPmV+7uH3mou538fdxjiDtmAfnUAO0macF2xLoRNPCXi3
         d1UQJVdKySjh/j3D5m0SVz3xF3BlJNv2tzcTKTaGoZPs57nxvixCblvbZk1jeJbrrmWL
         DbgVtO8S3viGWoiFzaahEE045KJKoBFB9i5xT7+YVrbdsWGzQ0TdouRDDld0e7aphvYl
         ZezJVFMbNauHXFwpiBZlA2hgld9/48QK4/X8MSgMGhDHwPC/6CJ/ZnlKBe8MQr4D9nL4
         io9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069207; x=1741674007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp193A+JhluCv8qP5l/ChkEEc6RaIoQRNQJIvejeTA4=;
        b=h4QHzhuamo6CPDA3vsU6gSIcLNbDAquaDGXflDkpy8EYFyw25yH38EoSnJ5+kbm5vN
         RbNh+eF9RftLY01y8C1q6DxsHOnkSBsN4T+HrW9EADr9exJSfZDS5q89gypRcHJ8pD6Y
         MyjwqgUTi6yHPHEAuLfpjIUP4gtWRjzC2mHnpNhz1rST3mSvaiAbosQIG1zk+Cg0fd9N
         Ls3tQlj+y2LgEJJS1CuK9IGxbED8yYKwOciIzfnEAk/hHcYdOG/i25a2ahCWMyNi4krD
         X8iGndK3NWwlftXBvisefxa1ZUAU1LE9XlNUQ+eVnnu/8fIqq5/W96SFsguATPxdBhsT
         dFpw==
X-Forwarded-Encrypted: i=1; AJvYcCWRW4UPa6Z+QI8WeQa74gLn1zwH1Qe6f2NXCv2EyVUeX4fwPvZrh8sHJpyhiS0uZl8yzJYu5XSnt+smG4OUNuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPVFwJTOsaMECee+L4eu5ccXGJ+1YoxOEHmto9sPNPfamtDk9
	fxE+e252IfW7PoBtr1wo0766FbdYhRiEwHIs3sJyzwn9GHNSJPsnzNZYHoqBeZw=
X-Gm-Gg: ASbGncuonW5wlvJJHwfsyZO9sQQk1BROAvoKQMRwHKq4ptg0QiPq+zjJ/sryipobBcT
	ZN9NEp22D2Yk5f0rVGrVa7cxfzKOQ1jUO74G6kjQFGk/W1MFgwdrkMfAT2tVoCtaiRZAambxU1h
	22MIf10P7HqNhJvgQGwApxeOzwNj5RdJean0WkMaB8gQ1VcUQ/aFdc9rKoUAqd/1pT8xR+NOEWF
	olvHpNAgdBrl7ii+WG38JdgKI71SWae6Pmd6CG1YgfiKN34tpe8O1cIVyHTA7cb4p2nncxkFeIZ
	bbLNRvJKRMvOgE3cxGebjmWosshSpvdhgIksYAqJLJRTaO9oMWdrghkr0xmpTAc53PH5sbSlsl9
	ZWokT16WMo6Mj5Uy1DbbDqJnsUOuu4uYJfsjang==
X-Google-Smtp-Source: AGHT+IG0Gxf4YK/HD50mXFiiDG95ss71jhrpwSYGLOu3ZBBRkJV8zlY3B0ySUfMhi6f8ULplESBTJQ==
X-Received: by 2002:a17:907:6ea6:b0:abf:6e88:3a65 with SMTP id a640c23a62f3a-abf6e883e60mr754174066b.19.1741069206282;
        Mon, 03 Mar 2025 22:20:06 -0800 (PST)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6f5363sm892708666b.123.2025.03.03.22.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:05 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: luiz.dentz@gmail.com
Cc: arkadiusz.bokowy@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/3] uuid-helper: Add A2DP to the list of known profiles
Date: Tue,  4 Mar 2025 07:19:57 +0100
Message-Id: <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABBYNZL3UsEQk7t2rff8gz7f=-=VbrbAvWGPkx5Kn5Mq79rfuQ@mail.gmail.com>
References: <CABBYNZL3UsEQk7t2rff8gz7f=-=VbrbAvWGPkx5Kn5Mq79rfuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/uuid-helper.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/src/uuid-helper.c b/src/uuid-helper.c
index f32ee0a85..640592fd2 100644
--- a/src/uuid-helper.c
+++ b/src/uuid-helper.c
@@ -101,29 +101,31 @@ static struct {
 	const char	*name;
 	uint16_t	class;
 } bt_services[] = {
-	{ "pbap",	PBAP_SVCLASS_ID			},
-	{ "sap",	SAP_SVCLASS_ID			},
-	{ "ftp",	OBEX_FILETRANS_SVCLASS_ID	},
-	{ "bpp",	BASIC_PRINTING_SVCLASS_ID	},
+	{ "a2dp-sink",	AUDIO_SINK_SVCLASS_ID		},
+	{ "a2dp-source",AUDIO_SOURCE_SVCLASS_ID		},
 	{ "bip",	IMAGING_SVCLASS_ID		},
-	{ "synch",	IRMC_SYNC_SVCLASS_ID		},
+	{ "bpp",	BASIC_PRINTING_SVCLASS_ID	},
 	{ "dun",	DIALUP_NET_SVCLASS_ID		},
-	{ "opp",	OBEX_OBJPUSH_SVCLASS_ID		},
 	{ "fax",	FAX_SVCLASS_ID			},
-	{ "spp",	SERIAL_PORT_SVCLASS_ID		},
-	{ "hsp",	HEADSET_SVCLASS_ID		},
-	{ "hsp-hs",	HEADSET_SVCLASS_ID		},
-	{ "hsp-ag",	HEADSET_AGW_SVCLASS_ID		},
+	{ "ftp",	OBEX_FILETRANS_SVCLASS_ID	},
+	{ "gnss",	GNSS_SERVER_SVCLASS_ID		},
 	{ "hfp",	HANDSFREE_SVCLASS_ID		},
-	{ "hfp-hf",	HANDSFREE_SVCLASS_ID		},
 	{ "hfp-ag",	HANDSFREE_AGW_SVCLASS_ID	},
-	{ "pbap-pce",	PBAP_PCE_SVCLASS_ID		},
-	{ "pbap-pse",	PBAP_PSE_SVCLASS_ID		},
-	{ "map-mse",	MAP_MSE_SVCLASS_ID		},
+	{ "hfp-hf",	HANDSFREE_SVCLASS_ID		},
+	{ "hsp",	HEADSET_SVCLASS_ID		},
+	{ "hsp-ag",	HEADSET_AGW_SVCLASS_ID		},
+	{ "hsp-hs",	HEADSET_SVCLASS_ID		},
 	{ "map-mas",	MAP_MSE_SVCLASS_ID		},
 	{ "map-mce",	MAP_MCE_SVCLASS_ID		},
 	{ "map-mns",	MAP_MCE_SVCLASS_ID		},
-	{ "gnss",	GNSS_SERVER_SVCLASS_ID		},
+	{ "map-mse",	MAP_MSE_SVCLASS_ID		},
+	{ "opp",	OBEX_OBJPUSH_SVCLASS_ID		},
+	{ "pbap",	PBAP_SVCLASS_ID			},
+	{ "pbap-pce",	PBAP_PCE_SVCLASS_ID		},
+	{ "pbap-pse",	PBAP_PSE_SVCLASS_ID		},
+	{ "sap",	SAP_SVCLASS_ID			},
+	{ "spp",	SERIAL_PORT_SVCLASS_ID		},
+	{ "synch",	IRMC_SYNC_SVCLASS_ID		},
 	{ }
 };
 
-- 
2.39.5

