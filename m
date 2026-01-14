Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F822D7DE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430524; cv=none; b=rFsYIR/EWtGHNZsOevAS92eXXNvIInIPIuxWcNg0kjEzT2JpnQnUhjdoDZm2jqpRBmuuImFgUH59ZYz3Ap//+Y3/UTin0cuXtLFz7p2oOk6NmjUb5xXrPZXiN7/GVhOFh6zqyhnIiB47qOXQ/UBCerJgVqPIf11d54OqvrfKR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430524; c=relaxed/simple;
	bh=NUK97cjocTEM1S/hVmKV+iMa2a8lJC5TDDVtusaA2sY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jD0gfj426WMsohxsg+evgSXqQkvT0jwr1URWhV5GRzmafWyiE/j/i1VpRRLarPh1zxU6BoPgvT9ZewuXxvEKXgKo0v6rOZM+aI3sVuLhfe13g6foYC5uLZoI2/MkM3++32uRyMqelnVTKBnjwd7wUy5g7cb6OIVWYw3kCBUrVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFMj9htf; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFMj9htf"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12332910300so793251c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 14:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768430514; x=1769035314; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd9BvHZF6m54q597nhyN3Cu6l6A/8ZHmYptP/Ae5Y8A=;
        b=NFMj9htf7Mpm9NcPZrIWm4nCx3UoBSsm97vzbhLFogqO3ywnihOYolmZCZB9XYhKMM
         AkrxXnb8APgQk3IIVJvloeRkz8r3E38/E84uQEgukAaY2iQ8PrNBpvKTVql7dpqYkOvv
         bpNejsqbMcJSVy48guBuNcwZgHqStUchzRh8IRLkEQuEk05x519+wpS4kIcFN77Hidas
         xMYrImc0D3EGDpbarBNOZR18tEhqWXea55qdM3xE67PQxBUOkg1yEaadsiDBqqDbIi3F
         0r5f/tTlMcNx+pIrtJmxE/3hpZbukTM9wOwWP3YNr39c1b1eR3d+g2FjAo0zlwX7mcmf
         SkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768430514; x=1769035314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd9BvHZF6m54q597nhyN3Cu6l6A/8ZHmYptP/Ae5Y8A=;
        b=f162LqmLlGn6BtfE/6zivz8+FAQJ8ZXp+DUxp+HoHW4xLVo2u00/17w1Djvo/LzRkX
         s95wbM/pWQkn/zmu8EXwAzp8gTivADxOJqDFCUbhXjakW+nAS+AQ5OH8Jw5FTLtzd0hA
         /1gSKlu0Z/IdBdipCrvOFp5Pibo2Bwf4L4IVr4Y0MR0S2IW2O7rTHgm1SfQoWNcuN13M
         0hn8kewXJc3AK47tLQdaX9i/kVQuL4pxdgI0CARrGw/XBqBaG5lNmZs35WRsmK5POk7c
         AMXsgppI7ggiHgR5uOtkIqmkZ+X8m+8QlZ/S802Z8baxwu9e9mNseSIa1Dk/8hwtRMeG
         W6eA==
X-Gm-Message-State: AOJu0Yyp+Xe1ZmZ85sKY+rsn2qIZVYPIUytiEmCBGWoozsNBCLWwwW9U
	JZzhng7NAjAjvfrBORKtuq+ADYeU6etF8gKP+ou8+aINYFcxsxpV/Q/+sZo52e3o
X-Gm-Gg: AY/fxX5+vXhxbpOZgGqqbflFPNdllo5lXiYnMjUjdNc2jWS2l9tT0RcFldUtUt08z14
	xeHHGFDvZZFcJ4JvJkCbhb/2UNBVgEVf4beACImqeNeNqMlxnSag9gBLmMiK/1MTXMcsYlLXgmk
	sO2OW6N8MK/g59GhuaWiJDAbeiX4Gj1YfLGHphHRbbDcay6BrHez6RiyPP7n53p7GWWtT/YJrKq
	/uqjMSs/x/1/IavYI42dD12HxTCswgVvLjFPwqoXZaVDahYpQh6lM4XnJBN3nieLPOK3kLar8MZ
	ud+b6bmd05JTjuJpg1GbtE0XtACVHf4inY6Jn5uF+J1FhkGpIMcE9StlxW3zt1iBbGY3fEGhko1
	RkFwz3vS9jBXXlVwx8PlriLSeZOctuLeNRqgc/sT13iQ0tbRRqU9nHzUUB6AUo9bEp8VblY4690
	42CMK0EnTWTZof207U
X-Received: by 2002:a05:701b:2211:b0:123:2d38:929a with SMTP id a92af1059eb24-12336ab506emr4194889c88.38.1768430514426;
        Wed, 14 Jan 2026 14:41:54 -0800 (PST)
Received: from [172.17.0.2] ([52.161.55.201])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c246sm32292620c88.11.2026.01.14.14.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:41:54 -0800 (PST)
Message-ID: <69681bb2.050a0220.81efc.d465@mx.google.com>
Date: Wed, 14 Jan 2026 14:41:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8997731024580660837=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/6] shared/crypto: Add bt_crypto_rsi
In-Reply-To: <20260114214938.1417430-1-luiz.dentz@gmail.com>
References: <20260114214938.1417430-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8997731024580660837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1042511

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      649.88 seconds
MakeCheck                     PASS      18.45 seconds
MakeDistcheck                 PASS      244.40 seconds
CheckValgrind                 PASS      296.12 seconds
CheckSmatch                   WARNING   352.55 seconds
bluezmakeextell               PASS      185.09 seconds
IncrementalBuild              PENDING   0.46 seconds
ScanBuild                     PASS      1042.90 seconds

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
src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8997731024580660837==--
