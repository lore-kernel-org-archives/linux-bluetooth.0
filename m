Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh6w0pz/"
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ACDBF
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 08:30:45 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4ac2c1a4b87so2148278e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 08:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701275443; x=1701880243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJwYPAm/q4hSeBbPO0C2BMMYNCprkMddZ2eED0seP8M=;
        b=fh6w0pz/99sVDp1StEmeLDM6/CCFOvoxyuwTlWyVyqYMOB33wX9G/EZf6JsP7MiUNe
         lVvajXXBORNDmQQ/AGvLgssNI2rDSiEWeQTsfDlzAR7PTyd6XSeVhmx/MEuK6Wwmm7SK
         Q1M1HurbVkr/RfVMLHF9SffuVD8GZ0lLf59HWRa7mwzD+nYw+MnzCfXV/Ukx41HG2PpY
         8v3vzukn4uE1DsBDtSC4MnJ0C67kV/c0t/n6njd7IdDkpQ/fFLVKT+uL6vIClRGAXNxe
         LSmatJJQz2V9fk8PHSblHwTrTIRaejAfctFC88gSqrX+lsMLA9qXxL5K7Y8IWIq5DOD+
         2ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275443; x=1701880243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJwYPAm/q4hSeBbPO0C2BMMYNCprkMddZ2eED0seP8M=;
        b=mAy5R880wxpOnMLuMXTaEFfKwhaDNrMcZm6LjbOYBiTVXjIByQ6ujR8+PXnSlrOgoC
         4DUEZsY8EaCBfHBezbmMEG3nzzchEGr+fYF2YNfCFOMs0OH7Jpze0LYudfNuqzGIFVgY
         Z5PA13WO/1DoEgoI0u617qo1jutIZTEtHmNzRPervucV+Z3WKGUzoN0KX7SBE4/9ZBUl
         3KQbRdnoVoax0w91v0Cox/7j0e1VXKVBa3lywPVLYa130KwmlCEcE9MY0n9voObuu0OD
         UF55gOrr14539do1bGWj/kHMZhoe9ZVADozOL+2cJuofHkB9lpCRGN/uOjZpRWJMeyQa
         DJfg==
X-Gm-Message-State: AOJu0YwPN9gG61dsolHv8yBhGHYtvZgZqR5sWGMRW3ybDBPhmxQI2V3o
	3ZggZmiyhQOgmcLDgCpgIEUrJ0O2y7+kqA==
X-Google-Smtp-Source: AGHT+IFwmdLwXpgKk2c9KMi4XyNRiOJwfzJHjWolE5cYed+M24Re9b1yxNpvzCFh/Vamv92FBR6Olg==
X-Received: by 2002:a05:6122:d9d:b0:49a:6dc0:5a89 with SMTP id bc29-20020a0561220d9d00b0049a6dc05a89mr21234871vkb.5.1701275443296;
        Wed, 29 Nov 2023 08:30:43 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id fm9-20020a056122290900b004acebe1af09sm2540063vkb.47.2023.11.29.08.30.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:30:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] test-micp: Fix endianess error
Date: Wed, 29 Nov 2023 11:30:39 -0500
Message-ID: <20231129163041.2075184-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

On big endian the followin error can be observed:

MICP/CL/CGGIT/SER/BV-01-C - init
MICP/CL/CGGIT/SER/BV-01-C - setup
MICP/CL/CGGIT/SER/BV-01-C - setup complete
MICP/CL/CGGIT/SER/BV-01-C - run
micp_write_value handle: 3
**
ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) == 0)
Bail out! ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) == 0)
Aborted
---
 unit/test-micp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-micp.c b/unit/test-micp.c
index e2975c298ec5..a7fc7fb321bd 100644
--- a/unit/test-micp.c
+++ b/unit/test-micp.c
@@ -147,7 +147,7 @@ static void micp_write_value(struct bt_micp *micp, void *user_data)
 	struct bt_mics *mics = micp_get_mics(micp);
 	uint16_t	value_handle;
 	int ret;
-	const uint16_t value = 0x0001;
+	uint16_t value = cpu_to_le16(0x0001);
 
 	gatt_db_attribute_get_char_data(mics->ms, NULL, &value_handle,
 							NULL, NULL, NULL);
-- 
2.43.0

