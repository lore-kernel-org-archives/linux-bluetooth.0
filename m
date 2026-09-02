Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D07243956
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330127; cv=none; b=KRmvh24PhcrQzZgk91J88ArrXyZhzr0wQXSwJ3KGiO5mNWTJSidJSsKEf8iSW8g4ozZl1WHYc8cVqc7q+Y/9C2gxEjIAyjawZRzcBHByr9271IyXOW2SWaL1s9m6hdYPe4Wq6dvO0GNOBlvrm0oliykXN4G+9XWMADz5NvQwPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330127; c=relaxed/simple;
	bh=+6+bz1tvUsWYdYxCzUdocnVmn4165aqatk0m/3raTZo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z7X/9eL7ehf/BxXMkvGhmGMKfTO4OBejX39NRviKKf6miI5R7jV5aD+T+g9TR+mMDDrBtXARyhfYdGS1WCisJoKkT2Gi6cGVRLpnMLnCl9HCmxz4PBclkvBGgKbNE0NdIHHAWUuX9pF6jvNE2F/AEmbh6fFEdEQGOpwYFHLiP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ+3z2E9; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ+3z2E9"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-46fdd5884d0so28333fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 23:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788330125; x=1788934925; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+6+bz1tvUsWYdYxCzUdocnVmn4165aqatk0m/3raTZo=;
        b=NQ+3z2E9UgDCgSbl4zttqTeZbLYNNclez30QlOKbZq8Da1TY+ukRA1yt7bhmp6FQGg
         jxqmkhYFF/G2eq/xXgf36ip+tHuSH5/XlBQRVYaiFP/dVyHCbI0G6nNbKSnzyHXk1Cef
         NJBhs0GLoib/kezxzCgIHGFRtl+DfX0Cz3nZSa4V91c+jTZuOuGzh3tlPdBT9ABlgxrK
         GwL8rpWgqULRzoGMOM5fO3NmVYBn+RPHCkMFU5rdTrfmI/rSmwxR/7M4/ca9XiN7tOpR
         GniZJtn3hKKk3bi6riwfMnqQDmnWT4ovr09VckOvCsvqteH3BKi6hx5np+/8KSr4vOYw
         iFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788330125; x=1788934925;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+6+bz1tvUsWYdYxCzUdocnVmn4165aqatk0m/3raTZo=;
        b=dYEEeM45/yIXsxjwfFLdOFBw1vI4zIVK1PaUUrjaWrBG7N81bkisvNCPl5etwo+W2U
         ekYJxUNeEObWCRB0c+yHnTUTea/V6M7tFsG9n6PRSJOrFLc/362AriL3ND4zX04JBeDE
         nCPWHOuCK57Ugt059FCgN4lG2Ke/feCZHa/dJlsjXbS1DP0XZ0KYD8Y7PO6/4Qs+xV3t
         aIDagH5CJxmzzyFNfaTMtVrvcxpqtYgAV99jZSf79VuG+MHuXm7KR3A1qviQOnf3dq1H
         MlPyBTcEKWWrJmUX8HnWte/IZX70E3RorXDMAPQeEBYul7iP1fPYbAd5lxrn0h9XYjyM
         L8xw==
X-Gm-Message-State: AFuF++nVkrcOeTricPVwnu+hDKQk7gX6tg5bM+zEGRA0oH0HHjwmWsxr
	0yiqTNErzPG2xXySqADWWXoZJjWFg4mXLFOko7pcCUV0FiHx8I6W8oyeVOnjxw==
X-Gm-Gg: AYBFou3cDuAdGgXxWWZuawh5A6gECnyTEU/mfsLd8VaLUoH5xuwV1wMtUP13+1dXlFV
	Jmk2WL886fEqdLauFrotDIfI9Er0Fm45JcgebOj6MeTlLw9L9k4C4k773Irq1BwwgNeylecCC9F
	/N30P0JG8ywH3akkiAAZIlfPaULrEefCEMdOVbuu9alanaQUCF9xNy7ddq0BktwOq3lOP7u3qNP
	nqYPl2es4LMVS2Y/NuXsq5KI8LuJ891gGuKUYEFaToQO1wd2TdBXy+dooYysw5zH9BD/0Brd6Qb
	UGL9QJ1YEkUaXQBmbgqDcs3+WhCInKZ8IPWzUCvmVYtxI3/ZS9AgDLPn6hjRmxtsGZrhalS7aYw
	g0sCMRNS1+cu0vZtioLwfNN5AqrYW0pJqT1lGi74nibtJBDkb1FKRhDnUf4I5YycLcdwWt1pbte
	VSoMGOe8LJg1tHyuYRwDP+v/AXp6D8/sByDMFYW198FBAtfhHy1paqV6wOHs5WjI3cRFi/jkkTL
	clZpA==
X-Received: by 2002:a05:6870:e184:b0:447:4fc:1da1 with SMTP id 586e51a60fabf-46f8a42bb89mr2113904fac.12.1788330124727;
        Tue, 01 Sep 2026 23:22:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.141.167])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f3046b139sm2936092fac.3.2026.09.01.23.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:22:04 -0700 (PDT)
Message-ID: <6a97c08c.0c3a67b7.20af77.ec29@mx.google.com>
Date: Tue, 01 Sep 2026 23:22:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0889101856047179798=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, usupergate@gmail.com
Subject: RE: [BUG] Bluetooth: ISO: listener sock leaked when iso_sock_alloc() fails
In-Reply-To: <CAPBHdanvQs_e29KUYjBn41fA-WBqLxDxUDb4Tv9Efh5pTm=8cw@mail.gmail.com>
References: <CAPBHdanvQs_e29KUYjBn41fA-WBqLxDxUDb4Tv9Efh5pTm=8cw@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0889101856047179798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 12
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0889101856047179798==--
