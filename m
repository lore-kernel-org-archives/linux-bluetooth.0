Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99D21345
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738815085; cv=none; b=u5F9g9Xvi2bNGxGoBzjagN8T8Q+MJqX0Fx5uIfCg4x+OOSAb98oh7j9UXV9p3vFizWp0y3+cnllpXho/GMlKquj0DX9m2oatrKpe0L74lIKpRngFj+avTcK/Bese/LyBvrtdwgSlseWZB5dcnJU0pJT76eO8klnzoZLmLVcnaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738815085; c=relaxed/simple;
	bh=E+v8GD+4oykb3ssgnAsxY7/XHAtcxFY1ACgsIgIH3Vw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GVJdagQm38iD6IUtw6Wsz8kk4tiqhwBdeY1H6lXv1EXVt3WduFM/svWhJzGJoTM2E6YZlg+IFy2fQAHCzjmQ4HSnkDvMYyTDsInU5nniHnc64EHxLt3ewE1xPe5u7pGMTWS164GF3tgsyKGyHbtQfeBiIMea5K3baFXbWJmpiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyd3+GF8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyd3+GF8"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46c8474d8daso4124131cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Feb 2025 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738815082; x=1739419882; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bMEKle2pn7/Y99ZM+4/X3bWdUMATS09RUpeLvXYi528=;
        b=Cyd3+GF8L3QhIetaNzjxAOc6eBYU3arzX7OX/dCa1KGC5nUQ1Zasbl6l1/jil8Zg0d
         aj/MLylRSZQeLZw5waUVYc/4TBGn9Dqnp4iuRPZvn+Wr7uqVfim2zdgjN5IfU2RVfaUO
         FxtThiMPsqym83Tu7qVGYNHDO0oAQYuWPOaAYczmEoS7WnJb3d0IdeM1wp1JjMjkWruX
         wcuKDBF1y7nuCPOKR8GPK9NMm2FM7vuXrijlj+e9vFZSN1Tm8y9ESQCWUdoMtw6Jmoup
         IYRhucspqxPODfsJ0GZNicCIEGLFaznlSFwa2R+5Ieh4sQLNZZL7NInC1AVjyraR030q
         nYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738815082; x=1739419882;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMEKle2pn7/Y99ZM+4/X3bWdUMATS09RUpeLvXYi528=;
        b=e3SrR1/x66MK0p1DVKiFhCdTB3fqv/vX+wWZ4LDS335GZewKJpINQL7Zy1fWxEcQ/i
         7nqn5jjpKhMZeA4p7Yub3YDzWybd+NMAhQOT+Xy3ws0x74SLM5LGKmT/RYwLwtSPFu2z
         nREg781UR2R4I1sYFReO9gi6KPldzHX0JyJ4CJYuMsPKu7BqvGHWvpBRD4gsrw/sEscC
         sBffPQ3KKtEn2ouxBrOUGkomiGbcGJbz4uvuU1X3LtcKw5fcPbzfuGp2sBwqsyXYcwnk
         J8jigP8KPXpbu11BEEU3/XrolLqthdoPHo/3cGGY1wQnM9LHE6I4ULiun0yyuhAXK1VY
         y/rA==
X-Gm-Message-State: AOJu0YySqErE63SMEKIP9mFC8HKjuhxPOX26vWcSHWIZ2C6y/Bx8OonB
	Nh8+plp9+mb2aEr8gOTwWmi4hUpJg4qyo5q2GpGTIkWgUYGhqTph/tBaZA==
X-Gm-Gg: ASbGncuTkV3+iPEk+CwQysKlaljraKH307ohEtJmLNr5k0taAXE6XpxhPtFHGBdqQZ7
	vIyQ7B9vD/QY3FoPTtcNWsi/es3OLqSc20vwBr2X/IZaDd9+d2WwYiIqxMekVsaZTlE+GhSRkLO
	JKpTYwuB5KHf5iAKqGgff2Pk6BTXXLzw+Rwp6zZLg8AJLICIVXp3f4831lLiWxJZ7Ha2vdLGSCi
	aP9gVITOBVv7fXc3ePZt9/iVpvuzcK9amQnHHXhNFWo8bvuJyu5sRcydghPjGiCcQc64aDuexNL
	QGK9YcFjobNRhGGIPSdqI9I=
X-Google-Smtp-Source: AGHT+IFbbYXODQIp0LjV27p2JEnlRCAUTgfTHKjl9KYk04jHpl1+1YJZXdL+bIs2HELAUEO8VuJr0w==
X-Received: by 2002:a05:622a:114d:b0:466:96ef:90c with SMTP id d75a77b69052e-470282de422mr74732691cf.41.1738815082377;
        Wed, 05 Feb 2025 20:11:22 -0800 (PST)
Received: from [172.17.0.2] ([20.102.199.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bec10esm1788961cf.74.2025.02.05.20.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:11:21 -0800 (PST)
Message-ID: <67a43669.050a0220.32404d.06c2@mx.google.com>
Date: Wed, 05 Feb 2025 20:11:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1555664643616850433=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: [BlueZ,bluez,v2] gatt: expanded maximum GATT channels to 6
In-Reply-To: <20250206-upstream-v2-1-ffb66c7f9544@amlogic.com>
References: <20250206-upstream-v2-1-ffb66c7f9544@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1555664643616850433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931037

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      1430.34 seconds
MakeCheck                     PASS      13.46 seconds
MakeDistcheck                 PASS      161.06 seconds
CheckValgrind                 PASS      213.54 seconds
CheckSmatch                   PASS      282.03 seconds
bluezmakeextell               PASS      97.35 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      854.88 seconds

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


--===============1555664643616850433==--
