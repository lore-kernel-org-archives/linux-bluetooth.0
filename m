Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgwHk1Rd"
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123510F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 06:10:44 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4b299e0703eso322224e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 06:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701353443; x=1701958243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSrkKKckYRLH/YiddRVTLirSFys3HSeLYXKLMCjanOI=;
        b=FgwHk1Rdm2xoaad9wEgrQZ8aFUrQMZX8jWivqXyoqjWqf1LrC0dsMYB2bbFplXCk3S
         TZB2u4d9CcGJRpNmqF8qhW1zU+FhWWkG5TPfN8Fs6W5IXlHrUEIfeIqE5ODDcbuNGHM7
         olN+0oklYBeb8UeraOZgJHwL4uiYUiVE2toTJ2bMVKC46PaAeH+TVhEyaQOqvlTlHhQV
         wMOI9exQvlbxHrS4WU7kSriCWWm12YBLtwPcihzVJwA6NgP82XBDgAUb3+ppeSYGRTS2
         CbYgXAnj3cUgj7GaL+KladhNA32B9Z8OQ/v9KjjqFhj6VTV8WcZwaxvrMFPUscz2lZCA
         wzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353443; x=1701958243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSrkKKckYRLH/YiddRVTLirSFys3HSeLYXKLMCjanOI=;
        b=VL/IHDanYtbmBcLv7GojUCvni2KpsDXgEeyIfRPgN31tvLYAFVWbs+egiFudUvfN5Y
         GTS/+1Szvdn9Dac+7qNNsqKn7thifjYGAORyXhP+ufYWxOOo4uZ4S5w9is+ONjoM6soO
         Jv4U7VnFITpVr2kK7IByP/AGf/pUa2GUaSBIsd+Bb939h4bSphLIyUzXJIMAouspIaPX
         JNye7m5iZ36y4Hxxcbkg1SYLB+20F4+LCm2AUkhj712/cSZr6v0EIp8HqdLh0Wt8CZ9V
         42fVMmnMis+SAtZqKhjyK479eWzxP2CsY8pwiSYSAF6osvhCbOn1nPcUR6aVOVu9Qv/i
         TmUQ==
X-Gm-Message-State: AOJu0YzeOZl1fle1Jd4NjkdDteZiqA3sDEFGTcPiQVnFRht9MxVWF+Wq
	jfmyWFuGOY6yzkPO6cDKU/Iaf1kAS9sOmA==
X-Google-Smtp-Source: AGHT+IEgMOnLKnTBE/3XMygjeLxEqAzXNvrNM/XybQ1p/E9xRyt9fHbDUudMgVFCFd+XW97+pE1U1Q==
X-Received: by 2002:a05:6122:222a:b0:4ab:f857:9489 with SMTP id bb42-20020a056122222a00b004abf8579489mr22494292vkb.4.1701353442815;
        Thu, 30 Nov 2023 06:10:42 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id v9-20020a056122120900b004b0317c3576sm193002vkc.27.2023.11.30.06.10.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:10:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/vcp: Fix build error
Date: Thu, 30 Nov 2023 09:10:40 -0500
Message-ID: <20231130141040.2243867-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following build error in some architectures:

src/shared/vcp.c:961:24: error: lvalue required as unary ‘&’ operand
 961 |     iov.iov_base = &cpu_to_le32(vocs->vocs_audio_loc);
   |            ^
---
 src/shared/vcp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index f2c04d184a08..06a22997a95c 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -956,13 +956,12 @@ static void vocs_voal_read(struct gatt_db_attribute *attrib,
 				void *user_data)
 {
 	struct bt_vocs *vocs = user_data;
-	struct iovec iov;
+	uint32_t loc;
 
-	iov.iov_base = &cpu_to_le32(vocs->vocs_audio_loc);
-	iov.iov_len = sizeof(vocs->vocs_audio_loc);
+	loc = cpu_to_le32(vocs->vocs_audio_loc);
 
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
+	gatt_db_attribute_read_result(attrib, id, 0, (void *)&loc,
+							sizeof(loc));
 }
 
 static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
-- 
2.43.0

