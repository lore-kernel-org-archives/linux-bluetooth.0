Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBOcAmrk"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913FC10F
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 14:07:15 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77d6b28aa9aso343833285a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 14:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701727633; x=1702332433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZxuHDLHq/7J9eWN8ZsQmRte/LPyVEp6v3+CgTDZ1ZE=;
        b=HBOcAmrkS+/3rHO2qmeTr/hhcNHk24hKy3Ms6cZ3wrgonrQKSUz1/WUhKnyNCPuiEY
         ZSvj+MxeZVHHLLOTClkgzOibzKHrieiTaFS+PWkRDdCULMcq8hR96I1DlXh4rozfE+H6
         F8DksKCosMo+8gbmPVFj0UmsUzuPjr6sp7X5PJ0Cxn+YQPvb9pDqAka57L0m7WTW8EEL
         aWJRMiyW3jQ/SvHCow/jB5eZUJX3GWsg8Ppl2Dqgrw7HKFgOFmoRKrOZrYspUwZ0BzVy
         LQZ08UK4qWcWJU0NgaHvplmfX4RcBlx5vs0AN2kjsoR5ZaYE5OW2yLSJzrh5bjUU0vns
         G2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727633; x=1702332433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZxuHDLHq/7J9eWN8ZsQmRte/LPyVEp6v3+CgTDZ1ZE=;
        b=AVEgB8I8bN/Of8SvMIKaqnmoypuPCoz06bibfHkdzOZ3qsFgm911zWtFtjKkoikmAi
         GjIepIG4ruiWJlItfnMUEHZOCxt4yPps78AkNxTanY71SzDDKgyW4z4CWehLuQiT3rY/
         MuuZbGliFuozQgAx7MUDHSEsnj1dHj1Ur5SV/obQuI+kx3CsuA5O7ecUEkC/Mxa0g3De
         lrZsqAyFNeIijtbgQNJ1livI3BTnQ+3zPvYGUlDZTTqmofU+aMRCtZuoxv2LXxe1P70g
         C2MCICuwRGB2qpFFWXxUXZLvPGiIJbR/rRyI8/1TSwKhlIdl4/2YS3FhMKyR96WikrM7
         Lwng==
X-Gm-Message-State: AOJu0Yxela/igdg5jRmiddPmBqjEHNwEiS2HZgYl+CVYxqsj0T+bRG7X
	E9MSHq7BTPB6XtMCpYQGG6dmgUxK/Gk=
X-Google-Smtp-Source: AGHT+IECVCnaw77/kYrbf+3X66p3FQBBz2wCQiXHWrzEbsCULDuigAuLPVqrgQ3a1hBScJBW7djPsw==
X-Received: by 2002:a05:620a:8181:b0:77e:fba3:81e3 with SMTP id ot1-20020a05620a818100b0077efba381e3mr248584qkn.121.1701727633482;
        Mon, 04 Dec 2023 14:07:13 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05620a458900b00767d4a3f4d9sm4566903qkb.29.2023.12.04.14.07.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:07:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/vcp: Fix comparison of values in different endianess
Date: Mon,  4 Dec 2023 17:07:11 -0500
Message-ID: <20231204220711.2974630-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Values received over the air are in Little Endian format so they first
need to be converted to host endianess before comparing with other
values.
---
 src/shared/vcp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 06a22997a95c..5d163266b480 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -709,13 +709,16 @@ static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
-	if (req->set_vol_offset > VOCS_VOL_OFFSET_UPPER_LIMIT ||
-		req->set_vol_offset < VOCS_VOL_OFFSET_LOWER_LIMIT) {
+	vstate->vol_offset = le16_to_cpu(req->set_vol_offset);
+
+	if (vstate->vol_offset > VOCS_VOL_OFFSET_UPPER_LIMIT ||
+		vstate->vol_offset < VOCS_VOL_OFFSET_LOWER_LIMIT) {
 		DBG(vcp, "error: Value Out of Range");
 		return BT_ATT_ERROR_VALUE_OUT_OF_RANGE;
 	}
-	vstate->vol_offset = le16_to_cpu(req->set_vol_offset);
-	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+
+	/* Increment Change Counter */
+	vstate->counter = -~vstate->counter;
 
 	gatt_db_attribute_notify(vdb->vocs->vos, (void *)vstate,
 				 sizeof(struct vol_offset_state),
-- 
2.43.0

