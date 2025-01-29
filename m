Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5BB17C98
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175464; cv=none; b=RrCCfbi0DNxJlIa1MeaRKV6I/m42UjRCEGv1h6IogusH1nLLtV2E51PU3ys+Vyi/dG1ciGH1delZPpIsfxUC9VfPMHHK9aVt4GwFr5cxBhE6yHNck44eCKdDaQrHBaAMtw3iC8+lyKIwGZGe4a13M2w2OrU+Oc6rtGgbFiTb5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175464; c=relaxed/simple;
	bh=plnEDCY9A9drPAp7AS+lpWtNUuSyO5jbHRDeWKPEvzo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jOXQ/rMXJymSnLs/+7fLAVBYOj2O52/MXPxud9OHhlCxBFJanvdX0TW77RUamxgKWXmVBJTWjmPZjqulmzQx3H5kEATkUa91bGanw5Pg1PcIdHt1Tb2gfLVtvr7/s2pQsrY5VfxHkToZ2xwGEzu5oIGeF5CLSX6TzACJgAXF4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUAgTxxt; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUAgTxxt"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be3f230436so655344285a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 10:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738175461; x=1738780261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HUQCMEncMqM0XOrxb89Fqmlg2U7YW1mMlXK7OPQsQoM=;
        b=aUAgTxxt5dYybtZfYcgeF7+DrTjGl1wSjkuc5mguP8VWnZjnW6qb4LMyYhKHYoN3Mn
         j7eA9CELM12DXDlYm+yGKV1ursTHCVobefQP4OsZIJ4wgMEbZrCpYMRrHPEQv8zAKjYY
         OWuf2fdlmHrkFv3d3N2L9cuywaVDd5+Mf/w4duv5+kG1tTJAfSaNGqRQiSgij1fI/tSr
         dE9RKJxPZyYQssEN/zGrcySVPefmbgiQ+UDa0dvQpotXavFkRzIfOrEVVDZgFEEo2K2F
         bllPtvEW7evxUPtx07mFoTwYwY1I5QAI/c1PtSEmxvgOI504L2MUuuOQ7FUy3nPek1AV
         RDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738175461; x=1738780261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUQCMEncMqM0XOrxb89Fqmlg2U7YW1mMlXK7OPQsQoM=;
        b=e74ITL0jSzG9J4YeP5QQbk9yrNn5ICl0hjHib19EMv1aK5hB8BWa0wg2bnSZPEB/JA
         qEkWNT1jM8oTVpZYYPCzqV6u0CIR2rNOji6bDRp/hbGXBdvaAugoZ1Ujs8/4gkZStNY9
         4IX0JQDgGD/HGpZ4jGOjbtk5YP8VYnPc364vgzHYFLvl9w9944tRub00uYplI1c6qVEe
         FH+PZNVkpYJLdF6tLn6KyphD+fto+x6TYZj967J9Z53eflgD7kazrtpVHrkxpbbSdOv1
         85AcZwyNdJsRcJnwCjXF/9CPeEsnJKosMdT/XMd515UqwB96e+tlT4HlmO3FtXMijgRC
         ljUw==
X-Gm-Message-State: AOJu0YxySrsJj1YNmugtPOZYcqXr/x8QY9c0PxKc2NM9zgNmu+OuT7n6
	4GO+2f+/G1jZfJbvIMg3c5OFWuZU25GpiaglKR4nWSOGEFIMB39ZAYz8HBeA
X-Gm-Gg: ASbGncsT43Sk0lCYqNbj2C4Sh9S7DFKAKUzfLOt7xL4mXZbckbMnN1tgpmHBv+xzqqJ
	TNFvCXrUuKmY2ctzKRl5P9DXVHFvBX2N6jrTMVm5xm4kk0ROr4TvoyUsrWR/1SXHRMg+kL0r3dp
	N77S43GwbYtnI+PVy6o8L5qg3whMISbHoi00NSfGL2u6J04/b9tFmX+YhabGdYPnu/bDhJAYHlh
	drWwg5xclYWbR54mkjd886O391lJLyK96/NNpvfVK5XywRtRGf8rutp9jLqcEqY/o35M8im+Lde
	SWohLhhlNP5wXpvyKsSWa5k4
X-Google-Smtp-Source: AGHT+IHOXMAIHtKcfVb7Z14bngdM1y2MJYHjxJxnYltgttg8532lr5ilSeWqoX73iUyYBmhThXgoIQ==
X-Received: by 2002:a05:620a:258e:b0:7b6:e9db:3b19 with SMTP id af79cd13be357-7bffcd9d19dmr571947085a.47.1738175459884;
        Wed, 29 Jan 2025 10:30:59 -0800 (PST)
Received: from [172.17.0.2] ([172.183.135.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8aa00sm648693585a.41.2025.01.29.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:30:59 -0800 (PST)
Message-ID: <679a73e3.050a0220.1f51c3.ac83@mx.google.com>
Date: Wed, 29 Jan 2025 10:30:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6881183673108039381=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: [BlueZ] adapter: Fix the pending changing flags check
In-Reply-To: <20250129172316.329330-1-ludovico.denittis@collabora.com>
References: <20250129172316.329330-1-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6881183673108039381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929128

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.16 seconds
BluezMake                     PASS      1491.56 seconds
MakeCheck                     PASS      13.19 seconds
MakeDistcheck                 PASS      156.72 seconds
CheckValgrind                 PASS      212.20 seconds
CheckSmatch                   PASS      269.67 seconds
bluezmakeextell               PASS      97.29 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      847.84 seconds

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


--===============6881183673108039381==--
