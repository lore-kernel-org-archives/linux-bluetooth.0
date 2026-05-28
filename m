Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB13612D8
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964051; cv=none; b=oM69F4+HtpdVJRg5bSSIkRsyQZmz5keozkPrZxDPpODFiqWN1Pj7NlS4+dvuFqcqEw6Z4L6J/sDqdDy2hZJ0bH02PQ6olpX+pKYa9U0QSKJSFNLDOLHaKJC25ZmLzc7pFwx+o83fAKkpfao4mxTdPpjY1iLzfHMX3c+3hsHD4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964051; c=relaxed/simple;
	bh=FuwAt9g+rU1H7YGHFjJTdFexMUhmQr0vD2jIsyrBaRk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IpQKdajM39E0g4nElY6S0sV6bgqJ2Q0ymO8rCoMEzTLXVnh0Nvtecmur5HKJ4M6q6pqQSWWJiCpv0N1obVQoq1u/6P/rmU9VKQW6Oo7lBqzSBvBCUjomxxN0DAtlVPrBNzfM1H65YqWHvhsntrRfMnfCxytF80g6DfQHhrS6UGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE+VpWiS; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE+VpWiS"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso1288342eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779964049; x=1780568849; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CI2BUxbyEq2CHC0XXw4A4HMRshois47soQLKeQjOXBo=;
        b=WE+VpWiS80AqVwN4+TuYQku1X1OZ1LOLVQ0PNqwpTrkjInebzoPSXoKClM9e68/E5a
         C59q51DSkAJYIx105s2XyzLQj94IGgOFF9/Qf3QO/aDDqRUWOcOTbG/BbIWDTwl2RDrO
         Er5YR6s6CmNd8f7+Ey9gUncdYsOyXWnq4TlU8NwMBI5En8meOX8ov3PKrAnmiQQJOk1a
         rENmbhrtEABrqOL26pBHgA2d+vT7XEiSfApgAshxCvpzcjitWCMmUvqvqB4LN23YDsnK
         SFafblzJ/ehwM5+LHPWXDDcGfLOtkkC6CVOw6leX3WhWP3QIGaGZjMQSSS1vjPWicBZd
         FVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964049; x=1780568849;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI2BUxbyEq2CHC0XXw4A4HMRshois47soQLKeQjOXBo=;
        b=WJ0a0N08F1UBNn4zxGKlxLjKrtS0/Ci2O9dZ2wDJC3C+/raDNSL9h7WWc8rMA1P4Pu
         XsLXWx2PAq84Rcghd9ZqdegL537Urv5hQfY2MhpTtUBta2irQpWrfPT/9DAbPaw826X0
         yI+uOmUlaNZlqXZklvyeblye4kl2j3MxA44da4dbCoUuxSZXIxk6kzmIlY9ckcdr2aOz
         uQ4iBbqM6JQe5GT+Fc3fpO209wJJK9TUAA2vV5XeCaEP6CndG6+IDhiIk+J38ufpLp3j
         7Vg7I0HJtjjS2u5+i/36W+hH55CecFTjYUyULqFpjHqI6TBmdBr7ojWVtV/hQkhwIDta
         2JJw==
X-Gm-Message-State: AOJu0YzzGTuQedzdQAMH2BzjlBWJS6DUFqKG3gOyRvX3U2HErd7FUz38
	O324ji6jmtOn18RJmCDenzvnIPYiTtSnksLj04dxYsZmW+YlDLnq4Um1RWaMug==
X-Gm-Gg: Acq92OGzz2hA50N0vbENC7X3u7Woqg8LpraLXu3uyx+GGQ0WaXF82MprzzP3XqiFah6
	ae/ckxWBU+bwjlO/YjmuwATx1epmIA0+jWjFI/pwzAWLjS9sa2rHR7BPkSwAkowxonrBeorMz67
	m28XzKt3NkbCA1inNklJNUZ+7CtNFvtsd2X7qaeS1hlSe/hr6FyGaQGcdGDAnIV1vk07plD8ONA
	+YErl7JZb52WbKYYw2/hS/8bIL855wU3jGajpZFgkl2AN3LhrDpi9HzmFx3l5UNMnKl0iZbEjUy
	oLNliBMiHu6KwXRQeZBwEhaVLaAG0deTfdWBXBP4XqOTcti1bICPmllgBr6uXjR3Twfwk5mEyq0
	9ogEvwfad3VfursgxAxArRa84yfrBHl7lSGqK5Wd1gWoqoPS+dimjdFpN2RxFlCmTStq8NLsHTO
	KdqdpCslRpA2BP71iv/nOFe9C+VHxyFKmkBCCIgHZopQ==
X-Received: by 2002:a05:7300:3b06:b0:2e6:e504:5431 with SMTP id 5a478bee46e88-30449149080mr13344889eec.22.1779964049271;
        Thu, 28 May 2026 03:27:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.123.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452259de0sm13830771eec.22.2026.05.28.03.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:27:28 -0700 (PDT)
Message-ID: <6a181890.fb1bf61a.5eae7.4714@mx.google.com>
Date: Thu, 28 May 2026 03:27:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2016439825219904859=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
In-Reply-To: <20260528075641.3416308-1-rollkingzzc@gmail.com>
References: <20260528075641.3416308-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2016439825219904859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1102052

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.39 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      27.78 seconds
BuildKernel32                 PASS      25.61 seconds
TestRunnerSetup               PASS      568.59 seconds
TestRunner_rfcomm-tester      PASS      25.28 seconds
IncrementalBuild              PASS      24.56 seconds



https://github.com/bluez/bluetooth-next/pull/251

---
Regards,
Linux Bluetooth


--===============2016439825219904859==--
