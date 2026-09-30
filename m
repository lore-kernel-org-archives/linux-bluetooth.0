Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F14DDB2D
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799639; cv=none; b=UbC/527HyoMQp3A2P6KwieAWGy/bXGdWNkj/aqKqg/UurFSnJCj/0q9ccmvVr04YIeo9NuTAq4zCjbpyUkBdk5ZiG1lniaED7PDR0y9212yz0et7WMec0BIWkVclrWOErgvqRspOydTSM5Ij3eUp2gI7H/ExkBdtttd0ft14xIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799639; c=relaxed/simple;
	bh=VZiqq5exM76+ml8DmPCfPF81gwg700yK39iQ31Tkl8Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pc4Dec9V1YagHZfc0VEHy9bomuRxLW4833FtavmNnJaSRE2794iAZ2V6z4I3aLslEDE4LDQhB1sW7gM1mcndXDDc5KKcttjaiWHsI7TDl2IOHOoWCQ9S/smJuKZQcsPGJ9HE7E96IdO7SOxa8rFFje/LyHcF3n0YTHWDkbcbqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlOYGy2i; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlOYGy2i"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320068d8eso53565851cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790799637; x=1791404437; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DnjF1CTTkX8L9ciU42/jcjptwkhtsA3qL6bPMo72jH0=;
        b=GlOYGy2i4QiYKp1ftxJgg1Qq4Ety4DL2Krhp9H1SnaIr6CNgXH1HKpoJqo+PI5KVQ+
         LTCNHBVV5cFcsvxLmXtUT1eAIVlxcNyRXVhl81P+cd2YFZYGH+ioDDbirEahqfR5ol32
         paxt5vn41LhaeuDDIXmac65Dx8QUVrkP9EHrDFB/EppcmVivyT9tARxW+ks6EcYMKZ0M
         3J3ZRMTibOmPPROURzkkl/uA8aVTy/pjp1jGcn9t4UTAKF4brQtlNkr/3hVK8f8X5+r8
         I6HiVhK2EWmhJQDwgGqKSyy4W7W+mjZWa+mVJGLNkZ93cY8kmbn4dR0qPntIM6N9d8Ql
         60Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790799637; x=1791404437;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DnjF1CTTkX8L9ciU42/jcjptwkhtsA3qL6bPMo72jH0=;
        b=jXYuMP/eQ9tenCh6j/7xbsICgxgCYLkDNt2vw/QE1qt68pSqoPNhdDScTNL4ioMQEN
         62/9JA6Q07jj4iLWXZK0/slSkLNUm0CViShIOf85YmmDlOJll0edeA19/VsSItZuMDr9
         w26GBCB46TZbRT3XxhV2TjiYt+el7wsRvoA+Ql7IRbAo0d4L+HzT9STZ+n+CQGFo4PTq
         GJJCVx38mqzYlL/J43olRx8LxiNvzNsbZapYtjk+R2NvWR1nJ9hMQ5w1i9+9RcUPWwWe
         GiuUFp9Q6iH48HVnhtWyv636JQIeHfCoKGuzH4yXfqI7w5el3osJrbsxkMRqgh3MC7RB
         D7rw==
X-Gm-Message-State: AFuF++nwWJ+iLzhATDTMPCQAZ0mVAKkufl2Yk4gwWY1M6YLw10yjwEII
	l77deO3hd6HxAhjGckrMLDdBmp2zSNCUN2TYydE1wE3OmF9rEfFH6LnmmtYFCg==
X-Gm-Gg: AYBFou3hal1BKFuCxwqQlA0k0VOxEpDGT5wpQXp8co1mHtY8oXMT9Xh4xgb9rqJF//P
	fx4WuyB+5i405rts0ISl88vB62zT3PUZclFTr/9gcaLsxZQ3HDEbXc/+IUsZ7cuK3ExHDsV+Hjl
	gPZaM6Bl3KLTzc8iSR7+kJXbBq3FXK4yb4OgD7R5vb8GG4bg9BPqTbzyTUQjLUXnJ1BEdKsOCPA
	w33ymN1IB04v/ua0dmcS0gzdfTVIBt5VfHDp03y83zH+yzXCZruNx5tHoG2x9nyDTHeHE9hbGMD
	y1JkIFFAmnbXdrMk56zoAVxwn0Vf0ojOVl2FVxbPX5uDeL73V+oF06Fx474m5/OeUfP8fH7jd65
	difeLXB202rhUqfqE4ElUmelrLAk2I3SpM3000lpztsZx4IdTegtof+qOzE7R6QC1aDkZFWE3IO
	7Vola+YgVR1W7K8hh7bIqtacur+LsKRbcY2x56OdYWFipXpMviz+lXFTqXK12FT6GX7uGLuX/BG
	kcQow==
X-Received: by 2002:a05:622a:985:b0:533:2f98:5b88 with SMTP id d75a77b69052e-53374486cd4mr50724281cf.47.1790799636779;
        Wed, 30 Sep 2026 13:20:36 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.247.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a89a52d2sm8161866d6.14.2026.09.30.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:20:36 -0700 (PDT)
Message-ID: <6abd6f14.9f1151e3.381f85.04b2@mx.google.com>
Date: Wed, 30 Sep 2026 13:20:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8014948828589269509=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aurelienrivet@hotmail.fr
Subject: RE: mesh: Fix Command Disallowed on random address change in generic IO
In-Reply-To: <PAXP250MB0544C1A2B8FE7294B7757FEECB8B2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
References: <PAXP250MB0544C1A2B8FE7294B7757FEECB8B2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8014948828589269509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176997/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      19.47 seconds
BluezMake                     PASS      404.92 seconds
MakeCheck                     PASS      0.92 seconds
MakeDistcheck                 PASS      138.81 seconds
CheckValgrind                 PASS      143.86 seconds
CheckSmatch                   PASS      287.50 seconds
bluezmakeextell               PASS      93.46 seconds
TestFunctional                PASS      1120.92 seconds
IncrementalBuild              PASS      376.15 seconds
ScanBuild                     PASS      1107.96 seconds



https://github.com/bluez/bluez/pull/2615

---
Regards,
Linux Bluetooth


--===============8014948828589269509==--
