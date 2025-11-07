Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AB23D28F
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762553263; cv=none; b=PIBzeaDjAw2SotRCr56vWnRumB6rddk7ph7ktw90J2nzwCZD3/j7X0dc9ZlXG26wRNYnbOQBClRI3+solsPL+4uH5p4hQbYWHXYa8MkNge/KF94s4Vo2S5aA+wdaXxApzwB056etKJRGB+/KGAmgGGBLE3hnnfS2rPqX+KdFKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762553263; c=relaxed/simple;
	bh=sRhbyRF4mrAfCGoxQkSsQvSLP9UEF16uKUurBYABZb8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NvhpbE6T8aS0lBCpgVJVXUVJp83b2nBGBj2he7C6YF3bfqDXU6/WkQQB2FFAXjZI6ftnhpoMSq1mbx4gS1yMlGc8tpNdVAAiH9ZHKc8Y7a+yMJXY8evKNJ8l8GpL75BFav0WB0UUgFkeMNlfB1G0yIH4tjYCgKtN4aiVTqPa28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlzCyJ9f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlzCyJ9f"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2952048eb88so15494455ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 14:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762553260; x=1763158060; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oEyMfAJ+CIeyvv6It+9klkCtphpRjiiyCwTo4KKDd24=;
        b=SlzCyJ9fR/51BN0W72WHy/34L8Jk1b0wcUIV3A/27dgTLRBnXk7xSfUlIJArIRr+dk
         SE5MRAIrxAJJh/AeeF3zHa1Np5KKnBQDAKms9adjIVCTJOKdMMUIDrlS0FozvgOv7IZZ
         RXPyVqBRHn4uQ47w7H8Mx51lVDu7r2BQP/Jsh51WGyBe+ra9yCRMR+Z+YKD6hJCTBPD0
         b07e6OlOEq24qJNNUKDAbJ8hIG8zf53B8NlUwWoxRKlWevJ/a7nvP/hFwB0AVIeEMw5K
         qpwwuOqTd6r4jkvLK4vP9wm7XqwtSIR3C3j9nEnnDQio6SsPT/312ky+OBtdw3bupY/Y
         a9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762553260; x=1763158060;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEyMfAJ+CIeyvv6It+9klkCtphpRjiiyCwTo4KKDd24=;
        b=WjH716nFWoWAOW1fuezr3PmBYNvOoyiImRSXyIN27MaKXZwiuzsof409alCI91yoMa
         EOEKKxtdbwBhhVwE5ypKqw4g6y5ogOB8OCEg4tf7YGOHCDFpz1qvzA1tBbgnuUFsRqYa
         ci5Qh43/dr7gVL/oK0oGCvZU7P5Qu8OH3/deuvyAZEVODrMjq1CawXFhrB43Mo0Bj6wj
         MITvDxHExZUACZ7nJ9LWz4Eo51mMeZ7UNv8z61XtO/dukmnM/962LKZk5FD1mhx40IuS
         2xR2PwsrG526tE6Hwr1fm1N8tcEEc8ZCvglM4ebNTaiy05dFgi0bW3vRYCuVA+fNu89M
         7QGQ==
X-Gm-Message-State: AOJu0Yw780JoXCKAdk/szcWTFu2H3/fVochKriiZdb6f6sbyTTW2jMUK
	qxJmeOwXjNQluPJSUWmXFO+d5KIL4dSixkjNCMUIcTJWGU86O8OUYD6ifE8DGZcY
X-Gm-Gg: ASbGnctkT9ZKMUcsxsHmfTtWJfazoXUC+4v+Cq5tPzgmJMuWbUUgGQ08z5Upk6hPFvi
	uXLsLYe43AkJ23qNX3uv/avlsTRBbdr9tlMl7isjMt0eWrf2JDFud2AcwWOaaqdTlHO7JFpFZ7N
	pknVBNEVKc7PsSH7NzofOjSAssGzRmbqr8L9dl0O9r7a7uJqWe3jRzhGF8R1IjAVZGonKytg2fX
	GlJu4xqvr9Fkeg/BlCobCDiWQVBMdQHEJ9xECIXFK/pqkHankdg0zrP6/RwissfqlOkE8Dnm8+4
	GKfMPILfDMAks1cN/yXoGgXTWfo869+lYuAxeDMQMYDsgouyPJIzDPM5xv8d4KZE5DmDDKzpOHY
	oOWJKhu4c2OTGIxQGsI0sUhl0VXzYQYYXun3rsPBHs5a9oxukUNsvNyfzGMB7/jzqvsJsk7YzN/
	xn7qhty68bnHrePfLAQw==
X-Google-Smtp-Source: AGHT+IEJ+xv++sOE8bs+TS6Up7WO1wftNB9Zx9WNwgbFKtFqnnOAODRurwWwei+SCgr7U8kIyDiyZg==
X-Received: by 2002:a17:903:249:b0:296:4e0c:8031 with SMTP id d9443c01a7336-297e562e639mr8841405ad.17.1762553260517;
        Fri, 07 Nov 2025 14:07:40 -0800 (PST)
Received: from [172.17.0.2] ([128.24.162.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93c8dsm70957805ad.80.2025.11.07.14.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:07:40 -0800 (PST)
Message-ID: <690e6dac.170a0220.9cfaa.0d4a@mx.google.com>
Date: Fri, 07 Nov 2025 14:07:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3130569074800859748=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/5] emulator: Generate PA Sync Lost
In-Reply-To: <20251107201827.1235953-1-luiz.dentz@gmail.com>
References: <20251107201827.1235953-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3130569074800859748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021075

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      17.98 seconds
BluezMake                     PASS      4072.92 seconds
MakeCheck                     PASS      19.82 seconds
MakeDistcheck                 PASS      172.58 seconds
CheckValgrind                 PASS      231.19 seconds
CheckSmatch                   WARNING   275.80 seconds
bluezmakeextell               PASS      121.99 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      833.82 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:461:29: warning: Variable length array is used.emulator/bthost.c:699:28: warning: Variable length array is used.emulator/bthost.c:700:32: warning: Variable length array is used.emulator/bthost.c:917:28: warning: Variable length array is used.emulator/bthost.c:951:28: warning: Variable length array is used.emulator/bthost.c:952:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3130569074800859748==--
