Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E3284B4F
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479248; cv=none; b=SX9WKsc62XhHFj25JQIBxQcHc3jQVDozZjFZYYepyjkKVa20VlugFZFkXH+ZoDAESyJb8544CH6CmAaWu1PQjyt0HZjXP+bRNiIdw0PVD4uEfwcMxUy9KQ2SyR3qi2taa3S9biGE2s+S518vQLlfTDrqD+cfhlMVrrHp+FKq+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479248; c=relaxed/simple;
	bh=FKhNPWiJbrZdN+qIyxovUhrqwMg20twW4VFgWrIPSsg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=he0EZlMzNsyEPc1MDF8wPUgjOjVOzLmdwCnmQqPMdV5AvmPiROOXWc9fgcPoXGfOh8DgD87uWty/xyElazS8AY8KrRdfZdzA1rYVBIbow3VbVQjC0ZeM2Za3sUsKJacnZ0LuJs3EbxAWH2p+D6H9I2nPoaBK+AMQeqQBbgmdHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2v1fNtK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2v1fNtK"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92ed19f4d60so41904685a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788479246; x=1789084046; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=31+fBwgXWPif1z/ufuh0wrPzCQVeoRzR1V9rWtvW1rQ=;
        b=T2v1fNtKe+78g3OsSOFSXOU1Uy5QzG+RlRgrGTSaYV2psF9/sggJ5mVkCo/FaMnBA3
         4h9/ujXMwcyi6gJjdyJvirJCcxlt9wIb0b4tvTC6tAupqGwa4x+iMKrzcxT6hiCoTM9h
         fYcWO+aR+vLLGszTlSS5XeoSM7HnBeFMyl8/7ASgtHsKhzl6f57Ubxg1jIhWETYZfqJn
         dJdT3nP4YRgZQEDtOShB1p8asFvm3cJ5JzFfMSe1Fyxv7HxIlUEud5OQMKnjQvMFdbMA
         ycW5TmbaAhfhOo1+es/4VrcuyunaO5r0rZ02hXI/VInuLAWKjwBaKJ1j0nCKwegbfAid
         V7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788479246; x=1789084046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=31+fBwgXWPif1z/ufuh0wrPzCQVeoRzR1V9rWtvW1rQ=;
        b=UfqVDC2ldEqFVRpYPKYrbWXLNbKEG4HtyNv1BFg68KrKHb/3x/42ukFeNhKaR69vcq
         /GVbcjFKuQuktiNbHGL1Qr1N9zgb37aL02qEJ7xRUn8CS0FipYgbl8NKqzmyBnf12bGK
         RK3oXf350i0knMfuA38Y6ET/pHCtNQbuh3IT/SaMa/fK7EzbyPD7CxVGVg1S3lkZK8l5
         5/EVcTNWYOTuE9s260OBHYr9NthbXgwBrkJb0y2vkqfcxvQGnhUk+UBkdvWLW7XjemZY
         I0Grlj2R5LJfjLFoWbt8hO7uI4fdio600CoGAs5Fp/1kYT8awA1Hj4QfO+fEx7E6buh/
         5urQ==
X-Gm-Message-State: AFuF++kyg6kR2ioGgMwRS8V5fDZJiN6gm2MOL4vKiSfZNKkZLVQuc5N6
	omvbWEpr/y8gN7d2YuGJtR2S4k5V06dHhTxr8ZPas6ZJB4DHqVIs0NHgFcmRUQ==
X-Gm-Gg: AYBFou25voZqdVz7SqUcRPDI6zRHfR9Tpo5mXmeVnoKFD9r7o/LBCcSHhRG5I4GcWaF
	SDHQpLOW9eG6ENicU17kvJ3iisYcEP0kIWcFnjQcx5qST4ftH+3CjJexDW3dO74K1y2g5YMf+8Z
	86Qe3SwuTX4qcd/8sIlPe4T7+i0HzY9J3NJ0l1jSO1SqJfzi3lv3fKRGhEZp3esJ86jj42JkQPq
	LoRmh6m0cWj8BxeX4eaz8Tf62Swud4ydbI1A+/uZ6dI96wdNTwpYyk1BcO09dLB27iQDF2sIzQV
	ClOYdpqN0Vsm5Qirg0tUheuENaqEZ+w7gFj8UyldnoNrV4L36NINfkAyBDPM1R/1VHdPoKAQXSk
	VR8oq+B/GLyEq787uR08s8z7udz2KzrWoknfwpobRwB9VQQ3mIYBR8nyAjJwc7p4IGDGJigJHsE
	+MORNpKJL6Rt+/rANVyPFHMROSsTcA0eYfq2u2+ptI4e59fuf9PBQFfPasjO8oTLreOgA=
X-Received: by 2002:a05:620a:2b90:b0:939:79b0:e68 with SMTP id af79cd13be357-93981429145mr112805285a.4.1788479245734;
        Thu, 03 Sep 2026 16:47:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.102.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbf7c78sm80427685a.47.2026.09.03.16.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 16:47:25 -0700 (PDT)
Message-ID: <6a9a070d.feb7f338.220a9e.2709@mx.google.com>
Date: Thu, 03 Sep 2026 16:47:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9173870436194470254=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aaron@embeddedts.com
Subject: RE: [BlueZ,v2] btattach: Update for glibc 2.42 compatibility
In-Reply-To: <20260903222005.482058-1-aaron@embeddedts.com>
References: <20260903222005.482058-1-aaron@embeddedts.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9173870436194470254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157441

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      15.85 seconds
BluezMake                     PASS      494.98 seconds
CheckSmatch                   PASS      231.22 seconds
bluezmakeextell               PASS      74.44 seconds
IncrementalBuild              PASS      453.86 seconds
ScanBuild                     PASS      718.81 seconds



https://github.com/bluez/bluez/pull/2490

---
Regards,
Linux Bluetooth


--===============9173870436194470254==--
