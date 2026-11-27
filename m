Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794422;
	b=bVQoMjU+ummRDb1whxgBwSEZ+l9bXxja1c33kkDFiXWhiZ+9wYlNicnY37w5w5XJLuuQ
	 /eggjDNgjd4ZF3aUfmA8ddATkpe2kOPdyCxFrDor78zlWh2qBmJioOr70CiMfbffefzab
	 8g9LFKhO0HsPs+DNbzZM99UmWq1kyHmOoWn4zLYAx+4X/1P7SdPUmoaMc1KORuOry7s8N
	 lnaaUzTG5uY3uDfIz8PztOEtkjqPqvfKMxxb/G8B3/IOnuV2zLAeOb5yQtEiWhYDi6O6Z
	 8y5Hg5aYCUi6YuIs136xFOUGz6ZMbNhGZv5IrdBP2vsNnjg/EnRjTLB3Bpe/DZR69ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NJqdFt1CNmqez/bmeTeUq/D5IAq/lm10GLfo+PNjC3U=;
	b=ZEJ+616miQtl5vbihL8dJbMfwpfTWl+Qdj4NzVouflf8M9ZuXgDxem6asmHh7U+bEZ9y
	 QkEgxsUxu515PGv4kubOV+OU5hRJgSmPgbjgCk1a4qCKzNstaSYEkMvmnJ9Zu5UFooLpj
	 1fxfwUfyrSIhJDhgMZa3vZcwiEt5FYmXAWqdNRcrtYXe0jdDyl61uU9Wt76u1dYRBftnH
	 fdrILsUQYdBngTaLYdZLhESUYQLcogDf5t6493XjHT1V+u7XB7LCAKUGM0EfiU6j/1QPQ
	 JuLUxipdB7F2QZlzWuIrAA6+NrnWIBSi8fX4Y1WObz14CXx0RjAHBJDy3+FfhpwtaYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GyvJhuTi;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DE606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 15:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 112DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GyvJhuTi
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-38692f62b22so11206114eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795794421; x=1796399221; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NJqdFt1CNmqez/bmeTeUq/D5IAq/lm10GLfo+PNjC3U=;
        b=GyvJhuTihCsD+JL/xCzsISn8a8xgfCbooVJCeonZO291AsE8BjoyN0xtFzr81Eyre9
         nRPXpaKXkOncrQCBziY/9UkLGjx4sLKplhTjSx//hzOzLXb/QcR/PLBUGayspAzf4sXK
         +8xF1/UYv2aDMQVdzJ3oMEC2JUhdNA0rDPPRiYGYwzFWd6DbO5roF8wdEG2NQdkRHOzm
         cFnqLLcnkbJSjTvqiTKHZI+9tKClmFwlzC7kIRUR6g4mX3bQ8g/SvGFEn2D5pYArlR7r
         4rk8ZKmjxbQ9qAhjUKFpe2hPdrax4RKIy1txUm6iJLJc7OrCFjILuaXhuml+Ujju1ACN
         epUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795794421; x=1796399221;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NJqdFt1CNmqez/bmeTeUq/D5IAq/lm10GLfo+PNjC3U=;
        b=LT5R9PiyjL79uph8C02tH14ENdWCGeZwF5zUguiYFlPFZHsTSE1hpJOfg7cJ8FMdyC
         2LmAXRnj51NWWWuALnvuSxOZPn0x+iBV+lEN8qUQH22eZe0nrmTFUI7E9qoAK4g7umMx
         9axxHvsFZ7/TWy1+5XUanrPK9UO197ZXyYestbMELM3MlThM1WTcsoIjx6t4CMdKgMD2
         KC/kltfznT2Y1XAKT7tmduCH8K2dG39xRP9mOyZ53ekX8JuSatosKNjePWJOTx2n/Kca
         foADN5NbQ5ov73vookdXc4hdYIGDEQSFjt+3m/URqozFmTDVsy+mKYKVotfC13pLpizJ
         f2IA==
X-Gm-Message-State: APuU4Z9VoKJo5vsZ3zFZAOsuwGYox3qW51F3hny+9T3L/NsfR1w3hbPC
	ugF5PSN888U3eLsydNNULcFgru4XrtfNXCgYrCbe+8IDJCbnpSdkEO7ru4/eIA==
X-Gm-Gg: AZFdTZe5hcwbr0hKTxwSOlMUJ3HXbyOUGuOs0kcY+q5POB0Ept0zDtTyEDCk1LKw/vL
	rYq+0TsT1O0O590F3K48LXeM5gmUd6Sf+g42vYLoP7twtmAt0ZqPdKwdLUe161UjCbXF5G0CfsB
	dDIX+wLdnVqBQzfA1jCrl6j6wfV7iCUfr/uQkafGnNmIWZzi33IH0mOzCb5ubSEDJov/jlv9mIx
	bpvxbhCqTDA7Srgv9AJKVaSg9r/ZkXK+6tC5v56WdAf8kAH3f1iAEa9TTm1ZCAIkCx7NK08yOHZ
	k3/gi5nMrc/jkFBmbkn4eH7TDHLsYPBGmqfKkh2qCFVabyz05YewZYwLoomuOkpgkMs8kgLdOzS
	XgM7CPyVUrr9qjcGiZO66eMpk8OvHhzXL5Epm5nrGhwqsCkpTT/GUqFyhSVoVsy76qLWCxwJanq
	ip8+tZSayLcRby17InsmJpQhl/YlK7IDPwxJ9okYfHM234f/3WgBj2nSryVf0YtLmT+loR9/0RH
	g4s3XPq4TsE5CdLsh4t2RkxU06GYH2Ci4/WjSR8kVEAsfJNjiq1rf8Wrcz3NcUufQ==
X-Received: by 2002:a05:7301:700a:b0:384:988d:6ec2 with SMTP id 5a478bee46e88-3856f6524acmr26495815eec.33.1795794420848;
        Fri, 27 Nov 2026 07:47:00 -0800 (PST)
Received: from [172.17.0.2] ([172.215.216.238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm33230224eec.17.2026.11.27.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:47:00 -0800 (PST)
Message-ID: <6b09a5f4.9dffc5c7.239033.fe8a@mx.google.com>
Date: Fri, 27 Nov 2026 07:47:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4263768158199864723=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: l2test: Several ECFC channels and sends on demand
In-Reply-To: <20261127122705.2393602-2-simon.mikuda@streamunlimited.com>
References: <20261127122705.2393602-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4263768158199864723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224446/

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.76 seconds
BuildEll                      PASS      20.84 seconds
BluezMake                     PASS      299.06 seconds
CheckSmatch                   PASS      308.03 seconds
bluezmakeextell               PASS      98.55 seconds
TestFunctional                PASS      1187.18 seconds
IncrementalBuild              PASS      297.36 seconds
ScanBuild                     PASS      1088.35 seconds



https://github.com/bluez/bluez/pull/2938

---
Regards,
Linux Bluetooth


--===============4263768158199864723==--
