Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226137755C
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778224194; cv=none; b=RnNBVHFXJGa9ID2H7BLkWaXiaAo4ZhMma1sF+JsuPAx+7yu+/AmHt4k9OxhrcPK3WQx5auFdddEk1OOq+3heAz9UNWQqMUvevWMkyB831D7fTAK2jSNa/Z2SCuZlYYrdmG+PCKPIoYEMNMSMhesW0RgLO8/jTcq1TSAwltQp7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778224194; c=relaxed/simple;
	bh=l+yN5nMRtFUtosAediu/nb//BmITAol/CBGSs2MxYHU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J4tDpeXj+PousxLkaMcLQjyWr4jAbFne+F4utoeFpPvUypEv3Ejn86nt+Ihk6BcSk+t/U/ormdyFv7sxDfSJNv15DLeKDibR3iKKBpJfbcS6bFtlPkCk3afgL3fhnjI1AHIP5TYqO7TrXwwcZulkzIajBJwYW/dz0EtWW0yGgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgphJpBQ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgphJpBQ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f33ae12f97so168448eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778224189; x=1778828989; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mRVunwQGPGk/VN7QwXj74BmmP5dnFL6CncO80stg6dE=;
        b=pgphJpBQmPNXQgmxLP55hsgAPc/md/xuh33jw29aNRfypciyF9OIAE91ckeIEexeJ+
         rvrwSI9QCXZVdSQLDCak03Lf7xvZZunW4Rm3dYgJUT3QCwOb0Y+pR9mmpqF4LnEBKAwQ
         EyeZgxHd5WvrfmtZCZ58BfG/9UOrlz0iOXlXzImV9Chq5zy1VYbnX0w0PeLIYmO/gFvE
         asmB4Gg3s4PPNc18+yVLP7cdymzHoZ7J+tWleNx+J6moXadd+TXbO+BOENZNFpar4/Pf
         vru63q7IQ8teFNT8r1d3a5sqGiLfcQfwmIWgiBCsFX5+Xg2Hl1dsojMqn+Vokqujhhfb
         9dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778224189; x=1778828989;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRVunwQGPGk/VN7QwXj74BmmP5dnFL6CncO80stg6dE=;
        b=A0A6y2mTYX7eMSJwddysth5OMMkgsEnszDLtobfcjjgUnlhjUgF/GL6xuMl7d3zXBV
         nu9QVRj1JTU4IraUQ9BoOggiwYsVeTQW+dWX1XaaDC7uZEzEN5NSGllwZE5MS7kkIjkX
         issWyCKXsdKuYn0+seYlfpQ+h+0v/qwERM+93yU63J8+n6/7i2DoY96Rl+/czlc1D8m8
         ojsSxjxg9zl1t2AVRsdDwPWciZF4GQUR+ntHJcLHwL/pT+d7juwMEROt3nNGhwgmcbzp
         RT45F/V+7LspWeSYTZEQyUWEEVTVmuyMAYGiFqJWfaWjUC5PKcoNUp+nCTW+apQ+USX6
         U5ZQ==
X-Gm-Message-State: AOJu0Yy7/YtQbiul4n3znEPvFNLhLwkhv3lxKM7duIiQ+soLETHav8Ud
	pCIqFPqhfSrMe4R556fuzkHjGPAnQ4YJQtVgrPvHsyEMDItY+KcdW2b4+mrY8Q==
X-Gm-Gg: Acq92OHqiGdBF9r0OjILA13EtvzOyn//3+TfxqWdO3AdMhvSwFY14b3o98uEd1St/qf
	T1hkQaFORLaFVTzjQCUR5JiSa4oYYAOuYe0pGEpSgoqfxzmveYEGfJO9omesghonuc7Bs3hrzaL
	OV0a45l8rzOwi31LUDLY28100iY1SlghZ4Gs1LcUMDoGG5WSDEVUm+BaqFBQlJNVlhoAAd7tqCM
	0h5GQ/yLR/1C/H1V+U+1KP1uS9vZOMS5ebQVrU3zXKSSFkD68pmuoum7HutJflkWSW+NyPWJP7a
	kYOnB5VLy8vYQw3MUeYVO8zFXdlhzL8aLyNefR6NWF6wgiRNhTSqf0MrSreVMrTDSyIrd3Dua59
	kUuRBe1k5+tRYoasgyUAed0+x2tf+mukRT84tOfevJncY1msRR+uU1flkDWfghhbS0tjIHoOIic
	RZ2BO9pMLVs9wFWE21UQ2e2lMw4riQsTgqSGAMfM3P
X-Received: by 2002:a05:7300:3207:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-2f85bb73083mr829586eec.3.1778224188988;
        Fri, 08 May 2026 00:09:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm1297343eec.10.2026.05.08.00.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:09:48 -0700 (PDT)
Message-ID: <69fd8c3c.050a0220.2f853.c5d7@mx.google.com>
Date: Fri, 08 May 2026 00:09:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7667693177782158273=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v3] monitor: Parsing of cs step mode data in RAS Notifications
In-Reply-To: <20260508053819.3424918-1-prathm@qti.qualcomm.com>
References: <20260508053819.3424918-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7667693177782158273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091417

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      653.56 seconds
MakeCheck                     PASS      0.88 seconds
MakeDistcheck                 PASS      243.78 seconds
CheckValgrind                 PASS      220.27 seconds
CheckSmatch                   PASS      346.56 seconds
bluezmakeextell               PASS      181.41 seconds
IncrementalBuild              PASS      647.01 seconds
ScanBuild                     PASS      1010.36 seconds



https://github.com/bluez/bluez/pull/2109

---
Regards,
Linux Bluetooth


--===============7667693177782158273==--
