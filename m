Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A3361DAB
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224950; cv=none; b=QhYHAgGD0ofcaPbcFkZbU7yevEbXyTOTj6UPazHPfcLukY1jmmYNZlBiACxZy1izXkVe8wyRm902mtoFAlWALN/T21ARhA6FbB5GM6hAZNGxq5B5jULi5dHQm61HJV4O2oe/Pj6TKxO2ApNDn0k0StQ1NEP8sS8hlEfyAFm81+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224950; c=relaxed/simple;
	bh=C+JgOXvzCsEdD+gCbyRmAFqpR0gAisoegclAiXkE/so=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bZf5MtHaMSEUh04HNgLMbAtpmya3pllhkc4eSY6kt2mejuQXOgfV9aA4mL6nBkQ6rkcEPAI6XFy3n+0b54YA2/sznUWk3+F1qucBQinHOl4TBetHMoji6HqZiTpB3sbwFJN1jSsTq8P0GdqcTI+STAeKHTQVs4UlpLHBooby5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDkekRYw; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDkekRYw"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbb6c072f1so882876a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775224948; x=1775829748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+JgOXvzCsEdD+gCbyRmAFqpR0gAisoegclAiXkE/so=;
        b=EDkekRYwQO/D0gJAXa7U24MCTUP7jRTPwLdXbhwHVEgegUrcRgKEgQZwQebpUKpPeE
         mwX/EHlqJCLB4+HO2lzYxEsIEK7540Bet921YsmWwGBfTbvtntFZDu1F305QXrzG3ssE
         NOOWex4/tDIE7C1ClORbZdHcj6N9vaXbj42FWFlUzjKtK1Sivp75KS7swPkMeg1sKxxy
         4BzsAXldd+bz54kBjSPN/p7ukXJ+JCShYaoxpoPA5A9ajeL/rP+bBMUmJCOPnOMqv3+R
         3ZBZFES/8TdTjFESRVchRcQSScj2+Vc1WBmJmqDZ77ulQBH1skEImmql21QgjyZ2RO1h
         KscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224948; x=1775829748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+JgOXvzCsEdD+gCbyRmAFqpR0gAisoegclAiXkE/so=;
        b=q5Ch4B3iEuuaKhB1OVtjpL88rVLHIqhL5iMVjl7A6IgOA1TBirhLJFTrnMk9MFkRQh
         Btx9Ik71Rx3SUNwNxlFOY2FSHOCa4ZjuBH3zAdJQKMOUpwOd8KJruUFjaEqvlQiCuMFg
         ZrfgAtYop8ajwekhfXcbE8tGPswDFbRjzeWy0twUqovCDl/JykJoKLHffShLesjvAdYh
         3tLEoFpCYMsi0L+bFgG7z5kyLsTar3prQdVM7JIItcoHP+X5HAy/8A9GYVsReSROGip9
         UEkMCzFlQZjP7+uZe7zKbmm8jcuiBJ1AcCQG+hG35YrjQ0A+pddNBTeN17cpXVxZNQvy
         vw8Q==
X-Gm-Message-State: AOJu0YwrSAlpOd7WY/aMApg2se9nX29uG0FDNfKvSYYWsBczfPSMIjn3
	TzAEEJj9yC3+j+ec2M+Jw5DKaze3c+YCOCT5asa3g4Qe2Bbt51v5W0tzIizyJQ==
X-Gm-Gg: ATEYQzxjUp3x77onYZbmxYEFeO/SwgHcAG8YwV+FiMc0UV4ZNIlZrrv1i6ekDY8YVks
	5Qaupuytuh3tkFDpE4ab3xTKKS1oNqO2HUYWsGcUY+gjVGp0fr99u0HwoVTaGhYztVRrZ1LSJN8
	IogakBanRuw5NyjkxHj0HwGoLl4Ias2B9YTxF9KUtzjixtU+FjpKU6v7lyIE1J4CJDne+f2VXpP
	4eBFHPe/zEyfLQRV3gp/QZJl6aAeQwUseosgYxBs84BLoLZ6H7j94Y74ViS1s4i7xk5oiiAhWP4
	l96kcwaw61VgGJ0+2lktcpQcHcv8tJgv9a2Bdjw4gj+QxZMBOvY0PQPo5ysEgIBOCEA/BbBV1Y1
	50zK1cSRfhxoUatcXL4ktDp9KjSBNcWXjhahOl7YsLsMCPzJCkjNbxoKjMPas/R4Vq/77zNJX/R
	JD+AySex1WCu8NUWWQHv3Lf2whVGA=
X-Received: by 2002:a05:6808:c2a2:b0:45c:8675:eef1 with SMTP id 5614622812f47-46ef57f16aamr1808252b6e.3.1775224947609;
        Fri, 03 Apr 2026 07:02:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.18.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b73ea66sm56349051cf.14.2026.04.03.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:02:27 -0700 (PDT)
Message-ID: <69cfc873.c80a0220.276524.cb45@mx.google.com>
Date: Fri, 03 Apr 2026 07:02:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5695093973139563146=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luca.weiss@fairphone.com
Subject: RE: Enable Bluetooth and WiFi on Fairphone (Gen. 6)
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-1-393322b27c5f@fairphone.com>
References: <20260403-milos-fp6-bt-wifi-v2-1-393322b27c5f@fairphone.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5695093973139563146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/milos.dtsi:2099
error: arch/arm64/boot/dts/qcom/milos.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5695093973139563146==--
