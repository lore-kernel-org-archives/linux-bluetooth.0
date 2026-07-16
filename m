Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4B3A8723
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197765; cv=none; b=Pa6CTBVielc9VaglHijrfoivxsTA+qZL0IqsO1oskXGAQvHIYWKshdSaNV5S54SQwATy6tSYPRL1P8fyBmV7NnCktHjFKe8qQTny2JBw6oKU+EzLNPDofIx2MndWIMJPnoVQJJTUZRzC7HfVmxx/Zy75tmEQiPGuxS5LTuI4UE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197765; c=relaxed/simple;
	bh=b7Th9SubKfUMPszGrhqE1RYAR8undP5B31RUWKZBOk0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sWKuS9k4rImMbtwUvCjeeJjpp/tdzpLldu5CBNxas6pZCS+NUPfHD29R9/QwqXE1tG6BR/jR3EDwXgp7bKv/vldgmJmSgAYrrunpPyyCT/BEH2ESSEw9pZ4Lxgb1rafFzspmhAuKGJbNhD30iKkaKpa7ATPimRN79xGltvUnZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgvOZjP+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgvOZjP+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8eeb4508f29so65409106d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784197763; x=1784802563; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b7Th9SubKfUMPszGrhqE1RYAR8undP5B31RUWKZBOk0=;
        b=FgvOZjP+JA7z8zvn6PnURz/RJ/1mUDgaTiCUGH4mGMrOxa7dlM+f3OUlPoNLN9HplT
         QNMXfQRfXvUgJkpgyvCmI71I5Ryxrox99tRCyr6Nu2TvwmySJAW6vZz+WwCk/iQSk/8M
         VWUdFIX1L7zzYkaKWgRcHyFjHbnuS+7Ud5lgTPotgULApVXeun5cMde+2sgrGgMeOuVo
         h/jezq3G/vB7m+ss+6guH1G/of4SGcb8vQVIsgIL9oDWIFOoXP6NB2V7J/t2I41pHdmS
         lg3PTbKX8+CyYeF+nK2HKeFLMICdGFqzNyqmRVewwq1W+Rv5qyTNjWPwM6BM/LQPNTKA
         qjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784197763; x=1784802563;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b7Th9SubKfUMPszGrhqE1RYAR8undP5B31RUWKZBOk0=;
        b=QpZhoMNZ6oASCk7VZkdSUTonctdzFkdwJE/0PoYGxgyY1zi71yXjMBqoSvzLZWq0Wf
         g7PsOPCOflgXtP6s9X7Epm3TcxIgHXcO5pnEV+KWbXu7cXR5Xpb1WAmlU/Ajyr6Yg+vb
         b+vB2dXUfcbQZyGOnui+wzH85O8bmL/Co4MFaMxfVNavQyQjvyw2TCAX1+53y7kSHZxD
         dfjyBxLI78g4jGAGXQo3l5cAJHLgM35MtGMJXaYxQhHSYny1vqqtWWN4mRizOqlkTfSo
         FzggDJvHbd/L8gz5VFdluvpX+1g61iSHhqhAMvxtHZpI/T0Q8NRVhERPWa5rHpcV6dyo
         1uMw==
X-Gm-Message-State: AOJu0YyEkyD5qe1jWbUUP0Te19TR9YT8+mQjZUcqt/d/jiRWSr/L9b/X
	N97it5bbU+qRRGi4M4s4iHA1n5LjE66PBm3lQXFC1rRN+1TpnENfz0bFcWAVpw==
X-Gm-Gg: AfdE7ckgnBK2BKd0/JbvBWNVfqABREcPYJlSSO6vUWQOypGLJ444sFBGc2olGDyr24H
	mZC2DM5iKSZC57DnK9RRfLppfotTEoG+kUmRiCuzxC+nd+2PVwETbHFSPdAzPdrikRvRClOyNMf
	mpQefH13IH3yTou6nxBY7NJlhuacd740twToO7ijoAEcOChM+Q6RYf10PVy1V0nzqwq8tS8gY0c
	u7cb5FI3ouKFTQgBK7MMRBJOtdO+bNi4vKban9s7I/K0PMXj5OpuBlZ9avQJFcFVo01Cl2YJd9r
	QhTXSA9DxeDKAj8TI1Lx1qiQCvSODsWdHvwucPZKC5kVtJjRbWuIYCqBP6zlOJ39/buzNb8AepZ
	IS5dDRaYLRUClzcp592PgjyBHx5wIBL419RdjYy2TtU6W14op6fMQfTaIY31TL77oacQYgIUv3G
	QYeEFyfS5j
X-Received: by 2002:a05:6214:500a:b0:8fd:6de3:bbaa with SMTP id 6a1803df08f44-90758e69331mr68315346d6.64.1784197762802;
        Thu, 16 Jul 2026 03:29:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.231.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90313c322c7sm186288926d6.26.2026.07.16.03.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:29:22 -0700 (PDT)
Message-ID: <6a58b282.170fc313.170f14.066a@mx.google.com>
Date: Thu, 16 Jul 2026 03:29:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4254151945699369116=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liqiang01@kylinos.cn
Subject: RE: Bluetooth: harden packet and transport parsing
In-Reply-To: <1f79f2f12306c15d6f686348bb79d8e6839968d2.1784191283.git.liqiang01@kylinos.cn>
References: <1f79f2f12306c15d6f686348bb79d8e6839968d2.1784191283.git.liqiang01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4254151945699369116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:1082
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4254151945699369116==--
