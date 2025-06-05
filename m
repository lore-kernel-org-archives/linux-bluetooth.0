Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4317548
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749154189; cv=none; b=iP9L8lKCMgEsQvPjEr91y9Iw3CGwTbCOGrpb7Xm6KqFw8tH9nJO0fPlwix6PK8L6tC5X2URqJENNzefXU0+l1NPstV/GKG9utqGgcc6wBirHYR+P2RMMtGQBAYzmmfl3F0T8b8By4D7DjAYfaMcdVN8UEhGJxzBchw9OUbWDZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749154189; c=relaxed/simple;
	bh=DyDXS9ft3OIFHcLMzHUROnlYQfldVUZw2x00QWKgeIs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fXMjC+kAqKMlg9xaJP5usNJG595w7uS0jm97bXa16phIGE7LNpuHRwZ8Kpx3pK8xArYf/Xh82EJM2IBtYf9q4Jx4/5enPF7CQeB6lrVxJZB0yEEDPhQ9/C7DKqFZekEZsARh31WtKPq1uhsBKExE169TBz2oq5i09E9tyMOaZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeqFc4Gq; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeqFc4Gq"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fabb948e5aso15325516d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749154186; x=1749758986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1vXJF5Ij26IzZ+FtePmTgFqhGwkr6XvkSSvl7b/yZEc=;
        b=IeqFc4GqM0vFKfCujjSPAyEYRvGGqMusWMLkjWt3FHTVWxUEbOFS9uoBgHayWbIBw8
         5ZNgKwPu/c9uXcnEJ7/owOSWaFAknAeX+o0ajpTBed8OOqhigLRZWG6Qv0kF2x+XmPWw
         GT5cp4eHdot0WcIcQ0pJGE8iO8Q0CMKj6gt1gy0loZYMsogt1tNtkezoWNOsI5aYvWYa
         iBcGZZMmCoS2fr7IJf7wE772V4cvw4LVT9xzIkkZSCl1BvmjnbTM+t/oyAXdhfPxGXWZ
         Iae9aIOnV2pulmvSMHxAP85s2nh7kf52KjWE7jBENpDW9FqMJJzB/+Cyf85pRRXNqktU
         Foew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749154186; x=1749758986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vXJF5Ij26IzZ+FtePmTgFqhGwkr6XvkSSvl7b/yZEc=;
        b=NjrNu8vtU0BzZpTkQmmifrc2vElEFE/vBOMLT/lBMrmgMfnidQnZ3axd7kCG2UEdLv
         kNoxEjjXg6VhHCiJl89i5JR2+rRIaO8FnC4Dx4fJCSVuYPNBDdxuev+Vz+AU/8A9wHjE
         ULkdlq3AAtb0PqiqZaspqU/mfqpGTUGu7K/gBgK8xp62lGif7eVxW/pcfjc1DAMMStUL
         jzHxvMbQ47mI0P1q7LyxfDy2c3PIR4iM/cLX1i/MUGSVp2fFaG7Cd5ZSW7rO7XcoIr+b
         dEKmmejyUEfGbVdPFTz/yEeDf6H9HpwVp+wwzL6EJRneJ6dCKN/FrmnK3OI4sIC7BrrK
         JPDQ==
X-Gm-Message-State: AOJu0YzdA9/j8xe5pXGk2TaoHcdtP44KH9EdMIQNL7APho3y4aY0mGAj
	yTvY7DTsIkVTjKClJkLU8+ujZEgFnxvQOCXV4fSgoxJswb9RBgKqbK9cJR+Qb9jX
X-Gm-Gg: ASbGncuRhvPoDiD5CHcYkW1/KvmXBJoLYzfl+oXpWEem2FpGDQrjGWuagklfuYPfyv/
	V5sels42laFGBrBNP/t9WZLl/Qe9AaSs04rHG6vTjEBF6wFxVTdMwN0mg//ctwtZsmMbwoNszQb
	u+PEEipDH5n49fw6gSQl0KtoZm5DTLSpo/FuO34qPVAclDPT1XP/eAs2xOwqnrSaBuwsSH9MyaE
	fGxMsinQOdZMPb2etgx2r5jA6paYirPQHuYTJDE9h83L4SVhoQtSp3S85/U4ZBj2B8I8dwuCYUb
	oaW3MtrtM3Jdq1mg+IlwVtk+ce/3UuIQ0MTPdqOFAlIoqVWm5UPRPARUi9rtNT8EUcJ2
X-Google-Smtp-Source: AGHT+IFg4B45d6nuC+uTVDMRhzIqmH010tq9z7QIP+++L/l3KcbpcaJp8ujUT6sON/i8eUtxwCi9GA==
X-Received: by 2002:a05:6214:d0a:b0:6fa:bd17:338 with SMTP id 6a1803df08f44-6fb0903d83dmr12449546d6.41.1749154185907;
        Thu, 05 Jun 2025 13:09:45 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.219.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fafec3c10bsm26749766d6.107.2025.06.05.13.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 13:09:45 -0700 (PDT)
Message-ID: <6841f989.050a0220.2da957.88eb@mx.google.com>
Date: Thu, 05 Jun 2025 13:09:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0525927027076998371=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] adapter: Fix exposing coordinate sets if LE Audio is disabled
In-Reply-To: <20250605181256.853484-1-luiz.dentz@gmail.com>
References: <20250605181256.853484-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0525927027076998371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969025

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      2621.01 seconds
MakeCheck                     PASS      20.28 seconds
MakeDistcheck                 PASS      195.62 seconds
CheckValgrind                 PASS      272.16 seconds
CheckSmatch                   PASS      299.16 seconds
bluezmakeextell               PASS      126.99 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      898.08 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0525927027076998371==--
