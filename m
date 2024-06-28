Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA8158A17
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578449; cv=none; b=bhH27YqKUAm9yiWepCjAL3pXJMB4A0n3Mc1db0Z40zsjLQroOkQPs0QYg03156mMtKXeAwETMSlXL5/aarHlFArzaev+OKxp0O1o9oPSdXO7nr26DLBeC3naLtKb9KKGJ+8oKCpkkyiKV6HK/0Fw0ZdBH/XZyPK1JYNabbjLgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578449; c=relaxed/simple;
	bh=WQK61I7GGKJoAaX0PZYhif8AsQq0FZkb9bh+6n/o//Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tvlAQ8tq1Qrm7WkEHuvqDFwmjx0vb5jy2AAXp50Sznnx5KwEaa1sr4Vy/5/PF/XPuQ6HSit7T3tz3Yh011jgGUrIr9xWv4Kf+bmnmhpx12zQmz/cFr8vAKJKCU0pl7papWy8vCbb1oFJoozS7HLnR0q7vzrELADSxNzYAXHTy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/fr3kJI; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/fr3kJI"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b4fced5999so2498296d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719578446; x=1720183246; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rr1sAH024U6pQ8/zf6seVYS1QzP7xxpnrNZODq2UBJY=;
        b=Q/fr3kJIN1hTp2S79nilUnkWWWHkNCBZEsBKoeXH5dwYey6mjvAbFwQV4MAgnwkVpD
         B98f/u9xudS5evjNuTDu+HEfpRFwaUtNapaJCyaEn9Yr6sKx8qvRTU+FdSzweAQB5h/b
         LyGTbPGdPx8oNxQX0Y74RqxYyHdb2NkbsnLrbahTq75KI1dbYmEtzdZX5kAp82RR1BrM
         xVlzgHKxpZu9fWXKlbiGWogHtR4qpQ9IZLmUxRlJHW1SCP3Lz8Jgo0Ftb0imoxE6hNHT
         sDcrIK/M2hs3cS8BF1qaoXDUGB6NCkG22Ubyr0XVGB7D6L84I+K8vxVYVazdCQjxGQoL
         +kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578446; x=1720183246;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rr1sAH024U6pQ8/zf6seVYS1QzP7xxpnrNZODq2UBJY=;
        b=V9S08uZhTAjBfz2+Y7qXcfkd4NbakJCwGIdeaJeRqYLfZZcEK1iTtV8w1nJrGWQaqo
         Gzc63YUb3tehSZaGLXB3e4Bb0ClNqY/1vdLP8yQssYkXdSd84LPZCB06TAwMYCpQW9Ul
         keZkYlBNvcCPSjCZ+m35ZAtWlOZM+fZVQPy1gHcPv/Yf2Yae5sCfWL6vg6EVihbyJJs4
         dSQdZwu0O3VqxWwGl4XSVDgkmBaGpQuWvCuEF9WmkglWGfNQLe02HhIsGWXokYGY+Ubh
         ETLPGXJtP/ciMZk3t8+Dj4ce5EpdxKekyhM5uYI/SYrVJq4NzC9NRnh+O/vGdQ4LZ1jq
         R4mg==
X-Gm-Message-State: AOJu0YxpE3I6gH+7POh5etXni+uCUD9aMoG1xzciv6eZlFqjaIR1H1p/
	e4qA9uhyUK3rRV8yIjBnWiPTCpg9w4dYPZ+khlIRbn5iAi2jBkdVvSyknw==
X-Google-Smtp-Source: AGHT+IHdbFlGBmoPSS0fWaaLpVrT9EThmg3yp028UNnsdZkTfapYN9NnuFR1k3rH8PV4dzONsd+wZA==
X-Received: by 2002:a0c:9cc3:0:b0:6b4:fdfd:fece with SMTP id 6a1803df08f44-6b540aaa8a7mr176221356d6.44.1719578446330;
        Fri, 28 Jun 2024 05:40:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.106.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f2ee0sm7411656d6.78.2024.06.28.05.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:40:46 -0700 (PDT)
Message-ID: <667eaf4e.050a0220.946cf.3395@mx.google.com>
Date: Fri, 28 Jun 2024 05:40:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2933466867128130867=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] a2dp: add NULL check to a2dp_reconfig()
In-Reply-To: <20240628105521.540629-1-r.smirnov@omp.ru>
References: <20240628105521.540629-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2933466867128130867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866533

---Test result---

Test Summary:
CheckPatch                    PASS      5.06 seconds
GitLint                       PASS      0.53 seconds
BuildEll                      PASS      24.76 seconds
BluezMake                     PASS      1729.03 seconds
MakeCheck                     PASS      13.00 seconds
MakeDistcheck                 PASS      180.18 seconds
CheckValgrind                 PASS      255.67 seconds
CheckSmatch                   PASS      359.16 seconds
bluezmakeextell               PASS      122.04 seconds
IncrementalBuild              PASS      1502.11 seconds
ScanBuild                     PASS      1031.31 seconds



---
Regards,
Linux Bluetooth


--===============2933466867128130867==--
