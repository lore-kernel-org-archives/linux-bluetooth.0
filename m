Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587883;
	b=h7+BtSeae/oMV6VJTYfhA1kZ7/iVqOm1YtznBaeSAJHiCaB/8XX/CfVY1XNRkOaNawGA
	 OrGiseimsuAQ3On2M1dVioP8Ev/qWyMFByZe6si9dNa5e1JdMdzetXB53eikCNjuZcH9r
	 E8EJlZ4al9wUlHjkt+QAb8c/aKU3T0FNCrGAZiQR9X2OK+zajzLalhs4Phk7efCxHRUOX
	 VsRpZzUESTDObZr4Z+mSj19LZ/Zx2QsF8qUw1DLWZ+0Lq7FTH9yhyXWsPy45BOtOtSeIy
	 xJI7JRwlJUEs3MB5AO6Oxh33Ecb+hILzZAe/NgK62r5Rni1Kp31vb1INaNNn1W/3kSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
	b=lZzMDy6YPtnLXKmxIGK2KNZsXTeWqxtnhXYbNL4ZJrOvPy0Go8wTNFaZAcRitPYSY2A7
	 Ep7AW1KcFmNYGlPyNbrIBC/rAZ7ikTa5vJ0mLj/79YdkhkBtD9wgFppDMoqf4juoiHHHL
	 I0KEnizbMqHuF742uQwZjvoG7lrrzuOIMPpkAUINghrbcHWMuJ+FW4g2Y5tfqfy/EGCJR
	 2NZNWPODGYhOw3yb0I47M2oCtLG2ImFM2r7KtfXfgajjb1/Hwbw7cMIUdBDga1DNX4RAo
	 XdlRqyAx8puvKQlIXIurhEcit3O39A+/XlJXtVGnpPqsmnKuiQKaXa4vYfT/RIJ8y4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnzrUTL0;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D885606A337
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D885606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnzrUTL0
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2dc1ac787so306369137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587882; x=1795192682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=NnzrUTL09+SsnrqTZDJqIOrl56f86p8qzDzcl5zSNO0HJ+E1AnYelkznQ6ruM7YFg4
         puIAtq3YVnQX2OJz5lU7NrqBcqf0RWioPnQC+IwFJLPraBiND4zH9dsonUoUellolF5+
         a0xYLXeYyJQTP22fQql41LFU305/v9cLJje0/z1gei8qA9Fciv1MO+I4ApC4m5AKQWW0
         NjKFYcAlwU+F5MKImKSfFlmKmNtBpBZaRMbF/DzFkLxFdFNk/7xHrVRHDzmzcvEBd1wH
         GL4fTVn3dTjO6ZVhz3GdJboD3CikkqhOokpxfAmsjOzNktZmhzLB3BavH/6YhyuwKr43
         uUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587882; x=1795192682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=C41wdrtnLHYIW7zQ5iWijy/A8MR08H27tlk76/PSevCEMQ7iFE/pmr27l5bAYgiNaD
         8MWRB3lBL7/S5o3SOgeBUZC1bAPpw0+GmZSkWKz8DCFtUqvJacVMIVfQMbBbyuwjvEOU
         TIg6n31ywuFQ1cEqibP6/VpalDEeyVWQrp+jklcG0LFujPUlUw3LrbREv4wlAVP9JFN0
         XI6J0EpM4Cw+y5I/OPETgXmB344oGL+727szRrPqOHEr+rcOhkmrmN9xREjpK1oNSiy5
         OcuQQnHK7U54U/NF7E1+ILruSSdhatn79JilWk1qlJrH1VZmA7ejws3p3T7A0D/ar+iX
         JnTg==
X-Gm-Message-State: APuU4Z9UVSluhaOGUQhtXPdcY8jVz3bA1uNLU3pd7JE27ezUbp6q/3LX
	uRI6KKStuYtvL6QKGG9ph2cTodWU16wv/G+R0k2NmljeyNxt38SdWuQmdJTgFhdym9M=
X-Gm-Gg: AYBFou3YC+Hb/moVLk+MPa4TxDWNFzIe7d8qDsCe769PI35r2eF5JUnAKSgdNTKTTez
	VTA3lJEsTA7S/W0+nGhaXJIVpTklmTGo5W8yMDuUk1EDgrNoCrbZFQ6QjocNlMurzE95ju8TMcK
	ibu9osIvyS3GT9Pw25fTB7XGxpWL63dI7W4axvls6QqVF7g7VUew3WLznQ4oO2hrCZJPUhFpdAB
	gWdmA3qI7EPe2jDRUh7Y4oE+3fGJQSL6HQxpL57N3IRXrQYcpyWrRSY7W3hIDRrg1luTOtnlUWw
	PCb//U3Mu6cKnyyYuHxGOMnpCC+65MKSDuAyC7wBkZWIupWnrBiFWqHK01FfofrUvQXfRuha9qZ
	Q6jSA67eZjtBS9eCU/hDNKFj5Omr9ifqTZpg89T+BW//PPLx5bO2FN4u2PUPHQsnanrjcaxdhPv
	ielwMKmpzpuLkUFvYcJ09BimEs/z6px9tQhuS2y5zt7B2h8ER1kgxY0mRu7Nfa/qE9UYjtYEAJh
	qClkMkjIwheRRLyAoKJ/P2DAEI/YKdfl5R4X+eHh5TlGi+jfnOU9iRhMBtuEiDdeYBkwt+35KeW
	E7w4kG0WzGKXNcBus0XxZVafc2mnSyqUAtj6KIcZ3WC+QUJfyVb4q4ge4m+7qkl/zkcYPKS7YdP
	E++rfcMt4EU++l2lReiWHwlC5fuV6uE0P7K8+/VIg6O/1grkil7AWR5/y4Kbx3ciGH0jnyADK1d
	WK/3s=
X-Received: by 2002:a05:6102:e0e:b0:7d2:d194:3dd7 with SMTP id ada2fe7eead31-7d64d8e20c3mr781090137.36.1794587882496;
        Fri, 13 Nov 2026 08:38:02 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm1746701241.10.2026.11.13.08.38.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:38:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 2/6] shared/bap: Update the remote PAC when reusing an ASE
Date: Fri, 13 Nov 2026 11:37:54 -0500
Message-ID: <1c41577456acc2457f3c5177d9380eda950649f0.1794586887.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794586887.git.luiz.von.dentz@intel.com>
References: <cover.1794586887.git.luiz.von.dentz@intel.com>
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

