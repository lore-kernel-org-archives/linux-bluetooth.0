Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E332254E
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779255; cv=none; b=PapfFB61YUu2bZ/Cwc4QjN9URJepJSomwyLpWsFVy4p6iB0WtAMuqFmr5aNZjINVcOpKO3Y2pGocc/YazEVQhbOn2mG4dWV0/3VuBtRNMg8evgf6A46bTz0u0obKpuGCxxm8vwQxsJCT6OTBEPaQfj8Ogx04Y4MJQLq6RgEeK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779255; c=relaxed/simple;
	bh=tgsG0Vn+FONYYm8YzoZaihGekyHkB+ARq0LWTJ+o2tM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M9PCMfyTPVb/OoslGhJHbkau2oRYussG7MF/x0CnutjPXQdU56t7TkDI388zAqt/dcRhFTTNwYHhApHYdkXLw9aY+EYwUPWF/L3aBWiQpYU9a05Eo9oTjum9LH9tpIlG5rG5zz2isZ5WMlfeyJAj3USHuOY7nz5ep/Tzc7AeC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeGRApSW; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeGRApSW"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c0f13e4424so183781285a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 01:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767779253; x=1768384053; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RGSii8JNWhtiYFV1SjkoXil9X1J7T0Yx1H0urE+SMCY=;
        b=DeGRApSW9QPMW6GbvjDNBjAp5tjeshsSlT8yCprIBchh7viALYRr2gMNI1dCm2P2Kg
         Dup42gQFtrn7Wo4hEvQw9MgYvgiMIAArA02ypzYZTGbN7/n4bwbTuVBi4plS2nvM1rd/
         XrEJDhKoCUqc4/JszVOM58SyW/CLMlDJoccgezhLyAi+yU8NfkyyGoiu9SVVyam82f/S
         XYFllUX1xhIMmqv6Qr8MvDlU4FgPnuLr8c2rU+Ltl30aywOxO8Gi42X3InzgImYkon+4
         N1mdjEhG9SR4EB7HMHOvnLPYOdLpPVRiCxoCxw2GsX1LCktxmR5MO8afGWPGttluqkO+
         6/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779253; x=1768384053;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGSii8JNWhtiYFV1SjkoXil9X1J7T0Yx1H0urE+SMCY=;
        b=gD5CSo5JaSgkbjrknt1RG3sTJ1m7G9Yg9B691vjrVayG/Aj25pP2cwq0ZwRz8JD3DF
         /uoq/z79TtCfgvgb58m459CifeHtyt5Isw+3KhYMAoyRH+Cjfuw/6nIoXemYdFksdvpr
         1+tpj1eMawNuVoXOt8Zg60pyWIVv3aqqdKMkhc3COkux8hgcZ0MYiSv0g5uNoLPT+zLF
         OfruvsO7IEK2pJfM5B4aM5yAQT94ecDeGxG2w1D2dJJJNdRlDOnaOy1uu+mlJhoyxgeo
         OQHqSuhYXf7QA1ZxrmZi9ojyX/EF3qvaJX8FD7U2HT2RNIFVMaa2fNH+41u8ITEKiJHD
         vzjA==
X-Gm-Message-State: AOJu0YzQ8BNuZc5guAKLIsixA+cQw9BcbJ2evscWZU+AFd+dZVHzWXWv
	ZnGqzQPuTJ0JGcjbn0USnjraqDZ+cqSWlEx1plU7ZOr3CuP01Mwny/s9ArfR55su
X-Gm-Gg: AY/fxX5K+DEyVYQUG/z5Bx+zprtvmHIHP1mktYpSfUK8NTDJGDTx/uGDrdm/egETT+M
	A9pSjW2WFvqWhGGjhueFTaxWFLfwQjun80Rg+QasEvlRrvXo3pUu/TA+QLdWQZidd9FSiMWstPq
	1XaNAtHTsbx2V+t+pO1sujO84xIXYGacCkzojfRu+CJJ3FFk7JEM7Y15r854cIrKWWoI/9ZhC4Y
	8gpEODOqR923KS0KkwPpgRqS/Dunf4gfkFG+9y/76DdAnu9yr5l8KhqPGNlqGkbz9mQsfVmQoNQ
	R1SCs7E4g5g2V/nRjwuIYWcBhM1NL38sHW0HJYsatlDXlZ37qxUsX5AzbtS0Zi9iJrHfEDsijcB
	yYXrQuXcnbr3q2OxL5intiQsCx+wqLIJC4njbOFPBA3Tb99fAUvLkiPp9gp7hXKSaSNKtyZAwv+
	SYXSP7Fugq6R1+9vah
X-Google-Smtp-Source: AGHT+IGsDWZwqvVVXx8KYQ8sgEtqOLwJXTHoLRg0kVDfHWgOdJLwnu/mRvsLDF7+vcJ+FyApyQvNrg==
X-Received: by 2002:a05:620a:690d:b0:8b2:eb2:54e2 with SMTP id af79cd13be357-8c3893f57edmr249135685a.47.1767779252771;
        Wed, 07 Jan 2026 01:47:32 -0800 (PST)
Received: from [172.17.0.2] ([20.51.198.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51bf8csm343685785a.28.2026.01.07.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:47:32 -0800 (PST)
Message-ID: <695e2bb4.050a0220.2a8161.7305@mx.google.com>
Date: Wed, 07 Jan 2026 01:47:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5775421658518586263=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Optimize the PA sync flow
In-Reply-To: <20260107-mgmt_ext_adv_sid-v1-1-6832b40813fd@amlogic.com>
References: <20260107-mgmt_ext_adv_sid-v1-1-6832b40813fd@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5775421658518586263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039291

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      599.63 seconds
MakeCheck                     PASS      21.80 seconds
MakeDistcheck                 PASS      233.03 seconds
CheckValgrind                 PASS      284.17 seconds
CheckSmatch                   PASS      329.24 seconds
bluezmakeextell               PASS      165.37 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      939.13 seconds

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


--===============5775421658518586263==--
