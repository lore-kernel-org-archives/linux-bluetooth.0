Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14B48383F
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328159; cv=none; b=PY5R1Ed9bzFjD+elrPPT+iwb2hrJdR62DzPeCsinVKEdEwqIbYC/V4rwPOOQ2jasGxLIBV2GpISagfINbtJChcS5DZ6YcF/KzjxZcz+7NLRxK5hCfO8Gdmc5NGUaETN9N+mD/wMZ2ZTbFFn99lhggbva8ApxTs/p4sPyXltZokM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328159; c=relaxed/simple;
	bh=sU7DS8mwXAZxSQ6WTuf0oI8pVLggqR+ncxENbE82z+o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t5n7223XG/BQRlE7E6rDuAmN9kLmzQhlrPaQg4YuIFM7fvvELSB5pbAEncXu4ouDGAkdf0uSHx896tqlSj2MlkewrSqJbsbbUt6/yDHrisRVwSY63h0QGNEC5zV3ofNR5QEVY0AFczzr4dlcbaCKdDgXVzlJKdzdXGwunwWG7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsP2ep2+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsP2ep2+"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso540147a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785328152; x=1785932952; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QKu0eBXlmZtan5WRhNEspAZWeaycYJhyK4AEP2avGh4=;
        b=IsP2ep2++TnLihigm9PR4fJ8d2Cndn0CdKd8QlWqGFBz+jOPmTDgXwC6hnFzF0GTMy
         SlEU+jaDyls6aJupSTxqP4Pn14eywNHwBWpWjETgUSgaIeBzXlgGD9ULsyxkL1oRG8m9
         jVHRsdQZypLpGwVmbEaJ8QWVBOT6/FUUFVONLZwgN4zuBRuV7OUWGl5Pgo0BeK/jgvQp
         9hpDeawfk/8noNSRNZ2a863uSzCZC59QB1ImpQ89FuwcLMlsC7v8uejQnXriLEo03IME
         hR9IrvQeH/5hwlqII+w2Tv+JXNZpJz+fix/jlu02F5P/jlH/LXXt01/tXTq4G9EX6YBk
         8/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328152; x=1785932952;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QKu0eBXlmZtan5WRhNEspAZWeaycYJhyK4AEP2avGh4=;
        b=FZab1PuwrkCZAs2GNnjApkZSopC7xDpos6s5bWDtyA19km5B69IE+1wrVrWoz83/wE
         +vUxpSWKN9DyWwRjvj0dWjxWqGUsi2/xhw3a1TUTzSoiT/LhMvy9vGC8OKuZPa5ree/d
         O8h/yPASTA55ABB7kp8jCAJvnsovh885zpizlHMkQR7J4siU1u3L0Veh+b/Bm33gy9y6
         h8kt4sTh03Blapg2ScOeUzcmdLR2dJYiQNVebCCLMoF8tvT7fxYPIfps7ucSHNwlcrPs
         MqoG1IFqypHe7h87t87D4huKVWwuO0mDvV68n4lTxd7eb02FZy0deYJuP0VcNStOuOkB
         0kDg==
X-Gm-Message-State: AOJu0YxiR8YxDrT/LOm3U045RZJhylpISdSaJnjc46Rh0/wTd5b1OwRP
	jLWQJ9L19wn2lJUC0mOKDY2fXex1UbgybNJwq6DqRSAT0KR8lQAo2F0m+9tWAA==
X-Gm-Gg: AR+sD12AerPCTZ7JWn7b4giPeWYzZu0awp47Hw0jXZ2fFkxfZISHxqASgJDpQoGaZ57
	m6SzhL60y7wAw50AFxjTyEsAC6AME8UBBdw2InfHva8Zn9T0wzrVOixB8oD32Oj6tbv1bZSGVZ5
	TqEhiNV4t9ET7csXbXR6EsuuvCp/gite1Sj7k9ibuWSOPua7eMRabXm6myqiHVS994uISPed/tn
	IJlLArv1WSB8DngAWdjAv2VAac4ORatXd9ljOHVmYCe/5VJEBQZorxpil1jIsqvzL9HaMWcVNhv
	AqVSPjVsHZ3oxbSzohXU0AFUM1OhWZvhdkY5JJIbpGo/tvJtioMi477WWoxOsm4MLRLIQPnewM3
	HtB4mLwDr63E+VhVFvWH+k05HMEKQShvnhoX6kMb5P6aAaGqzB8v7Wmru8f9Z/RgIIyOW94QH0V
	3tZEbKQOcUAGAvMfdznEnHDD16jcWoqSGWq34vp2r4R2djM9xIx3j08VHU6EmNIZdW93LwfA==
X-Received: by 2002:a05:6a21:6083:b0:3c0:9c19:65b1 with SMTP id adf61e73a8af0-3c8ba6476cfmr7662390637.73.1785328152411;
        Wed, 29 Jul 2026 05:29:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm9022200eec.6.2026.07.29.05.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:29:11 -0700 (PDT)
Message-ID: <6a69f217.a1accbb4.5fffb.7563@mx.google.com>
Date: Wed, 29 Jul 2026 05:29:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5226598968907850034=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add CS procedure data aggregation and D-Bus export
In-Reply-To: <20260729103019.4178720-2-naga.akella@oss.qualcomm.com>
References: <20260729103019.4178720-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5226598968907850034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136563

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       FAIL      0.76 seconds
BuildEll                      PASS      20.35 seconds
BluezMake                     PASS      540.34 seconds
MakeCheck                     PASS      19.00 seconds
MakeDistcheck                 PASS      160.12 seconds
CheckValgrind                 PASS      229.19 seconds
CheckSmatch                   PASS      313.06 seconds
bluezmakeextell               PASS      103.83 seconds
IncrementalBuild              PASS      546.37 seconds
ScanBuild                     PASS      980.56 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/3] shared/rap: Add bcs_procedure_data aggregation and procedure data API

1: T1 Title exceeds max length (84>80): "[BlueZ,v2,1/3] shared/rap: Add bcs_procedure_data aggregation and procedure data API"


https://github.com/bluez/bluez/pull/2360

---
Regards,
Linux Bluetooth


--===============5226598968907850034==--
