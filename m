Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429473;
	b=htl5z3xDOPtTAKHXHJAKsjUjW1mMgNWvyhMaI7CtNWq4g6xDHimh4zvh9lO7WtzlTXAk
	 m4Wzhh314K3AQASoeOqtR3WIqZgW+Z819N4n893NKqQ+ZbLOjbfjp/57GFb+gWgJNOOHF
	 n2t5+VuQcJEjXkYQBU0iIsxDxYUY+Il54zgnUncNN+8opZ8SUEOvc/JfD0gwynSW8jJOd
	 3fM5M4IgWMCDvJZREbiNpZwRTxVEkM2nNHSXZAG2O6JuEACHJTDi2DA6WxWvo6ck1wgrQ
	 MxWu+Ze5TVb4Wwnv7LULlQaLbKuF360o9Sc5sUph03v8V38WmHcGKgQZLuI3Xv26IkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
	b=bhhrEG6KXTc8Rs7yc7DFTT6CG3Xdi6RG57r6VTB92X/4mEgKE8v6NRi0H6el5bonGHm0
	 2/Er8eg9LmEID5zvufczK7k8UhkVBzAcpqPifWM1BDbb6YnF8s/D0ONao4E8uMWDC+9+C
	 XKUFYVzk3pWicrOVTfD4A5DmRf1hGbdmKRb6qeyx83hJdWSpHg9xvG12FMbblbp95sNuU
	 ELCHbw1i7hFPdk1dSKsiGpsCMSZ5oEP+JejWrsdmZp0f3IQ/bJtLmc5vaxBJ/YIJ+GLG8
	 BAR7Q+Pa/LRKnoysBw7FsInrlqe+pRjsCdWgyL9jpO9sYnUbC9PR7SuLZhhZH8JLO8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlJELVGF;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740E60A260B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7740E60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlJELVGF
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-990a39ba4fbso914286241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429472; x=1795034272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=YlJELVGFTqjIGezXyv99vASqnMwPnOiaPC3Uad82UvC2T/pS6zvXJbCo5PBT32wsAp
         0gOy6S/PFHn6S64B5bPUT/eNBOzZR0LndeyvFZjn/h3woTKTOYQQwZSIGbnu97RxhsxD
         bH4R/BukW4D7M+cb2mbuYwas+ZSLO47CACnVEYUDi4rgwqrPZYwGQRLQhdiWdbAOI9Cn
         Osvq9DP4KSWWHV7i/oM/8fAYRMTICm83fXySXUW4VA9GzPInw6IRnpwJ/RIicJiKL5DQ
         POA7tQpFiO9TR8x410B62p/vNeqWQl14ZP4CDX2JJAhDfMvHPjpE5+AmKd5C+yY4lT3C
         /Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429472; x=1795034272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=172A0DSS7hF93F+2oJzU1JiRiqZgHyJmuUxSwr9lEm622HarxBUGwcodM5wGXw3/KC
         EUINxkIb7NCjPg4OZfslF+e5pyuWFfY0GNLScX2FurXHxKcLmPJsHDVPtqFwSOUjTOfa
         B+2tRbmF04UkdBTkRHDWYTxuMH8MnGdcJ72ipcpkoPEJGxL1UahYMqtmiDvKK3JdewSo
         E/suG3RPV/gHyV+7Ka2OIOPBjMmW/GwcNgTexu7IJASuSJ4AN28UkErLA8i6YCRrqaLr
         s0CfJ6HGLz1+ZoREn641qc2kSiZd+92DbmkTFYBAaCTLG2nNk3Yy7iXUdGjDQmljEKvH
         RjbQ==
X-Gm-Message-State: APuU4Z+2VXhWLX+7M7rYF3IJBXxL4f9wnZzE+BL3dUkpFIF57zdXaKqA
	61VbMX2YBteBr/P3lJdrYWMTRhNcV0Qw46bNMQqMYvPvSTBnh5Sw26GspZTS5w==
X-Gm-Gg: AYBFou1syf3lWvHTFUpfJq+asb53WcrqUAsD3oLVVj9waafBCW8shukftKrUleb5kaY
	8Fz2NKM2sQGPzvxdysHi7aNNrgGzDpjBHupCiOZgbuV+VtvuNKWDeHyuT8HhMipCKHdWaeRRc8p
	kIrvkVH0+G7Kfe43OJzd1gVQkMq992Pqie7cX29ywHPNOM3UeN/9kWBnJxU1W2d9u1a0fybJdld
	j42KT4hGCrwar/ysdMPGmejiGNWodV+6wKh/r81shYcjPcWJdVx+BfYrOoslF90Iuc5WEsEiYxL
	qCtR323kyH+yX+ikidoFAG3PgcvhogtrQE+6No+PEj9PMl5mgLeB0bwoVksRyMoyhgd//LsV47o
	HHZuDVQWbLTesMJdYCU4TRZquz+6sHVbOH2hcodisNV3UJmVdVoQirAIN6x+8JogFGfhAUebAW0
	Dr/glZ0Kj3LFl7wrKpCoSN4PrujBmIB3DEGLG7A/kHqDsGvo5JPiql8v9wAyl2f7y8SWHtxfT21
	Yzmuw1sG/gOvmxKqT7LsgnroqbVK6q0EfQmQJzqHugJwsCtosPDf0cbR9VGvdZnRLtkxe6xpeNW
	0a3yc0SMZNrmDuSwaXBAXbRKkauZuwJIJD5F/xWUn8F2K0sWOiFZl3LQI4TgdP0nJ44SKb0H8Sl
	MLqCE15z/EZrJT+9LBwaU4c2ONAcqNOPK6KOR2rCyzjSnuA8VHp8xwlg029BsxRCfZWmvHHsoz8
	0xTMw=
X-Received: by 2002:a05:6102:5092:b0:7cc:c7aa:106 with SMTP id ada2fe7eead31-7d4fb2a2d06mr1116502137.18.1794429472392;
        Wed, 11 Nov 2026 12:37:52 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/6] shared/bap: Update the remote PAC when reusing an ASE
Date: Wed, 11 Nov 2026 15:37:29 -0500
Message-ID: <1c41577456acc2457f3c5177d9380eda950649f0.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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

