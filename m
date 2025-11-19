Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8E30147A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572645; cv=none; b=TXJdSmt0NuhyzfmVxtBm3sL/Dxefvm4IyVcMxNw1J+vkJ53HXzxrj4C+0g2ur3ucw5082BVn/A4A8m3vCwkmedTqIPUoFmbByTMH8hadTHHkv+g//VSGJRL2vMqOtdRHaIrzSFvb0yThaXZ0rwEgntyDb0U3iZaIzIh1IDn3Xj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572645; c=relaxed/simple;
	bh=aLbCJk1Bjq/bx+JT11FwcAhzzfDCacoCAfe1MlwPuW4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r4K3ipeiWVBtTPg6hQ3UopiPc/yU/DWdBEmPtc/EElqE7BowWWL/vhf05xMecOpMSbySUVL2kIafXXEnQt3Nhc0l/pFXv8eGajxX9wAOVJeB1m7aWKSJed4eH0asjSttIceHg3+JqwaPmYapk5N1eYZ6wgeZ1LfHtZJ9kAf0+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPSO7DcR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPSO7DcR"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b25dd7ab33so459481485a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 09:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763572642; x=1764177442; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aLbCJk1Bjq/bx+JT11FwcAhzzfDCacoCAfe1MlwPuW4=;
        b=BPSO7DcRJnCP6iXdgsCN6zq0CWTr31G1CPfSIkqW477Xg8QGEWKFlp2xnDBFd99Zzq
         d+ZPoWv7o7Ocw2vK6v51+Sikm8IrhhCCbIGHhLMH068gIghsUtf5tIjIzJApW3bgXnrM
         GiZaRUi3NykM7/sozt8xgXuEvmCo+FcCKIIgYGiC0z8usQvHj7qSWiIXfEFlazIUwhOT
         aP09iJWnEsubLTn5qlsXe9e4tkTKXIcabxHk1X8eOB8le0q6fgwY3Jnq5VO651NQVIWK
         6lwhvv/D//yCbJO42aaVqlNO81AhevL0/ekO0JmW38iPd+rtsy7MJfYMrmy/QXgFHhzM
         elIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572642; x=1764177442;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLbCJk1Bjq/bx+JT11FwcAhzzfDCacoCAfe1MlwPuW4=;
        b=X/eKKt+YYTTfCbv+XlZkERcWnqAkAHSu8O4iSN3MtFHyGdKYPIh4BZCOqwTH3OQ4zL
         MjWFyVptCrJJCT7DyTE9pOfTkCMLjkK+kXuEdLTrhvu25W/WqHWmXzW1Re06TEIh8uUQ
         U+uHgqgFI5FncT1PhiyW8oTk1YPO/c+cFiF5FIEVnWUNjUZcFrmHOVt8R71jahhAih1V
         uT6lgHQxH6Nf1E28GPfcPr5jFlcU6rv/bCdkjxYVtBeP3FS15Lo6t8ASeMt1q08nls3p
         Zn+3gxWAJkFLEof+W6Vim0K9FnU18zoVxEhOUnSLUgi2q63Pv64p8cWf16fHNBqPEoBE
         3w0Q==
X-Gm-Message-State: AOJu0Yzx4+HsxjVpAkXfhnaZIti5vNHnVrIiUfJfrmf6YLzKbzIRiYin
	ieE02f5647+8BH6Cy8owB2GNKxrny6MtOuaLZvZchkyKwHZfJu5aWUA+HZiqSg==
X-Gm-Gg: ASbGncsesKy/ql9iyfUhRNv+0R8z5e0SNVo9vt3dTbwA2ce1cMhWgM+dYps08LZ4rLT
	qmMdiBBAmA8BWFtMHapZq8jf76D0cPBaiWH/Ta67SCsRHuRqx07Ao4gPFc6PZ7WgRiYqgqXygbG
	e//yy1ufZwo5b4RlaV6u8i9Acc570+E4maB8+XXjbWihfRWojh0aYEqkknkxsEgFTxy9eLGoPkw
	MM2PHL4njr5gxPwYp3EMWvOGUPBb/g52Ji7XFscQ02o9QsicKTn11CFFrFIsZD6QkI1zxgeYm3e
	F8GsToLEdS5esawB0Y0eVBbSWqq2UN9QAHuMDkGNzO25WGfrWasjH6UtZaZ4ZTPz41WN1YaLqc4
	WMbDkRmkM6cD9/jfJOFb0LE5NOo1I75c0geaO5Vwdy8Nn2ZnNZ+Lqx2XEkRyxzMN6LCQPqDDCLV
	56FfxLQ47vGRB7wj4=
X-Google-Smtp-Source: AGHT+IEBuW4DzYD/Gt8Hy7SMVkD0fS1hkBj4WIumDTEFN5iu0qDWHqtzsJwKmbINwOWnwCicO1LAmA==
X-Received: by 2002:a05:620a:179f:b0:8a3:cd9e:e40e with SMTP id af79cd13be357-8b32749aedcmr14272185a.86.1763572642285;
        Wed, 19 Nov 2025 09:17:22 -0800 (PST)
Received: from [172.17.0.2] ([4.236.173.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2dce77d27sm1000941385a.13.2025.11.19.09.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 09:17:21 -0800 (PST)
Message-ID: <691dfba1.e90a0220.421a0.6ff7@mx.google.com>
Date: Wed, 19 Nov 2025 09:17:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4340702633169677298=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dianders@chromium.org
Subject: RE: Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
In-Reply-To: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
References: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4340702633169677298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:2714
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4340702633169677298==--
