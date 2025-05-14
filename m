Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94139193402
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251054; cv=none; b=Jan+AroJ8IGKR96KKu4dZztg5Ocdhsp+OZv8Y8e5K9W8fHc02RWEgRUEtJlkkG9L4HpeU+trz/bgjcwKfvdLON9q3fU4tQ9fi6aybwl9GEwEGXvJcOh4nX9zOaHrPe+laEf4mDwkM2rv2yenlOPtpUDVPAJHjBgkI5aj3XRRLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251054; c=relaxed/simple;
	bh=cqZ13YPxq2ZFul97X2GmEjT63/cXgFfuXHh+gIFkWwg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cEuPbMhh1TdQh8dty5gX5zCfX/BAygDWphojdSBarrv3gBCL6nsdn8jdTP4w+E5/6JKIP6o1EiJcDXAVLIVbLzZDnl/HFmFxne5UUGbNcQWZG3UneiXORuh/bdARcwrEvuFcShKd0HeAbnzMXpt2MY1QzyTBx0acT1hdEZqSqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBgMB81W; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBgMB81W"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c559b3eb0bso7163185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747251051; x=1747855851; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SaRSMpFTNYO3nOq6PAuRUXTLwVGzASifJZ5q2RX7vz0=;
        b=nBgMB81WktkbF4Bsxo/U6oHrYgRKkW30Utnq83SqbMr+64ywukxuuoNhu0XiIU1vsU
         KB2krv8mCMFPN93sCg5G4S/wNaP5IiOKZldMUzas9+JVdRVoX/0HBTLdeIUmt6xJYnHn
         q4U2MYSZjZtVQdaEU/GmAglnjMEkxq8C6MnBe7N4oPXocbzGjQ5pgC+k4v7XiTb+5ZIV
         HClT/Db+wEW5HqqGMfGxHb0fGNPlNIxraO+yHKJjpTQpFkhEhjy7xG+DtsXkTKhKPolw
         mnFJl1GYg/vl3WvphWPwX83fW5pBYDYG8sKEq7Lg0dT0NZEjTPwKc8zfBTZfSZEaLEmM
         T7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747251051; x=1747855851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaRSMpFTNYO3nOq6PAuRUXTLwVGzASifJZ5q2RX7vz0=;
        b=Y62PFQ7BwFy7GOpSUc7ATz4e034ecv8IYOcX4lF7CambOGAG2TwaHkP9f7TzY1TJkc
         Egrv+eob4yPnp3vwVdsLPIVaNBhEkDHmrsjP++RMABU7H92ZJXCQx0QBjP1SH4EO3n/u
         UWLTMvJbokchpC91wZ2+C2TMCUhq0fiw1bSWGOrc7HS5SOC4NulIxnt6kTrRdZEbxPiE
         mSATthXJn6utaLBf9S8dUqls4xBxPJ2QwksY5FrqDOR1P3THrk2Kg5L38pKoCWGj8mCr
         NEYJofqOGwi0mg3k8br7UVRR56GfeHBzj3Sj7Ps+ImGlLv67+7OMrfsm1b2xhFKglxrE
         Lpdw==
X-Gm-Message-State: AOJu0YyhFrwSzz7wroj6ayUH+l2QqNRTrg5p0z2T2rOWIu/4bwa8mW9c
	AuA81afExc6jhs+TbItm4n/7Y5+eoUjHcDmm4jTB2+lsQyRP2qtQC6NoEILs
X-Gm-Gg: ASbGncsjYGSOr1MJNcM2ct3Mn1XNGux7vmEz4H+F7b4CcNtHpqWP4C5OvQNuf97Rv0d
	0KK8WOPBFSl/5T8t5X6yLVHe93f1L1xrpgRdBgFJbVBUhmT/mcXhIp0cWBPmV2fhvSCcRhlCvAF
	KH14dCngOPM64lN8FXk7yYMgzk66SADg7cDWvWdfpar+uJsjY3tB6FsQ+30R97g710PBMlC6znI
	7WmlmgRrx7pP1OyL+A47bsclsfUaYo7Tb0tOxk2YDl1iKbr/sLAYvNLTPHssm17nxZTzwmYjGxx
	O18nTjvK5oPZdjG2DK4nJn5oJ/s+rMcaULf+TjW0JROmNowz7jlVS1eDtw==
X-Google-Smtp-Source: AGHT+IFBY+60K8ykrfcF3j8zi2xatQTLZIprAM9GmSA6kNht2dkDuFHn/A+ymwH4hbt43wM+7A6+mQ==
X-Received: by 2002:a05:620a:408f:b0:7c5:6678:ab18 with SMTP id af79cd13be357-7cd28876ffemr599740085a.42.1747251051022;
        Wed, 14 May 2025 12:30:51 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.221.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f4662sm84952086d6.29.2025.05.14.12.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 12:30:50 -0700 (PDT)
Message-ID: <6824ef6a.0c0a0220.3ba16c.0f5e@mx.google.com>
Date: Wed, 14 May 2025 12:30:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6162954590601424438=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] avdtp: Fix setting in_use flag for local seps
In-Reply-To: <20250514180127.1399136-1-luiz.dentz@gmail.com>
References: <20250514180127.1399136-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6162954590601424438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=962935

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      2622.61 seconds
MakeCheck                     PASS      20.24 seconds
MakeDistcheck                 PASS      197.14 seconds
CheckValgrind                 PASS      274.21 seconds
CheckSmatch                   PASS      300.60 seconds
bluezmakeextell               PASS      126.96 seconds
IncrementalBuild              PENDING   0.21 seconds
ScanBuild                     PASS      898.76 seconds

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


--===============6162954590601424438==--
