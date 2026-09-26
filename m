Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46554233920
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790386242; cv=none; b=Qtl3ORR59a2rOSoxP+Ab0oHTsEqoUdNsqFhb2O9zLXclcbj7/OduBK3twl0m1eS20AwkQLZ4EObhrB2iEx4gfx1VyahTmAKLsNi6tfwHK08WWhPzpwTzGoDDsootauFZIBLmClu+pvqg3ySSr1I6c6Hb7NI6vy2ec25EpPiw4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790386242; c=relaxed/simple;
	bh=fSmSP1FCGSszDxCT5/TPUZS2EA8kIp7lB41WIxsKL+c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=esKojvehhHFl5FQjrdrtdbZTYKE1Rqyo3fGq3EbCnRxZ/Tezt+RBC3Tt9Zna1aGl7Y/Wm4eV7kcrjavjak4wrBMhkr5P0SlRt7nY8UrlNS6Q979Gx24jb/cUprAku2uMirpylX/1mn0lPWphqBWCWWlH9tW41im318gL3BHuztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSKsBBAT; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSKsBBAT"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so990626eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790386240; x=1790991040; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+DnGRes970k8qBuLSw6RmUG9QgOKP6b2awqeVcgIRes=;
        b=FSKsBBATQOFRYVVgQXL5vefTDBiyhhIw5BpimOSLCpei+AG38WBszOgU9m5nd8NSmR
         sBFrWohbo90/MXUJRo4A8Ilbs2g3zJzVwAz2LI82DE05iPAT9+WOQUMfvEiFKDXGS9zw
         /teDipO8pxTnoSryA3ZHvSugu4PnjC85TmyLwchjKUMYSAU2yHv2oKocPI23/UpL3nRj
         nt+r8jCLTIl430aE04grI7zgi7WGSORho7H2nRiTBEq33w2Mw7CEhE4rn5gojTEXrfhp
         roeyg40E8jIjIQS338dKLeXfu4nPxJ/MF8VeM2sYw1qpXQiA0gO3KNTpp9fFO7qKhkGd
         1ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790386240; x=1790991040;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+DnGRes970k8qBuLSw6RmUG9QgOKP6b2awqeVcgIRes=;
        b=sHkbZvAQK7YjEJoyhgSqYvDJ41Ka6tfU5EC6/W5JDKZesCqqbDrAvVaX3NW4OrJAwh
         ZtRT3InbWmIramMuyd7ka3F/UJMo8UGkWJqHj36P6ElkxalwNz/fl6qGtdbOvatsG+C7
         HXTB+IvkCggTA7W0zgtvatB4+QY1O/ebGx2lmYGKpfgrQGQbSDnlDe/F7jBELC3SsbDq
         4moy+ffK9IWjLiZxa0Z+GH8l71qbmRt4+ltEiIZP9XIgjshFdWU3FKyHUIPW4ZaY9OoA
         qf93dVxxq3sf0zyQPH0UJN3Rdd0eartNaze1JsmTYMBM1G76D5KO9zGafpXZ7FFKsYWH
         2L6A==
X-Gm-Message-State: AFuF++kgiBMy+cQEvbY+YX1UxsU1LTJ2yIoRnB54OLI+bPUSZu3Va0lp
	ltTX9dSPQ9LGaR2+72Eh+Jmx3q3pO3YVLfCpErNc0NcOrI9cEgwFYn5T2PkbSxNWH4g=
X-Gm-Gg: AYBFou13jRYbmYQd5Q2eU6Rj0e3i15syphxRH6rJOUMd7+DKN8dlph40QqE4Xnz/+pR
	GU5xDjiX3NnYf7EXb7d+y805bIy6M260xmMqw/J/BVbQivLmcz5tEhZL6DDs2FFc3j8D6HTc3Wo
	BItbQsBW4gyDqNPzA3UNvq0T1VnFb0bBN71EUshB5ziZeHGx+obP0BJdNgLRKRmdyPkdpH/cCJW
	jf8ufqsg9gtFhoovKkMOfJejCqtVa4QXmtJPOZDwYb9jN74tqP8LaabSbGqB1ScUvjgpRq4fBM/
	+egcx6XmUw+Oz+BQl97yXeoS1KjottUnfLtVn9RZAK2yApO1Tw+IhB8klDUlAhqay0bMX3QUjxW
	b99LbIxrAWdZA5mUePgmbbF6KPkm2jI1OZdSI5ruF6CW6k4wQ9yna/rbE7czCZSoYekmXWdoYqq
	r2c3WmRlN2IlIP1axGWnta+WaXQmcuO14Bvlsdr0l85wuceuyZPzQfoSJ/jR8M2SYMVzuPI07+4
	8RZ95U=
X-Received: by 2002:a05:7301:4284:b0:33e:42ae:ad7 with SMTP id 5a478bee46e88-3427265c77cmr1496729eec.32.1790386240078;
        Fri, 25 Sep 2026 18:30:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.211.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c17074sm8471988eec.26.2026.09.25.18.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:30:38 -0700 (PDT)
Message-ID: <6ab7203e.ec46f90a.25b39.52f6@mx.google.com>
Date: Fri, 25 Sep 2026 18:30:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7622115383176190796=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ooonea@gmail.com
Subject: RE: [BlueZ,v2,1/2] input: Reset report map state on detach
In-Reply-To: <CACmoRBZ-pHuzAUrGK39O_1s1xkbvH5GubRnqtuOELU-Cv8Q6uQ@mail.gmail.com>
References: <CACmoRBZ-pHuzAUrGK39O_1s1xkbvH5GubRnqtuOELU-Cv8Q6uQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7622115383176190796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174115/

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      17.11 seconds
BluezMake                     PASS      303.54 seconds
MakeCheck                     PASS      0.85 seconds
MakeDistcheck                 PASS      127.51 seconds
CheckValgrind                 PASS      131.50 seconds
CheckSmatch                   PASS      222.20 seconds
bluezmakeextell               PASS      83.48 seconds
TestFunctional                PASS      964.15 seconds
IncrementalBuild              PASS      305.70 seconds
ScanBuild                     PASS      881.88 seconds



https://github.com/bluez/bluez/pull/2592

---
Regards,
Linux Bluetooth


--===============7622115383176190796==--
