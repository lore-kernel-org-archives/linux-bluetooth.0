Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FC35EDC3
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608693; cv=none; b=kl9bX/xfiTmFLB/vMJ6buvlz5xPxM/yF+eRi4GVYM46rKqvzLWYt+66ffHPRuvtXXbb2H94eLtVXEOIU1SsSCjzusrjiapYZ+4hLePTStTneava4ZuBTjO8gbGsnjpQmf1Je0cf+yZOKLcf6EuC/XF/h3vxdKp3vMcg+E4g5ZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608693; c=relaxed/simple;
	bh=fuUQdX6CZRNZEMmwOUyrN7ojoLw4NDfO/mVJ3T02KTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aMXd5gBhAwOIkns26y8eu03UoANJzE3kuFQ5nwmhO+94kiGIJalfv2rRiaiMH43CgiHVVUymcbULuTetkawwX381OgtTN5p6A1l8QiONqI1NAdZcNKAQWPBoE7YB22qtv5QFG5B6aTvHXZqZsXGYui4W4AGPgljR1GlxqpZgNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs9meRe3; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs9meRe3"
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-567606e16e7so2165386e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608690; x=1772213490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgpWV7SaCAkmBJJvYVr1KKBvX2KdlgsaiXoeBQcaWzg=;
        b=Hs9meRe3KwgEfq7+5Kdhceb+EtucESvIKPACg/Ir7ROh2V3WiO287dOFjvNKOyawSd
         ZIfZOKveKcmS5d6B3pjGZwsve8W5Agm0bZ7FwOYy10w59nZ6ZK5QEle4LLI85A9Dorqc
         wAgO25uZCtKZZNkvI+y+0O9Jc3EaQh/0EV1gf6xno/lfJhZDu7ifIJR6nQ9FdOHDwTk7
         xcwnhAYHL7uyu4koVk+J4k15i9a1TRHbzn7RGiBlw3A9leK5aIjN68fv29LHhDe5eLK0
         +dd7fOyCB1DESNjoEhvCo66TlFycyI4DxXBxElUluFGREgYjavCewqkoygyODqnN1OVB
         sTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608690; x=1772213490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgpWV7SaCAkmBJJvYVr1KKBvX2KdlgsaiXoeBQcaWzg=;
        b=V+UYmKLTuysSZfkoJszlbKCt6aod58aywtjSEiSwq+62n2ncXIzsjdfwnjIKfudMRS
         07lFrnNuTi9fuM9Pdialecgf9qbxlzVlMavAgCD1ffuwjaM6DBUWU1LuB2abPJWAVP8k
         zELLDkpSv60yxxpTmHk8N3Wb6cdRFsjht3sOLJUY9KBLFx9695wOAdQ/BWkA8GzW3rIE
         voMbED9WOLuNxByk2+EJ4kJHY/EnIM8gPDiRTHKRvPQCnODzhMpTOvV+bhvuTjOByPG5
         Jv0X6xNXM/Q37KHYmJf+XrRDo9RBXTDQcthiNyT89lS3onVCn/CXuvbAYMeA3+vbJcr7
         mdtQ==
X-Gm-Message-State: AOJu0YxN/k8+Osiwh/XYqrA8fsA+VqVUwM/dKka6L5tTP6HPWoKk5svD
	YFgz2xZVmt2UaqDqvFDQPH+bLNMQTtTiFsWTJcDUm4rp/ifVYeN859LxNDn0vjuJ
X-Gm-Gg: AZuq6aKgnmkO//3Xp9c5IMxBS0kxxc62gHn83RX55tWAGeRVarAZruK6jIQiCn2pw3d
	xre5rH3qs/LT0Z8c3nPHLakikjXqSTxNdCC9WofjPHkTPGwYIhwzlWB7SeXVdxZj7brMlWYhKJg
	QoeQEcchhjiy+WmRdbFExx8c6wlUrzLGb4hK/IIYe2xDpQWNBaPYVnKb4BvSE00FE7SXufov+RU
	MQILnYPtct8hJhoac/a7Vxj3/VW95O7zqVrFiyqC+QMSWEDZ/QGHqk6l0PHM3O5mckpyIXsOQHL
	64fnlMDpwDLH1hdKMEJSgmVT+lkd6vOw/q85zSUj3Gyy+dXt9eiQwjTLegv2a+HKgL9J6NmIfyy
	ZmCJpiEU4YJFBhJmECSMbngKjwUkY3J+KlRtWe7sFPQYo91u1w4urW9cHVpArutglfClpIygzpX
	mYdtyT0C7umxCvefIQ/G1M2sUXq+v4RZPdcb3A9CB8N8A6h/iDYzkgcPmurxlasGW/CKvFBujnM
	ZYm5Wu6Ev6YBv6ODg==
X-Received: by 2002:a05:6122:3387:b0:566:2568:df1c with SMTP id 71dfb90a1353d-568e4783d07mr319518e0c.7.1771608690033;
        Fri, 20 Feb 2026 09:31:30 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/12] doc/btmon: Add missing documentation
Date: Fri, 20 Feb 2026 12:31:05 -0500
Message-ID: <20260220173120.3418666-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing documentation for -I/--iso and -N/--no-time options.
---
 doc/btmon.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 11d98a93b4b0..e51001921ab1 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -84,10 +84,15 @@ OPTIONS
 -T, --date                  Show a time and date information instead of
                             time offset.
 
+-N, --no-time               Suppress the time offset display entirely.
+
 -S, --sco                   Dump SCO traffic in raw hex format.
 
 -A, --a2dp                  Dump A2DP stream traffic in a raw hex format.
 
+-I, --iso                   Dump ISO stream traffic in raw hex format. Required
+                            to see LE Audio isochronous data in the output.
+
 -E IP, --ellisys IP         Send Ellisys HCI Injection.
 
 -P, --no-pager              Disable pager usage while reading the log file.
-- 
2.52.0

