Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E033B6EF
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433647; cv=none; b=bq+xSL0K02Cjp4b1tRicTpB6EkGb8B3sVF269rdi0EiKSAzhTCjT+gE0VpYM45+j9r46KPFvHymsVeZ1qe4+my1t56k1SCy/iA3r5+rAd1UZ+h4+5dLN3dMBga86vOSGXajBFR9jYR2Xtj1EXy8NzXaXPjfqZ4bkwdhWeeZkfP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433647; c=relaxed/simple;
	bh=dT2QpKz/3buSy8vB/Wept2jMCgV2t/Fjg1GQROnCjoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c32pmsqbyPkWektWyaOojGWl1bF0BoFR//bUCFOrhklsbzjKMGsiHo5a38oDnQiK6JXOJLe5Ww4mAhqg76ILyANAbxSgAPx8Z4mD0L+eLJB7A1ttfP9FJrWqcvNcRXJ79v0wcXXOx6QeRfpAsDeZEq/2izc0mMaauJMPkbhz6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKIwXorL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKIwXorL"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3387992a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791433645; x=1792038445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXIleF80V9tD6g64hmF4dQJNHIEL3vW+DMhKPhWaMpU=;
        b=rKIwXorLeCc9yujhCSQgqbQNz5kTwD3FihXFMCCJA9dzgon5GMvAY/AKMq0Ykb7dwE
         enp5V+2lxV1ZzhkraTefYo937CL3FnKH/0N/LaCgzCRH2bhZ/9yU2HJV27PaxSjg2sS3
         2a0a1FAMYa+CLxVe4SiS+6elzpyBHuTydsJ7aB0sSUB2wnvM4PNd/CLyR7w75G0CqHue
         rEnWo+l0HnaOid2zv+jdzQ3h9S8vq5VHjdVNAbB7maUR3PdeVV/67poWTMDyZdagybUQ
         Lu0h2uOnu8cBgFXWV8LMQrOFXEV5ICSyopHwK0sVER8g3iWrlpviH2drKh69RFb6uSeU
         L30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791433645; x=1792038445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXIleF80V9tD6g64hmF4dQJNHIEL3vW+DMhKPhWaMpU=;
        b=w1IcZcD8eTnd1kdyy5fWEar3c6PogdGd5ltn6h0K4wKL6wLLjd5UWx7h/9AlkKdN5b
         0mqiDI3rbnUaInm19UWcsz4EbO0cOohpcTpy42iFJkkKVdscToG77LIQTaWsQvcpPnkt
         XOpUYTdoalOQeiiXljlXEWwTDAFBrQIi8KtagP0veXAjgWGS/DeVugd3mu6AM6V2Q72R
         fddnzkRCPd+4m6GnrDh1NWPnuvP1KNXzog7h6VduTWqFz7MTaWka9WKVhQncX5vRPidC
         +cW4+7w0fbH7waEVheHCz+wEZav/qvci6D6TlO03eYh3kHYnIu3DxvCP/zJuvLZUZ5rw
         1cXA==
X-Gm-Message-State: AFq9FYIKWLGF6kvQg1TuMLKm5ankqKuZ+gcYnsym5TlnHxa5PYdeCttP
	Oe4WxaKBVUSxdzncH7Tr2nB75//mP0zD0G5s/x9ifZL8P/1kV2VUAqwiCHAvnFMl
X-Gm-Gg: AYBFou2RPaJ7sJyCGjFhveBWAPr1Ly4u7Q5Tp1EfcCWFZfxx79pWUPC6urI+XxTATKu
	vP1yyatQmIDekbFZy4+tnnKASEBiOg1OoJ7jr1jSg8H6pfb7TfZXj29lwsNyIJ2nJrF6Lym76Fx
	tSgF4fPn/tIcCGWPcx+eS4A1NCzLAWmZj2ZVMHhzvtQWtj2sNunEtYp1Vsa1IT4vC3fZ/Q+LK+N
	viZdV4eCrXfz2ceHQBs+Pp+MuCkvFzHByZDIBwvXZrwd2kjIFV43JXqx5PePs4iI4AEdAvMoErz
	+w5rm/PJuZEFb0rznqDvVqeF8Q/jg8OrIKl+ywGoZvEXQCl1QS0bU10Z3ODKsQGyR2eDu1R6ZGC
	9+M6AHtV9hpussCKdn8fxTOQTILB8zEzPs4KFlFouBYFpCacmFDObBI78fnbPcbxDGU8xZe5IxA
	9MjRilfyI2mZ9ZVxR+VqCzU1wr3ektDx3wwrxTKEB0kdFHjBo238wf58gB8Q2DtE1FLob23npNk
	u7Dchd7ehyp8bcRPvZbX//3k6eKhFPj9PqfJIB/wR8Bv7urYWaZt++t3cHgxPwssiJAiTu3r6sC
	2u9yawnlsQ==
