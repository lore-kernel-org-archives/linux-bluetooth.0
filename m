Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789E3A1680
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784433; cv=none; b=aINEKpKYJYW6BA1QdZvU/BA3CXQ4Zb2lRPSb6qshafkCAOw+u6DIUB/56Ioq4BgF/2uaKqhLLvUKCKicqbTXMzKbgx/zyyrMavEyxgxmeu9MBHFWx0OFyPhYQtPKloS8QAjlTKg6rbn18Y5dVjmHnFBMQBcQou3C/wqhlmreUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784433; c=relaxed/simple;
	bh=q9zw6foDnDpwejoEkPnlqueIXakfauXIe9XNSZdy02g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uQC7YulKAhARkwuOxuS5LU5of5/ZYPoxDoLmStIABMx+BTPaD2g/Kx4dya9jMlnaqvvFbbc1O9w4R2RAjK7/q4vac0wE7DJHNjjZeNhmcKdgOLcgYo9SCyTMkaw2rRfO11FFeNozcBK6V8+QBw4pto9rY3XgvJwfDo6EkU2rbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeubCV8c; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeubCV8c"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132830d8281so2660545c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778784428; x=1779389228; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J0tXhfl5LBudMQW/pveig97tAISZXI+cPQ5gasY7yVM=;
        b=oeubCV8cbSsP85IzvRZu3x1VYGkdmxMmHYgAOTP7K59MXatQcjmVRgU65KdXF9xiRO
         Bv+OsBg5+Pjw3tj1ZDEe3fiLkpgisZXACadsEArcZVndi6OeRfKaHtzKLP1TNuRQZHdP
         00Imt+gDr7aNfHAFNiN4PZO6z2OdKN7IPl09i5ULouRjtGwPqahbtU/lyOeln1goVohE
         TCJpMjkmz7We4/UpfaJvQOaZhln/96vU+NuDquIwDyYMlUMV49u/gvmbKXtI6mWkreP6
         9/E7tMcioIUqoXuWGCAchHoObASIKimNesxwOLVlVZqOh5s9bYglfXj2bjKkKkkRnx/I
         nDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778784428; x=1779389228;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0tXhfl5LBudMQW/pveig97tAISZXI+cPQ5gasY7yVM=;
        b=H1LF+0SQpJc5Ut05YEn6Ieh1V5GBkVvhSkXCQSDFCiHIPP6+17vct7CrBEGpAAJmHg
         76SCzb0SI9/z4cebDavAV+T8BOGHtz6GQZbZOH3Uqjs4jA/lt4XOZskWdvBd4DWLuLy8
         JpbeF+Rde84Li4/U8BQ4v/FMNOEw1uD/crCLQPYpWNCo282VLhPWkgKtWkis742y1pWw
         YBhubn8toy8Orxr7Np6FTqGFvDU871Cyg1uzpW8f+2fS0uPrNtTnB1Kfl2OKoeC8mgsj
         kM9O4jV0R309jFFPpa21LtnshTPquABx3/uMwUTGwNSCbizheKdlGBET8XP6BAyZ99hJ
         DoLw==
X-Gm-Message-State: AOJu0YxRQpo9NdanZHFeBlixuqy0JUAk9Maxy6QY5i21tYXhI7Zwof6L
	M+Vj1iUCbLTh4uBw4eCHrAd5k9n321RROuUvvgf+/bMCCucEJjXKecZWdM4TVQ==
X-Gm-Gg: Acq92OHOXlbuCCI1y9rQtd0JI7lzEN5lflAsRgtIewHMBFarztpWPOPn311pV4swcDN
	b1+c9RyWlfwAA8XCCKwA0EFYNu7NehfZBGgHUXiZNdy82z0+777arawsDrPP+eSnf+uJylm5EQK
	rDo0PrQkXs6kU4zKWwLff3WI50tJcnr84pk5MwDJpjcvubxlngJZvHILHqqYMLhIPNKZWu/4qhu
	5LjFl1Tk8q/E4Kb4TayHisISAQQT+Ngj3HYyRUIOXGy+KGmbgM9W9WJtw/FYpjo9fcsc/I8ZSPh
	vdEF+4VkLa6HCCPPONhjTswRCqViLVoeEs0k/4X0/drVKyutHqhr03JpMnjrROiUSSwQn5PlRt/
	p9+oj7YrZNEKVaesEn+bWJaXsPpLx3oG0Us9iLvDzTJtwRijBMGigVEnVRprKw3LT96yeOhqOYj
	LImqxdDOPLTuBepAraCgGYpm3ENIRL
X-Received: by 2002:a05:701a:c971:b0:12b:fb81:d69b with SMTP id a92af1059eb24-1350542e923mr138684c88.19.1778784428331;
        Thu, 14 May 2026 11:47:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.6.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm5391226c88.2.2026.05.14.11.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:47:07 -0700 (PDT)
Message-ID: <6a0618ab.8e75e0cb.1e3599.0d5c@mx.google.com>
Date: Thu, 14 May 2026 11:47:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3911006895138112766=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2022090917019@std.uestc.edu.cn
Subject: RE: Bluetooth: btintel: Fix insufficient skb length check in btintel_print_fseq_info()
In-Reply-To: <20260514164913.3123671-1-2022090917019@std.uestc.edu.cn>
References: <20260514164913.3123671-1-2022090917019@std.uestc.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3911006895138112766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094909

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       FAIL      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.46 seconds
CheckAllWarning               PASS      27.38 seconds
CheckSparse                   PASS      26.10 seconds
BuildKernel32                 PASS      24.20 seconds
TestRunnerSetup               PASS      539.18 seconds
IncrementalBuild              PASS      23.25 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btintel: Fix insufficient skb length check in btintel_print_fseq_info()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "Bluetooth: btintel: Fix insufficient skb length check in btintel_print_fseq_info()"


https://github.com/bluez/bluetooth-next/pull/191

---
Regards,
Linux Bluetooth


--===============3911006895138112766==--
