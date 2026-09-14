Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B03081A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384839; cv=none; b=sVN9sKadk8th3xlvQNlT66zT020pZh1xZ9WTnB+JzW77L7AOBwioDfGeL8F8F6rXqrNa7yzPX5KSKbRXX1HLWywZ19uY9JAmHEgVxEH4hdJDmVhE3mLmjLixqG3zJJN5khTXNHmUInZxqxl541pCXodIOco3KxJzOxgv80SgGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384839; c=relaxed/simple;
	bh=bZFSLXBXNHzITGEDMy+ldgKt6Kg+I7Fe4bMpgvYBqkk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mykBRajKrLg7of519wQTlR1xXbjjwG202pQVB3eivug2KBQnomRquxy/Kep8CGwPrHGbkY5RfDqufT/T9C2mdFz6QCRXuJIyL3nxnbp5h3NiToYpzgJIjSO5SM0O6wp7QODhHPvLbdVvJ9VvVuVKVNd3OwnIW2izFZ9cxVnsGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsV4Hts1; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsV4Hts1"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6d6660191so562069b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789384837; x=1789989637; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TnEKWpnCIUJJWMJcagnmusKoD1ehG6M8eoPDO1B9rz0=;
        b=bsV4Hts1WVxsZvKoW0iX0RET8x1T7TslHqjA+DhJ8XymbNpOo/yr1mshMkHTb48dI/
         uSW3KEkGPAKpsNkTe2QR+R2atY+1iod5ct+/f+CwtzmvGopUbr3Q3gGgdVzHSs57nHSU
         jAwpxfp9IqED4mfoj8Pl9Y2dFbW+VP+OzNAuk763Y+BFGg1B+Wdq+cnW7xVhBc60QhUm
         SGiqwKyPsMxRjcqUC2Zdktbue+44STG09wnEwMUzEA3/mRzFZCJyL7dwdb9GIo9id8BO
         UZ+EiZ5+bM1A0SrLAvi6+rA+g7m9iKXMF79Qb4fapV7nnUTELZj9Jj0YiPojUGz1EQxd
         Wk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384837; x=1789989637;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TnEKWpnCIUJJWMJcagnmusKoD1ehG6M8eoPDO1B9rz0=;
        b=Op17YGrEcwQ18zCqU8E9RZhSkWe/7dU7NHjZ/S21AO0pEVGdeCs2ypzkigZ4F7DC/d
         dkBStw796GoDjzSek2o9CknQ7WaNxkn62fT/rDivrUx/RYlN9CVfGiK0BEQzbqd1yKMq
         1PgQPyDahuOFZzBb3kBW79I1VYM0nw/gTo20+dqnPTCvGXpnPf4KUmbvTEPMIULAiT81
         /8CAj0eWoJ0bezQeBctatPQOy/wRGnGT4bWOe4NJ1ckdCXh0/s4M+k0NsWyyrCy5IdTq
         G5RhjFobvGu/O1E7mmc3cjS5wa4i/oMbmc3yY0OkYuNNExwSBmSYbnK5s5ZsBDgkz8Jb
         IlyQ==
X-Gm-Message-State: AFuF++kj7cKr0FNQnutWw8mrq9/VHo6zXTxhIAptLuSK8JQRtR/w4ELh
	nPY1HqVJqOy5S2mNK7bX114vC8VprKPJILecLVvLhGZt/fn/rMRkDrZCmKxYDA==
X-Gm-Gg: AYBFou0y6uW4P0tX9yJDrBjvTfRtAIGLmT548qKF+7o5Wq5WzeEIhcylz3GfGrjLyYA
	QoDB2eWUfqvK15RnrycWCrqq4fJA/XTFSZ7v64seyrXxig9pbFVoAspnEfGqOmkJP6plynR65qU
	bD0KA2M1J6+8g1GdwlGby+9JNN/4evhHJ2EO5pGsJWXIoVknkXmawhCCh+vpBFDftcsGlERU2i4
	AMhUtw+qAbiyT1/XbH+YmwWYbdSVpbCX0Rh3H+5BXaNoDdzMW11c7NnZXNmPLCiC4mWF3tIgpxM
	knPWXHRsUSoF1c+CuLGPJC/fSugva158EORFIq0lsmeBu43qm+BchavUDQPUoQhlOtgfA8bZw1F
	C25SEiBAu9jTVtqwjHsYTWn4uZgHScswkLtD8hL3V6wkiUDha/3D+msGDkg09MhY2nJbkI+ZfSq
	UmMTkXOmxy2GSeRVVB6uOBa7+ZfuOsRTtjVbLj3cScVDwKrcHTN54lGZ0BcM2Q20Gx8H9i7q//5
	qyrXAwv
X-Received: by 2002:a05:6808:1a29:b0:4c4:3997:ef2f with SMTP id 5614622812f47-4c7b3ed53b9mr1117035b6e.17.1789384836920;
        Mon, 14 Sep 2026 04:20:36 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.198.136])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c5ba4646ccsm5257533b6e.15.2026.09.14.04.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:20:36 -0700 (PDT)
Message-ID: <6aa7d884.184146ba.1b94f6.b84f@mx.google.com>
Date: Mon, 14 Sep 2026 04:20:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2707153012417388476=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, webgeek1234@gmail.com
Subject: RE: [RESEND] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
In-Reply-To: <20260914-bcm4356a3-bt-v1-1-ce44d0abb5db@gmail.com>
References: <20260914-bcm4356a3-bt-v1-1-ce44d0abb5db@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2707153012417388476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164383/

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.36 seconds
CheckAllWarning               PASS      23.67 seconds
CheckSparse                   PASS      25.89 seconds
BuildKernel32                 PASS      21.21 seconds
CheckKernelLLVM               PASS      20.08 seconds
TestRunnerSetup               PASS      485.19 seconds
IncrementalBuild              PASS      20.19 seconds



https://github.com/bluez/bluetooth-next/pull/764

---
Regards,
Linux Bluetooth


--===============2707153012417388476==--
