Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C67153509
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537882; cv=none; b=nU3ye/nw03UDCuKF5rdUV/9+1hOIPz5dBHn4FU3E4VGWEkAYjFSQ3PFr/rHXMda36KuHISDGL5LlkBDhyJMa3mBgS/fOn9WQxP8hMG9277hC4rCdrqZQzFBA4mTTzYcr6u057xtXVmjrOmF2AwLxAH4vY2wH02Cyh/E8n1iHXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537882; c=relaxed/simple;
	bh=7AU+CGMctS/U7y2Va3dRBC10Pbe79TqvqpPp5ojOtJU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DWH1YfKQ4GMso59Bjwj/39LqOARnbDZdk9tbOi0z2GCItY6xKd0mjnEiGcHeoWEa3Uz/LZ3pmB9GOHLXUu2+JGgG6genXpVABr/ZitFwHgXmaGvOZ0poUaS1M4H78EWLCaLR7VxhWqjRvWP1mtb7JJOXIWYrk0Id+9uEOgO39oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcQi/6G0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcQi/6G0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-449f23df593so1156731cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720537880; x=1721142680; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oIPiFc/5d45pV+WL7E9WItgOkRm/VIvDr6Y6UBFfzqc=;
        b=KcQi/6G0Q0E2aSmGBvDm9iKdGOH8yxUNkPO6TMzTQHhtFNGcf9zyITuHg+1BwGLiW+
         jP2qE1FW2DJVOdOMXoYKzMgTx8BDlqIe718SVRgYsS7fLox2lttE2tB7yYWttFRbsJVO
         zvn/k/xelRwSqasREFNL+HKTr8HdaMMtj+Pz+APVGwvk0Cvw2bMWTyKuvGOVDuHhr27m
         Y7gnVjV7R4t6MxYV4wdquM+OCyf5Gj5vtdGHeV3ZviKmYpZpSy0mt35ukxKa9xGlWdAH
         avohKbPrIKNdrFxCGfDWvJJot3Yu/jX5sU823WIK6ehRLU/4oDZooS588NE7nETle7Am
         aShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720537880; x=1721142680;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIPiFc/5d45pV+WL7E9WItgOkRm/VIvDr6Y6UBFfzqc=;
        b=GoVJrPeRnjb+cYm4q4ywoMKHHJ5MNBuoR03grzO4wBh+lS8a1ervROUNYuJ512I57p
         rayC9U8NCr7/Zj4MxI7EctTpgoLJ9SwRMqR6RsbU5ZNsGhKsOSma4PaGbnUW+Q0lA0re
         7mw9NiGTupQzCJk4qLTifMokwaNmDaToDwSrm9Xtb8/9P5vdb3gKmm2zrvVYBOIZ4GUr
         CQRhyTA4qJlQ6W1TYGMp7kQYBdhwfi26UyL60hVqZmve2R6ph152rr7216LMVlMXwuKZ
         agul8ItdhU8xJi4MmRJ8P+Imy35Uu4/1Lopct14j8JYteMOi+94t9Qt3FIXthDPfXfEY
         zm+Q==
X-Gm-Message-State: AOJu0YxJjFI8KOOry5y5eUjyjdC0+yQH1byd/84+r5R7Z0ocKeiwp+3t
	5R8r1Yme0IlUryc9B1Onikaa4vEepfctxrKlgx3/l91OcyO43VtaMhEWNQ==
X-Google-Smtp-Source: AGHT+IHBJI56qPUmrw0dvsJ6GuyTnNvfVqVEdmqAmRKM9VqKfCZabDGfgK0CYgVHh36INh0FFWnH2g==
X-Received: by 2002:a05:622a:164e:b0:447:dd66:7ffa with SMTP id d75a77b69052e-447faaa5d49mr32045791cf.41.1720537879970;
        Tue, 09 Jul 2024 08:11:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bf3308sm11194221cf.85.2024.07.09.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:11:19 -0700 (PDT)
Message-ID: <668d5317.050a0220.d0726.45f3@mx.google.com>
Date: Tue, 09 Jul 2024 08:11:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8281201112915774105=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: fix errors found by SVACE static analyzer #3
In-Reply-To: <20240709120031.105038-2-r.smirnov@omp.ru>
References: <20240709120031.105038-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8281201112915774105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869638

---Test result---

Test Summary:
CheckPatch                    PASS      1.90 seconds
GitLint                       PASS      1.32 seconds
BuildEll                      PASS      24.56 seconds
BluezMake                     PASS      1667.59 seconds
MakeCheck                     PASS      13.11 seconds
MakeDistcheck                 PASS      179.03 seconds
CheckValgrind                 PASS      255.48 seconds
CheckSmatch                   PASS      357.30 seconds
bluezmakeextell               PASS      121.14 seconds
IncrementalBuild              PASS      6078.28 seconds
ScanBuild                     PASS      1030.01 seconds



---
Regards,
Linux Bluetooth


--===============8281201112915774105==--
