Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AFD5C8F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125758; cv=none; b=mKgJs+91R1T3G8IuTtpkhCajmVB60aGita1xhRJPjG5aFdRBKwxzexJxXcXrGhcTabVCkxYeUShO+X3Xk/0hP68i3z9OVQzZRp0lrmZG7aGcW89podOLCKuYnQNv153abiL4/2TdS5CA+KweErioLrsC+eRZMYqhWL5lISNINgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125758; c=relaxed/simple;
	bh=JGimFLlQ7HrvT/b52oak9yqC7gASbUiW+tBTctAiAGc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K7izPoijRU0C9Qsf2lV9SXjvMUkEdRDORxVgTYtDpamu1cxAsFvp7URlx7ZNT0y7pzf4Radxc28A4fs7sCr1wwTopl5i2QBIzG+mMjSLv/f6R1162XW/7pS+CUYLHRixTuzVHm3GqCUsQh1ZECpHv5rBH7wvyqBGidDOvH6v/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmjcbQxE; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmjcbQxE"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c390030af2so1578998b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711125756; x=1711730556; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9CRzyNsTpNuGL3qg5wDzFjnex+ewQxO+RBSCIJ1ZH84=;
        b=hmjcbQxEjDPLeF6aG4uBXVGTe+w020Ecz2oh3SgRw33MTf8aiX1kN0AZqsLgK1TSec
         /Tmbr4UXiM4F+u7SUt9dI9cN2kD5IQmbM/1U82WX+eoUIoMzpbHcXjq1D31FVWnyPgv2
         fHteZUMnb2x5v9PhW2En83VjW9EaCzmfNp3vbh85e5LKF5FS0j3JvhBxugMbf4Ry+Y9a
         M8IgUXIWaGV0Y4Jk+yVTTl/abQKZbERQpa0niuu8PbRD0nrUWFIfPTCGn1w7Pk3bdr4Q
         k4xXiuHbahw37o5emX64p2/cCcDQD0QCozCNp5WSRWbCHqWBRMvK75LvTDsjvbnIRbtu
         KeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125756; x=1711730556;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CRzyNsTpNuGL3qg5wDzFjnex+ewQxO+RBSCIJ1ZH84=;
        b=SCAnMbWY/0ZdBA7O1BfvwadnUhAlpgiZUHWguXTEEh6illo/PNipiu51vxbUZBsjkt
         QujmD9s39hCW0UPCqneJ8WrRz+JrhSogk6o3C5o2BA5/GEtAgCbtbDOjSnSuH2ydsCCC
         h8lsvZuEnJL0HWJzfrJ4BfNa4kH1w1Ktp3arz/z1LjAg5ol3AB0pwN/vH9CoRP3UL9cu
         kOmUJxlVzEvfaDuResvhdkgXDUhL/s8O2lmQhGxxUa56QztdoHde6bEk4obNlgSlUVEy
         64LyN7CiezcWe13uGteXtB+c3gvpQ67w0r3c8M2gyovO2uQEQGITb9w/kMZxpu6G39gY
         kVbg==
X-Gm-Message-State: AOJu0YxmVnpvHRHdLrF1HORKWdwVRX156zTEY37W6LmbKjdfXHy0GLJb
	VfNA4QE4L1CZ9vtFqEzTmBAw+5xgkrJ0b4WGj0hm2sjDbi5NKVfr0SeZRQGyOiI=
X-Google-Smtp-Source: AGHT+IG/6djlQPlZ2KMrWPdkjN7q0RyknsGMMCtREnoNmBbF2tGYB2cB1WXN0pKZ5/278YGLq+PYGA==
X-Received: by 2002:a05:6808:1296:b0:3c2:50c6:f14b with SMTP id a22-20020a056808129600b003c250c6f14bmr297371oiw.43.1711125755931;
        Fri, 22 Mar 2024 09:42:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.123.54.125])
        by smtp.gmail.com with ESMTPSA id cp10-20020a05622a420a00b004313b245388sm106321qtb.93.2024.03.22.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:42:35 -0700 (PDT)
Message-ID: <65fdb4fb.050a0220.731c9.22d0@mx.google.com>
Date: Fri, 22 Mar 2024 09:42:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1990399032810322789=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] bap: Fix not setting adapter address type
In-Reply-To: <20240322143831.198777-1-luiz.dentz@gmail.com>
References: <20240322143831.198777-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1990399032810322789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837395

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      28.46 seconds
BluezMake                     PASS      1812.86 seconds
MakeCheck                     PASS      13.27 seconds
MakeDistcheck                 PASS      174.03 seconds
CheckValgrind                 PASS      244.31 seconds
CheckSmatch                   PASS      345.36 seconds
bluezmakeextell               PASS      117.25 seconds
IncrementalBuild              PASS      1611.38 seconds
ScanBuild                     PASS      979.13 seconds



---
Regards,
Linux Bluetooth


--===============1990399032810322789==--
