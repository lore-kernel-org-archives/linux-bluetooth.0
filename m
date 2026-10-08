Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489237DEBE
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478499; cv=none; b=hNhzb3WqVFs7A1xSEGhUxHhN3kYsjUlny8ruTy07+8VgyiRkoMwmZz/Kz0OCCGRXP5QuTWe+1tXGudW+j86kbP1/TxTirwnyyGd4J3ugWZ7DRRItIemNdVDJB0Ld6i6tAMCvxM29D8U4lsGWphcC1c+6PhYSK3EfQXtHoX/elsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478499; c=relaxed/simple;
	bh=99piUuYi5DfSrKlOlqDPXd50ICJgMO74NBIJiDeKzuY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject; b=nqe+z2htPeKoTf8KuGGhvX+siOm4h3F2VBMyaNoaBzzdNZXOh1qJK770TAuipSRDUj4QuFWSlKiqNnmqAw5MiONFHeWTQX++wLzMsGQJwC1g1AAaRu7+HNp/6Fxy+HZMyFnOgQXLa5YmD5c/TQTcpxFNMeIujReK3/XDFZzAZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG7AqJgB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG7AqJgB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e608cd460eso14352695ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791478497; x=1792083297; darn=vger.kernel.org;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=77UKqVyJYoVP3y5ptGHI8ybCb93qRK3Olv/o17E2x8M=;
        b=KG7AqJgB5I7U5x4nGZBPlnKeL/MkHddao/tkb0HxxMtK0bnJxCKIainy3Vy3dAZZoc
         VAt6dNta83pncTdf1Hsuiri2cP6vnOgDr+rm86ka0aGcJj9PZwdhiCE1KVjw5y4T224l
         QZlzo1QBHK+tSmMeTvc+UaH6iPTsyFs2bxp/nolF4Z68iJiePEwzkbsRbcIXDRXHi0nb
         ITsuLBCW3ypp+uK3iXZDFgIMys0TZMO0H7lli+F2k1qDr2mViCoiUZOMCaNkT8xwgQzU
         UQ20n8qP21jZX8/zeqRrQFEV1qOyp3lIXwCG8zArwWDtbmnY/VW82ZC1t9n3x+bgQkJm
         w9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791478497; x=1792083297;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=77UKqVyJYoVP3y5ptGHI8ybCb93qRK3Olv/o17E2x8M=;
        b=OevGE5xOAXGwtepsVXbKgYGrRRGHFLCDgSSZuxE/Qyq8YfR9SPm32EKuzgiS2DSTcH
         XosBwL8M9MEEgrlJVBSvyWua6Gy3KIYG2TpXvfMUp4SQs13/Tt6D7kNcjH1Z9TiSErWx
         qhQy673jSFaS/UfzaWfCGcAgWdHuANL0FOx2sEnhlb2cleQKx7vrUPqOKwkrFYyjpGTv
         bAU+ary1LLmySmxg9qz2fHjvNeRyNaFVvim70X+e7jTlUHHZEfmHyxekzw9RTMJC2Nxs
         IyEjteOVlekJb2Mf8AcKnqzVpMqfzSkPxPPivvqFUnL1oTvfCqiSXPlUfBmnFWqtpxJl
         vy+Q==
X-Gm-Message-State: AFq9FYK4TSTWBFwo0yXbwaw87b5A+/cRjKY5F++VDdd42XJewQcXLuFJ
	E7mz46QkTGiQ+ALLzQHtPkTrVZEFzBG3ChkfirFW9s5p9NlqsFUZsEHikDRrwQ==
X-Gm-Gg: AYBFou16x9h7LzIn6Oa6rAPi3Pr3YJm3jm8JL6rvjHhY1t6HVJaow985sk8jjH3q0Iy
	13M1YpvpYsx6Q+arrPrAvpV1fJPam/5AX4+wSWQ5m+DWJoBaqyxMcbp0ytqt3FavCUApA7uWLmt
	qfrrnFuzA7FGkLnAp6rMLF4jQ0MjfUozsQUxygjb0ScE1srxKgEkez6NjTjWSZlIgZNdl4OkEkF
	AV1sPQyX4LZO/Mnu4UOStvITlI7dtajd8kv/kQL726hRaSBOgocF1CwSPuON//8q7SRlwg945i8
	+SF6FvzwxLJek+JcKAOOZGPqFRv/9Nu6utRBlM6SlSRsC5/q6aTGMSiKCn/o14TXDDk81Zr8rBs
	g7XKX+CHo3ATG/8QxXIxDr3bFg+yBuF/WZ0xiwnySRPBs6uVJfwSoK/rm+b0Sz5qoc/CAhhe2go
	+u1SoSlLA0e4i+5RVkXb94jS9F2ScFmqK+lJKF6FKxoBWk0pDxOfimViyX+yTsNNuHA6XU2mR4L
	N7ZHw==
X-Received: by 2002:a17:902:ce0d:b0:2e2:c491:ec80 with SMTP id d9443c01a7336-2e60036c9b2mr48332275ad.22.1791478497323;
        Thu, 08 Oct 2026 09:54:57 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.236.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6049497fcsm29302655ad.64.2026.10.08.09.54.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:54:56 -0700 (PDT)
Message-ID: <6ac7cae0.acff6646.3d4557.94bc@mx.google.com>
Date: Thu, 08 Oct 2026 09:54:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4688369726803294986=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] Pull Request #2572 was closed: gdbus: fail closed when a method declares a privilege but no security table (#2359)
Reply-To: linux-bluetooth@vger.kernel.org

--===============4688369726803294986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

The following pull request was open for more than 2 weeks in the BlueZ
Github repository and it was closed automatically without taking any action.

   Pull Request: #2572
   Title:        gdbus: fail closed when a method declares a privilege but no security table (#2359)
   Submitter:    1820893135-pixel
   Created:      2026-09-23 14:18:38+00:00
   URL:          https://github.com/bluez/bluez/pull/2572

Note that the BlueZ repo in Github is only for CI and testing purposes and
it doesn't accept any pull request. The patches should be sent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) for review.

If the change should still be considered, it must be resent as a patch to
the Linux Bluetooth mailing list (linux-bluetooth@vger.kernel.org). Closing
the pull request doesn't submit anything on the submitter's behalf and no
further action is taken on it.

---
Regards,
Linux Bluetooth

--===============4688369726803294986==--
