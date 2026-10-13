Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4EC4EBAE6
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935584; cv=none; b=WQ0UA7n+8t2yhN5Z9do6xDc2XzTQ1u3tltNYyvhwOEYxpA2D+NEeBZGgQCTnWpSlpv67fLvobUBsixc88SZH1+tqEMtOqWYhGFa3Mqv8aZ99tcf07kiGB7tf6gWKJlsyUfWWJQNJbhVXK07/lLm2acpNy2lorM/7dfbLMO25NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935584; c=relaxed/simple;
	bh=8KefpZ8+e0reqMoRnV/hd5iC+FHXWJeq7Rj/49B4znM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lJ9uiRhZUVAmJIBUUy8ABGEjoNodXp0396owsc1+ijn/MobBX2jLD+BfMLSjabvKxbkiY5oMhKmSeEqncy7Yy+bSSuGyliySw4PabheJafkAhfkxpA04XJ1DZOVam1uG3w1476bMtRopD/iNywHZUwBHAt9ATX9Dq7KiDRdg70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbGDi3QN; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbGDi3QN"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33c2520ad38so8151083eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935582; x=1792540382; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C6tJTEHrYgFnbnR6qIBmkaMJcmJMRpJvNA5Y0NJAJrg=;
        b=GbGDi3QN00HIC9i/wHlRH2Nv2IPsfR6pznN4D47dQtonV7QYZyox6nxjDtRAXXq6V0
         RSo/JeW7uOymFYVmcOMSXxsSGJJMnCVTwJ7sEmpWyBOA8Vo8YqWyataFMa58Yzq7VyQT
         w9eC2gCgr54zIP8t4Xl7Yy4KMCHp0umKt4b/7vQ0EBhN9mC6IDOjNtxMt+2bC0g047H8
         2i3Or12VhXD/m6XcmeNtWXma1qtM0UdvMMjv9XwEmBwmjKh84hd45wJlpH2zwiHUbAh5
         wXkboqSF2YCJPzrQqSL1cnnAJwYh1rugzsjALdX8zF80c6bvQGcF2ZZoK9hRlbXWNkKg
         7YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935582; x=1792540382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C6tJTEHrYgFnbnR6qIBmkaMJcmJMRpJvNA5Y0NJAJrg=;
        b=i193eG+s6/Rn9CLEX4EG4cKyXIwPUYofnBG3zc3aPwADTx4xLHBnP9ApA47fIghtqB
         Fb9v8EBFB/ffewxJF0XIolQxB169lQ8hHzwk4xCIRjKItqCyegbmClTPb3tJdM1Tn112
         BqKRWyyN3xwtB9E11lgDQgidGLEniRpbM0u0LGtHQfOq9m7s13VaaVGKcrxuvWuafhaq
         KXjXdV8vda1FhNcZsN+0MTf5MXDulSwhyDohMnZ9+H88aejFjscZkhLj0ftu+48vsqrE
         aW3UCkJjPbVefdWWuCDBWLGV5A2qQs6PTPFoSxPDgUvwTiDaz7T4PN8Lh++Revvwrry0
         PBhg==
X-Gm-Message-State: AFq9FYKdSH7UXeIF0vW9aM4GgOqKYMFtjLIfEdfmFC7othOUGrN0Ecp+
	cAC/xk+sict72jtfvSIfJY/JoEANU45TU3vcDd86oRZR6t2Sejf8RpolGLnjIA==
X-Gm-Gg: AYBFou2IfSwFlbo7eKw9Zwdzn87pW9+2yxSivG175v/sl2YI1GBkhURigXy/83MwVKe
	yWAJYHKPxfGDUOsVme6uyCD8Zhv7YJ6gHuEV3kP9DVapED+SdO94Aap/Yq4QJ/eRH7Z/CW7pxcQ
	4+l6A+kUl/T4AZRzCMM/JIcGLOFGesT9eyrV+1kPy9L18STz9OE6XGLn76sdPXCsCJjqIiLfTrR
	GAivXsRUJzYF934SmkgKJouX4z3ZH23n8Ep8veFTW/q0W3bNpITAm5Go22xYHdK8VAF1rcNm7Ke
	PnoOHjI7s4uBkfra+9RO/gC1SUTZl1IAwX7Q22UOn2cCHSbFbQV4lzYfBP1hk5KnTW8Hob5naXZ
	45oIBcMTa46k1KoYCq9EXV7VoFdojLQYkUPN5QvNi3NQPI7/iUK6JfylPM/OWNMMAkMlQIi9jkc
	Ey+PQeGYODa4OzqSbbJCg79vZ7y7+tOtO+Fql9KSLo1mPRoi4wOPa2e/LcS68QzCuDp7KD7PbBS
	3fxVFM=
X-Received: by 2002:a05:7300:828c:b0:35a:5e11:bf81 with SMTP id 5a478bee46e88-35a5e211ce2mr11290426eec.21.1791935582398;
        Tue, 13 Oct 2026 16:53:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.254.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm51297625eec.0.2026.10.13.16.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:53:01 -0700 (PDT)
Message-ID: <6acec45d.82a2a138.123ae1.d590@mx.google.com>
Date: Tue, 13 Oct 2026 16:53:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1015897893123475561=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v2] asha: Notify connection interval changes
In-Reply-To: <20261013222556.513513-1-cochcoder@proton.me>
References: <20261013222556.513513-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1015897893123475561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185115/

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.18 seconds
BuildEll                      PASS      15.22 seconds
BluezMake                     PASS      219.33 seconds
MakeCheck                     PASS      13.74 seconds
MakeDistcheck                 PASS      110.60 seconds
CheckValgrind                 PASS      179.65 seconds
CheckSmatch                   PASS      214.37 seconds
bluezmakeextell               PASS      70.29 seconds
TestFunctional                PASS      908.59 seconds
IncrementalBuild              PASS      219.86 seconds
ScanBuild                     PASS      794.26 seconds



https://github.com/bluez/bluez/pull/2675

---
Regards,
Linux Bluetooth


--===============1015897893123475561==--
