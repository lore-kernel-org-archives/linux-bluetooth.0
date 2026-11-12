Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515617;
	b=lxL33v9UvOWp5284FdzVtHlHE0nzQDRJg3xzhHywGTd1IsWPd4e4kaeCHMUgOVv3yHMV
	 kUl57l6UsfAsPxZUYsMNehZ5WlsBJzbVdCqMUnIZkZ57CTdOlaBKe9Xj8ggG+6Wn7+9HS
	 cwWCiBIC7+fxefBTJGPJ3inTmns1ztHhyhsR20f99TJkhO7rQ8vOSbIo2qas4BR8uKGp/
	 oN6HbGdlFSTwSHR3qgfwRGLdstFRPzMAZlJlme9vZnDFuhf8PpSjImEcuTsHSBC9XVj9L
	 Lgh0PHkHzPysT26TyGvoWM4D6iwlpM+nUNfB9cXdiIiafQMWYVsVZMrCRkDHKJGQZBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
	b=w0e5/fIepSyNcedEXlC7e0qrMlW0VAlg9LmWLQttTF77Wj4E6qANun68aW3YaSLzaSDl
	 ZQhlKa9UwMGwk7JeEWgKs77F8mqssBb5m+4+Crc6l9KL+phDCn2y7LcOqXYqNYuKSwXeH
	 3voV1qnjQOPHwM3SIG16t/d6HhkLOP23I7KDNwLDcZKog29AoMmg/Vk474w79U5Ol1PTo
	 eQS/gQBsW2RLkIroozVwv9t710Hv7R7/0xTCWORjxl+msN+sLgJ8sBFF2uKigf/Z6Sear
	 1z4O/PLqWkbHSc2KWpoxbPUPCfxSMa3Sdfz5DFEmNd+VCWGwvOnTLtebDAyH2aShdfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MB+39qOd;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CD606A332
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC1CD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MB+39qOd
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-998d151f441so88363241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515616; x=1795120416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=MB+39qOdaRs/zgARvFw2yBarVbcyG2PBATMnTDnm2VV/HsQiVsj+tP7xzPuLWGRtsx
         sbm+E+IvjwI+ypPQAsM07Q8o4/+IALAMlu/iW4y0pfxoExQUApySxTLeSg8ZQmm2mNoR
         OgcJZOi9ZZOPjPWarerh/mz7K7huyyGiNNp8Y7elf5IHqPMAVMTpy1gkCS00y2rDnDiW
         WcHrF/5+uoO3rPfqyyJIc8O6xS9TKxzaAe9o+s+tDD224CyA7O1QqCKd0CrR5U7qquK+
         9XD0tf5swwQF+m9G2mrZEQplEupj0RLTIYu5NY5rrs0OB8FPLICurHazVHvxEELKWYcf
         rwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515616; x=1795120416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=apI8MS6arwK/eO4v4c3P8yG4VWYsG+Yhdy2WeFV4LBORBwXs3jelNotF/L+KUhOdUZ
         nZdeblBQ9rq2TR5X8FT4SO4mveLUfOaTuJf8iX/lk7OEYxcMw/Pg1QnmJHFcHi/MTfoX
         x3lrakGpYeuRAxt+OH8vTwoEjy9C1fH+KfAc0+nipLEOgZuwVqqCp6tn0ee9uEN+mFal
         piWD69hWd6draGsJ0bdronCmK/d2GS0fOLZlmoiQ/7u0qWy/LgOLbai54Q0G++qGwuNV
         00GJDvGsuvyT5ZvanYrLyXXpIjIGh8cJtA8zNmabQqfAGrM/5BnKWxkw/SghWrmkePGH
         NhVg==
X-Gm-Message-State: APuU4Z8SL8eUKUq2pryUeyGnrp/fDzp4DNAASc09G2ceMSLm0XAllobM
	6EdyjXmPM4GxmeDDlRYPXm6ffqJGBZCOBcGG7DDXwSOrimG8ZTrlMipov/GJEg==
X-Gm-Gg: AYBFou3eGB8wxNKa4RPg8oqdt58WFi6qekYCJ7Y/sh8dstpEFCh27aaw3ygMlF6fnw2
	xltD9dGLjYsvztgZGB7Zi4gbQG+TdoeuerxKJS13g+adg1qmbTpAF1oE0AfabJRsgYEou/hT4/o
	JXXQoc3Z7gbD4zH3PsVFTs/6/66rjjOjBn/WC2RjMhQ3rbP/4wm2ABfs6xRubDiUwHxctHM9+pp
	h1qFdU7NZS//mxupHVaCTawqLz1RqoT0mMyXUv0YOD564WPVY0UWuBPP8lmvA3JnGCI564gJPjb
	AqxxxI3RL6f3MpQpgPGw3iOmzmYOC+9bEUZs07+f6msPUnxLaQmgl/aPvPOA4CkIXnnyVe8BP1c
	Bfhx2/+1rItxrlHoyz4A/v95cdRAQSZ0+cHonqlYEJ/6XnEQ3NKnAb7eoAQiT62nIU2pjUS1w/D
	YFPzYf4IsaUVztbKQ1UAcERmDI0j+Zn+0Kh3meftxAwKyggCss54fWC84dY/dB1oeSR2Y2fuY+Y
	/YQlnU/kxiyYeENym7WmeqLJJgOHK913Rmthc0+TLuWpeeR8P6hEWkFMeLno5GSArvQmn2V34Kc
	w0q12yY5PXfnNFZkVgmMG4EcRwFZK/WLDKimviZ8sckVWtWx1/5dlZ+6fT2V/CVW7cvZkp+jwYS
	Thd8HsMXD/3ZgUKTVJ64k6JujvoIBSEWR5+UbwwIBBszr53NrBNS4fYhdZDq5nRN9Ppffy+kCa+
	OUcdU=
X-Received: by 2002:a05:6102:32d2:b0:7a5:7282:1994 with SMTP id ada2fe7eead31-7d64d6db612mr110409137.7.1794515615908;
        Thu, 12 Nov 2026 12:33:35 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm346627241.10.2026.11.12.12.33.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:33:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/6] shared/bap: Update the remote PAC when reusing an ASE
Date: Thu, 12 Nov 2026 15:33:28 -0500
Message-ID: <1c41577456acc2457f3c5177d9380eda950649f0.1794515475.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515475.git.luiz.von.dentz@intel.com>
References: <cover.1794515475.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

An ASE kept by a stream, e.g. one the server cached after its release,
may be reused for another remote PAC, which replaced the local PAC but
left the stream pointing to the previous remote one. Update it as well,
so that it matches the PAC the ASE is now configured for.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index e45d12144acb..4fd4055565f7 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6975,6 +6975,7 @@ static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
 		 */
 		bap_stream_clear_cfm(stream);
 		stream->lpac = lpac;
+		stream->rpac = rpac;
 		util_iov_free(stream->cc, 1);
 		stream->cc = util_iov_dup(data, 1);
 		stream->need_reconfig = true;
-- 
2.56.0

