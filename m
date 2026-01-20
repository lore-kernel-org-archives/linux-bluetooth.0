Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D741323D
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930812; cv=none; b=T/Q2Q7jWOQr8b+1qaODzmEQrM661ApEw2oDRB06YVcXmFyPL4OQmlS2FxfdXUFc8qhD/btdg3LRz2uWVtAdQ2FY97H/1YkNiAXm6gSf6zRPmyWiOkpLwATgufMFlGIUXUh+AeaQpI7OoxbItAicWBZwOPRGaO80nVozhYcL1+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930812; c=relaxed/simple;
	bh=qGOH8BpySpFkSlHsgWqelfQ0MQFQQgakHuWiwllnii8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FJGnYMvcKLnA36ZxHyf5DhAObBg8wcNCvp8kgl46Iu4uJpojuOMxGIOY1pS9rzYmEfgKRJy+FpSA7VdeF0Thu+fLNcBUpTzfahrZoU5s/Vc3YYrk5wMe/W9fit4CuhjutzAR+KObNIdXm723u41IXow/cxMbtLGCFsfiUc6A+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5hvBdBz; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5hvBdBz"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso6711622eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 09:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768930809; x=1769535609; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1qwm0F7FKg+F4xWx0KuIiva0Mop/gQWUTgVC7Grs+rM=;
        b=S5hvBdBz8bF5yOhEbMRGw7mn9F+gKIK87uzUh9EQmmYG/4S4m0KxXsIVBOtcZXBAnM
         ZMUfJeQ6Af6zUnUgVipbqoFewlk284UzWBQlxb+FSztU3/jNaW6BRgVHGwbw4W5wGNp2
         kSrXVz67rlrAW2fTPHW2S0U8JMP7wyQ1QzRWSKUYMmIEIO4gsM6VxRYPDIQEZyv64sDW
         Ej7GHyu7PMov74D7Mw7DboG5Hep1CdxScjO0xZTCBGkpM2iSYXMlneh4Cafuq6l7hxFl
         MlQvu6ju/fiuRQRMj6YxMjhe1vpb/J6q6lvUJ+jpf3l+BnzcY4oYGwf2p0nySUg55zSq
         e4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768930809; x=1769535609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qwm0F7FKg+F4xWx0KuIiva0Mop/gQWUTgVC7Grs+rM=;
        b=JWrAVi+PWZ7vJBZE+99wCPXiJn03Pr0n3FRQRab38bJlUg6+8TECrvNmq4xU5pnUk8
         qhyeByxUbpCEe+6k+dL+FKB9x4g/rXbI+eKjGwo1kuqw/ATwcZZ+QQg9DRbYvp93ocNZ
         p/kLnQ0yG35VHRsEfGHguMGbXn/jpuB4dvXOACkyWulkFWNIpB0k63cciFFwK4wumyVI
         xqnaBCGi9pFh5kV5JE/wDPSKi6oX6RSH7NJVBifajFenXDk9pZj47vqT+Wr9v8JwI2JP
         LPILe0QgB8ENAH0/X5Q968UHMBuSaoUPhGdisTXxN0TKr4k5WzFFcp6FSx5LxzwWTrYy
         8pBQ==
X-Gm-Message-State: AOJu0YxpnQ/YyPk0EV1eb9TkLxzhZi9INYJHSdFsPgWr6lJr2+xiOUoU
	EJz5YUDZyuyIAY3ngSNfHhuf39pDekWF+m8WFxMejWrC/NH6hslrU90TR4RCgSPJ
X-Gm-Gg: AZuq6aLJT0QqjrOM7NDesJgaPrVpO0DkWBY4uJbiCq5cz4XO9IhkEOvZlImeeBj/3g6
	yaftyJBQhMkbZndtqBeugpLi9it09CL0ocFXyDqywxnresFNp3S134KU9pf/xfdsPJBJLcyD6Wl
	79TJs7ux6o1ENW8/hICnijMvS3U5Wz2i3p0kzlat0ct4WNgg9G8nwWNzoaJ91se/8iqOCshKM6s
	8sb/CqUj/keRIr3HIGakt0TbMVCwOPxKeqPkWZhJpSoM42W4LovnRN9NtOZSfj0PgdJ9qjl7c4A
	qE2jF2Y6Ljx9xHWlQ1MCv0HJi1WhH0EsmTQfiI4RSEvNxP5TxZKEDGGH4Qn+tfPmZY4OFN7Juc/
	e9Gqt6yHoFdeEBHt9JvVtTS88uTWjOK/1NAPKyFlRQsRgTHKdWy31MCqS2KRWQMUHJAIrobGrac
	oXfgAyiwikNK65vJKHwoQ=
X-Received: by 2002:a05:7300:cb05:b0:2b0:6a03:e66f with SMTP id 5a478bee46e88-2b6b3f29e91mr8113667eec.10.1768930808728;
        Tue, 20 Jan 2026 09:40:08 -0800 (PST)
Received: from [172.17.0.2] ([172.184.173.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefab3fsm19033147c88.12.2026.01.20.09.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:40:07 -0800 (PST)
Message-ID: <696fbdf7.050a0220.63de8.709a@mx.google.com>
Date: Tue, 20 Jan 2026 09:40:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8541277471711488470=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] adapter: Fix bt_uuid_hash() crash
In-Reply-To: <20260120163614.261494-1-frederic.danis@collabora.com>
References: <20260120163614.261494-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8541277471711488470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044781

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      19.88 seconds
BluezMake                     PASS      635.83 seconds
MakeCheck                     PASS      18.57 seconds
MakeDistcheck                 PASS      240.61 seconds
CheckValgrind                 PASS      293.42 seconds
CheckSmatch                   PASS      349.61 seconds
bluezmakeextell               PASS      181.30 seconds
IncrementalBuild              PENDING   0.66 seconds
ScanBuild                     PASS      1014.90 seconds

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


--===============8541277471711488470==--
