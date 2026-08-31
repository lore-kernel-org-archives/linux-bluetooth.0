Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687883A6EF1
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212299; cv=none; b=PVG6cDIXjtjf8ciaONLw4xKQ7oDqxkYJqkMWToY/SG3S7lG/sH+B49mZs/7wjd218ZsYCp9HnA5fZ5C8u47QSGJ0QV7IHipL6J5ak8JRJi7i13vrGmIGWa0rc2/VXBA2gvSiAmfWFt88B+f7XJ7QlAfrmUpAjreLy33VsqhOEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212299; c=relaxed/simple;
	bh=LLKDo7A8UAgwDJWiJwKaQRl9DsG2ONJBOTmDT+lvCLo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kru/De6wFfaVp9DvgZ7LV5GLJ9tHlHimcAya+l44L4Dh93qye654mxTTeHPOpeba2zbliyjDoTdQZ/X7kQ+GJLNwNkov3IO3i+SSl8P8mKef9/bnnGfltjHd7SpSpUN9TJ+QG4bjCRct/V+eqtQcvYHoJmOdO/xjf9XeudI8G6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM2w2PvW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM2w2PvW"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92ea24a2dbfso410729185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788212297; x=1788817097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h4b76asA5303p9vzr9uOeS40mCJXJFcB3swYUXqgcPg=;
        b=AM2w2PvWRhq2bj2ffhxX8SUQnPA9bw5seJ00LDDlbV+8vU7MZ57k8K78ftJN7hkSHn
         C0YzHrUH09ADX23coXzdqKjPuf4VEta7uBOsg3cfw1tR9PkbmA7me+FSVXSgSDwtBC2v
         RVkNHOWGTZP5a/uPSaj6BuLc64gpyz+piYYV6+YmMwgIMb4dnB0D35gdxjwWBefu8crE
         pS1BVK825O71tYACHXxJb5O+jje0hqQeZKzHPxhvzgF38odkvzjgyzgI8GiJtw33HBKD
         Qo7ZhJgha75932EQuACZLsKJy2hjq/blXh2q4gsMJrWjg0VAnaW3ykoVyDxBDsISLtDe
         IQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788212297; x=1788817097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h4b76asA5303p9vzr9uOeS40mCJXJFcB3swYUXqgcPg=;
        b=eODqp5jTLFXo1clgwZIEznGIyueXhRHGbwM5VAjULFmBsvkvXgvqCMW8M2KE/455Y0
         AgbnGD6feVyHv37z3yVDp2TnFXWTgZ/oe+0BFoVn6W8mqM0cLdmebtDAuUUWoFgN1Z6r
         NRXemsK5lSfmt5LV9O0iH5llBS3GP2e0arT1Hh0/Sdrbc6/oTmGGG5Mkp2ty8v3TKjF5
         SJ4GQO7Reo+H5Pq8wsb11I4O4CtZfaOj+O11lCK43eamD3iHaTcmb4gZrArOPP+70PnR
         YM8Qpe5WKj+BRCK4A0j8M9MrpPKgMQE1ZvaUkkcoroTob8GBkktWfPQy1tgude+Fi22X
         1G+A==
X-Gm-Message-State: AFuF++mJl8KI/Rf/yg7dNMOlzcrq5BTgDyZmIVpi2R5WH3CfnbZbpXTh
	q1hrSsKSGfanP1YQyZfB3RGhGkw39ZXjhYrtlu4ifYZpzKvX+uTqgRja9P6qdCd/
X-Gm-Gg: AR+sD12UEx+toT4ZmAWvLXTi/8iYU4ufu1iTcfK/etH40Y2sxiMW6/4ed1ouHXpXv4L
	KJgACdHFZaQm3KNZ1ndIZHj8SiH9gPpZAF9GZH/pg4U59kD+NtHoW2Dl6scmqnnfLARtMroY7xp
	4/Fha9a9Y2UxR1No84jPP3rQGYG36DZcnOiSKQV/0qI164D9U0skd7jVjZiDL3j1y+JIYMct/Ck
	wakDOoaCLBMqnL5lqbpAmBJPl+bURvoyy43DBO5Nm6VDPwmx1HV3R3tsLiAyMZ46YWAeDc1vfqr
	psrtk4SCFkEFdlq8PAxff8QqDt6EbFO/ISM+fLx2n1tvqfyRjCMVtD3Bbp3V6P7L0Jjr5Hq5EG2
	5XVg73I90PsSLeJaXMYRrcpcUeJX5WRcvtOWzi7qMfas/+wZeecmdJWQR5SP/ORf8Aq33oxHkM5
	T8zANuvrJc6cm52VD4OEPE533Gf093hBLTEpMuiaqohhdD3YbVrUepiYmHpH9MGW/bTYbf
X-Received: by 2002:a05:620a:2546:b0:936:dfbf:85b0 with SMTP id af79cd13be357-93913955dfemr3302213385a.35.1788212292518;
        Mon, 31 Aug 2026 14:38:12 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.133.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917247209sm889167685a.17.2026.08.31.14.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:38:11 -0700 (PDT)
Message-ID: <6a95f443.7ff333e8.bf24b.fe03@mx.google.com>
Date: Mon, 31 Aug 2026 14:38:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7993844976352760299=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jan.brummer@tabos.org
Subject: RE: [BlueZ] Add cover art support
In-Reply-To: <20260831150051.80631-2-jan.brummer@tabos.org>
References: <20260831150051.80631-2-jan.brummer@tabos.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7993844976352760299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154605

---Test result---

Test Summary:
CheckPatch                    PASS      1.33 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.36 seconds
BluezMake                     PASS      602.63 seconds
MakeCheck                     PASS      18.92 seconds
MakeDistcheck                 PASS      160.40 seconds
CheckValgrind                 PASS      232.78 seconds
CheckSmatch                   PASS      315.83 seconds
bluezmakeextell               PASS      103.48 seconds
IncrementalBuild              PASS      610.47 seconds
ScanBuild                     PASS      993.28 seconds



https://github.com/bluez/bluez/pull/2464

---
Regards,
Linux Bluetooth


--===============7993844976352760299==--
