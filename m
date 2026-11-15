Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794772416;
	b=UI9/+s793HZZYK+yw82as4TkGuLiF1ZSG5LUdwr+9/CQvyWvq7daYlufYvGE8aFUEfu8
	 dRbApaZwR0OwQMJP9WiI+wXVJsP4NuvTi0Ral9q1/ikB2XynrjJ9ZHsC5rYvBUfEL81u2
	 faQunQkhf0dE7DX4b7kg5nHpV2zrWoMJpsSv+Hcy0m6d49/dyBcEvYslFb9YQwg/G4P/l
	 /LUykoH0kdC4vcWJLpODe0hVNpKtn9b3+/FHww++EYZcMuuHF/SYuyQepY4NIIy6zaTGy
	 VEe+PJiUueWK0aVcfP7hYQ4LeF/UtAzzm/Y4I8aBx4eAeTpsmB6tnThPV7NL2mjSD+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794772416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NG+dV1vzBAA0WTXtplktelRpJlV/CnJBfii0WUODBd0=;
	b=XHXmFnSEnzw7KfvLn2AvJGlorqsg7EJpjrUaF3G22QI800TvVoqsi5eAcwqNuOrs0YFT
	 kHeF6mt/q3Dy6nVThv6B9baAJoeJaYXtpwHMZApmPTvuzrvZP36HrnMC3zaYM89ZUEgjW
	 PWDT5oZF5g5Vx/d+F2XTuXFIB2aYwJZ4VTa0Bj35o/7+wfnC6OhNgSD8fuDa5YDB6GIm5
	 naIl+YJ9c+IlAnTnVdJ/wVgOdKk8EWL7GO4K/R2JypRe9Vhr60JM40wb6VsIaxduKLYXo
	 EVofW69BDi8U9pbva4potPqjl396BSSPEbVEhsUFUleOlMSpnhco2N0+dQW/8Zf+yGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kY3/E1YZ";
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F159606A329
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 19:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F159606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kY3/E1YZ
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b30ff12f84so16875177b3.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794772415; x=1795377215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NG+dV1vzBAA0WTXtplktelRpJlV/CnJBfii0WUODBd0=;
        b=kY3/E1YZiXjLYzpt8f4chxg5H47ilbSO/Z+cjEbZ5NBMIDzMLGidnjZzJxnxHWvOp/
         ErC0dEA69DbXttreubjS7g3nHQRS/U1axGzQHD1IYISJbtS89wkbAtt35N2NJ6kSbvBS
         xcCnwbZfGfUKNkwXqMtMik1ui9aBLw9KCmpoPzjPzJeGWbg3Is+iG9T/sESyLCoocgqb
         hIkfB+xEL04KD6SttAl5+sFik8c7ZrPzFvceT7uv9Jj3/ovI0+VWqGJIot4vyk0xdquD
         VR4nGl7xhArdaqihx+A832uZRLiLzlQnc31kF5wvV04aZsctJ445Y6ha/wfHC3TwEfoB
         OClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794772415; x=1795377215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NG+dV1vzBAA0WTXtplktelRpJlV/CnJBfii0WUODBd0=;
        b=SvXuif4BR/uUuIhfjrC4lZnpSR7b4i09Pbvl7jhPp67p0Thh3C32RphdHke1AxH30b
         Mn6vws0gL/Wm4oO8cl3xP2xm1u4ZFiKtIS2rayjcA4WXNsDjHA6JDZJuBv5BZNXoglin
         gN4G0wXrzc/uJ0iEiHvagdp+/5R+XTIUvFqCnrZeT2HUi8vOh8bOoX1ql1fEnhhzJRO2
         ICqLJZRLBmWn14tuCCrKpZ4YcOgaWLFxcN7x/ibnxvHVQ3nSkcVlCeGCNWv/tgbDzEWj
         2M2T6/upIuUh6vcrIJkcbZwj/rGFAZJz+b9iR2wViPJedJKedawKRrWBb6CEgfzXRZ9w
         b7xA==
X-Forwarded-Encrypted: i=1; AL+hErHGlOa3xPtZs3J80QlBEbqFsIyj8SAb7htpKw9QtHW51jlsaE+2aJupHZV+4ICfMIIHXex5Pu5bWOc89LDqaCE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+O9jbyxeho6TthXhw//kfEpdKg8FU79Em3bFICRe60IaZDcx+r
	qRhoIIGLm7IVyi8fqkimDIzdtDguW5pPX7DzjxTxjYKuFN0zmVClVGiK
