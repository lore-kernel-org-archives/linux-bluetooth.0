Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B092FC038
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873093; cv=none; b=hqHv7eZvNv2p8OBFzobozu7aSBd7blmCM/UeTio6DBK1ZOEyEe6Oz7hcW7DIgO0cM2gKgdFFN3A3IC/328MghiwxDS0WeElz2OMrwGFgWSXpu/cl3f01swEK6ucYm9R9f5Pv9ew2uUNtufG9JyPW7r9wdb6zU02O1a9ofYglHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873093; c=relaxed/simple;
	bh=Wqqwmh03qxNpQXaczwXS5tpuv5kqeDDZoY2p1EdqsTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4DRXDn4w9jFFosTYdwZlBzJVTetnafB2c5+TvHQKlGzhmceFZLyD5oGBlavD5YTahaNcB+SI+L/B3ALpTKKTrszo8+1nduplrIYx1v3nZkg8YKKxubZese/aDX0qhRqpzaClL+yyRl21VfOcLROxY7Z2w75XZ1tWrC41Ttxkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukx3aVe6; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukx3aVe6"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-55b2a09ff61so394565e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Dec 2025 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764873090; x=1765477890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ylm1zupFMklBHwtioCi90QvPxnT31gNX9Qln//rxNM=;
        b=Ukx3aVe6Ffv1Pgn53QsLIP6u+Y2ApNSV/G4sLy3pkL2MTm507cUB/StjOnszdWUrTd
         qEHcwXfxs7lyS4js2cAQ9PdWaNB2+9ETCxKXTafWu+Y43xUrhrwa2B0LZAbePv7hifDw
         RjS3OU3TassDJ1eRHvQo19MB+KiPtbl0JGG/nopwTZF9h0llt1aJ9zJFPSCdIEj3Z1ZT
         CQMuuorB/2L6uY6sWni5GawCN3O26VnBXwRRr0/8DY1zbpAjHqNXFLXk68sD38CxvQoF
         VTthgCqr8Jw+WmcP58V1bswEWqbbP0wCfKxfSYAks46uJDZZ3MnetRzfijDTwWPq1G8T
         FlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873090; x=1765477890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Ylm1zupFMklBHwtioCi90QvPxnT31gNX9Qln//rxNM=;
        b=QlsfZwPgsWORdOAUdJ1oWMNsuVVZ+P3jpgNF8Tw0gR/M/kzsSvDi9zHdEvl2ORpxiZ
         5D66e43H2U5ZYlPigt7ZFi582AAPhtwif2uTz+rjruoofOo6CSTNg4fVLsLZWMvrlGOF
         h392uYl15QJ/7FY6MChIv9ZiiVWmilAWlwjZZuRZmBoxD01zqZRS5nxlIGBB3hBLSV58
         4043ZiFJxWCda7SrFf7o5wWzoO5YaEeqT3axK2509o2HBmwRjfkaJ/H6LJtiylWj5yyp
         GZAzpENkfR5mspZ9ZqEwZqu9V50gKSHce+3W9RE+KsTQQOQ8o3t87s+skgb7qxMChj/R
         /hMA==
X-Gm-Message-State: AOJu0YwJ4bigMCP1Ra7b/UnAocAOjJrKI0dxnLR7nPCW18DSX72JCQCh
	yZc7Pmpl+juJ5OTRh1HgOMfrAJWUR6Gwv3kkytDZTJP/Sb9oHqoyahj+/7S/vw==
X-Gm-Gg: ASbGncvWrv2HizWWX5OhdEK9cxM+j//vV9ZQZsLAoSrpZJD6OS9wZgokVKO0PylYb55
	ll8qV/ZHpgRUuw/mowz6trAfbx4DOKJI8lQt8JabpCr3zl4ZkzP81z7RAiAZ4KnBTVfBTh43XmK
	aFLwgR38JXbHS+yM5O5Xjf7AtWUQ0aZDucJLegLHpCLDleVpj1glOP/Ehsf+xICwRNvIvkA2yfF
	+i4iRqnPDLhF0kD/cu8qEm1ZtxCnVbzOb4ACZP0E1z0PhK0GQoiciU9X/RRbyDGA7TaYP2GPmeE
	gD4fmtBhIrgYIezIG+tCmS1GlMNT1FajJnRjjnqSynlUEm77NwxFhQo3dDCZsTHwzWMcW8Z4kD5
	F9XpK6b9vjxBkZZDjEs+E5Ti2lxc9bcZFYmdMRUZl/CRc15f630gqvsyJsn2/Yh11KbpCNUVwfD
	c2ehtGwCM/GNw2Jg==
