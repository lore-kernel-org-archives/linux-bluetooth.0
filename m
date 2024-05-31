Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27176208D4
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191747; cv=none; b=mvCB4tLq71uQzyUz6QW1vMXjVYc5ZAoqN426tszTXGOeBER+DhgD1+pglMY+TYMDZ3mHwdGGX4F4sxMTEEwmDQpFn9jJOuRID/C/OQat7uCnt/mW5bH8DniX7bFYcpldOi5v0O1zXj5BtEYo3gBFCf7SfkgtTJc0ONHo584QDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191747; c=relaxed/simple;
	bh=URndx9DEm3bqSRgZTFIMhY2oDNjAgRjnBS4wlbP87S0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gzsEuSde8tTkQcab9pc8ALIprpoEC3F0LUzcS31V1I5i298kfVYI+89N2l7BQyYyV9lc9tep9w1Y+Yy3S6Evyut0dch2D5vucDXiokyHmL4Mwsy51E2OvWeGuB2GP9o7b5jbZUnLcMQLnqwMgWX5duFG3KgySgJ4KVg1ZhF1fcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtOQafKJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtOQafKJ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-627ecda47d0so25593167b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717191745; x=1717796545; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NJA3UloVPLuROLzZYEHb6gzWcCSey+eNuyaPw5D2q4A=;
        b=KtOQafKJi9zsUMCUaJb1cmZhDCy3T9gtTdUgJANG9VH1j3NHHR94oRLua5paAAhttW
         60L44I7CgruFHveGj/2pQ2HLUdAWxuQ9W+tcnqZD18gce3rCPd9/cZqIR8OadiZDD/Be
         9oI6Mz9wHcV9A51BCqSt9E3stF01c4PtQ0US4PRS2OkfU9EmuRNLyEgXryDToscbPDmv
         EmNJNPKVIPCYZOXiceWeQH25xJzFRQQkQoaQqcSasbqeEDMyeGRNqM1Kw5s+Qe3XLIbt
         wiuWJ87D+dqrJpsC7NNlzE206rgHzjhxAv+1G9P7cnhfp9QzQnAceshsSIqbYvii6pAG
         d0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191745; x=1717796545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJA3UloVPLuROLzZYEHb6gzWcCSey+eNuyaPw5D2q4A=;
        b=rZh9C1l+4GXMH73qBe47eeXd6WY0RP2+nvAkkSWnFimxuJpzO2t3me+zzFXBqneDbq
         bYn6ooRyX1hwCPUuAG7Zn9W+SICSsyLj1iVL7z+d4JOW75OcLyUosysv/jjcrGnhIOWH
         C0cUuvglIInb6q0SQWAJA72TUmolVWynhlzC0cCBuAR9H0jrPy+t37jaG1P+u1YpDLh9
         WAPPQ12bq9q8HjFzBqM1urSawtyoWfg4RqoEYNShvEj/noBRTM61Jg/VN5RbZ1TnRmEL
         9p8XnrpzAZUALsUGntpGjXsxYHVh4C6mOcdpDdRMHA1Ee5UgOrVvqbrAaOelyA1RoC+x
         gY8Q==
X-Gm-Message-State: AOJu0YyoGOLiU7ScpIdn1oqgVYMVDgr3tlwiKmFOW3iRRNFDK7B2/4HY
	gbEr/8Te0C/2iUOEZKXrzltZ67GRqVo7A3Fw5q7keTC4xRcgTli3o6c9Lg==
X-Google-Smtp-Source: AGHT+IGt+D6rr+GqF4jkq2E1/7XUFkK9qOgNvfpnTEdZGpCR0awANHF2L/PcuFeSqfYMIp9hMRG23A==
X-Received: by 2002:a05:690c:844:b0:615:1a0:78ea with SMTP id 00721157ae682-62c797f109dmr28796167b3.34.1717191744935;
        Fri, 31 May 2024 14:42:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.46.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f3172c92sm87972385a.107.2024.05.31.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:42:24 -0700 (PDT)
Message-ID: <665a4440.e90a0220.80a62.4f3d@mx.google.com>
Date: Fri, 31 May 2024 14:42:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1886104115794463374=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@prestonhunt.com
Subject: RE: Fix GLib deprecation warning in example-gatt-client/server
In-Reply-To: <20240531193622.1696328-2-me@prestonhunt.com>
References: <20240531193622.1696328-2-me@prestonhunt.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1886104115794463374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=857808

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.61 seconds
BuildEll                      PASS      24.44 seconds
BluezMake                     PASS      1728.31 seconds
MakeCheck                     PASS      14.17 seconds
MakeDistcheck                 PASS      211.65 seconds
CheckValgrind                 PASS      251.05 seconds
CheckSmatch                   PASS      361.44 seconds
bluezmakeextell               PASS      132.11 seconds
IncrementalBuild              PASS      1507.35 seconds
ScanBuild                     PASS      994.73 seconds



---
Regards,
Linux Bluetooth


--===============1886104115794463374==--
