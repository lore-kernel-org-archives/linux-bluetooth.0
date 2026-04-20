Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0843803D4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707096; cv=none; b=oCm/c10Btiak0HcjtAoFdlMyVXkRTTwByN8aZA+2+tmtQyZhoIxnMHjw+meAVin6D+mrlW0IgUcPXrCwhOiN/mEgft0p+2PjE9twTn/IvAvFPIMLu7myDB0lpS13fjEV9a4nWdZ6HizpTDnEikW+Zh1VS5nqO+ip6cGYU9hIDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707096; c=relaxed/simple;
	bh=EgzDvlXXk1qwia8WL2jXvTdiMGgDwI0+Is+hFjsOTws=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BzuNde9dcjFKrL48DUJbI2xyTexpNbsv6Qbf1jcVz7h87ykus2VCM/Bt9QynYTUMQlOIYtcUBGI2YwFNIAsAV8Xk++Iuw2N3NZC4DhIZ/mHDP2RSberh9n8JetHTMXFB6h31vizUtg0vb2t1amgchopGKTQWU6xxHPLBwY4aeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvpHBf7W; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvpHBf7W"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fb1932b62so57161cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776707094; x=1777311894; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P/ie+2TAznKyUYtSjSdqPG2smryVzIwnWeI4Z4azgbM=;
        b=BvpHBf7WDMk+VaRrd1JTymEgv4BsIhHrIzP+jTqUDdVq+br+gV8oAyqhZc2oY9TqJL
         XvokV3gWiG07bVfJYp97qXJdpI476vWO+lLNL8alz6jE/RE3d9J3HGRYQAcM6Awk0MSf
         TRPbfJYPxvmX4wiyws4tqFvH+ate3uqe6+NKfOuvDhawlG0yHh888/aago5fBwxjqn0m
         An5MOGbLAzTdA+jcTyUIo/Z/oftcmwfrp6t1spHZdaCxwnjQOuo6MQoL0RksOcdtQ7kk
         R2kfIOtqMX5uOuk7bwBbQ6qtx862YEojvSO2qaW9Oq2jNN37s8BIvAwdm1zO1/NQ40Lg
         6ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776707094; x=1777311894;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/ie+2TAznKyUYtSjSdqPG2smryVzIwnWeI4Z4azgbM=;
        b=guNRCxueHVdCF25kb3ukD5/YyT3ghV8TxKJ89nWeV5RZswoMVSASDzE14wlkBmAdLc
         Dv1FSuTZy5dsiezeW08vb+p+SRduXl9hQ2SmljYKz79TMhNakOwz2kKV6P56WUwbI/ZV
         rgS3lAChnUa/BtjMase+B2iqWEF+YczmvYs59pwz6NTXiILgw6ZasLqvs2BEtCzTjFC/
         HHhqcG4XjS4VN8jtEi7g/RbjJzHZQRcjClsmFpcnPrser+lc5IVxgI5jznwxEHFtm35C
         j/Vr3EM0UKr1ooUtdLvL+9zC6xont95jxhD3xMLbV/tAoIj5RQF2oG3epSDAPqSMZ0vQ
         IpDg==
X-Gm-Message-State: AOJu0Yx39weyvdXUtF2fXwIig7K+fREa2ADyJBlGCCTVIdbijQcJC2T3
	jTvC8Oao3dopQVhLwb4bEfWbWEPl8HRCZPBrrIyvcnbHGdRuwT5f9bpK9nTIJvYY
X-Gm-Gg: AeBDieul7ofsZPUEdS0hTexAHvVa07ym/0ozap+cklICiiewr0ETy2iDuEuDlb5L6v8
	pXgXVAKevpjrGZXzUAKh0nbfPrUoN5et3i8BmgDo41cZfxALi2wRh7qZuy5AyM8VvgvzDljtMCW
	IE98YD3h1t8kOKEgHKDzwbwwYFTZ/YoXkPX6n7UHZPRWoxiim50JlMY1mJ1HonZdskGJ03znynH
	bx8CP9vw0yqFOVf2mYml9sRgu8Fizku6VX72tDyuGx5SHa9prK0C7VvEJUckAeJYiY4XFKpklsP
	WMcJ3Jn/v6fy9GluyQB3z8RQGyuJCT4rwsUUWEnOu8bR7uhFgPlVkCiE6yIRUzuoQF5YVmn64FH
	/XyuF/D1yD8Zm+q0Vntfyo/VjnjxVJ1dlXfgpQV70f0HyCjZEtDbxIds/QsxozlqERup8q/zq4K
	OpHX7dnFTZbijWOAgcpg+wLBF8Lu+9tYH9hHC9lupHor0=
X-Received: by 2002:a05:622a:138f:b0:50b:3fbe:a0de with SMTP id d75a77b69052e-50e36c16a48mr224956861cf.32.1776707094031;
        Mon, 20 Apr 2026 10:44:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.157.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392c859asm104985841cf.1.2026.04.20.10.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:44:53 -0700 (PDT)
Message-ID: <69e66615.c80a0220.2e6467.3285@mx.google.com>
Date: Mon, 20 Apr 2026 10:44:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3658936324408184058=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/3] audio: Add ability to force CIS transport Links property
In-Reply-To: <20260420161345.145089-1-frederic.danis@collabora.com>
References: <20260420161345.145089-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3658936324408184058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083418

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      1.04 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      641.43 seconds
MakeCheck                     PASS      18.94 seconds
MakeDistcheck                 PASS      248.34 seconds
CheckValgrind                 PASS      297.20 seconds
CheckSmatch                   PASS      348.73 seconds
bluezmakeextell               PASS      184.69 seconds
IncrementalBuild              PASS      642.44 seconds
ScanBuild                     PASS      1015.02 seconds



https://github.com/bluez/bluez/pull/2058

---
Regards,
Linux Bluetooth


--===============3658936324408184058==--
