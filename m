Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3C1A0707
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260009; cv=none; b=MK07dqMdp9Nb/OGAipEPyNQQfhyW1PI04GVgD/gLkB6mIwKnQ06eOiPajzVtF8whKUCWLPujJcYXfNUDkhSORtpJbOMHBps2Emq8MsYP0IFrLqq1VXkA6QiHLWnr0fYPHsjEr1WPOoXXFgZ3L8u8aEvmHPDCkq8j2T24yWXNVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260009; c=relaxed/simple;
	bh=L3mNlZkdGp4QGU+YY9UbIILi68g4Uk4HBcMd/Ji79OY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IQ0haj39xEx0HVzoG3pVBcTBeVtOsIb9LoumyZxt+jkfnvsacla+igYrx+CVXYarNFhRWfICVMou0xmLM6tPgUtneTydb/RPvujEf5iKu5DeUKI/6+PzuQqozQxBrpcUtf1f/lL/1WsH+ed/T80XlRK1aWEyL5Eug3VB0QKxaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LARtFxpK; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LARtFxpK"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80d64c817a7so1288646241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719260006; x=1719864806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmPLEWtYyCRhz6ou8dHEQKAhNbJiKUURPjD3otgPpMM=;
        b=LARtFxpKZZ2ZWrBhzbaVjKz0GjthrMCGOnajzB/0Is/UlF+PeFvVUMCqKZLq2ssZWh
         AfxwtH/WVmXBDIDG/qQQ5/K/LSimPnytyBvdB2+EVu/2VRdFVtECYjZR93azyF1PUXc3
         oo39DiMiW1F0xuQ0tmzAruCmGY/Tk1PawIVDPV3DweJgSGlv6n5Wu/N9lZj6b4LDvFVf
         pxS21ThXwsLSMAKY/bEot+gPgkbJW4tbdPEFZpIXwCY8gmm7RVAeZVFspH1Z0D57dILy
         MR7ujEhjcj/XUIu6QPTL/urvad7fgTKO4MUOEhIZp3DcABDqcAYUp12y3xLWC7ubBumq
         s2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260006; x=1719864806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmPLEWtYyCRhz6ou8dHEQKAhNbJiKUURPjD3otgPpMM=;
        b=OZ1unOgctWE93/LA2nrepncrPxv0C19ymljwi9Z3bnDO85U/Ejfp2oRf0Eg42u/u9e
         1spxGdL3QMnG32DBisaVo/C/Halcy1n+/AD+H9XI4eFcHKQYiEjTbWRF1Spc9BTSFpk/
         AqHNC0ResmLiT8jO87nBsmtloSz7IaNgmY03foORSZNcOrK8U27TZ0/zaeuvg64uEVlr
         3lSNH4/x4IgbWf1dny8aVF/J+bRMdVLERMHrLDYQAhCyeTG6hJxvX9CVuslApFHWLqSE
         BxApr0FsyDE+fWPz2/5krbrpFYoWMUndPCVolX4HtKJl1J0HVXoT4p+I4prusU5l7idH
         /tUg==
X-Gm-Message-State: AOJu0YwErMwYWpUuMDFD4QhbLACm9I/BNLJgx7MA3geTxFSgWipMtx87
	pSYe+yEi1MheWhKOzLWL42BkIluSO18rquPQoHHfEpo65YgWwWvPvPQbTvid6FA=
X-Google-Smtp-Source: AGHT+IEtWjyveNIzGy90yQRdBZsu069LG7VujxBK+XcA4g9rS6XjA7YDXN29cpmM68GpbCl6vyvn/g==
X-Received: by 2002:a67:f349:0:b0:48f:417e:a03b with SMTP id ada2fe7eead31-48f52b1fea5mr5444285137.28.1719260006035;
        Mon, 24 Jun 2024 13:13:26 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48f51d72ac1sm917481137.4.2024.06.24.13.13.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:13:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] hog-lib: Fix passing wrong parameters to bt_uhid_get_report_reply
Date: Mon, 24 Jun 2024 16:13:24 -0400
Message-ID: <20240624201324.3891633-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The parameters of bt_uhid_get_report_reply are number followed by
status, not status followed by number, so the order needs to be
swapped.

Fixes: https://github.com/bluez/bluez/issues/880
---
 profiles/input/hog-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 67a0e832dc98..1b4aca07486b 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -904,7 +904,7 @@ static void report_reply(struct bt_hog *hog, uint8_t status, uint8_t id,
 
 	hog->getrep_att = 0;
 
-	err = bt_uhid_get_report_reply(hog->uhid, hog->getrep_id, status, id,
+	err = bt_uhid_get_report_reply(hog->uhid, hog->getrep_id, id, status,
 					data, len);
 	if (err < 0)
 		error("bt_uhid_get_report_reply: %s", strerror(-err));
-- 
2.45.2

