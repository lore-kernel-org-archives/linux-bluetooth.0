Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256393845A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242082; cv=none; b=RESGohABqvcmCCwRsEhQjRIbVzkS086wpZF2fyU2Tj5qYio0QQuziJC9wGUT6nZIOO686sifEyRZLekVnY765LhSWqE4FPYgFJ3DJrKWyF+UYmPAoKC1WdsPwC0LAoJmrp1VfBlUK7q00qHUX9qIik44RUAK6id9ZSyhns1kt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242082; c=relaxed/simple;
	bh=s6hsVPwczfvrarbW9msptPZgE8A7UGv/z7WRX7ac7vE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjURG4ya7vTKSJgMVphjaNTrr1DE86OOS3Vpl3Qx1e1rAYRUmnE8HTRa0te8SXYFMW5w6M5iqLz+Inxvhg7in/fWlnOgAA878ji8FfAdwahjxpjJWHxlL+ZOxvpoAfi10O6UghQFCIbykmJaYjA/j/qkn01HyMi5cEZHc3r5wjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTsv87Xs; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTsv87Xs"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-96392241154so137831241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782242080; x=1782846880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6xYwL84HKHKXCjzdLtK0via8XkXYBIUjSj6kSdnFLA=;
        b=pTsv87XsSqEdA+ZFeFKpKfS/vXlbMEvsW+CRWU3oBy/jBpQWkjDxuG5kx+kGkQIxOL
         ZmiKS8IJkoCkTiOhhUfk5UhvgWaLcrulAnWhnE+EGj99nuGdTV+MqPzKEb+Tazgf+jPM
         4rGzrFRxIXqTlJ1Pb1R2gtOgXC5/PBRPe5XYIgVwDBy0N849iyWvCWN67oTuxKz2KS+2
         U2+vietreJpNOynf7BeB8bxv9dFz+9jm5Rj1EW+lOle4oonkblaOhhPXWphg9VNd18+F
         wg5Zr5ctlkHMl9Hf381rjLk79wE4Zo793S/8dizqb53UhzoYGqkCMHevbdw1b823W7y0
         0bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242080; x=1782846880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I6xYwL84HKHKXCjzdLtK0via8XkXYBIUjSj6kSdnFLA=;
        b=bt0N5HjLZ/Drpbrehnde0+I9KLkzOFFE1np3kNEfPi28wj82VykrgolBFI/+O7TxSe
         JuxVxXtunRRtJik++hzzfZm+Gf+zVpX6IBjuhHMXhoqwhJmmFBRpHv/RjZ312NnYsvD6
         2rDC7TAUexV4SLd2JzEKbd9/kppI0UGz7leNaUezzronx80vfWyo8R/asTiNfdpUTQV2
         JZJXMr/Oi0EjVVhUm17Q74o5l7OHByc+j8uGrjFoTwUkRepOpV+vypWXETXRjUX0NYxd
         5uYGFfSfgHVoTcpnVMDXVa9/kD06G9noRBreBnH+xzH+No1CVP0hB+xMu9aARiIa1J6m
         GmJw==
X-Gm-Message-State: AOJu0YzfrTcH7QdQhtcAP70On7+rJzf5Bk3ORLK3dNebpvgad7zjexZ6
	bKLPsHBjl6jN7PSW0/5L+XwmQ1zJtO437MGdQ07AeBt33jwkXRd/DylgepCr7BEzd+oVvA==
X-Gm-Gg: AfdE7cm6jnesiZqeZcmXlYrNiSkwQgq05eU0/xYZ6SOksp2EZ4s2df4IziUOvj0j4jF
	R4iXqHf/TUIKFMcy8C9tPQjY68MJ0hbRolPF8VPb8wQSRuf9cdT7D8yH76XszYmVA6ZiiaJJYzK
	ZZT+SwQRqnvyWJHWgBQGc6oZ03fu7JuZp0JNi1njjvN9n1AA7QZavWNXMIW8VRp2Rc5hpeYxBxy
	dhQGml+lPlUmrFx9OLVOwSrUS/wJh4oizROFnvn26j3t0hQWKCZyTC4s8GmkzX5MSXEiDojhzH3
	UfAA70ifnPePmDzBuVb6QXLwwVqotfeOjF9Z+J0a0uACBK8GkbET4ym3cJWboNUROzmcvPPPfNH
	lCIOJM4Dv3HnnKzuNZZck65tTrNbYXPsuZNA8XGSmNJA3qMdvXbxY3azOlcvJahcYe3TSr9ZpHT
	7tTCPxQeHZHRBu0BKMvMykQoPXQY1bdi10TD2Xot8lYJCPR/YFkAqZ33q+1poJEwrfp2XKho8Sq
	8j8fUE=
X-Received: by 2002:a05:6102:d8e:b0:726:717a:696f with SMTP id ada2fe7eead31-73115b5c61bmr9845137.25.1782242080087;
        Tue, 23 Jun 2026 12:14:40 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9670c0e9590sm8965546241.3.2026.06.23.12.14.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:14:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] shared/bap: Check if stream is valid before attempting to release
Date: Tue, 23 Jun 2026 15:14:31 -0400
Message-ID: <20260623191432.270241-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623191432.270241-1-luiz.dentz@gmail.com>
References: <20260623191432.270241-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_bap_stream_release shall check if the stream is still valid before
attempting to release it just as done with other operations.
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6f2f4fc11f7c..9dd07bc5f2e2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6727,6 +6727,9 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 	unsigned int id;
 	struct bt_bap *bap;
 
+	if (!bap_stream_valid(stream))
+		return 0;
+
 	if (!stream || !stream->ops || !stream->ops->release)
 		return 0;
 
-- 
2.54.0

