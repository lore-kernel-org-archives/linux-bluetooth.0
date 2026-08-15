Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A6223702
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786768759; cv=none; b=SeZKllB0oJul8AGJlhKpaCLpxgyru8EjIqt6y6vUHbprXW1/p9NlEhI+yTM7xwAPwguVgzPHYrfRNNVvtzzAtcILYn8PRkpiPYLD584pBW/mufUWXuJWMvEe9Mw7eGZRE9S8ZoKjr70qjcYvZAOuDCt1dYkOMds0h9h8QkQZSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786768759; c=relaxed/simple;
	bh=jm9WncjmoVwPLhNa917Ju6E23+z5mJhzEBpDfpWHiN0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mJWly6Enryrx8r9pxu/uEenVa9UinKcs3yAUyCX2hELeXUrvG+MBfyp0grWZBYO63W1U8aoUegl3aCkHWleA1pGhvr18aTQ2DRylXcXMBdkcRWJsSmejlNW2pGWzMpTVFx4Wo+GPrT+EdTPWZKGeWN3nu8tMpt07FnmlIlFKXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPPojzVT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPPojzVT"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eeb4508f29so11292326d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 21:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786768757; x=1787373557; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R5oldsE5HfnObe/dtS/Ne1VikAkRdHgZDH55HrMuSDE=;
        b=sPPojzVTMqZzPMD6t/l5K/zzjATAaM87hmkohfmQjvClSsJXwbJJFvUanUxO7Qq1Xb
         TR7qnJeGO8AAC3vshhz0G9XXTgA51RNQ8akROCsOzgx9KtGmj2z0E77f90MDgXRkoQhw
         FT6m61TqllXGBRmM9UbapmuXm0j0o6DbDqzNQ1zgRnxysNIy4R220B2E/FPFAl3jc9oy
         v9Mbj+xU+SKAlxh3bBnsoU51/NvaE2j1mgFjrU42wvk/VyFJRI4sGh690I8+pvBxKino
         jpodnfNU+ZDC3GLSvByUHdbtnz38u24RcE3n5hVgIVVzFxZ8pYXVBdPoSMI+foKpkvkn
         NNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786768757; x=1787373557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R5oldsE5HfnObe/dtS/Ne1VikAkRdHgZDH55HrMuSDE=;
        b=fuvGv75MKvZqzRrk92AwUNFmG4QV4I6B0VymUj5RS8GUg2410C0LeGJVeRxDcFDHVj
         awrXtbyLdckd8WDjKuXXldtbROXbTefnBlrKODboNwSsne795GdeBIMY8L2nbxUmr/zo
         Hjb14W2pT0VwsLupzVY1psUXU+AxZ2TA3MJPYS90VTtJFDqLWhOeG+uTsiLD2Go7OITA
         HlKXpXthcSH+JIOsv/ra1NOnBjg4faw4Mev0JdsoxKR9F/oRwi0pezZIMBj+JJ91TW8+
         ybTgb0kpYWnal97ikCSIMUIYcbF0mI9hYVJLSfXBIa1KcgwZ2SEhezvbCUWkAUFAOLuw
         vw/Q==
X-Gm-Message-State: AOJu0YzO2bTCDAv7TBUg+gKdGDd3MZwP/B8XT3xwcNkNvAW4x+J1ZKA/
	qGmreQr5fr4s1Nc74HP8VPf0l7mI2Bbgl3GaRg4ZOMSkc+bVLLOS2+d7eFvmNQ==
X-Gm-Gg: AR+sD11akbyQFSiORQxxr6SUXMZ4N30ViYLb8kbzj4yEkwKf8HjAFvz2i7K21O62XzV
	F2PwQ0It+AnNY3/L2XLdsba7pIhlTvtz7Of4H1WBJYESwldikxSZZzsBkagPTY/Q71XfQgHx4I2
	klckKGyXIyzDIRZbZoj0cRGZHZO1gpYCEb5igL97rColtIkCF7V99ittbRK+iN52GtHYtBDY90b
	ZvlEvid1iafpPQrNrSLpJlX69Nu3VmqyQE9cjzOk/2L2R/BbYDahpvohRj+g2ClytZ3qZtlvpdI
	VD+yq81p4Qb8dfnobkYDy27HNwL/0k+o6bwRsOXfcmTqsk8/CeF9xm51b1yHcv6Tg5sUkZo9J5a
	q0ZW/ELKnzhRjNAH/y5FQ1mt6/DtxfiQCauPBs38XMIYHBwrvv34+koubeZpzu3xwDpistfJUlg
	6nfrQcW17+upHgbDSnZbyP1ZXP+H4Y06A4qaYeI7g+jE9YohetDAuT/yu5HOPYF09/
X-Received: by 2002:ad4:5c67:0:b0:908:965f:55c3 with SMTP id 6a1803df08f44-90a91ca64f3mr127725786d6.10.1786768756845;
        Fri, 14 Aug 2026 21:39:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.159.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a9350a071sm33459286d6.30.2026.08.14.21.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 21:39:16 -0700 (PDT)
Message-ID: <6a7fed74.a374d419.a2751.0970@mx.google.com>
Date: Fri, 14 Aug 2026 21:39:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0355081542665598906=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrewbille@gmail.com
Subject: RE: Bluetooth: btusb: treat 0bda:0002 as a generic HCI device
In-Reply-To: <20260815033346.15882-1-andrewbille@gmail.com>
References: <20260815033346.15882-1-andrewbille@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0355081542665598906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146378

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.04 seconds
CheckAllWarning               PASS      30.77 seconds
CheckSparse                   PASS      29.76 seconds
BuildKernel32                 PASS      26.87 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      506.27 seconds
IncrementalBuild              PASS      26.54 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/586

---
Regards,
Linux Bluetooth


--===============0355081542665598906==--
