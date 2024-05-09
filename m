Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5917BB12
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715298095; cv=none; b=isBYaz59Vk4VnhyQdORu2rStbiJyphRKchpMLm0ToyWxUSOV+Tqqd5/nFc966kUafJjAyV07crinaoOuwYsWZXqj5kVFp2bgNNqYN04Ho0Dh0UaciBfjdcDpEB6JVwfE/oTc7QvTJlRJmZ7gOd/NKbFLShB73XJHXGEyYcPTJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715298095; c=relaxed/simple;
	bh=nMXxuSsQxHaTIoMCv00+AwVdIqfBBs2h0RMB8hON9Us=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Q/NUWmTII+tJ5En0CEavXPziCbyvmCjv7qfc8GykMZUTM98XOtxVOt9Wh0lEJ+aPC/20OIIC0DsRbNEX2zvh50Sa2pLy73n50aUk9SMtvtMWkSd/B4YdF0z+gCsSUWKCzDtsBR/lxpTC1lD+ELbrPZn9SH60MPh4nUjj5xDbmVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpAmmFtW; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpAmmFtW"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de8b66d1726so2169017276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715298093; x=1715902893; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LP7kzxN7Oq80bB/sHDPCMzhqnPh9WHSbRkcO4b8XrRM=;
        b=KpAmmFtWPP5mHDNnPwwMmAbMHpczLZHlO0L8oS7oFk2Nqz6ROqUqrvL8YBjwDrassK
         CQyLVjMrl1drmM+/8GAEOdJAPnuJS0oaWzZOORO/yNbN0bHC0u/dBB6SUcXzf1f5cmP5
         VApTQl6glkm5Y9v3kIUqjZrZ+FJ4Djr3vxMz7VLZvBXe9Hx/h4bSxKSPWN692srN1nKK
         z94jQ1D/C/SSlbRazYrDD21z4YnsWySWXaLH5JlHE+B4ezAeaMJsJj2iQCcpFuk3Txb1
         0D7t0ucLs2kuOEKiU24foFwFPH/Zh33Hxt94xVwN8GeBz2zMOFyeTaRDRFTrtb8ww8jF
         /Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715298093; x=1715902893;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LP7kzxN7Oq80bB/sHDPCMzhqnPh9WHSbRkcO4b8XrRM=;
        b=UIEmMz4iJGmgsf4Y/w7EQi7F4LnhKbiAtMSeIjAwxgfFg2rr7aEak9AcjaB0VrdPch
         U9CxSMXche4BSWcixU4m7YcXpqZr9lurTj2mG5RNjFAYmg0CGuuJshYwRNeidBrgKK4Y
         foyP7tvWxcrWTGj2ty3O/31eEKGo2tA/ANwrhWbA1fx2FdW8mqpj2x3UeMfiFpAO+qJ9
         Vn3YW5LZf387TiuDXCJnqTvW3SxkvRXk0HvWY2ovL0NwxHwdKizw7OUsPCa0dimUmkXG
         OKSvdgm55ewd9Kj601piDzJXvd46CNzwwl1m3nhDmVSbMKuHl+OBG/CwTc5BzwpIEc+s
         RMcw==
X-Gm-Message-State: AOJu0Yww9c4RqOBd9nfHr3hj97sgMjhZmDg0vG4kZCnJbNnxm5VagOqs
	YsUoL4JYJWteymy9QipG9fs0DkksTCDfYzhsWpf7UzEMUAsy++t0nlSsGQ==
X-Google-Smtp-Source: AGHT+IESoCMu8qOmru2cWxASAB6nLbewb/l3I/z5uzSAWcvrCs5smNURGV1ActnWZAV8yj77wlL8KA==
X-Received: by 2002:a5b:2d1:0:b0:de5:59cd:9b04 with SMTP id 3f1490d57ef6-dee4e4a647emr1040674276.13.1715298093149;
        Thu, 09 May 2024 16:41:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.245])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd3866d98sm536919276.65.2024.05.09.16.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 16:41:32 -0700 (PDT)
Message-ID: <663d5f2c.250a0220.4bbe9.2906@mx.google.com>
Date: Thu, 09 May 2024 16:41:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2333713179843699373=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@prestonhunt.com
Subject: RE: Update python2 examples to run properly with python3
In-Reply-To: <20240509214231.2783781-2-me@prestonhunt.com>
References: <20240509214231.2783781-2-me@prestonhunt.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2333713179843699373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852053

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.65 seconds
BluezMake                     PASS      1733.09 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      179.31 seconds
CheckValgrind                 PASS      246.76 seconds
CheckSmatch                   PASS      349.98 seconds
bluezmakeextell               PASS      118.94 seconds
IncrementalBuild              PASS      1628.80 seconds
ScanBuild                     PASS      993.90 seconds



---
Regards,
Linux Bluetooth


--===============2333713179843699373==--
