Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170813AB29D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176214; cv=none; b=arCTUNtlY1et7q7Hr9OkNCg6SCVKhqiFXPuV0huk15VK9JVPbPc2GGgb7tM+rjXbmyew8BnMuNFMMqAFQC6DE4YxthYMmdEpGCYf1gvJ1kR2Bk3dVLMwN7GK6NVhaYvnVvPkf4qBPO/rzlNtaRxD15hbwHeWOesMyiuUWYf1Wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176214; c=relaxed/simple;
	bh=fjwk+wIYI116gVH1E98NGf4cM0Hrhw4YmQ/+QTfyijg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HqcR/kh9DRZtJGgFDabDU3Fcke1ryLkq80rVbLDhuH5awumxHaLabtGmxtj5HUhyxtIXFBxkv1H54S9YGnoqbNahlFGL+Z+ouUql9HhY5apYO72Ll4qjk1QnVCNGc1N7JeEdPqEig3GsGOq9qhGbYShQGaMno9s1dqD02iTIL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkmJqfQt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkmJqfQt"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d4f78fc9f6so115911585a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778176212; x=1778781012; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Act7GpY5FChzDTAunip+YmAQcr2c26/vNpSyibsAqU4=;
        b=YkmJqfQtk4r0QevBSZgJmjSKjEdZ4X1sbMfRi1zvmyZXinrgbgC25zZG/P2kLg5HIp
         Irmlf1eeTrO2zEbfmw73KedEEN7tv0zxKlc4bCidjLL+oMS330hUGRoPBzqfrVW2uMOj
         em1+jO8kIFTmXi/bUmrWawooqZUf9zm1HzkWw3g5XreKl4179IAoQe+vSlpcVN4b57gA
         /mq4pcwqmR6GrzpahQ1ncQAgkjCm1NuCVKloyYYENSX7776oY9N8CxFbW8SBFAJUcBmt
         Bo2a7jEKx8Fd1iBdMTmE/+FvaACsCDjUO8wWHQvOG6cKIQvQ0kdmMJUdyAoEUB0llisv
         9IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176212; x=1778781012;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Act7GpY5FChzDTAunip+YmAQcr2c26/vNpSyibsAqU4=;
        b=UJp/Xt2MfoPuUgzd7ZXVzXa9Brtl/zdb5d0EQ9+woZLXyj9BOHhjnmTT7y6KyOPpLK
         jETkOY3XHV9CtoEp6fMNzzTIcG82J0eIwUn3tvbtoKEzJsMoukyKAeKWCUqxpinrEXzN
         dLfju7RLNeUP8WWzCRE/Ke4uUnfLEJL6v71mMszQZvSIcNCRJtS7qYc2QpSt5czAvXtB
         s9+CGh8WpDLCzciUfowezSEZGTNxwDBfmru2s9btykQqBwPQmjw9m8IOKaDWlQJDjgRx
         IPxjvY6ggt9vL9K+ieBg80pZ3ol5kIrakGaxoatNWaPIgtKIy4ndeqZzQb6F4HQgpIx6
         PEpA==
X-Gm-Message-State: AOJu0Yz2DSzG3d6W+4jg64rUG9JAAK0icCQiNaftidxiyvToxn+khSrf
	hfP47WDnWTzsMZlNqAGb4ktwO+WTXN9/QCwrpd7WqtfuAC98BWbCKU6nTfH6fA==
X-Gm-Gg: AeBDiet152KF099jXoj6kqlLxdRnDLH7hjhHvinZ/VhF8UpI1sgL+KeaO4ur6L9qsbe
	3Lp7nxFGzKpju6WFK60we/Ldk2lWURG0xYe7TIAkuLUBvvxIjNLl3/uWwguoFH+eyHOWCJ/VOUU
	CfAm67Lca1anVYYqWapCZ3u3AfJGdiXXrqMvHtpK5j4OpevTD8NafHMth5RK6ZibqdXnHoxIenw
	rbelI/Iw/5rXkUuJZFVESH4T7v7W3Tdm0gXpEg5PkEurLKKsmbwj49T2DugaGcTp0uot1Ukmlep
	+hMYTpfL5iO/ftA1/6ep2hCW//DPQoeVJNTGWsRmWZ3LxxXN0tj83cZDgICaMltak7vsNqnHDMw
	nN5aszicOBFhLbrQUI2kWwh6LBA3zmRu4daQyV+WPX6tVJsMHStciCcwhOkjf2GSMDU+aASWSbV
	b5IsrFTNdNgffSvqlgSJai3PRxm3TYsFIC
X-Received: by 2002:a05:620a:2804:b0:8eb:f3c7:2251 with SMTP id af79cd13be357-904d61ef95fmr1365067185a.36.1778176211752;
        Thu, 07 May 2026 10:50:11 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd06f16sm2022354385a.42.2026.05.07.10.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:50:11 -0700 (PDT)
Message-ID: <69fcd0d3.050a0220.25e6c5.e040@mx.google.com>
Date: Thu, 07 May 2026 10:50:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3533717711544402645=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
In-Reply-To: <20260507161633.437600-1-frederic.danis@collabora.com>
References: <20260507161633.437600-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3533717711544402645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091167

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      652.26 seconds
CheckSmatch                   PASS      351.90 seconds
bluezmakeextell               PASS      183.13 seconds
IncrementalBuild              PASS      657.53 seconds
ScanBuild                     PASS      1021.35 seconds



https://github.com/bluez/bluez/pull/2106

---
Regards,
Linux Bluetooth


--===============3533717711544402645==--
