Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE34470EBD
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000453; cv=none; b=ZCS4IM2XJZ9q7gctPJ+ey+stsXzYNPjyxHxATprAh0W1PlPXkLTaXU1bPyCAw3+HPpkabjISq43DkjPXNoI0xzd7w/JN4ydoT+/P8cH/dGOPnTATGIiIOc/+t+4bevX3kvwq8xPDGiMNvrin60GSnSfVU0POCLiVBiZH1Q2XLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000453; c=relaxed/simple;
	bh=fTQWt/pnrfJ+bvL+vgKtO2xn2nougNw77jFu58NBuU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l91FtGm9VT5rWCfvovtsLvSbE5KtSsOaV+6xix5JSLxwYkGTLGjvT15LsHlECvn3K7kFmXFwyetFpfcmhD3cc7HFiEA/PtkaHrWPshiigWaqX6d3Hzo5v5/cjG8gq8I6MYtJhQlpNn+Z2+AZ6ZULabt07fT0ly2t4v44GzL2xU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM2+ZrRM; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM2+ZrRM"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9696319e14dso1193688241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787000451; x=1787605251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N9XllhlYJq6h/HiKT2Q+7HaFOp3lEdX9oujAdfynaxc=;
        b=VM2+ZrRM5wZPZoJWAczJ6yy2pEyb8v4z7TQDwMYw1SUEEOPtdx4MoOPzHQ0ejoF2oo
         IqKX9cTypFNy06I97EuF71wU3xJkgfRCsbRkwVR+Qw5+TqGwGrKpdz8GpJ799ufWn/0X
         Xlehvb/qPGFO6pia47gy7VWHyhhGo+3zy/tRoZ9bqapKWhuj9Q3EsjnckNWVMdLlCA/7
         wooLv3dqt5HbA39/c/BApDJmW7CrXvxziXHbEQXD1pE0jtyJF0mpsUF6mVM5Bopq8RL3
         XzWEYKI5Lc4CzdbxJdO9Le9Wn9dVT5JrBGKPveozbpWry8FU+EzF+2JqmwgGn5FKolD4
         oAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000451; x=1787605251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=N9XllhlYJq6h/HiKT2Q+7HaFOp3lEdX9oujAdfynaxc=;
        b=eFJra2JbWOypu8UM8MRw+W82Vo9PEZE9p0hk/8pT+Z/QCZwCG+Pl/m1Ii2HpY+r3ow
         kyE734kyE8ptYrH9goqABcJzt+SWaQAR0voXKniAQDoNRufLcA6qUAQJGAehJpASfzLp
         0q6LYZBN+Yinc4KMwCEsR1KvruRVL4BbiCeUMPXFFQm0CtIMjDocnFVoXUYlnHb5qeHo
         PWBY768bCIyCykw50uOQdA3Rj7m74KGmuegBDwNyLn8MeAa+hPMu1FLx/EFH50vhAVrP
         SpLqqZI9nFDYPnJla5HITqF478L2l73R5gSi1UxZCOHWJTihPj45WJCfvZO0vQ1slv2u
         T+Dw==
X-Gm-Message-State: AOJu0Yzi8d+cZC/P+6CBocvfwEeE6Y0zkuo/aCxixEolZn4e23ibLCNw
	/h0dPvrLscEgdVSaZemiDuvzNUHkD/ec6P53DIvtIXMSCk4C7hvGTVPnEEWsviIO53DAZw==
X-Gm-Gg: AR+sD12bwVbiDo985x5+TXJGyD6FPqQh7+Dy/X0+1fzKpYMBEKQJHZCXceQiPSHBrS1
	gBNF+VgrKBRkPaAqsVrclyO4LOPJYLxoeWG5b/ncNIqtAhFmCg0BzQtLXavsNiiazvBoizzXIkj
	iwQBm6caZqATCrQop+aEz3n5Aem5gDLTP6RSWLVdrHaAh6O/wfvgF2QVS+8pdrmottgb5zEafU3
	WOz4M6OBj7+8+/eVMvwpRVCBLy9x2xMChXEdQqcHr+7btkp8LbIvxR3YbqRp4L3dCwchyoO5rGI
	So5eBH+hq8ldnBB0sNVQFF8QK9plUb9a+3wmzSPFNiAk6Xywdsk82uCO99M2Ss6iDUuQfM7OIEM
	wmicpjydNhdET6UMffqv3tNaj3FvJsLTk5uKCgipQAZT6+D81JwFxSMqrBuP1EWGYNfhiQ1JFj2
	GTwvamxuh8XpIvG4SQZanUQkuMiDVwxWUyeyzjxGivpvhO9JpLkee+zLYcFTpXt1nGfi+qLhdRP
	t4gULj5VVCcy2BSUMWHP2HvsIosDmD18vcuHAzGYZFmBubRQ0mz47uI
X-Received: by 2002:a05:6102:a51:b0:6d4:ba3e:bf97 with SMTP id ada2fe7eead31-7747c5caa46mr670094137.4.1787000450526;
        Mon, 17 Aug 2026 14:00:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c2c29e934sm2121511241.3.2026.08.17.14.00.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:00:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] sdp: Fix memory leak when freeing alternates
Date: Mon, 17 Aug 2026 17:00:37 -0400
Message-ID: <20260817210038.1839617-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817210038.1839617-1-luiz.dentz@gmail.com>
References: <20260817210038.1839617-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

sdp_data_alloc_with_length() stores the members of SDP_ALT8, SDP_ALT16
and SDP_ALT32 in val.dataseq, exactly like it does for the SDP_SEQ8,
SDP_SEQ16 and SDP_SEQ32 sequences.

sdp_data_free() only calls data_seq_free() for the sequences though, so
freeing an alternate frees the alternate itself and leaks every one of
its members, along with anything they own in turn:

209 (48 direct, 161 indirect) bytes in 1 blocks are definitely lost
   at calloc (vg_replace_malloc.c:1678)
   by sdp_data_alloc_with_length (sdp.c:350)
   by sdp_data_alloc (sdp.c:486)
   by sdp_xml_parse_int (sdp-xml.c:243)
   by sdp_xml_parse_datatype (sdp-xml.c:421)
   by element_start (sdp-xml.c:507)

Free the members of alternates as well.

Assisted-by: Claude:claude-opus-5
---
 lib/bluetooth/sdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 8c0865398519..1e027f9ebe6d 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -972,6 +972,9 @@ void sdp_data_free(sdp_data_t *d)
 	case SDP_SEQ8:
 	case SDP_SEQ16:
 	case SDP_SEQ32:
+	case SDP_ALT8:
+	case SDP_ALT16:
+	case SDP_ALT32:
 		data_seq_free(d);
 		break;
 	case SDP_URL_STR8:
-- 
2.54.0

