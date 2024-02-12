Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E513F9D7
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759122; cv=none; b=DMg0uGhT5ff3XWj0uP0fQ0irofDizJLACNEe7/WNRvNLnurwd4NV+2Ck26MUqyyYvIp/Tk2Q8XyhWn7ccmzg4s4fZcFr3BJ3kp0tFgupdC+oa8xtgZtio3qmRWayFnXJ6uQH1OzuwRBBVloeIcxFKwt0vOMiMe/pEUeK4g6gSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759122; c=relaxed/simple;
	bh=Gf4d9x0W+IG8tf9VP18fDWs34cYPIqYZmSfRO+6sXG0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PkpIQt5Sldti9WK+X5eVE2pZ0K5YXElud6YNxtysaN0fFY3B2k4z8STtxSCDT3bZIiYG5UID5Hm0hFt2EGpwwJadcdqF7NGV4micG7i5jFceryd6FPJN4AqEpmqdzLsWg+c1iMMlFfZFcUMGN+B/pMEV05Db456nM/gwuBIz/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNY7ybJN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNY7ybJN"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-785d60ae6d5so59953485a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 09:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707759119; x=1708363919; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oTJuAyT7qytIRimzSqx+jqVhFpFGyIb1Z9Kyt8C8eWg=;
        b=kNY7ybJNveBG4srnjJGqS9DghMauAdc6kdU1wG+nYu5mUD/siYNwF0OesFwDe4YVeW
         OHkxYjg9T5cHya5aqKaxLqYVkT2XlEQAWjhrjSgdbLF/8gth62QnMH5eDGEldKcf2k9c
         aYJwPR2mPzd1EgLQxwJZUKjtFbXtvxyLsT/ZIhjgY/el0gSDQSptZCVM8d6uCgpz+Dzs
         umemSZFIokcTI7udn/TXgG9cNaXAy9u/o91UQ/4cgxFkhsXbAMFkpOYNHO3UfsQCeK5t
         Y3RdY2K1rXhNM4XHHZQ8oIlqbRJ7ZH76fdFu6whKbLcdEn5cpYIXyvA7NnE7Qxc2Xbtw
         hpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759119; x=1708363919;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTJuAyT7qytIRimzSqx+jqVhFpFGyIb1Z9Kyt8C8eWg=;
        b=X7jzP+T+7B7TIHjvZtjIARxArJE4dUA95INQLKm2Qol20m5zFS3DWDvQL8QuoX3E5U
         oDCR0OLrel0nqtCa6EgstbVd88dvBtLTogzCwWdIc+jBkRI5L08SffEmUrLl2S6v8w5X
         MBgbSqilMkFlRsZU1xquLfMyI15Qa/DUSaor7kmOY4JaoQSCdRo3kwq9YCWJp9fALBCd
         kp+3du2ZXoUhBtq8O+sUYid10yDu7wGdv/qZ9Y2jEMaGfPs+swxqsW/RylRwiZ1khziT
         FvewNvjrraLnD1azfUGDe1IBx5s4OHkN2OGiXkk6pAKO9SHF0xZP1XQoBdc2EDqQC8HM
         oHBg==
X-Gm-Message-State: AOJu0YwvUoiimsz4hc0WLo9ZYIDLgKB0Nw0NRTyHxuFeIMdZ1vOPHkqS
	Torp0YqfmjfCMD7ZyyKU62OBe4TnQXWNiAcy3JtZI4Sd96GhTG7GtGwqf/ZM
X-Google-Smtp-Source: AGHT+IH9lIbz75D3pzeRFfhnWaaRPxgTgM65MRTrpHRkNGtuL3X3r4hSRn8YEXJmfKJn2Dvp6Q1o0A==
X-Received: by 2002:a0c:aa5a:0:b0:68c:aac2:3020 with SMTP id e26-20020a0caa5a000000b0068caac23020mr8933701qvb.1.1707759119658;
        Mon, 12 Feb 2024 09:31:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4Yg9SXW6HDSuYqpu9J/Zn28vuwCKCc+PLsLXeJXZkJKX2EBNswtV6/5elFI7/48lfzxt5U6HsUkjJnRevV7P3KbjZAr6KOSCq
Received: from [172.17.0.2] ([172.183.131.64])
        by smtp.gmail.com with ESMTPSA id ef11-20020a0562140a6b00b0068c9c9321a2sm357566qvb.35.2024.02.12.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:31:59 -0800 (PST)
Message-ID: <65ca560f.050a0220.e43f2.2f63@mx.google.com>
Date: Mon, 12 Feb 2024 09:31:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2119296762330132434=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: shared/bap: Fix wrong value used when extracting LTVs
In-Reply-To: <20240212162538.32207-2-silviu.barbulescu@nxp.com>
References: <20240212162538.32207-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2119296762330132434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825274

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.62 seconds
BluezMake                     PASS      712.53 seconds
MakeCheck                     PASS      12.10 seconds
MakeDistcheck                 PASS      164.17 seconds
CheckValgrind                 PASS      228.26 seconds
CheckSmatch                   PASS      332.71 seconds
bluezmakeextell               PASS      107.42 seconds
IncrementalBuild              PASS      673.59 seconds
ScanBuild                     PASS      954.73 seconds



---
Regards,
Linux Bluetooth


--===============2119296762330132434==--
