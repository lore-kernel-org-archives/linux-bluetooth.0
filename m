Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED91B6CF5
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426195; cv=none; b=VSX78jDRuTWnuY+AAAeTCg2XUALGnnm8sqNWHG1S2l3GorpzONMbe9ARE1kDh3H6rwI+mpNvG/s6L9q3iIQHyVSLsPUo335gyFhrmScuA+yPqSA4Fy9ebq2gwb6u80UHQaVAFZC5DgulIUa2nXwf4cMYvHmzUMneT7URPkMRQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426195; c=relaxed/simple;
	bh=+nT+VrJgL14QKL2Bts/cGdObRCzkIO6/NjrNQmRkmb4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AFn84NtnzKsJdtgEBJZCJw8Dbe5RykmUdLKrVEWIRQ0yV3EzUFq3OQ0o3wpVU5JXLlwFZNHIgwuC2gsbSUjf+B+WKYalgYpiO2/ya0FZYK6uBlET2raJlmvLJYCdsJ1363UNl1Zb2WkBGsjOGyM9iJaEp5pclrcy7lEUpLj8Qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwsXrsrh; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwsXrsrh"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d888fc8300so14012766d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 08:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738426193; x=1739030993; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sVWje/cPHqU/nAqKrqBOkhuOlwymROBp+XURBQH81Kk=;
        b=VwsXrsrhDrbA9Bo0do++Mi4Jlqy17fqOWqpb9CcKnb0LVXzpi/CDuqWUW/SUm0BHK1
         PFIw2jft+6lAfqsQLhPviYHDrfvAzJmliKOaYmxozZZn/H/5ZVc0WDM0x0OpV0Q2xrom
         hDAO/kYdMQa7OrKjPT4L64FpB843Wrt2EquIjZuM/Ry3ixJgzqxUyrAEvwB/CqHYxmS+
         /fV3QvwU0g+ZtdoZEmSpnT+TK5RwPz9D0SETG5AXjOJK4oz7+Z8r2cFGVeUVduLk++gq
         XyHl9ynJFTQoAoDMY8IwUGxdE4zgF6SLtkWwWos+HfrBpVFw9qKaDgFaldGhFzEkI/Kf
         8VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738426193; x=1739030993;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVWje/cPHqU/nAqKrqBOkhuOlwymROBp+XURBQH81Kk=;
        b=wHRtYLQnRIsc/tm4qPtkO+KcRPthQrw2FUjQuUc5iMc6x/t/XmTJEOHKtAQbmIsgFz
         ehSQ9Ujj0kTc/v+oennJquQqzUOb5dZ411NVBAnV5QB4rw1dgAkKwIgBwB31jGQw4QNU
         3XcPPx5eM03wtLHO40aSsyosV2aolPcJaQy+pUq8c/g+YUwxMAcrcif+7hWZ1O56idk7
         58/OMbKdsTALs/z9gEiYwgezCHwjRzRHEfvMQ/8OQcYanFvQNhe9xDHijtYWQWuLSKJJ
         ilRbwerm6pKYy46Sr0/Doo7lhtTAFBOz/jX1yjuiznXlh5EWw4AU4j/He/nheQCToEVA
         jlVw==
X-Gm-Message-State: AOJu0YzgHoX7pwJEHOFsActzz8XCdosz0srt7PFjSya13ch1H0T8/61z
	ZHMZ0uFrBycEM1kl/qeaLr6l4df8ZxH62EoQPCdxj8wUaSPQtylybtXiHg==
X-Gm-Gg: ASbGncuKrnroxOEe7bT93EPd8XNUoCUQN0P54N21dF88mnzldFzbm9CNoHUPjA+CCAt
	cp4bt5pnowaqBau71iL4C0k1hppDkIheXDdrGTg0+duFDc27S/8cJCpTuN9rXWX9mjUddQAFyrf
	egV6ptlAZwi/h6kzAF/aA16bEstaZwOrg0VW8e/fS4AY99BrMqltCAVz5hbAwfbWp9z5892ePec
	pjdGyR/uKvm58A8EUB8cbziRKVILL/M3uRkzb5uX2kejtpgSMVsZmJcT/VWfvJXEdXuCIpKSRfL
	/UWnjLalP1HilUVSEXtvRqPC
X-Google-Smtp-Source: AGHT+IEHH81g3dVQtTc4+XDR0mG8nDsmOwvTkJb7OJekwb54Wdnb9sP95mdZ5VNa/TwaPdny9+joUA==
X-Received: by 2002:a05:6214:3007:b0:6e1:69ba:346 with SMTP id 6a1803df08f44-6e243bb8251mr247091936d6.10.1738426192669;
        Sat, 01 Feb 2025 08:09:52 -0800 (PST)
Received: from [172.17.0.2] ([172.200.183.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254922e21sm29495076d6.92.2025.02.01.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 08:09:52 -0800 (PST)
Message-ID: <679e474f.050a0220.b5c95.b124@mx.google.com>
Date: Sat, 01 Feb 2025 08:09:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0388289626971833496=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3] shared/vcp: have only one volume change in flight at a time
In-Reply-To: <06e82df8d3cdd52cdaf4417059638382d7443efd.1738422702.git.pav@iki.fi>
References: <06e82df8d3cdd52cdaf4417059638382d7443efd.1738422702.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0388289626971833496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929711

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.27 seconds
BluezMake                     PASS      1521.80 seconds
MakeCheck                     PASS      13.40 seconds
MakeDistcheck                 PASS      157.27 seconds
CheckValgrind                 PASS      212.67 seconds
CheckSmatch                   PASS      268.29 seconds
bluezmakeextell               PASS      97.69 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      848.53 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0388289626971833496==--
