Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372482;
	b=eq5fll48xq/YDVIfBFtqNclSXgA9IFZOyO8sRfBah9xl8nhjhU3PitvPiq8Pz8+/Dn9E
	 eVzV/mY5jvHDpP6yqaabewOwSb8ePWNWEXBKK+NrE1fMsZR6ODbrJs6zmvPo6ihoVLL+3
	 pay0YQlarcAx+d+4UMdgc6ycHYFu0BdvkM5PIhluqEhyaN/W6/7rn2SUMhckGaqGQicxh
	 dr/Q4RjxMhbplK3Ezw+Dk7O0R37atrj+Er7EF37OkMJ2j8Jbk9Q/WZZGJqq5Vwq9T6yQG
	 7Ti0dAZ0oWXOGMUx2zqk2O5o4JZqfC706sxDpeHhV5HIpWc560J+oalGfsjB54mSuHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=cJcvgnYEeaMeywXy567TWsHAOHWzTiZIJKJyWEQ9Ngk=;
	b=kt+Y38aAMN0hMZlWPbB2KWp5udkppt+jLZ+qhPipQchRFMDtafK4lZuqmCE4MRQWVNBs
	 qRYQmJBX6hZhf5D3bnVzpY2/DeOjPe7rIUhZaPD8908NAAb8BqIE1BJfwjxo75MlZbUaA
	 esZRAArf0rYKSX4PhJ+tRwf4tws/G1IM4B99MYbMHRCxP6JEism/pb6be+F03qhNW55Ef
	 Ssfo49T8rwNwo8FCRtjkbEz1vnQZy5DtAVk9XPoYOKWMTI8RIUb073x+KExqWW1jTrYiO
	 wpepnRfW932M9lQrepqEAoyyfAeK6Ol9Ko/BtNfEzFvHGLr/vHIaGbEhSGQ+y7GRfcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L9PvOHpJ;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE137606A330
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE137606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L9PvOHpJ
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso1905394b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795372481; x=1795977281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cJcvgnYEeaMeywXy567TWsHAOHWzTiZIJKJyWEQ9Ngk=;
        b=L9PvOHpJ4tFjUFYc/d8Fs6aaHHg/VQ5XmseMM+1wnQLAdmanFtBg0Nj3hCgxzLNFuB
         wWNMC7YGv1AQngmMb4ZbZbTso7oOZT89Ac8TPAhzy6ZKm9UL5x44xV1p44vOh41pOQpA
         nwHa65BPMNLQ+dkP1h3ZSMAbJiIFtciv2qR6629I+Cohp7JHJhGlBsK1G4ICUcHBFoSp
         0UCkgTHegGYh+xIkxfPlsOZng5TcVcI2zA3CFH0b1jyV3FTLnDcmGzvhCr2Kl2lTT5Nh
         tD/Oz65M9xSUFUmM4SOp+amqS8A3os+7fCqasnqnVCiwQ1wIsaI/wFj/PdW9op7q1DUN
         UOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372481; x=1795977281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cJcvgnYEeaMeywXy567TWsHAOHWzTiZIJKJyWEQ9Ngk=;
        b=Erv71eUADQQoxq3wxatFcVrFHAjrKLpxdVOetEtLfAJda0QhcwswScJNPPi3FGxtp1
         aZnllN2xM4ySZpP+HTVs9CK5WYG0EEze2kJPnXfE3JG0pHNTYCnYRZQQfv+jyGE9CDz9
         PqBTRlCq8Gysxnj7MHm0m+WvtxWcnA0SP0n2K50V5KJWlvHC40Xn9wW5k9JfNkNECbFR
         4z4XYG/C/+pcErf9sUjnbnwf9/1ChCryfR563VUWYfSqgVTre5MWoApocKZWGYWe3bCu
         ZZMFwuAsSHLLeh0M8Zg0GcfCNQfxbTA3o4HFLUTrwIqmXeeE0/ZiQ2PycqK70sjAf9C1
         7dSQ==
X-Gm-Message-State: APuU4Z+DNtvjVk06Fpgf+A/p8c5mr58Fw4qdVVLIZqbwWcZqMqE3ukFs
	OyG0Pc2J98SA6dLwCZt+5EdXDzG7jXACVP2xdUMBcr+OJf1ObkDsLWvf9FAibHfvXLU=
X-Gm-Gg: AZFdTZfRijCh8hopqd8s4mu79aNYqLHDcaOOU/8LWWi77MCBe93W5DU/EBRN9ghEaya
	5r1clYhxpcYplKFCp6MKawBO5I2XpwaWEc2IC8OAG+8B3MkyHAQXqwV34mxBQWpzAT3mBDcyJv1
	/+AIbKX4WQ1d77/iV/Ll0y0O6HgSDuKbQSP4PHT+Gz5TlEoIMHpS/gJ3XIL3ju4FTgKwgBg2sxF
	tDh8S8nRlOZ6hlcyB2OqW8OQWWYSEwyxSOo5jc8aOd/QJ7eCuGt1W5FkK7rYvNWdK2dC9B65lXl
	KyEdJWidVe6QBKdx90FhaLtLfgnjTMQB3Shd1Q2XW+fQwDnXj3l4qrNTuXJHKYL9g+68+nnduYB
	m+N0oXUIwLzzT0vxv2Sm6w73VX73T8uH5/1W1KL22Jh8ZJDHxi6hIyc8bjPUdWqx6YDVgveebOo
	z8UnujiT5uky+DlMQdcGSa1D859kpgN7mcAhFKeQcRz1OW6elbdQv7i/1ywEXCyZks1u7tUMORW
	IN4LlT03/ii0UsNeo/avdpcIfc3oJ1tybN0Hjfz1H0IvkGi8IuX/JzYkQhVNRA=
X-Received: by 2002:a05:6a00:4fc6:b0:89e:f8e9:205e with SMTP id d2e1a72fcca58-8c87c67137cmr8411167b3a.40.1795372480939;
        Sun, 22 Nov 2026 10:34:40 -0800 (PST)
Received: from [172.17.0.2] ([4.154.167.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8707792e8sm4304326b3a.7.2026.11.22.10.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:34:40 -0800 (PST)
Message-ID: <6b0335c0.4bd38db2.146040.0d49@mx.google.com>
Date: Sun, 22 Nov 2026 10:34:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2680930159386029236=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez] tools/test-runner: Add /usr/bin paths for btmon and btvirt
In-Reply-To: <20261122-tr_paths-v1-1-044cfb9521ac@oss.qualcomm.com>
References: <20261122-tr_paths-v1-1-044cfb9521ac@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2680930159386029236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218588/

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       FAIL      0.19 seconds
BuildEll                      PASS      16.53 seconds
BluezMake                     PASS      229.43 seconds
CheckSmatch                   PASS      235.60 seconds
bluezmakeextell               PASS      75.10 seconds
TestFunctional                PASS      1015.30 seconds
IncrementalBuild              PASS      230.99 seconds
ScanBuild                     PASS      839.71 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez] tools/test-runner: Add /usr/bin paths for btmon and btvirt

20: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluez/pull/2872

---
Regards,
Linux Bluetooth


--===============2680930159386029236==--
