Received: from mail-qv2-f38.google.com (mail-qv2-f38.google.com [74.125.230.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAAF47F2F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513138; cv=none; b=axf3kM0uvmtibFrvp3FehczpBqeB2TbQLbKkJAZ7RljvXxv4TT6YcL6s8OjIIgx+1t16UFwCUTONDK9enYCnZb1Vp57hNv9q4rtQoPMOzAcARBTUuB148EtLab8Ni2aUQLKwiXsMH1utbD9J6BM5TQj5sfX2aWx93xsrijg1+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513138; c=relaxed/simple;
	bh=iTvunSER0866eqdVvzkCMCxxLMSbkut236Ol3kG/M20=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Eb/r44/ZRKj8wXdUQK3pI8QlQvBnxI3bxf8gfXIJzX0iSSII6yBbiktKiB6XmN1GIWPcWLqLX8HZW+aUJjuUdR7SRIWc9zQ4AbRlafuhn5QNCZx5Rq7vkXTUhLyCZv2SlJg9rc3gqg+V+/wcU43CUmE808zJBU/EgqJ+By/0+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwvjr2AO; arc=none smtp.client-ip=74.125.230.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwvjr2AO"
Received: by mail-qv2-f38.google.com with SMTP id 6a1803df08f44-9107051ba26so2224206d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 15:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789513136; x=1790117936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F+T8GnyEEfotqrjywCvOm+U1HqnhENhKBoREN4SqYhY=;
        b=Bwvjr2AO86O2fydNCIFuMT9VKg7GyDBQK5KKpfWV/CGviD0FNopyUEo1iVPfPb3o5s
         +OhA/cVfZfOjJdbjXAjwjCDZRKZ0jf8kGCYvsBr8PdSpgwx1zCCwOZ39SGXHA4q8zb7C
         P2yqWJHNrdAUqJkN7XCj2aoIR4oqkwL2N34zAhxq4bh6YNxaJmziHx9HkrDLySJT26x0
         N9Sjt2FHxpoICmp2dDjkjByl8K4OxOclspcCqMb0o2KzLuJPGjbvSDFqvmudQm4jytKQ
         OJakg13iKQKG/+Uf9gXquuq/hhaeoL7x6Hjd8a6ZhksCnIvDuqrgxXR6s+WnzFAfuDmh
         D79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513136; x=1790117936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F+T8GnyEEfotqrjywCvOm+U1HqnhENhKBoREN4SqYhY=;
        b=Ra9B4RU2HQw7Ay5i/cStIlK94NDWGx25giNAOjPPsMvJjx6KmtMjqvBEmUVgtSxydi
         OoRu1i54jO0X41GiFYJzBTgo7oNAPhm+HIO12rFNsmUFqJ/faImqFV41m+K/iMg/aHp+
         hKLGJjZI0f1D59YVFvQfEu6ZsD+q0ekKeb/+7M44eJYqK3c5I6iUfq8UJ4qmm7vBD2uV
         Fd5po1TVsb81bkulVbRQXNO03S51LyP3ZDWhmiiDih9NwHpL6cagtQ/+Y2OyON1e3JvJ
         GoWwxKYfMuiYcTIvJ8Y7R2tqUGDpWxGx9snScPaTDs311/tdgvY5Q097KT2i1zIksqij
         N90Q==
X-Gm-Message-State: AFuF++ltUDCZbNGelM3470RNevtId95V0uZdXx3bQ+Ho2j2bwTMeww3w
	VdgeKeylriL0OP/dhvorjRwuQZL4HCk0bfFt2Fujon697FMGBpBa6NpjCnQ/tg==
X-Gm-Gg: AYBFou2/2BF8nJOMugw1n6Vu4cInfggXRNPL/eebOXfk75CLtr2kYBRLo7LVe6h4q8Y
	1I70DlSxCQtABcYNkBl7TfpyDg656sM/hkRGjG13tkVv7z6E2UFA6s8taYhIAzKU/ym5O0+pcef
	fINDCAGKWDXRkw43JpHA5arUoVA/6m2CwcCdDZwInRAka4GLM5K8yOnQh1K3aEjd2bS1F2dgRs6
	wyHMT7ZRneQEJ2mHCy4iQCMhtK4gXqjpZ68ARVQPt9do9DYLGc7F2kss0PLDcH7L3kKRLRMWppY
	jdYnTkS4ML1MsJDazRWh6FjavpCiyn4fkiGUxaKyR2BRgFrpE0/goFIcwy8r6RccdYPVJBrqqHM
	LmsUcdS/uqVJLQoOs209A1sjmSkyKCKRjwmGO0N+jVjK7SfTTHcuKTk4cSZGBL88JchIrJFSCGp
	zm3enMB7tXcK2Hg9kdMU+T7YPWqSJeyNcjvDkeIX5sHaS84Faxc2TTzS31EBMjC6FxyjrL2oITz
	NdJL+4=
X-Received: by 2002:a05:622a:5143:b0:530:5ece:fcfe with SMTP id d75a77b69052e-5327ed7f4b5mr8189011cf.3.1789513135702;
        Tue, 15 Sep 2026 15:58:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.87.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7dc59sm10029576d6.24.2026.09.15.15.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:58:55 -0700 (PDT)
Message-ID: <6aa9cdaf.a4ae4f1a.d047.b0c6@mx.google.com>
Date: Tue, 15 Sep 2026 15:58:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2719726556731889645=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] test-runner: Enable interrupt remapping for PCIe passthrough
In-Reply-To: <20260915213723.1242672-1-luiz.dentz@gmail.com>
References: <20260915213723.1242672-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2719726556731889645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165938/

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      23.08 seconds
BluezMake                     PASS      376.76 seconds
MakeCheck                     PASS      14.60 seconds
MakeDistcheck                 PASS      141.22 seconds
CheckValgrind                 PASS      228.17 seconds
CheckSmatch                   PASS      287.52 seconds
bluezmakeextell               PASS      90.17 seconds
TestFunctional                PASS      1006.00 seconds
IncrementalBuild              PASS      350.20 seconds
ScanBuild                     PASS      1011.61 seconds



https://github.com/bluez/bluez/pull/2531

---
Regards,
Linux Bluetooth


--===============2719726556731889645==--
