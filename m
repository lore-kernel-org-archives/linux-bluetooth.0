Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421353;
	b=ijPzsJYa14OgIiXxYSW2lM3xo5cB6RpE+jIjHdhVZYH1atSW4soeEhpzzkeiDeBYsifv
	 tanLIr9vsHr7qhw/c9esihfmkWmXpahBvbQfyx+0vvbL2rzbmWl3+Q7eI6l2AVSpB6Mme
	 P6FxUSD2XPrxFZOIsfQ1sIjN5v5VhJUM8bTF1Zo5NHIamW5NS7/TSusQ9obXq1XUUcM0X
	 yjrlBD5kpGAG349bWy0orgnDuvFFxuZBxLp80RhMkOq68TZmVxZgu+Xe+ECNpACPAzlNB
	 2JWACJxubBYykOLQ7GOahE7fsoeHlIkhJiSlQ0ZRWSuduwIICPaJNNT749D6abjTFxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=RbDB0Fi2BcCcKN4OOKR1cvdBBZiRgYQi4tvVvyteG2U=;
	b=eMZJ72QTG/wpY4GQk5/r4v+xg7LWTGzRVIxTRFyIqvAR9uLRaH5Pbd6YgUCOCDxSBc5K
	 e4CkXNbUwzAnMRHoEZTbyd8JkF9AJXqdUjxrGVf0tZI6PzcMkDqzRnEkoMvgrwga52HnL
	 bgWnQoteBym5k2rdhUTqr6jqTpDem7sMp72Ll2N+oWGWdRD/M9GBTdiQyCKtHWl8vVWkn
	 F+HGiRK30QKMELwdWfTpvpMHL2U3yoyzMSm4jcFawdppTRzLV5Q1MfGzYHDzJrhOIiolC
	 4xzFbARDpJeNnBwiDbauGIcqwSo5q7YXsfXrbUzXbgnOh6gVRLKWmujSsfDhy+wQI1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DbYsrDpr;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FB606A885
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22FB606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DbYsrDpr
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ea2e29d90so1228856d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794421352; x=1795026152; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RbDB0Fi2BcCcKN4OOKR1cvdBBZiRgYQi4tvVvyteG2U=;
        b=DbYsrDprfCnKv1ZiDSPiMqf+h/tYf8Ty0NVFHBwmKmDqYhFyvi36pbADUx4+as4mOS
         4QnufQritjiStamCyQELLTUWVWOzA3SNlvhKkupt4Fm4xLPqLvmCV4TZLH7jWXRlrvRr
         nz8B4oji7+tUiy1GtLjLjqUCRnltDK6jyxAOY7fJcAyr1ac3cNIThKzyKoR2ALK39Udq
         2Ju4Wo6CXExTY8ounJsh6sP/EKBb/PWKPz5Z4y2l6k1cpfHU4j1brfKU7j+5iCYskx72
         eorFIgVI5D7ktwRwVjZ6UeyRo7eCkv5zhnz2QXPqSKacwLataGqsr4X7Tft3qRc1ZY00
         uxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421352; x=1795026152;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RbDB0Fi2BcCcKN4OOKR1cvdBBZiRgYQi4tvVvyteG2U=;
        b=fajQtnrMwZpEgSV67d+knOA4rs+B5sZ7c4R3URTAF5zdppOOVYi+tsJ5IV9YGGXdM8
         dQJcpYlANQqHQL9RRPsWMYzTy87486H97tvxYMww8kz83OKQGTV5d4HcunmCu0vTylbL
         adnu3Vc7cE0yctxSDhi7i6O8PTbdBxMCtdr/uV6AW5rYNkhYYXTUSxzsIyp3MO4IBFeI
         6rvunVXd0uP4mEL8GVBOeIwaODqyPrMAbugzmBbFvs8ApIwo5FiljjfPb9X/XwXBTwet
         ItHvD8e0vc9AVafkAXoKSFLUGLfzsqpQOdASGENX+PpDeu9rGGX7WSfNxyU6Aqnv92Ia
         CeMw==
X-Gm-Message-State: APuU4Z/47usdXO5h4q201tM4ik1VIQ5Si/Rw1xOTZGYPPBumxOPP+eZs
	rMRBLTfWZPY18zhzotKXZqhMH6p0kmeWhFhm2xJIrqiU28QXjPUt0KfF/VjkzA==
X-Gm-Gg: AYBFou1i3xHmoVTEOazFfNwyd1WQAYJr4EM3o5u/6qJwd1aQCc8rZ9ptlDl00wI9yS2
	Os/LriN3Os5HaojkMGMtmHEikuLVSKw34jLvnNxBKz2nbx56MqL2ZQp3eRQ282v6TsR0ktkC/vj
	DfzpeYWj0Ucz1jV4hVlTfHFV67hIUZT+XrGvy0QrvQYfNIqK2SAFGSLDaWnPTo/zNNjT8OhODLh
	5tIl6X/SidkJqFM5KO7hPPCDsPvbziymI+DnN3lgU/Z3JQ3VlwArHO1uyujLcOXOPDWmtTWpQY5
	TkBrXzmqC9iZcGSbcY8siOfIOBWkqucP3jHXvLZPylREgTVTBsQZGV0DA58udxt7TRmd3C8xgNW
	0GW/psfoc7ba1u32EeGBtTyFkTU/Qk0DAKlKZnu5kRV3WkUxhtFebmfycyQaphJ5UCJFnlKegVl
	6N5lDNMhPOYw1DsLNIsOgGsg52XUrrMifHnJw8H5ggkVcB+VeZyxu/SGw7NdgycyJF+vdukdufp
	bNWCw/hXQDqFHN+ZgSHA0+thLjO4USR9BFIyRZtLc1Fowsweh8AyiyxlTM953us3p8uzOqkvBqj
	HuIdEBUd
X-Received: by 2002:a05:6214:2a4d:b0:914:cdbf:b6e with SMTP id 6a1803df08f44-91f1381bd4cmr5102456d6.22.1794421351514;
        Wed, 11 Nov 2026 10:22:31 -0800 (PST)
Received: from [172.17.0.2] ([172.214.44.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04f89c1sm52763606d6.23.2026.11.11.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:22:30 -0800 (PST)
Message-ID: <6af4b266.02abd67e.2acde2.77e1@mx.google.com>
Date: Wed, 11 Nov 2026 10:22:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6322943154686764214=="
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
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Fix SCP DBGC base address
In-Reply-To: <20261111141822.2888893-1-chandrashekar.devegowda@intel.com>
References: <20261111141822.2888893-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6322943154686764214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208423/

---Test result---

Test Summary:
CheckPatch                    PASS      2.57 seconds
VerifyFixes                   PASS      0.20 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.71 seconds
CheckAllWarning               PASS      36.31 seconds
CheckSparse                   PASS      39.09 seconds
BuildKernel32                 PASS      31.94 seconds
CheckKernelLLVM               PASS      34.23 seconds
TestRunnerSetup               PASS      744.21 seconds
IncrementalBuild              PASS      29.33 seconds



https://github.com/bluez/bluetooth-next/pull/1112

---
Regards,
Linux Bluetooth


--===============6322943154686764214==--
