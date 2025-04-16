Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FE20DD48
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819487; cv=none; b=kmE4Cn777ZC1eFMepw89Znu975MI3HKTWHO8tUK+DyZFTlrzEykXIU40p4iVNYvdlSBwT4VxwdCnhhS0uvibL55rw81KLAXfILFIc2JWOM8G63NqYly9JSqnXIEXzmSbU4l8QHSWXupn/BsiSPR1g5dvS0vSyGBiNpkV5UkRcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819487; c=relaxed/simple;
	bh=L3JCkH3UOERCddVJK7QZMFBci/1m6FwhSUZ3on3hKJg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbBpIWUdGuOEuhTRqp5fHiz7q2KOih3IfqHo1zRYp1ANyIAS2ZCT2zrGoebJ2kAAQxijn0E/TnrGRdP+5AV5diP4kepDOakneYG83/UL5KdifIohnH2C/my//hg9tFUNTAxMB/L09RcLp0CLBSvfUaeqc1CbrQvQ+AvDFhP5MAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9LTI1Vb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9LTI1Vb"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c3407a87aso13922085ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819484; x=1745424284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuX4QN1XO5qkD+Mq8ZB4etY5v24jEcjvNl1G0WRpx40=;
        b=g9LTI1Vbcpd9FTfz1XJXzCXe3kseLf9pilp55YLV08gDHJ5BhzSc2a1NC125WnenhL
         YbDUqLzFlrYXJY1Ho6e4ZWn3cFN0pu/m6uBjix3wNG9BocdDi3zjvqlmMSCZ3ovTyk6U
         I1YU+6y4k5VdJafcZcNzNVf8+hiPdcfb9J3BHx5yeCZVJ70OPClpaIRQQNU3aDNSydYn
         bxv0nAXcVVFV4siv2Xv8okIiOCkTlvRl66tbewmPBUj4Nt6/ntvnSOFbigTk+706ieIR
         uvZKEuYU3wMhV935GOb5i1UvOOf/2db7L5UB8HCXmNIMIf1r8ts75TmVJAotKrdwFkCY
         mRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819484; x=1745424284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuX4QN1XO5qkD+Mq8ZB4etY5v24jEcjvNl1G0WRpx40=;
        b=No8DpNVi0zc+vf1Lmr6EXflhNu1hJAcXUVr3/nEYb3JyZEuZNkdwc8VpIMwlkFXJET
         OFSOBNatEeejWntiUJ1IpDjHIp2np0zfw+6B/byCP0ZZdsLoU+cu+FGc4Hy8zB/V3fMk
         KpYziCIHZPGs1JjiJu1NDlQS8qgAffiuTjmYT3856Z8FlH9wR/KiaomvQGCt/7l0KD9V
         gkp3/PLD4aJOqXc7a1FndKU+arNkvBUV2BEVOUyGYnYKZqLL6XMG/O8d9EG3/bw66ZVo
         N6LidWMNB01MXgJI6g5OXgb67SH8B1X1o1iaTzOppx2tKTyBvw2n0FmuEIk0veWHnFvQ
         6e3Q==
X-Gm-Message-State: AOJu0YxpTl4xkBmXWCanhp3x7FIvd3PuMy8LBL8v4DjWZk3ISHtuKz6K
	JR0qhz2v2IFPxdkIG3bHA2Zl5HsU35aRSBSOMFvJ+CwGHD51UKYgIRo/sDy5
X-Gm-Gg: ASbGnctZA/be4xbV0EAuzHV6cQadg0bF7hlzQOYi3P/EEtWb3GB1s/ryfy4u3kJI+50
	R1MjmhCzR6bew2CS1S7YScSTIQs6S6AAeYt/nzbfIIsD1I1iSL4b4j6SPeDs+w9RgMuU5x2kK+D
	+lJmATuF4RDGAFyHhH1/67fpunxJVcHu4xDR6VRMaxr0oeoWa6NvD17aY6hu+kQkxbGlqpta6Yy
	1XiFcHpnHyfwxq3EAXtmdJqQkaYN+Y9mNJOUml/rgoPGhS1fUq/Tgkb3HyUd/RZpuz+Mz1QUWgv
	xd58v7YiPs0z/z+y3etcGMzyBue3mYs0HqXgbNrtyp2fSNuLdpNXXJ+MofCIb1qNq7u+3AeTb67
	lhjwzM1BuJVOmK3GNEbQu
X-Google-Smtp-Source: AGHT+IH2mZQlb6S/w6TxkjZbUxphnThU8XZ3cfchXs7VruclBFcGtnWs/LOP3h+su1tUNUK+7dS+Uw==
X-Received: by 2002:a17:902:fc86:b0:227:e74a:a05a with SMTP id d9443c01a7336-22c35986066mr43926155ad.44.1744819484372;
        Wed, 16 Apr 2025 09:04:44 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98afd43sm3094029137.20.2025.04.16.09.04.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:04:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/7] iso-tester: Test getpeername return SID
Date: Wed, 16 Apr 2025 12:04:31 -0400
Message-ID: <20250416160433.1822263-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416160433.1822263-1-luiz.dentz@gmail.com>
References: <20250416160433.1822263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If test is not setting a valid SID (0xff) use getpeername to validate
the SID gets updated.
---
 tools/iso-tester.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index b362647461c3..63f6951e3d0a 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2575,6 +2575,40 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
+	if (isodata->sid == 0xff) {
+		struct {
+			struct sockaddr_iso iso;
+			struct sockaddr_iso_bc bc;
+		} addr;
+		socklen_t olen;
+
+		olen = sizeof(addr);
+
+		memset(&addr, 0, olen);
+		if (getpeername(sk, (void *)&addr, &olen) < 0) {
+			tester_warn("getpeername: %s (%d)",
+					strerror(errno), errno);
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+
+		if (olen != sizeof(addr)) {
+			tester_warn("getpeername: olen %d != %zu sizeof(addr)",
+					olen, sizeof(addr));
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+
+		if (addr.bc.bc_sid > 0x0f) {
+			tester_warn("Invalid SID: %d", addr.bc.bc_sid);
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+	}
+
 	len = sizeof(sk_err);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
-- 
2.49.0

