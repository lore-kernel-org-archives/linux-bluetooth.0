Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554073;
	b=fLb1KsPbVNmibU+t6wzKwnrOxxvj2ALuHiCM8L0Djw6GM64dF8frfMgwIE8qRLT6Lq8P
	 c+KAEgLkXwZ3WHFJ6eMWq2qBZWPP5M/1VFRnM+A/PILeSwZbCljQwARpnECL9E9qMf46N
	 g9umeBo3vbyCiJxKQpaDguOQ2io8xS+jdbpjJlm8t7EzPMkAEJdCd8JrRna0uWzvn8pqq
	 Qt7tk+h48c3OF/pUUNz7Re76tnXENQLQqQPboUSCHgLvR2SYPAARlOWAR6yX0iia3H26l
	 0wDvA+dbRzXSMfFmG91MueFEZD3DJzxCekS62kg/NbnFCxfpzwXgdtXrZJZBBpImYgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7J47OQwHFIo9NR+7LfcknhgESXWg+gq3xhLJ0fUeUq0=;
	b=XIvxfQNe9eh6moOv8r99N1ThYhB/hLvnrW/LbWYAG3L3EdIhmEajH0ltn5r1qlQPTE+s
	 3+JnqB8X+l5P0qm/jIiJsNlhQnKBDVgXyh1Ywbdf01u6fmD7/j1Aqd3IdZMO6Q6SRPr/8
	 HKH387CiFWhYmPx/3zqrTLBMJZzl3BIkdWOHF9wBbEokvkMU9j3bRI0tX3qrR0GXAixo2
	 rH76Rd+haCLMYlcdqbh2VFNHFsOyb/Ng4HaXw1dndRoLzBSs3yNDzmuoPJhP4QLxT4uUA
	 gbf0Z8gWre/rG7cNlClkiNMa87MlfColwWSDYaynu8zfphdWlxtO+mX9xWtxbSdUtbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aD5f5So2;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED762606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED762606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aD5f5So2
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-71ac798b8bbso3204547eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554072; x=1796158872; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7J47OQwHFIo9NR+7LfcknhgESXWg+gq3xhLJ0fUeUq0=;
        b=aD5f5So2Pd30jEijFkkcOwYHkRFDfHq59Y9XgF6nkeUJBh1vRAHMbkfRAU3jIj5gQR
         W4oRquRcsHOFYZE22kTlpIp23Envapkj58jcrWJlBVb68w25ROj/HtGtvyD/+d2WAmSi
         BNHOyzIJ2nONUzjPg64aTglSzAwtH3XMifOjcj+mTiFfvf9UaDSf4G0NQlKYf8TG/y/o
         JhdNQoZa9umByqJdqkR+giBL2rJvgEWMCwRogppEMkpBM5X3PG/NkgdSYjv83dKiEBli
         0PEnh6Tko/8Ja1ZJicinZ0kx0gSbBSCaVl3vJZXeczgtyaPTNeKyZF1w2P1yvxCpRMFr
         zPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554072; x=1796158872;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7J47OQwHFIo9NR+7LfcknhgESXWg+gq3xhLJ0fUeUq0=;
        b=K1UDughV8RZcjNIaeJb8GyI370CJzr2RWP7MMdU8fKa4PTVHd+c6BfDOGLQrBdoY2d
         hlpowfTC5riQSVq2CBJki9CssFVttastMYvsRsedNDrlYBl+c/QChisf8Y+h343Z/rFd
         a5ZmLXzYZjjpJOwBCh7E3EQBBunezPcb+fZZV+BGUBTmWGWNokvLgVK7jGcx7uGOon8c
         rPHKnbQw3rb1DLmuKlajWDLPRLQHOpgNo1scA0NGw2zG3JABiFHCkRgyPan71pXAXMx9
         ZAncDKiuuYjYRcOayxwsN1zYfbKoYFkv16msTsX7HzhENoDytlkCVkyJWLDMwMlgzAby
         noow==
X-Gm-Message-State: APuU4Z9mmoDcZ2sxnvRMHeIINsRQwyjiyTlizlGtHTC2GwBioPD361n5
	BteMiDKVLKaBR6uqgmPgSYORJMbpCtK4jQwtoed6scIuUV4Au0QsvzrkqnxqUQ==
X-Gm-Gg: AZFdTZeFNQEj/TYTrTmsDIuddLAj++db9QvYrzD7noElZArZLHbd2mzQ5+AMTococ1F
	W1WYhACnhDQRmgSU15YrDq1G1x5rjGMD6a9XmfSuzIhCK5aRLmffwjbN0vOZC2cx9fzLUpz3JRI
	tjMnZ2C8INilC/74xjiAigOYUFGYvFQya+qMUTDHeHM16Ip6m7LZR2kOfKlYKXRNRUpsMUj/a9J
	SsWLLqODOwXQEztmg0LBNqNJPBdVr0IRbHG7HwXGPQ7OGHU5ULwQeon3LskVJndZHjoMEJUA4zD
	M1+Ti/vZFu6YSbkHUSsazikzx6Qqx8+S/pgA8alMfjkEmiV51+gsr5saNiZWdm7cq19/Yf+XXCM
	AqlkOxw0HNJm4J9mTKtJgcz61U04mqEbZSBHjFf9q58+UmioV8Vcvjpek8j3GVYJ88+q4t12VXu
	MWI0+8sg64z76QA/cFdU01kPw6kpYh89kFLhOSlCngFCG/BygIhjV8oHbQtw8FWouFnEUpL/Ie9
	7FIdmLw3HqiyyDY69r2Y8A9+iruuFArEKtVDBXbxB5n1uV5LXDTnkFVB2m4tPt4YQ==
X-Received: by 2002:a05:6820:16ac:b0:6f8:728d:cb4 with SMTP id 006d021491bc7-71b392aab12mr12115762eaf.3.1795554071735;
        Tue, 24 Nov 2026 13:01:11 -0800 (PST)
Received: from [172.17.0.2] ([172.183.183.219])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b37c52ae6sm10275784eaf.0.2026.11.24.13.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:01:11 -0800 (PST)
Message-ID: <6b05fb17.c16221f2.24d1f.a227@mx.google.com>
Date: Tue, 24 Nov 2026 13:01:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8687142051066693545=="
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
Subject: RE: [BlueZ,1/2] avrcp: Defer init until service discovery completes
In-Reply-To: <20261124133954.4009535-1-simon.mikuda@streamunlimited.com>
References: <20261124133954.4009535-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8687142051066693545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220896/

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.60 seconds
BuildEll                      PASS      20.63 seconds
BluezMake                     PASS      324.07 seconds
MakeCheck                     PASS      2.78 seconds
MakeDistcheck                 PASS      150.91 seconds
CheckValgrind                 PASS      162.94 seconds
CheckSmatch                   PASS      323.72 seconds
bluezmakeextell               PASS      101.75 seconds
TestFunctional                PASS      1244.74 seconds
IncrementalBuild              PASS      325.93 seconds
ScanBuild                     PASS      1224.80 seconds



https://github.com/bluez/bluez/pull/2904

---
Regards,
Linux Bluetooth


--===============8687142051066693545==--
