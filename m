Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD73214812
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948365; cv=none; b=AP71hV6a0xWYajpQANabdsRC8M6o74WSEfcbcnfc2ud3YWLnhwYJYQz6YDhQ1ysMGFllls/f3iUUa5JrTIX6nwq8FHtDy/x4PwuWPihA8GuSEdiur+iqF5n5VMe+eMkoHaNu6jSu8OztvqAZiQOdV/hxCHEEzkNFbneJk+eLmbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948365; c=relaxed/simple;
	bh=HwBNXn4T+WwFldvi9ichH0ANixaToeQOi9YoUHmBu7I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dre/6cWCi4pRrVLrAk4etw9zGh0C6Zc1RtJk/5zhNAx8nq6ny7k/aS8IJ9ctEIAIrMzzoRhRON3D4au8+GQy+V6kg2nO99vGXHLiU/GhFtr7PQhxoemYEiJ1TwApaWZQ8/zZA6+YNjxATy7kcDe1TC1P7DJgcJ0dov28bY5K6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvds3l+p; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvds3l+p"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31ef50d8d57so3374514a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754948363; x=1755553163; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2YrJ6i5ZA1XBbJF6KJ386fN0LyzofjyyhyOUsySiK+A=;
        b=Pvds3l+pVA88DmL4VkXuGNx+2PgNpxC9wKUVcP0nr4H5mIBP7tza4IJaFuKASBJYIr
         ReBiaoapr1gWwPF+QC1ggK5QkB38WV+LokWMfrbOa1cbr7QE34UEYVs5qMfIdtZpCu6O
         vfjWZ/x6pVjpFWWO72XzhGTmhFgu+xMI90YnKy2fVZZ3kFtWt2Cf34Sa/bPL8jKMwFyv
         NSL9vYiKYLfjRML5snFCet/6sVTJjNwbVM/uXDyoOfIF1L3ySiju/VnUz5WTVAu1f0mb
         Wn1M2U0068VnWbW5SfyX/53HGPaBy79a/7u9KH4zaWgE28PNaXdXXLeVhUqeQLSZ2KTh
         f6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754948363; x=1755553163;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YrJ6i5ZA1XBbJF6KJ386fN0LyzofjyyhyOUsySiK+A=;
        b=R5pizomGvBrY7AdgPljv1RAOMS9ioJIiZ4gQ/t53HNogwEysJuSgUICE0UeIXlXF3M
         1WT3r0GcZdW6pKKTckNugUv+mOwRlr3+GRtUN4r3Xo9R+KzYnkIQVHc43o1fGD7RXu67
         peFq4rfE4u8CvWIFeT4ff1j0DcSZPIj6WE2ikNcuzyvN9ppFhn+1TIarLjwf1XAB336H
         tSV96ITjAoR61jFtTgKfhgg+EELQNtoIcB5zSVYlK9f3FWz4T/cTMFquVbsufyHDE7Hg
         0vDMZqzsMNxXj52A7eahJB1FEBHCnA/nUrtsB8kITXG8+jPjPtIbPxZ/zv5lvzu6IvqB
         vgCA==
X-Gm-Message-State: AOJu0YznAw9nOAdOVg6HiH6ll0YEfUro1X1dczrsgdRaMPUGhQEyIDUS
	q3B00DdQcPICMnrfJOJ1D60PYGh8bwhxoS0gTZUPEcVzvQ66u+DaffZuviJucA==
X-Gm-Gg: ASbGnctRG9OW7AEFAcD4ytWcHQSK8gBgXQd0ApCmJk06IdbcODJCd9+7nDNGpCuZBNt
	b8Af8qXHCbgpcFbXA4eNYo1DBJILkQlSIhntAKRJTBqTUq82QuVVlFST1VRG+Ex8EKz1jyiQIwg
	30fcDs0KKCLuskZ1WYhqKWwbni0BN2nkw/Py7+A/rPrTQsErzvAdoj8xkhrN6EmM+HsIS8uZ+xC
	4PCT3Sowm2iyD0rMbHRX40+JWnldU+zCcB9Xjk3xmpaO16wsMsHbt86hh2vNhu6S+Wjs1kSYzAT
	PgqgJKadaotIpMjJzdcK/u1hIyudyMtuyCK3AGxtBJHUH1MFwsgMGsM223q6l7PruQ1ll3m8Sor
	nb2Q7uu7+OHXQPU+bBa7tNGaBDGer
X-Google-Smtp-Source: AGHT+IG4mGaaRruOJDm0WGRKWLLsxdhLaDyStiN10U4zH3Ya+MqcwPmM7Vcu/R+krKZxrlhEa4Gyvw==
X-Received: by 2002:a17:90b:1b12:b0:31e:eff1:71a5 with SMTP id 98e67ed59e1d1-32183e6df8emr21411295a91.29.1754948362490;
        Mon, 11 Aug 2025 14:39:22 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612596d3sm15558090a91.19.2025.08.11.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:39:22 -0700 (PDT)
Message-ID: <689a630a.170a0220.349f66.e4e9@mx.google.com>
Date: Mon, 11 Aug 2025 14:39:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2590589523626869547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: build: Add meson build system
In-Reply-To: <20250811195850.1775759-2-hadess@hadess.net>
References: <20250811195850.1775759-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2590589523626869547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990211

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      2773.13 seconds
MakeCheck                     PASS      19.90 seconds
MakeDistcheck                 PASS      188.78 seconds
CheckValgrind                 PASS      239.19 seconds
CheckSmatch                   PASS      312.07 seconds
bluezmakeextell               PASS      130.28 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      945.83 seconds

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


--===============2590589523626869547==--