X-Google-Smtp-Source: AGHT+IEdu1dgfcrgJH0KcYK6Ql1z1cnvFanOyTpUHM6Pv8drPoikJd8p0VBqKWa2h0R+GJ9Fq1S49g==
X-Received: by 2002:a05:6102:d8c:b0:5db:3b75:a2aa with SMTP id ada2fe7eead31-5e48e24e9e0mr2766813137.18.1764873088670;
        Thu, 04 Dec 2025 10:31:28 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e510808c63sm1009520137.7.2025.12.04.10.31.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:31:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] shared/bap: Fix parsing of BT_ASCS_METADATA for multiple ASE IDs
Date: Thu,  4 Dec 2025 13:31:15 -0500
Message-ID: <20251204183115.2533504-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204183115.2533504-1-luiz.dentz@gmail.com>
References: <20251204183115.2533504-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_ascs_metadata is variable length so when there are multiple ASE IDs
each item needs to be parsed according to its length otherwise it would
cause issues such as bellow where the ASE IDs is incorrectly parse:

> ACL Data RX: Handle 2048 flags 0x02 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x009b Type: ASE Control Point (0x2bc6)
          Data[18]: 070201060302040001050206030204000105
            Opcode: Update Metadata (0x07)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x01
            Metadata: #0: len 0x03 type 0x02
              Context: 0x0004
                Media (0x0004)
            Metadata: #1: len 0x01 type 0x05
            ASE: #1
            ASE ID: 0x02
            Metadata: #0: len 0x03 type 0x02
              Context: 0x0004
                Media (0x0004)
            Metadata: #1: len 0x01 type 0x05

= first LTV in the metadata is incorrectly used as ASE ID (0x03)
src/shared/bap.c:ep_metadata() ep 0x55b1f428d490 id 0x03 dir 0x02
src/shared/bap.c:ep_metadata() Invalid state config

< ACL Data TX: Handle 2048 [1/6] flags 0x00 dlen 15
      ATT: Handle Value Notification (0x1b) len 10
        Handle: 0x009b Type: ASE Control Point (0x2bc6)
          Data[8]: 0702010000030400
            Opcode: Update Metadata (0x07)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x01
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
            ASE: #1
            ASE ID: 0x03
            ASE Response Code: Invalid ASE State (0x04)
            ASE Response Reason: None (0x00)
---
 src/shared/bap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 27321a3d1e3d..b5840d18a820 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3508,10 +3508,12 @@ static uint8_t ascs_stop(struct bt_ascs *ascs, struct bt_bap *bap,
 	return ep_stop(ep, rsp);
 }
 
-static uint8_t ep_metadata(struct bt_bap_endpoint *ep, struct iovec *meta,
-						struct iovec *rsp)
+static uint8_t ep_metadata(struct bt_bap_endpoint *ep,
+				struct bt_ascs_metadata *req,
+				struct iovec *iov, struct iovec *rsp)
 {
 	struct bt_bap_stream *stream = ep->stream;
+	struct iovec meta;
 
 	DBG(stream->bap, "ep %p id 0x%02x dir 0x%02x", ep, ep->id, ep->dir);
 
@@ -3530,7 +3532,13 @@ static uint8_t ep_metadata(struct bt_bap_endpoint *ep, struct iovec *meta,
 		return 0;
 	}
 
-	return stream_metadata(ep->stream, meta, rsp);
+	if (iov->iov_len < req->len)
+		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+
+	meta.iov_base = util_iov_pull_mem(iov, req->len);
+	meta.iov_len = req->len;
+
+	return stream_metadata(ep->stream, &meta, rsp);
 }
 
 static uint8_t ascs_metadata(struct bt_ascs *ascs, struct bt_bap *bap,
@@ -3557,7 +3565,7 @@ static uint8_t ascs_metadata(struct bt_ascs *ascs, struct bt_bap *bap,
 		return 0;
 	}
 
-	return ep_metadata(ep, iov, rsp);
+	return ep_metadata(ep, req, iov, rsp);
 }
 
 static uint8_t ascs_release(struct bt_ascs *ascs, struct bt_bap *bap,
-- 
2.52.0

