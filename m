Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99792F0680
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779044625; cv=none; b=hPaIVjsV05o6+kjusa08nLFPiwM3d1fGoJNwAyQ2BImAIREGEGmWGo2rf4mUb6PwRAx9Js2g8m4WjWGFl1Vw0wzWWKkEfa8q+T+3LpMYuLmYy7+FPaA1v2S1QkmgrtZgopd8UUpQsIP5HN++ZU3+QYYF2Ry8MZp8XM1jXX6toqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779044625; c=relaxed/simple;
	bh=doIwb3v5SqeGUL31YnrxB/ixVjxF8Ax83+teKGbkmAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWWPYFNZGmwH1mPn8vrRdl1oYCUwZVzyYArQdGgOt3Nn+hRIrzxXt+Ik4GFzxEN8Kw92FPTe+WBwc7BAm4EqHo0wKp/L7UvFpFBIgroVzClpb6itx2yyHIE64bLX30I7k1m8M3lZXulidXu1VZly7HdD3Y0P4upXDoqyhJ36Nmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2f9O7Hq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2f9O7Hq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso10915525e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779044622; x=1779649422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAAWutEdnIfqLAID0zZG1UZooygo5KGwOl4Z8XVbioA=;
        b=p2f9O7HqlQPLFE2+KdKmNA+ejm0cr31FXd6+FnspgrtTZ/N+G6ccPX97SUWUTb3WyU
         1Su8QdLWVAXzn2+Tx5tEZcsC3wxu22TiwCdbN/xye/yiBv9cJB7JGystx7qN0Wa5bBPk
         GM6Yrkox8jHJlc7NKRL4oWcNgPRzHGmju7Zxx+QnE1Lddp0b7szC3SbfOXC0Jwg2wtYZ
         f3U3fl+X5XM+iUyyK5tEVnhUkmeTW+4L4AWGaXcQCVwblJy+vUE/B6LXzOytONMEznwH
         8C1xI8yXoQxOW7+iPFi9k3jor1u9f9m7V6QOM/huz7t6UPh7AJ8SW3e/7pBiDj9joq9f
         FCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779044622; x=1779649422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAAWutEdnIfqLAID0zZG1UZooygo5KGwOl4Z8XVbioA=;
        b=XQAj4r5lGJhnr5YUIxDRHP//ro+WJTVXCBpAgqTne538GWNjpTKY0r4s87tEkB937I
         XCRUpgSqIO2OV5VXxfAbMeMelqiaAknuePaxrcgQ3DbFVk3f1EuiHpvPwxgbM14YwmY1
         EDoD0IZV979UooXaHEtY7SYghy7y86I0GcrDuOlvfwKAMxLjGCI5P+UkZRnO8RV5pvXq
         j7oR1dVVDBi41RKL6xwFB6k4CaMzEkLwYUD79pcnpr6Ee/GHaKakTxLAyIiY229hFcqX
         IVPL/rk0UfrloqU2QIDRcosVCQ9xL1pOQb1he4LBxlpr7xh6ZXwumJ2dTKOjvuiIHr73
         ow/w==
X-Gm-Message-State: AOJu0Yx6rPR+B3VHY4TbKhKiklBLiIMQe5VosAV6ncMZDVrjJ++KzFDv
	5w8y38bqzkU/qsMugEvqoiMQhBmn5j8v9fPJyDK0zHMvnuuCw8PLW6BX
X-Gm-Gg: Acq92OHsl5uEBiqIQ/demR9BODNkSRuSSiew1s8cjJ4h9FWvyel5Zb6vt1RDM536bGi
	Jnu9yJ+/MBS6qfC7tTF2XO185lo2fMoPzGOz3yvVg27EvmCPN2h7k5OoDI79KfFESJBaRqMw50X
	KDfUJuTka45dEOOFhCFzQvgC9+HqUDv9tyS/mju7/apfErW0uQ3TNHrvY76VcSOcVgwhJcwORME
	T1pKliO6XXqhtXmLJKF7MUh9IW0z7+7/oXilOe2YOLeBg6aDaPbaSEVYAR8LyGp7aFDkITUzKiL
	EhLuwN32VuxicTy3r2scAomSvKjQqec7SxtW10BLtawWl0eRz80VEA29KcIGx4jTSel5UQI4GLQ
	ZuaoYBp23lqW55AcrhvzoEyz/veo77jbM+5qAldik5hnnnsq2pfcZlOvOV7t5JjvINMfRdICOCA
	MrGN4Ox0rSwGlWsNjtK2bqAicDxq6ml3o26qlcekUkh29SzyXfNIejojNT+cDs+G9GoRht89uKV
	A==
X-Received: by 2002:a05:600c:8b6e:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48fe60ecc24mr191700565e9.8.1779044622151;
        Sun, 17 May 2026 12:03:42 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm67660135e9.4.2026.05.17.12.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:03:41 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: pmenzel@molgen.mpg.de
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
Date: Sun, 17 May 2026 15:03:12 -0400
Message-ID: <20260517190312.56076-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <860987c6-5a8a-4409-8943-0cba9d3cc2e1@molgen.mpg.de>
References: <20260517145417.31910-1-meatuni001@gmail.com> <3a7eaf6e-6e4e-42b1-a136-3ed2befa90e2@molgen.mpg.de> <20260517180832.52329-1-meatuni001@gmail.com> <860987c6-5a8a-4409-8943-0cba9d3cc2e1@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paul,

There is no safe way to access kp->value in the truncated case, since
the payload is not guaranteed to be present when skb->len < sizeof(*kp).

If diagnostic information is still useful, only metadata can be logged:

	if (skb->len < sizeof(*kp)) {
		bt_dev_dbg(conn->hcon->hdev,
			   "truncated keypress notify, len=%u",
			   skb->len);
		return SMP_INVALID_PARAMS;
	}

This keeps visibility into malformed packets without touching unvalidated
memory. Happy to send a v2 if that looks good to you.

Regards,
Muhammad Bilal
