Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AE1DA313
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119181; cv=none; b=QzNrGTdiJEDB9zlXWDc9bqoWQLcH7eknPGsvuhVWHe+I2gb+6MI2bsMcoougcNle4baeR72gzj4EBQtRkWwoE/zo07tOdZXc8P+245lBwSbQTguSEnrya2oIpksUynUYQQGTs5BwBVoxR8l375P/X5C6FWTd/AWhviNGs60VyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119181; c=relaxed/simple;
	bh=ltyFPtyMc1rCXmwdPoI4Yd87g+uPuL9zEKuuBxhPRrw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wb3EtzGcxvtZ13c4eW3uZeNy3kw6hKnb4WRkbMfQM63Ilu55s4oRFBuVDRqwzB6rUUa3qk9SVvas6NkoU8ZRyivb+RokA89hS/88CDvgEpi0OXioxMh0ZRCSq67eFh7RU+l+XFxmwPoL2GV5eciWvv/wRLA5Yp22vQvrNswiCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mayBDxxt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mayBDxxt"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460da5a39fdso25155031cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730119178; x=1730723978; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w+qE+ciRmFK/BTGyh1ogVCoUjKJlfRxObPBBzVLYics=;
        b=mayBDxxtRN0kDsZAI56BuGd0/hy1n2IRr81WfuWJM6DIR3ulAMfad3H2gngG4ZzYED
         c4dLW2oIRo0NtzLoAlocd4FMT9b0giaNxAatb13gZlxGXcYwWuJCjkD9mkAIVy9BsmfL
         pNwMlCQ7U8PiPClhVi651z2e6t2U4Me5WFOjgCnrBlBegiDMnJmn8vo7cuAXkuPgeb0k
         Zt0XmPQzt2OQdACFejK6uQxW4HuG/aWGnaqPtU96M0zSICAEacdWeZHCKt2iaScVebb7
         jDaWcHYH4LkC+6Luq4b/C3A6caDqN/K8uRtBGGJztLizta2VoXxMMGrhXpk7Vxx91ezD
         fRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119178; x=1730723978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+qE+ciRmFK/BTGyh1ogVCoUjKJlfRxObPBBzVLYics=;
        b=BYmWMOvTYYtCWOMzpzt+j4yHRGcBtiHM1Dn6Sj3qEwvi+1gxhYvJ8LV6qpPHJJHBYF
         eud9KKdO7Y604GykSNj4tArV5xnSCpff4oL+RHz+zGyORtkyzBSaj8iJSs3NlOffRp81
         MI5sKFeZzvZ8zvNz1Mkwk3aF8V5VWCqdxWC7pUIKlYJ+N6814x7RqTL8fb6HwhqAtvxd
         XQ3QcOi+SO2mctpd5gjDsQR/a0ahE5jXWI3ApvnmqKI7kD5fQpbcQpZRslp8YFusV46E
         vloPZdShrIfJ3wacvLIwKNQmx79PWINmGTqg7/bAxDvXquJyyhfGCZl2H/sJG02NmDjc
         nicg==
X-Gm-Message-State: AOJu0YwzuBj1dYqGC/Jr/sZFGfmqnpmxr7JojDGJjqTIWiOKNuX/uUgv
	nx/UulXxBb2qEt+g4cRSBpNTgYuETB/LiODG29ZgIOBTw1xQfucQTLnGzg==
X-Google-Smtp-Source: AGHT+IE2/9ToXR2yo0Num5kCbco7vQ5rxgMzwRvhTKCpMT5jB/2tXasED4sIGWPN8cVG2FWtGhFirA==
X-Received: by 2002:ac8:5802:0:b0:45c:a613:65b7 with SMTP id d75a77b69052e-4613bfc88b6mr134130781cf.11.1730119177987;
        Mon, 28 Oct 2024 05:39:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613214d392sm34163901cf.34.2024.10.28.05.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 05:39:37 -0700 (PDT)
Message-ID: <671f8609.050a0220.f1b24.a58c@mx.google.com>
Date: Mon, 28 Oct 2024 05:39:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0997261896559870808=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex : Fix for PBAP GET request in PTS testing
In-Reply-To: <20241028105326.3159618-1-quic_amisjain@quicinc.com>
References: <20241028105326.3159618-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0997261896559870808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=903757

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.52 seconds
BluezMake                     PASS      1676.90 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      179.65 seconds
CheckValgrind                 PASS      252.62 seconds
CheckSmatch                   PASS      356.45 seconds
bluezmakeextell               PASS      120.25 seconds
IncrementalBuild              PASS      1428.82 seconds
ScanBuild                     PASS      1002.59 seconds



---
Regards,
Linux Bluetooth


--===============0997261896559870808==--
