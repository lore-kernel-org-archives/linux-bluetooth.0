Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552983;
	b=WD0Q9cIPZdR7aU8UW9iaEkRtl49HkdToBZQ/j5wIeky4DEcJZu5FRUhoeYRzfchcCZ69
	 ljd1SvOmE62/Uy8PScBEZlAfkwZgR71Xa5XM1q3ApDVrbU9811d6nckm3tFYSzVCRZxUT
	 vNtL6sHDevNvKI9DPjLysrdm4zrGElxoJGLAfCTotzHVW+r7ak1+p/kE21B9ubZ8WVxXH
	 qp5F2IHyjsPphMn8v6/hu42K3HZZ24t9OZBERhkR9oz8PEvmurOOqKztEW8KTT3QNnJLP
	 7VQJ9Sa8+fAoghBrAry+ZcQgzShgnSWUeRRSSdJSWw6jvViPKaJfY+9QwtwHM6LqjFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=E2TJ9hBDeH0+JtWhuLmIVTn7UCgMhN0nsXW18Sfm7mg=;
	b=xYe7hW8Jm5R37MtYJXud9/vlGzkN1ipNoq4DI4X9h4vKZdr+S8LB4b5UySlwVah0pdV8
	 jWkmIFWUG8vBrq/mkGBwQAU06edikV7YyCd+FT104Tu0iHgXMEb0eW9lxxiLtbgqRTzAU
	 rCZ7D/ksLlCUEeCMt1gxCvx7lRfAPsAYbfnMlHlfh72hKC3S8GSxnUIdRvDhlQ/qw/7JI
	 wCajzyEoA5kbpNqcaankkEsfz5+4lpKmrB4LNUNsBIr56PSi6kiTGl+buWqbUbegdg352
	 gEOlsVQG5NzlxRhzDEMRlDeGB4/YEvJrWZCN0ygy4QZyuhizrJAD3eer8YRyYIl5f5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0kECyg4;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9C606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC9C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0kECyg4
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-572a102ae27so1427319b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552982; x=1796157782; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E2TJ9hBDeH0+JtWhuLmIVTn7UCgMhN0nsXW18Sfm7mg=;
        b=A0kECyg4XTDJGU5IsemDDdiLy8DN6ALC2qnqt7rl1WlE83QVbel5u810XQzH3pUEbV
         aPPSEd0QoEZqWQaW/8h+qvyFBfCA8oAPbAdgz29y81+mx56lPxClJ+HGKnsCXw7W0Urm
         yT1ZHMWkmrSlPAo31PURx0BVONmyVm1D0dn5XjO1qisjeZyJwvBC0nct/9yzihVRNz7Y
         1uhTlA/CKm36xHmTSJwZ69RvhxquszIe7XQF9M/6wE2i+UhFvbJi7qyx6GG2r/tjSSoA
         rMDiDVLgruvGUBj0FzOQs/s/iz35y0v3X61ALyiccmrWxCfC3/jm2NZTqSQilpvqxYpD
         w4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552982; x=1796157782;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E2TJ9hBDeH0+JtWhuLmIVTn7UCgMhN0nsXW18Sfm7mg=;
        b=2GHCRiCDUTE/U8k2idHV6Pww2KmfQyOX5in9cK4LqNjT11JR2ryY1evWyBoRH4CloQ
         dbPtnWqGKJJIejFcOiLUdD4etYMtwzsKN/PU+Gi2BfGQ2FDiDs0I0JUp+l+waJF7M3Y6
         f9MAVDksSLCvJ6iCr03apYBp/ULdyIfoT684oQEdkVPNMvQibPMSv/BfB3nTFutoGFcT
         zgW/FoY71sKuMkgT9zg3K7QQiNyxJs8Z9Dt47MNkbkFOxAQluBXUqvGBhD2/sGK+fPbo
         nSfzv8xrDgiwQV4CK9P9v9GsusPR91wCK2kbKWtz6ox3xyd8xNxDz0ykjBKX4LnIo5u0
         2KVA==
X-Gm-Message-State: APuU4Z82dpTURVCfhtmXYKvo+NeV3o7BPJwFIHJcR6GCYlzlXvUyYfSZ
	vIIOn8cMe+UgpyM2hHIrAUmuNLPJTCe0TOGjlYTVU7r+7DmqJAsrT6vrikz5hQ==
X-Gm-Gg: AZFdTZfxvqqcqDywuuP1EsgZxp1Ofa/iCCPClgq7ZlwEFHw2xklIhLQJZrEYBFuVKzQ
	zQz1nNjZTJkpKPvKt0viYenlMgAXw4+0FzeV26NXanCC8rU64bmu23k3lHbWkOShrWBHd9PZRLR
	mFJwU4x/rbGyQ8Y4gqOjOWrX6w+7BL7+/X75EV29Ax1ES2j65TM+tnQgxMNWcvcE2z1pGqngxtf
	oMhcLh68NDPtinAPsePqveztiyeSJLHHE+OUbna+nDiOrh+UTQiluuq4y7jYA7xAdpx40ilC4Wh
	njZVAOHHui/QR3y5KCGQciLHCbTClLz3O82fMYRgDQcnYCgeZNqaybHOnX+KjCuYggR1fHKyt0+
	mfsGfjG/kT4HPoiiWG1GHR99/qFpkJGlsI2UPQOnY9vT2AqhSFmfvNKpfCJrH+YqiUKJmiwnAkh
	1DBJMR3AayYGhucrCOlC88e72HAHMZQaoGhCEwZAQp8KT7p9XUj+aahBmRMOINu072dJ5Q08OPQ
	9z1D3ob9B/W/gOql/Dusjln4pEXqzCzqpLowApuWucFXAhqfRy8wfkE+4PG47PaBvcg9ZfN/LKf
	XEg5v38p+wg=
X-Received: by 2002:a05:6808:1814:b0:54c:7ce7:33ba with SMTP id 5614622812f47-57a0a922959mr16715117b6e.28.1795552982230;
        Tue, 24 Nov 2026 12:43:02 -0800 (PST)
Received: from [172.17.0.2] ([135.119.109.161])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d57csm14347313fac.1.2026.11.24.12.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:43:01 -0800 (PST)
Message-ID: <6b05f6d5.a8122b97.144f8e.a170@mx.google.com>
Date: Tue, 24 Nov 2026 12:43:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6563612336569710370=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,1/3] shared/vcp: Notify Volume State on Mute
In-Reply-To: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
References: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6563612336569710370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220967/

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.77 seconds
BuildEll                      PASS      14.67 seconds
BluezMake                     PASS      190.23 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      107.64 seconds
CheckValgrind                 PASS      255.87 seconds
CheckSmatch                   PASS      199.57 seconds
bluezmakeextell               PASS      64.45 seconds
TestFunctional                PASS      906.35 seconds
IncrementalBuild              PASS      208.24 seconds
ScanBuild                     PASS      647.44 seconds



https://github.com/bluez/bluez/pull/2906

---
Regards,
Linux Bluetooth


--===============6563612336569710370==--
