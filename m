Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858373;
	b=Qs8Z0QMTHC82ALhnIVbUQ8S3llJ39QEL/12nK1eAp9fR9SwW+bacocSKMA1/WMui8rf6
	 NVxkN36yzBWXxnJseKQ55B88yUgt2xtsluYe5Nb5VO5lulOEMzFa24FZJuKco5wez9NEG
	 R+9RPpar2MwV7YVSgcB4VIPDBuuT/Ywh6URQBNJPDmRHrWOUYxAZ6JFJG5WXlNS46g0Sf
	 3bnYjsD8rCIelZXFzV6Jtk0UBb6XIHSd9pPNGhJl4+R7WqeHIyhjgf04CyR/LTy3rNbjp
	 GMgPWjvDZ27bYR7Re7LBymVNEAjBrpOkqYWq8nW6/gGz9MP5kpQfqpzlFFcmbq0yUkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=b9Sl3F9xox2mVeqX8U/kTj8heLIiE733eGWXV5tt+/I=;
	b=O5RB+9jLqgALGBSG3Zq72Dvp8+3A9ubxTKudM9p7cGNrkZB3IqJDugBD2x9B5WQD4WxX
	 C8hDCKU2YxusrSyHcJixZ1njzAQuNsYY8XGP8GCMGM7BywXNt4h+tBsLc4awB7CBJ2vBx
	 IRVToaqN0DrmuRcwMPnHwztKFXpqgknlhD95T7qgUGdXm4Q3EJmiqhf1Ds6GksKR5WrkI
	 B4nmE0et3KMU6ZhB32QhaM9JbDM74RiOSd/6ks72YfTj0+uj0LCxGnC/PjbSQ6ZYp7niX
	 iGo5ASV/cx6sGLtBf7JLmnA9ncT84bDwrJjF0zdHgudhRVneHtD8UZzdd46O8uh6P0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DFa36bl7;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DE606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 19:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF4DE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DFa36bl7
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36f6295304dso3273366eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 11:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794858371; x=1795463171; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b9Sl3F9xox2mVeqX8U/kTj8heLIiE733eGWXV5tt+/I=;
        b=DFa36bl758GggBq212qkL2RFYvvzQ6PkK9JuX8qLECEEw/OL+bVhKWqbXF8l5lnqtX
         mxdcr3dAzo6fle/yH6WdogOJnJuZ4CC++iA2KgWYO8Aw9YedPrayRY2TVzPdfh1pEkro
         Xe7vuPzwG+C/40gwSqFAviSMrWVHW53xgyAmzeHUcpEmYu/9cqcHB0YtEPWRqCGZrTUU
         mB02/ddgU4lk1PEcv4gUgVrkP1kG/wGbUNgGhwEJ8JnSCnx7uD4H94ULWntDCX2urk0+
         Cz+EoQu3Fx2u/LdEuqpG2FtOPgYEny+btbJEwNj5/CpDQeyxBSd2Xr4nedmuQdTFoHer
         Fn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858371; x=1795463171;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b9Sl3F9xox2mVeqX8U/kTj8heLIiE733eGWXV5tt+/I=;
        b=fX5GwYGDlI56Oyb61Jpkdk2tL86cZKHJVok+DBmR/jed4u+xVQtLHuTDxB64t0mR3G
         845qMiOd/FIXQd3yvwcR8j0IAedMD6Heg2tlMxHdSkU1g4W7XYOZc1pUvdbLhC79/zXO
         36HurfxCPmT0MdAEecO3Q13MVTC3iiKQNC4SbYXwHezFECG3eUTm7qIRh5+hTXbd8mNd
         PeRAq414it5tdEav4vjYy8gYGyON1Blk/fZjORHHhakMrG+PMh2wobGRY/mr2XXQcDS7
         sb9HwNkKdh6Emc4EO2gKqbsD9sjDjMVVjhtpMznIqBQItlwrLuTe8SH8r8SWHJVKiTf5
         Euwg==
X-Gm-Message-State: APuU4Z8CDW9Jhz9yQkUujiqEoak7KOgdSEPH+UStGc8Ju0t16lJ5SQNo
	dsZGoJDbuwlOsFVgBK4B+QrY/2s6mdB2cHmBzzKjTxymorYs/tKUUvCCsou+xA==
X-Gm-Gg: AYBFou1bjdTrZGKZpSG5z+0W/M4N0Yr4qhW1jh+OJTk0VwdNMpSSjSh24G8+bJ5iWDM
	TOrTAe4uqEzoZMhGTLTtqVf8xAZZ7dcIfQEzzp1pZFqgZ0HCEkLm6xI10asYSrVurJXJQxRnFCd
	mnuf5qsy5v0Kiweksrlcp/KDG95g47IVljcSTb8OFJsA/zzOEUAGb9ctxDSgzegboMvxtmoOk64
	u4a3+4u2DmwJ9PG+1RRmu1lEfrXv3qbc+UBcDU6J5z17htF4F4f64uXCxwuKB3VpR7ccYcneeb8
	yr13NTI7sLoMWbl8UIxaxfmI57AFC9IDC4uJfJSbIu1djNE9emaMBne3MCrHWJu1GqNwb7xXgX1
	sEKkyeFH8w/5FWUIjgLOZl7gCp5O0N8d3j81Rmg4cra4Ov6+AP4a04HqKokGPdxVPP1id02kWwr
	0NRqg0QQp6SgcQqSWUkhLGuE9PsXUTjz6XntVJpRTTnqp4G/LAJw+hWxcMQP2KTnN8X1r3Uxfqa
	A5XsW2jyLnqCBGGv1C1lhYzVbh7YT5xdql+6rvx/NJkJnL/BXhb/Ta1GsMpGwVR
X-Received: by 2002:a05:7301:5f0b:b0:378:7434:a526 with SMTP id 5a478bee46e88-3796628f413mr10653789eec.14.1794858370850;
        Mon, 16 Nov 2026 11:46:10 -0800 (PST)
Received: from [172.17.0.2] ([128.24.160.175])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38115cfdd6esm632913eec.5.2026.11.16.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:46:10 -0800 (PST)
Message-ID: <6afb5d82.85bacf15.10fb38.9682@mx.google.com>
Date: Mon, 16 Nov 2026 11:46:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4659438787168203476=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@michaelmcallister.org
Subject: RE: [v2] Bluetooth: hci_mrvl: Leave the serdev port lifetime to hci_serdev
In-Reply-To: <179484691454.54083.14464729860702732145.marvell-serdev-v2@michaelmcallister.org>
References: <179484691454.54083.14464729860702732145.marvell-serdev-v2@michaelmcallister.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4659438787168203476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1212990/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      31.51 seconds
CheckAllWarning               PASS      35.84 seconds
CheckSparse                   WARNING   38.53 seconds
BuildKernel32                 PASS      31.61 seconds
CheckKernelLLVM               PASS      35.19 seconds
TestRunnerSetup               PASS      758.07 seconds
IncrementalBuild              PASS      30.02 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_mrvl.c:156:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:189:23: warning: restricted __le16 degrades to integer


https://github.com/bluez/bluetooth-next/pull/1141

---
Regards,
Linux Bluetooth


--===============4659438787168203476==--