X-Gm-Gg: AYBFou2lh/yGxE3nIuHYvOQeSKSbARtSaafAHY9v1AVwcSF/LCTT7j244AJOz9a7OQo
	z+r2/RhtMAncpq1GtFOXIIT60b9gSuJxoXepemVl5AxUy7xdhk4S+ghnzBj5d3XwkdgvLosAJ+o
	zg94Umn/v3aDXs5EOJq6+iFkoE7RW96jsupu/HxgaLba1KCsBtn4h5cP3sQYjguz5/28TMV97KW
	KuOp62XaQdTqHpBVBgS/Lg69y4wua8s5Tx1Mm7ZSJJTwE14pCllwuA6mZNmRrDArDi9faihRjee
	QfdqZJArw7SQM7t7pJVNve7dbjfrMAXT52sJMaJcnEYhuNx5s9Zqb3Gz0rxUy5G3Z2+Gj8tOr4w
	8Ol9OUjAveFDkNTDIK7ryJ2hiC3b1ILapqDWwG17yJwWazd0PQ8zem8tKLWdhBAary1zg0SbE/4
	YiGMtk7kf1/Xsv1h8wrhSIyAWstMqQnI8E008jvLk9imLQ94hT7CFBP9ou7/boTDT4hP8meVFMT
	E4cVnpIxku9vKgqsF/0NtmLiJ7Hq3qHOvSaV4vbrp53vwzgPsoPcUt/qPFft5OQzT3aYgoFzrO2
	+G9lwn/S3wFIDf9YpC7D1YZUcfsjrBfXdya3E3k1As8eEt40d+NP2yL9gHvu26yj91NDgUzhZe0
	N8f8aacHFlroZ9hef4epSgjCOxGEH7QpGkxie1XX9evmheJ9OAA==
X-Received: by 2002:a05:690c:e089:b0:8b4:deb1:4aef with SMTP id 00721157ae682-8b4deb14fc9mr347347b3.0.1794772415144;
        Sun, 15 Nov 2026 11:53:35 -0800 (PST)
Received: from localhost.localdomain (179-252-148-65.user3p.v-tal.net.br. [179.252.148.65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9da90bsm69816367b3.37.2026.11.15.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 11:53:34 -0800 (PST)
From: Artur <arturfaleiros1254@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur <arturfaleiros1254@gmail.com>
Subject: [PATCH 0/2] Bluetooth: btrtl: Don't return NULL from btrtl_initialize()
Date: Sun, 15 Nov 2026 19:53:11 +0000
Message-ID: <20261115195313.20809-1-arturfaleiros1254@gmail.com>
X-Mailer: git-send-email 2.43.0
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

btrtl_initialize() has two error paths that jump to err_free while
'ret' is still 0, so the function returns ERR_PTR(0), which is NULL.
Both callers only check the result with IS_ERR() and then dereference
the pointer.

Patch 1 fixes the path taken when reading the RTL_SEC_PROJ register
fails. It can be hit by a controller that times out or answers the
vendor command with an error during setup.

Patch 2 fixes the path taken when allocating the skb for the drop
firmware vendor command fails.

The two bugs come from different commits, so they are fixed in
separate patches with their own Fixes: tags.

Testing: compile tested only, on x86_64 against mainline commit
fa2933aac170 (after v7.4-rc2), with W=1 and sparse, without new
warnings. smatch no longer reports "passing zero to 'ERR_PTR'" in
btrtl_initialize() after patch 2. The error paths have not been
exercised at runtime: no Realtek Bluetooth controller was available
and no reproducer was written. drivers/bluetooth/btrtl.c is identical
in bluetooth-next, so the series applies there as well.

The bugs were found with smatch while checking the Bluetooth USB
drivers. The analysis, the fixes and the descriptions were prepared
with the help of an AI coding assistant (Claude Opus 5.5).

Artur (2):
  Bluetooth: btrtl: Return an error when reading the key id fails
  Bluetooth: btrtl: Set an error code when skb allocation fails

 drivers/bluetooth/btrtl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


base-commit: fa2933aac170dd19c6a7f0d7b81a8f537e40915c
-- 
2.43.0

