Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02F3382F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442222; cv=none; b=DeGjnRucJgmI/Lfyq9/FtADfxCv/RabXLBTjxRUTKY5yFh5xwJbgg5+/+tjfnNKvfP+ZXxsXVsnSlYGlGtd5L2RlxFgOeQaDgWeUu1LFaAVeODJe5NvervBGa9zkmG+3CNsOAE0tC4ausFVCS3SsISPjzpNnZW05dZDhWYGujck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442222; c=relaxed/simple;
	bh=7FHP+WnpqzzV+XFSQgzGqPFx7dDxdoP+nRqE/HP9TJw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aksCBdse58HbFoqPdTrCNU0htRqHahOaBF328OkVKUfSXLMbzM+fQWGbCerPgFI3ovy4CgP/MLDVjNceQszpR8+/3XZDHFnc638vjS9B86Trps0iaIn8Fp91uupuC3r9YhAB7d/aVNUxdeplfhU/SJB33bt9pUQc1jxx3dBO+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV+zpLrL; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV+zpLrL"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-124877d78a6so2105659c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 07:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769442220; x=1770047020; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YMiYAdUmqeHCVPAXClxasoPV2EmcmunrCALxOfs6hbc=;
        b=lV+zpLrL5erMrPTiG9A7fw8SpZP+dQuZrLNxCLv8bjdopu8PuwNZSdRAXY7nFsAbdC
         LXaHOLEpiK308OVEMk1tGMaGsjGBHUcH2wAbfIFvbUE9Wjs5nO7Ibwz1DkI6DGhDtWNu
         7Gbg9hhShRCaf1B3SdTRrLh3kOv+IDU8/P5Mxe/470qRl7YdtjdJwsjIK8ifYy22qBa4
         4TKNoJ5jyaSToL16JHWFuoGDbar+9yw5yiIZ1grgL70VsRTg7ApuBpAFWekq8GoFaEi0
         H0siOWRP5amtOvanHZz0CR3G1NtAEplO2WoJPyweX4TUBlmdEbes7tkh/pFiFwdIJDzg
         ioCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769442220; x=1770047020;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMiYAdUmqeHCVPAXClxasoPV2EmcmunrCALxOfs6hbc=;
        b=lTd5IJPIlmpDvr3z8h4SrMyoRTOF9s+UoJuT2LayDNEDK92LVgp3w7r6wRrh0m+v5S
         XPCck4C3fO4hE7HgoUSTiW37qFJKf/8LsEtai60uCA2kGEIZi21duGJHX3BXGunhHWCl
         VAg2owKiIYrFv7W7yxNihGy5a0G7zhLR/pmBlE/O1M/ZmCs0CkVAQkqo4zq7QDp1Vboj
         NU8wCk5Q5LzDrPPI+Ea2DkMUck8hip0O1eYqKFFk56xJZhsmvI2CPThmmwHFYj2869Zc
         iTLU73qTnAujB030Gqh6OU9tIOx6XyuxSPIcpNbdNNSit+4gvSOpw6J2fMpqEHAHYEku
         RQ0w==
X-Gm-Message-State: AOJu0Yz9GOm8C3pSi5ubDWa+E3SVkDycbl/Rq0qqyhwQmUXplWHfmLaD
	kwuPA0k284fTYxgNdYZA8goh29BZ9I0ChOsL4oRNlkFBZnFDCoIxQuMmi6KR8WsJ
X-Gm-Gg: AZuq6aKImCvbgNn1qunOyP5mlAokgh2ob6qZTgHBV8Opw9I5IOSlxoeTTLomPmjcvCl
	SrpVKViK7atqm7Kf/jpD9p90tp73b7n+rzE+E/ZOpORFTWLa63vUTPOQhcWSDuONmVo5ZwiF4jf
	+jvhCml49zD8Rdm+JWxQc9R/ts1NCZPCxGYBZIX45qDM/f05qpcBo2XkmIRVsKEaaEUef85qBMk
	60VYxIQh4GE+f4epCGDJ6/bg4+2otldN5vPsL6vkNdp+v71Gt+7BmAF/1oJNQwn+rzT1HEHE59z
	UkwvMcbr1bTgBh2E+0qLHf7IhcAPHczYEZjRw5GRBL39THh49dB1TCaFAl4GlSvl+TTVFYUtAGg
	rVghdlDx2scUIaLdg1nwnlDLNcTMme6p9x6QwE8boXycIZtHROrcPIG2PDPh+8iLt7sri4teb4H
	TSfZZPQKtdFBSCUYxmio4=
X-Received: by 2002:a05:7022:1285:b0:119:e56c:18be with SMTP id a92af1059eb24-1248ec69e8dmr2601993c88.38.1769442220010;
        Mon, 26 Jan 2026 07:43:40 -0800 (PST)
Received: from [172.17.0.2] ([172.184.209.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d997f7bsm19945994c88.11.2026.01.26.07.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 07:43:39 -0800 (PST)
Message-ID: <69778bab.050a0220.2607ab.815e@mx.google.com>
Date: Mon, 26 Jan 2026 07:43:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0336068945033486055=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/shell: Fix not dequeueing command
In-Reply-To: <20260126144705.3516388-1-luiz.dentz@gmail.com>
References: <20260126144705.3516388-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0336068945033486055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047149

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.49 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      658.01 seconds
MakeCheck                     PASS      18.17 seconds
MakeDistcheck                 PASS      247.03 seconds
CheckValgrind                 PASS      301.05 seconds
CheckSmatch                   WARNING   357.92 seconds
bluezmakeextell               PASS      185.68 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1048.09 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0336068945033486055==--
