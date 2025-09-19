Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B811FF5E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275520; cv=none; b=a2qdGxRxvE3CDWUqe6SRhN7Dj+RQBLsOyyqVDEAIbyDBYZLaOHMMZb1F4BMZv9leSQyofk9lI+Fui0NoyCoupGHcgQjur4C1y/pPPdpAqOp9GA0uhHS6T/ItYBKr8GxjXHDiIduhR+gL3ULwIgOdj0dptPs8BohUdbhvXAkkuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275520; c=relaxed/simple;
	bh=7N8M52gUIVOnF0G4zxiiF+JAIiymRhEfrR2JvbcD8Do=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gPyrGuyozoIAaMsS7HGUX0C2ruCE5IEj3Zzvi+GAGbpwGR64nD31utCH+gyNRMazNFSWHfIZoQExHazNMOrooIVf1qTKiEg9J0TX0en+UqZ8YifWmavpvWhbH8q/6rS3aU+dX/uFu9PCQ798NXHLkcJSpagojAIlS+KD0zdFkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lovkmbh+; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lovkmbh+"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-892db7eb552so252781339f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758275517; x=1758880317; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XZIj5WU9ro0DWk33YYUXCIQN8brG9e1/5OB1ge3l3H0=;
        b=lovkmbh+ek6uMjapjqiDhuNoMT8WPXRREWhuCKBGm4LryZOBPUeV+nxpMVLxnDRu0K
         xgc70Xt1b2kughsP20i2rwk6kQ2f0LVLLFc1YNoLuqi+zmfN/J1NWmgEsFoRhY4TUNrp
         x2rZPQArEp4wtNVhY98e/12AnoirHIrJXQmvxfTBl8j1xh3nkT+iwNN1Vyuj+o1H5paq
         lSwWSRA5whAJPgDMQYnRgalytcPEwYdK3fBZbLUCd/NkUn6f6msOyS4f1rao2wtFcH1i
         SQLZbO/vPEU0gxqgq39XtAskzz+ZFhlCxueQP/bfziE/eupBrBpxnQNW1fkt1EOTIp5M
         86xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275517; x=1758880317;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZIj5WU9ro0DWk33YYUXCIQN8brG9e1/5OB1ge3l3H0=;
        b=wTZiNxKXl0gr/BpVNjL+g3isW5poihJIvVJ83FNAnck2BUaOYtrOnqg1QFA4KsoQQs
         pTSyRYLfqLQ4iLV1jnM6+s44TMS/5X6GzcKx1csFuLvIeuUC1pqx7PgjUyb2Tfqi7Zt0
         G8bvkE7cmRyNOgZjkUe2SV+rJ6ghAuJk+RqRSTXEkBzujZc4fOghMlRfMRXEGeVJVEp8
         kDPXb10+Whjf8zC4y3ZHvQPolHOJb79/oHbQZJjRzSeDTMdasjvuPLauOKr5xREut4UD
         y49gH2SFithV9BOlfRWbN40aUtbd0wFPbRfE8H16d6bTBlGpefFdDMrm1MU8UqLkZpuS
         mmPg==
X-Gm-Message-State: AOJu0YwebU5LGGjVuvkduRxEfCqLHY7e0Suhksf/DhKFDW0OlgTsy47u
	Ym0GJ+8r9Jdxkrsnev9Ag/0SIFAl9KwumSaac5qKOJq3stcf86Li10ZRFvQlOw==
X-Gm-Gg: ASbGncv4CSrt78U4GU/D43mkNQjUiEFffpkdAKf0ipry17D4os0+B0u4vVYmGIlLxQE
	hU+opZE5FxirXNsX1oMjnwAx/j9U6LQk5QhrwEj+HOKHJWRfRC7T0QbhpDbAmkeHemwizH/JhoK
	tiiagJMlELfwFRJzDShAwbSHqtBEB2tg6xxQKTtBktD8TzX/8FGU52SMNnMOI9FgjWXIErOaBrO
	/wSdPm/EZiYT6ueyon/SpseL2Pp2R/fsKr0pBswK99Z7pj0fu+U2wWe9fu+jJ5nDOh3P/SeMC83
	uSb5TojutW/iGeBOJw4Vs8L8iCtNdasofaOMqGSzZdoERI8fBa5yYdswq8PPNcQEkdE5jjhGHOf
	5mMhq1AMFZlenh9LWEAWzZGtq5SZI
X-Google-Smtp-Source: AGHT+IEUevKPGUJBCTOPqsjaWCAA/6DxxzLJ08xrgMs7Fl51sVUnpLHQ8pSpx2++Trg6uxHRpZryDA==
X-Received: by 2002:a5d:8757:0:b0:884:1e28:904e with SMTP id ca18e2360f4ac-8ade240522emr348108039f.12.1758275517414;
        Fri, 19 Sep 2025 02:51:57 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.201.22])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a47d92024asm154857439f.13.2025.09.19.02.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:51:56 -0700 (PDT)
Message-ID: <68cd27bc.050a0220.1d38a9.2a07@mx.google.com>
Date: Fri, 19 Sep 2025 02:51:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4640931052885327213=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/5] shared/hfp: Add Call answer support
In-Reply-To: <20250919082334.1443310-1-frederic.danis@collabora.com>
References: <20250919082334.1443310-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4640931052885327213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1004133

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      2679.69 seconds
MakeCheck                     PASS      20.10 seconds
MakeDistcheck                 PASS      182.73 seconds
CheckValgrind                 PASS      234.60 seconds
CheckSmatch                   PASS      303.29 seconds
bluezmakeextell               PASS      125.03 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      920.75 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4640931052885327213==--
