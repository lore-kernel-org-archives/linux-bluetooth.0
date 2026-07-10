Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E33DCD8F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675412; cv=none; b=lB24CRcnMKgufBx3vAISF30LwgGAZiAews/+4aaEMNPIznp5MaNFrNmOOi8aa4fZUpXrCHLIUlv+LqHqyRwh0meHcwe/tgqr+e/w6SVdwPN/hvDNDfBpzNfg/nUYX4/aPIdRaY6X8Q4YdeGM8dIbAPZks+0XOJkTdk0RECPmaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675412; c=relaxed/simple;
	bh=jyx2d7GB0DBNeKnLr89Rz+5dNDjAa3qKIN0aoomHr5Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OIYM36I82MDVi1U4EL0H12KLVzreQqsqFzFR86fyCHvDuIPmPmE3FpLMEc8Qtg08JDryOqL6cTjbHy1ARFeF3EDc1CvurIMUu0YVo03C13W54M3n2J77XK+l0iWuh+Q+wmwjguGNUxTNZRkWskk7aEOv/YIiUHxq+YncyAKoUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8eqVJov; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8eqVJov"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so533160a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783675411; x=1784280211; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8tDYaU2+d+4zXbiNVAFrLNoaUWA2hFjD7R/seHY0WHU=;
        b=O8eqVJoviT4u7P7lmvltU58oxlsG8Gn0d1dwjqw3MZPY3qexWWSue+DJUwEwtG4WsF
         uQEKGTI6zOdmlD0gATmZqfh9G9SPHTpRaOw5FgB6SPi2gQlXjHJsKv64L+x440jDIbPh
         psVtMFaPumQH8Ofz9Dfd09uRM9VHU6JjvBZH00dsPZG8TbZKsYiCWWX3eZvMchuECz+g
         DXyZWTL1Mfejs0fwpurljz4Rt5v6eB8GcWmR0TnwrcQ5JN+R/kFFYEQbuzHWor0jnYF6
         gOtPM0G8pu0h2S+PMvHWWpobGuNGe5vJvw0Eb4u8gyeT9IPfEGuN6oLkg5E2MJCLMOqB
         SB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675411; x=1784280211;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8tDYaU2+d+4zXbiNVAFrLNoaUWA2hFjD7R/seHY0WHU=;
        b=kZU7fDJZ0eS+6yINKUAzYGCAgwCMtU1mlY3ZupZ2a5TiLSZMtw6LM+RcJIw+mSudSl
         HIWaVLbBGGEeojEeKPJNk0k8p8HFTl6qGHqRoHzYZydKJFYzhhBqNTsPGqcxPmmo6qay
         Of4DWiQ7CyOQ64KIK9KIg1Xc+VrGzs/YtDX2jJJHwffegA/Rn8i/3YxFpRuSjsIj7YXw
         7qVP2gzfL0g6Yw51mSQG0iq/f0Rl/AxH3zGQ3pFOCqpzhjYbNqax0Rh6hLJTVAPqWKC4
         Utf/GTwa93dFTXksoouBQu3/vjhoSehl2H78860XuSAs87mzsreghGMmA348ZV7ktpT8
         iY/Q==
X-Gm-Message-State: AOJu0YwMabUUgHs2QOxp2+2HdbMvugolwJJWsyzLOrp5H8cJ1zG7prGT
	fQsqwpU3pvanNWOzrGeBlzblwFZhMYEbVhSfIZJ7gSRW0tlJve8RYsbby7yTew==
X-Gm-Gg: AfdE7cnLoix38CcKFBsYBFLdnnfFdyonvGMPwozplHpppiivQxDF40gYfJVipyyCdTi
	JEGCiZafNaoFKSZBPbLdmBNFLaGvOxgtAJ6R0uzWtdxQXeyywsNGMQTUy32eKJo7+Bo23gKA9Em
	Mo8GSiljXCoWkis4CM9/DU+E3R9tHQCyoTzJq7tIDIB/uPWlp0jAaNDsUa6eyZHvvX7BAbS3wRJ
	tdbWibjW9xhS6D/wvgGkVhY/QyIqRFbZcyLMHWPP8AEtWzA1sImVdsxdkoaPat3j/ButkQz94u2
	Ey8dCK0J5UvCt0FOIfQuUR3KstbPvIBfpS2wORX0db7hEvZX4r5XD4AwDZLpnn2pDbwzYAPgOR1
	F3lzXdKim3tnDsxtviVhWNKiJOBPhd4+HPR6mp+EMSvU9p6/ERzWJoFm4+27pYtSIANtpH+2XNP
	BLgcVE2+eZyBqHd8ucpvmyjGIu6jad1dp6
X-Received: by 2002:a05:6a20:158e:b0:3bf:ee42:195 with SMTP id adf61e73a8af0-3c0bc90146amr12889433637.11.1783675411040;
        Fri, 10 Jul 2026 02:23:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.217.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f7293sm37855822eec.3.2026.07.10.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:23:30 -0700 (PDT)
Message-ID: <6a50ba12.4a342cbc.ca844.e948@mx.google.com>
Date: Fri, 10 Jul 2026 02:23:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8992696192221070037=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: doc: Add Channel Sounding API and bluetoothctl documentation
In-Reply-To: <20260710055910.3691701-2-naga.akella@oss.qualcomm.com>
References: <20260710055910.3691701-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8992696192221070037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125144

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       PASS      0.72 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      606.38 seconds
MakeCheck                     PASS      18.06 seconds
MakeDistcheck                 PASS      142.12 seconds
CheckValgrind                 PASS      209.13 seconds
CheckSmatch                   PASS      246.97 seconds
bluezmakeextell               PASS      89.02 seconds
IncrementalBuild              PASS      671.59 seconds
ScanBuild                     PASS      783.15 seconds



https://github.com/bluez/bluez/pull/2288

---
Regards,
Linux Bluetooth


--===============8992696192221070037==--
