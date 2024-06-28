Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BB1E517
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584367; cv=none; b=W4QZuH7BVfxD9LdTknfo2kgH0Z3aTaObXvxpqT1I+frJrgJpbp/vclsR1LdZdGnrXbafGgbv5aYo1U549vrHFsSom6ZD20SxqbaBqJdt7rlzqH3bYZ5v3fEzY8CNA3ovGdF4yiP8dPBXfi2B6C2jPT0qTd4Vu+l1Nj4IecBwR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584367; c=relaxed/simple;
	bh=YvH8ezR0BYjzTGoKJvAyVKN6aDd7ckmgVeHQ1DSHWHA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XrzfE/R6XLkCieHKlRZJeBZsCVJZjBI5xQYxpvjI1BHMy3ChituGQrcBcBRlqjt/6YNoRwTL0isiATf5dlEfEex7nttmpwpo8tHH/RK/cbleOP1/C/OGLWSFKAdVXY3mO52Xw+HdyZ+f2aAn49bSMcc1Oa/C8hlkVSfm7uw0KvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHcUTmP4; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHcUTmP4"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b5052defa6so3822816d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719584364; x=1720189164; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OTiS3RU5Okg+njluug0qfY6rribqZlWnw6Lio8y49n8=;
        b=bHcUTmP4BqIw7vlFoLya9/pej3+qXkgd1hEazqLbV4dmR2R+IBL0b16k8kRw6JGWna
         UgMjsZ+4l0JCpx77UuXgIzI3EbAkc8DQ9AR4zql+2dwRMknf/tWaPpda3X2atSBQJzy1
         jOpMSb0q5d7eX9diAXD5X534ovsgaGs3z8M6ffBOhlitNbtGPoLiVS7xoethddtmV8RK
         jqEyBAk55sZUqMrjyi8wrhitlAgGhM4/QZblgGtrntGzecY1k63QnOzVE1a4xpcXCp+s
         XcMXlamY+pVzC1lQyLwlBqX/w46IOUCE9WuowSr+jE2HeE63cfSOeoC5Gzhjlzt2MP4g
         RnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719584364; x=1720189164;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTiS3RU5Okg+njluug0qfY6rribqZlWnw6Lio8y49n8=;
        b=dGFCREL3Y5asymqVSSgUi/DHt2yg/Hf7wBeJI7eQMD9p6xV9+teh2T8cfH4irkgxnY
         syq4+ORBigwBtURW62cVV9pCRGisxbhb/DVCv/Q8gv54CD+YIkuoOJcGF8nY0Jr5hwj1
         MWyfk9cN1HWhVvj3t1nIpMFLM95HKasqlDY2XcPS4BnBMJ0Sf8Al5hqNXkEqVxIHEItW
         EgKoFuTG+XoaNNFiy4nrj1JiTMv+QCpdGDgxgcSCYO4Rpo7ZrjxAEfsFFsfAvQw6hBsb
         cFU39DMK06kzwS/n5pRDaFA1zE+s7C79dgtsdhvsiqILpv4e3G6J7QyMCLt0CyaIOF9O
         ue0Q==
X-Gm-Message-State: AOJu0YxZmjWcOKM80mjWXfqtSlbdX7cJHtLmL+epH92EhnZh5RoxHxod
	9LQ0GgpxoB36aTxVrQVcNF0Co2X9G+zQhQDsbf5nhYcCYmJbBzS2H5BzRIZd
X-Google-Smtp-Source: AGHT+IFHuJeqCLzn2Kp/QJ2M5QsYZOBOqN1Nb+4uyNKOvlhyKvmGxmHr517svHunGZ08mM5SHJH86w==
X-Received: by 2002:a05:6214:3011:b0:6b5:a4f6:daa2 with SMTP id 6a1803df08f44-6b5a4f6dba8mr23558406d6.17.1719584364477;
        Fri, 28 Jun 2024 07:19:24 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.28.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f2653sm8092126d6.76.2024.06.28.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:19:24 -0700 (PDT)
Message-ID: <667ec66c.050a0220.28f14.3cc3@mx.google.com>
Date: Fri, 28 Jun 2024 07:19:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1237734174181656767=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] mcp: replace sprintf() with snprintf() in cb_track_duration()
In-Reply-To: <20240628123647.547516-1-r.smirnov@omp.ru>
References: <20240628123647.547516-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1237734174181656767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866571

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.55 seconds
BluezMake                     PASS      1716.48 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      179.65 seconds
CheckValgrind                 PASS      251.46 seconds
CheckSmatch                   PASS      353.87 seconds
bluezmakeextell               PASS      120.00 seconds
IncrementalBuild              PASS      1449.13 seconds
ScanBuild                     PASS      1003.14 seconds



---
Regards,
Linux Bluetooth


--===============1237734174181656767==--
