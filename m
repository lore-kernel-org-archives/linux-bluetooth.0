Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1756378813
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921268; cv=none; b=E9ekXmNrgI76DWGWx9lWt6zv3lDIy5PdgYFaAS+eOfXrjTGiQJR7eNVV+hkH0hhq1CP+cmRv8E2zst8ZE0PvWPv0a4BTwm9V27hFhMwnw/18yN7/1AbDUeLmSYYDn/Kaq0nTf4Vlv0kkfcsLW0HY4wn+NlZrhIAlOMzYbKFqJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921268; c=relaxed/simple;
	bh=e+6U9++RLYX93HiFDSNK/QPEdOLKJL8nQPu328gR4zA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cUd5TJRzMBoYIrCdnc3bMAjiVHH2rWUs8qTKygcn8Pe+UzTbUFQBhZs0kbaANi4z3+VPl2MlvEqOIf+CerUQDZ4l6fjZpwL1eZ2v0dpSyrFBUSxDd/e7iZZu2oUGm19QbxuDkHpRJrGfLXoPWuLRYshrYfONfjrW1fF6Zzv9xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUjgP1V8; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUjgP1V8"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-516e1525aa3so52223971cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921266; x=1781526066; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cuxBfsBNmkaudcGd0uz4tAZEZQq1VgA4jDZJRFGGEi0=;
        b=XUjgP1V881D/8SLNBiJzO9jn0xusVWJDs5UgmC93rYcLGSLma6XY4zmmaOOY59qeN4
         U9ys5feJdn/OyBJILl8RoQRvzoxB+0fft/ZCOuWqIbnaCoVTONlC3K6lQJXWDeXnqslX
         MBcaIIyxQZQcrkGTCsaorHkvm/LQQZcNu/qDoRitKMOhzNz5BO+1ZyqnsdnEacAUFvFP
         X8kI5VO1ijWjBHJjZqR5uJgXd6ppSEhxiN9eZZ3rYO8w+nhX4tHXzBZdEUDR6QpU9wPz
         Gc6lKljUBbv1nXHSk95/XWVEV8YIkBul8BtpKYNAHpGQfHe0DmU5PGr3aafi6DLs6n51
         VUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921266; x=1781526066;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuxBfsBNmkaudcGd0uz4tAZEZQq1VgA4jDZJRFGGEi0=;
        b=XciMvUCu9jkhbTXmOxcb7L77vn90KWRM5zY149vpGLJE5LLf8Qr6nX7FZTjhTAjFNG
         fZktJL1MZN9SIm3/CnF5CR3sIw5xx7trMevqamJbjLBtFyQlRc8MpmX9NEguiXB9JdIo
         iq2gpc5sy1PqxDDGlhM4N5BGooZL1ZvvaJ+3LgDD+lQzeEiW13A54T2oo0R6gLPhC2xw
         P2xd5MWRcXVzanF+awLeAH70aZSEfr2rTCU4QBd9X+CHaD8kLrS9taUxCPJMUvACvr6K
         2dVFsW7yCZ2dXUltta3JpiAX8XCUmxmHGNdB2aSGG1CJ+wUxtq2NOBU3fSo2w+pK1uoD
         Sk8w==
X-Gm-Message-State: AOJu0Yyur/X7fcdf8SgbUKZWNFNE8CMKLOqN6zWMY5Iv+deLOQbeTcf1
	CeGdemp2QDoLen/dBbbOCsO4wFBIONVoGlP0aHmNd1pXIJvnC64suYqmWeRd/Q==
X-Gm-Gg: Acq92OEjeKIudIaoQBbBJleNDv/3MjWPVmCgYy+YUH8STrg/MjIc908KGk6TOuPQ8XL
	/2K1kxJFoVTU6x3FPE0LYNd0I+5ivnemDY/cuUmafptuPeEKJLMjXxH+u7pnW0f/OYu8S5f+Hh6
	LI1wOJkRVnmphfvqO8sVwa1L8TookbZJyYYzkC9h9rxFWjGRsV9EpnBJvWndVJR3iNlFQuk8kmO
	a3GLWiDpYdQWuTewJviycb4gEscoiACF18vVMClE1w4hii+nH95mQe2/UBHb57iePlsGO54kihr
	NcKed0UvIFLMH4PNr79MPyu1dJoR6momeRjHEFHIHi6L1Z/jq0k2gZsa+JhTKGtPQGds6cCyf1F
	10xhRgY1txcjf/BeLsBL/mt51884rJAvYhfWhhnxDCKUADMo5EU+3J4xx8YYPI/LH4zslAUkjiV
	gsmSUT0Yr5R8FU51Reo50Gd5NUvV+TD23KCqIwIdhP
X-Received: by 2002:a05:622a:588a:b0:517:8528:e617 with SMTP id d75a77b69052e-51795b4f044mr191696351cf.3.1780921265605;
        Mon, 08 Jun 2026 05:21:05 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.92.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2629cesm161909696d6.41.2026.06.08.05.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:21:05 -0700 (PDT)
Message-ID: <6a26b3b1.dfaa6ae2.161a15.0719@mx.google.com>
Date: Mon, 08 Jun 2026 05:21:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6685671529666890716=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] a2dp: Add codec prioritization
In-Reply-To: <20260608111658.3686364-1-simon.mikuda@streamunlimited.com>
References: <20260608111658.3686364-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6685671529666890716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107778

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      17.69 seconds
BluezMake                     PASS      603.58 seconds
MakeCheck                     PASS      3.19 seconds
MakeDistcheck                 PASS      222.11 seconds
CheckValgrind                 PASS      212.63 seconds
CheckSmatch                   PASS      310.71 seconds
bluezmakeextell               PASS      165.91 seconds
IncrementalBuild              PASS      587.03 seconds
ScanBuild                     PASS      920.58 seconds



https://github.com/bluez/bluez/pull/2189

---
Regards,
Linux Bluetooth


--===============6685671529666890716==--
