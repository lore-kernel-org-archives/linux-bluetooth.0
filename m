Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430DCA45
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266045; cv=none; b=N+yZ9Y6/cDSOxd8R/n/9P+jmh3v7AOUM86tb2KbcxwkFy92QQPDwzSWZtU7zYwJ4LXWs8aAYu1pQ8K9iJGF3Iek9xWV88ub1bGgGqA7ydhrSnc1rlhxcEWqM/5tOeZhID/h3wq5IwUF9OiSRyP2r5fvWu8wy/ebaaAFv3AsYL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266045; c=relaxed/simple;
	bh=MwWW0A/NUOMehA4fTMkXPaGSqNDLWA2y7KciIM5AA40=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aNZcCIILsYXeSAGlKwW/LFdHmB2ORsvFJS0YgrUBMzq5IG50Z49HHLThGzu9F53Ir1VN4GQUfoacsaS9ZvwmPNB2NHxfxk+c/eN8ryjGzKvYlVaOsEq3XYGCy8m1DlepD3NyFpOsTeDB8h0Hkj3D5x0ywA7RbWWtIgNAyiMbDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFQKYSRJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFQKYSRJ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so23997366d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778266043; x=1778870843; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wqyDvqqMNtS+m+09TRVclOb5AQzVAgliBfle109f1W8=;
        b=MFQKYSRJJJyGE5C30AREi05tYITRIfcWOG5dpTUjzIok1rB3Lt8nPXhXycvRwuAWb1
         nQRmiCQgom1up46S16E66J5vxJ4+mjYH77aiTqiLuoN2etdnnR1P13xO7MIHbUpFafS+
         KHdue8dZqR9RNhJcKPWmDj/HE1BLov53KebEKty0/bwM7hh66/9sJsKSaGPDwwfJpZFz
         p7Z+uPxNZ1sDMx5/2zrrxYMho3+uIj4PG6weYQMS3/llCcNrg3z5TAny3z/goaWdQRqC
         LP7OchfE5A3ZX3OZfkxl+Sej/e8aJCxFyiNNJcu3Shx9+fh3q6YaU9d8krMbfEh4JAkC
         r1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266043; x=1778870843;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqyDvqqMNtS+m+09TRVclOb5AQzVAgliBfle109f1W8=;
        b=FP+lRMj8dQ/RzYcINTY/yMFdwpQLwVD0lqNiQhz4votGayRJHSoAmfXRt7ZkRO3NIa
         8rfybmksVKy/le8iDSiuK1dbONI0WzMDhpkxITgXpLsN4H+/l3CD0qH6Xc1PO/ALYPmk
         fH3zZN2lFKyIdDtvMZCSjHoh7+T/zVmwWoIjPyQaQynrbJEr00oZzDbU8jcsp0Vf9LIy
         wmtKVubB51zFDkyVVHFOx8XFBEV/7dwx3R9mmjnr1Q0YYImz+G4lTicwrCZ8qBbp/4+F
         uCxQUgeOs5fXDOmOPNSl7WkQmRlNi6n3FLpBf0nScOL2epwgvuks0DuCXCEx4MmNxRqY
         xJxA==
X-Gm-Message-State: AOJu0Yx601tlkbB50M3pUxq0DTu7cFxosgfqqQDhnAOPHrmoFK8IU7i2
	b2IQZAfuYdvQQ8A86zNvLWhnkMO737v8isGIq3fHVQHWyEVgJl8ZK2ZGeS3i5Q==
X-Gm-Gg: Acq92OE4zD+P/4kK0sARfVvoaIrFAvGe+QwOIfOZbRO1mwqquCmeCD7azQzxjaZZwLP
	l0gOajdEwVxZSah1WtSSZ9eaOVqocqgO1o8swbd6cxg3Whko9QA0Aq/ZbroRaurMprqdAAGVhYx
	a+SnCld6/WYLt4auPlwxOrOcuWqukLpx2q29kRhlrD55+ScDL6UmAbRFOHhOLTu6NNkQarthhio
	nF2cNvyCGHeSEZWLO82qBGUCV5+GQEEggU5KdyDGtxIJbzhq/p1juri5afXMyMuto0PjV7jixlJ
	JTJHlYOHB8ojLV/ODGS2Wg3G5ceFd6zU9qD2xPkdRYK3DE2CqYhsOF7ieUDU0F5YqKHRCv1+0ie
	l/pWVtX9FB/ortZ/JnRtLHm5Sa6M3qBcT6pXTYGygajB3Ph17EsnZ0MzOv+bgV13GR2TyTDopbm
	FB+dYO3GX6XuLzZSvxd02kGK22qi081r/nHmbYKGYr
X-Received: by 2002:a05:6214:dc7:b0:89f:2fa:a9bb with SMTP id 6a1803df08f44-8bf412ff394mr61847256d6.9.1778266042620;
        Fri, 08 May 2026 11:47:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.30.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d83114fsm238693876d6.48.2026.05.08.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:47:22 -0700 (PDT)
Message-ID: <69fe2fba.0c0a0220.f328.44ec@mx.google.com>
Date: Fri, 08 May 2026 11:47:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6970641213488498560=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: Bluetooth: btmtk: handle FUNC_CTRL events without status field
In-Reply-To: <20260508173121.27526-1-mikhail.v.gavrilov@gmail.com>
References: <20260508173121.27526-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6970641213488498560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091757

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.70 seconds
CheckAllWarning               PASS      27.71 seconds
CheckSparse                   PASS      26.44 seconds
BuildKernel32                 PASS      24.94 seconds
TestRunnerSetup               PASS      529.49 seconds
IncrementalBuild              PASS      26.83 seconds



https://github.com/bluez/bluetooth-next/pull/157

---
Regards,
Linux Bluetooth


--===============6970641213488498560==--