X-Received: by 2002:a17:90b:3912:b0:3a4:aa26:21c7 with SMTP id 98e67ed59e1d1-3a8a1974b40mr4063197a91.25.1791433645070;
        Wed, 07 Oct 2026 21:27:25 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1bfbafasm2745439a91.11.2026.10.07.21.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:27:24 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hovold <johan@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] sdp: Prevent integer underflow in string attribute length calculation
Date: Thu,  8 Oct 2026 04:27:20 +0000
Message-ID: <20261008042720.3134391-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lib/bluetooth/sdp.c, attribute string length calculations subtract
sizeof(uint8_t) from d->unitSize (e.g. d->unitSize - sizeof(uint8_t)).
When d->unitSize is 0 or less than sizeof(uint8_t), this subtraction
underflows in 32-bit integer arithmetic to a negative/huge length value,
passing invalid sizes to memory allocation and length extraction
functions.

Add explicit lower-bound guards checking d->unitSize > (int)sizeof(uint8_t)
to ensure that when d->unitSize <= sizeof(uint8_t), the calculated string
length is safely set to 0.

Assisted-by: Antigravity
---
Changes in v2:
- Cast sizeof(uint8_t) to (int) in comparison checks to fix
  -Werror=sign-compare compiler warnings reported by BlueZ CI.
- Refactor length calculation blocks to use clear if/else guards.

 lib/bluetooth/sdp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 1e027f9..d31463b 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -730,7 +730,10 @@ static int sdp_get_data_size(sdp_buf_t *buf, sdp_data_t *d)
 	case SDP_URL_STR8:
 	case SDP_URL_STR16:
 	case SDP_URL_STR32:
-		data_size = d->unitSize - sizeof(uint8_t);
+		if (d->unitSize > (int)sizeof(uint8_t))
+			data_size = d->unitSize - sizeof(uint8_t);
+		else
+			data_size = 0;
 		break;
 	case SDP_SEQ8:
 	case SDP_SEQ16:
@@ -1523,8 +1526,12 @@ static void *sdp_data_value(sdp_data_t *data, uint32_t *len)
 	case SDP_URL_STR32:
 	case SDP_TEXT_STR32:
 		val = data->val.str;
-		if (len)
-			*len = data->unitSize - sizeof(uint8_t);
+		if (len) {
+			if (data->unitSize > (int)sizeof(uint8_t))
+				*len = data->unitSize - sizeof(uint8_t);
+			else
+				*len = 0;
+		}
 		break;
 	case SDP_ALT8:
 	case SDP_ALT16:
@@ -4852,7 +4859,11 @@ int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
 			case SDP_TEXT_STR8:
 			case SDP_TEXT_STR16:
 				vals[j] = data->val.str;
-				lengths[j] = data->unitSize - sizeof(uint8_t);
+				if (data->unitSize > (int)sizeof(uint8_t))
+					lengths[j] = data->unitSize -
+							sizeof(uint8_t);
+				else
+					lengths[j] = 0;
 				break;
 			case SDP_ALT8:
 			case SDP_ALT16:
@@ -4929,7 +4939,10 @@ int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
 			case SDP_TEXT_STR8:
 			case SDP_TEXT_STR16:
 				val = dd->val.str;
-				length = dd->unitSize - sizeof(uint8_t);
+				if (dd->unitSize > (int)sizeof(uint8_t))
+					length = dd->unitSize - sizeof(uint8_t);
+				else
+					length = 0;
 				break;
 			case SDP_UINT8:
 			case SDP_UINT16:
-- 
2.47.3
