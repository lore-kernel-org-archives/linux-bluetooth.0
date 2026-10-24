Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804451;
	b=cXqQUg2jzeVRdfIFyILAvbzyfdWj9IU51Egb5kqyvhdmtk7VrNVhnWFiQmEvhfk9sXPk
	 vFh/kt2tM0l6PW8lrqF7ziOdDPyHdu1Lli1OAuwnxbdbzQUkv15EMmjoTU3UPvFl9UtFr
	 x8isohTg199TWzBgd/QI95+2PYifzUPwK6MUVTjz0j/Peo8JI5rS5s0MNsHuJQLcq5pEr
	 pDvRKamdVMZtEmguPL+CzLNiRBfOZiaDsSFV/1hq5Zf3Ks1fZxvQSFhoNHSIzfH4m1RLs
	 pjkHKHgzmZSoNlqU6wtg0bp8A8rIoyeOc2KitQQupbxI8rgTfVHxsFXqMS0TGNxxoAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=kEzMMYCkEr8OUG4tefUrwI3kr0kThXRqIihvA3yi/ko=;
	b=o64IYseIuF91qskQ1pgf2g4NrPQdZYG5nfvnKGve4CX5jZPP8kIhcyHLWC9cxEgNFYJ4
	 Z57CrIyjyQkJBeVxZWLK6GYwN6/19RUsqnmUSEWapGmloo4o5OlX0YaaDpvXfjT79QhLk
	 B1y3lPRjWMCGFHheVm5SRmhZH4IXFj43hYwnzyox/FkRdd9Ob/nVW7tSLO2ikQcSzUpKS
	 U83DlZWFojnvIGIGTXh0x00764MFh7DiDDxJTV0EQ8tvE5Kibk65VPPdUtqIITX8CG7QG
	 lxVbUp+YUSyWnDAQo6yITjDL3oMr6ZTqWrsOZnEbifwePHoJnPyGLGznM4QdcH+wVYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJ8LfE5p;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DCC606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 01:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6DCC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJ8LfE5p
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-53656465d1dso781253b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 18:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792804449; x=1793409249; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kEzMMYCkEr8OUG4tefUrwI3kr0kThXRqIihvA3yi/ko=;
        b=JJ8LfE5pv+RlcAvXq2nfBemURUDr8YQbOVX01WTveZ+PamcNotlhfQDtn6YJ0MGlfY
         f8T1+MgQvVRunbUya7HBDW6LlvAD/KsCI4LjxJjfPC072RwVr9RCMrDIchyuy32kM7uQ
         sXir7SM6hSA20xWv2UFEMNhdBYLH/C+QSQrjDnLCSz9Zjie9rzwDdfWlk3DRVR12Lsb4
         LPkoDRhYUdgz8fBdIbDRZzHdSjjv6R/uEEyXsgyn7B+c8DUFGxZqivhw0YRHHOI7dnbg
         hUAvByrsM7K/S3VI/zPaqQxQCFEB9mUHx+BFlrLYj5SwXdDUT1voFl95GautGBdP3lCR
         M3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792804449; x=1793409249;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kEzMMYCkEr8OUG4tefUrwI3kr0kThXRqIihvA3yi/ko=;
        b=ETIDQnRHATHJ3ZxVVlnCN89lThxwWsyYhWfmt7KpTyqoev2Ke18vaS7dIOOBvtA3cy
         ZaqsuSqCH9odCIvdZvItVsTWx7fQpr5E65+p+iD1MOAXvI8mmLamY/Mv+IZWiSCfKQDJ
         AxekPmY+vqwp/ck9O0hG2NrSaAn677kFoJk4i+ZpFuPX7XGVF9HIeWcUJwZ4M+zTXSbb
         SozYcJf4GuLlO7WyclEQ4VMHfbO6qLj3LQKqCjNs6dqAE9tVM+rMe0fI7W018iDup2XE
         XIpijVKaLsvCXpENSFWNtPSTrJMoQLlWUlhdWZHjBNvMn/lpqF5Gw3CCjgIa4KtXhxFK
         55TQ==
X-Gm-Message-State: AFq9FYJxfUHhRoSPY+u9N9sQn6G2EksXHFG+sLfGW55kZUgM0ONMbzHH
	bkWGZyzOQqrYBaqJS5ryLlPWDYM9tY7/6HO3vRM2HKs+i2kVYCO1nKTtaQrk4A==
X-Gm-Gg: AYBFou1HqGkQI8974TXsxEd5e4T5Ej/iFvkis4Asb1h6JV+yONCcuSHVD9KDS6X7OFI
	ujyvRH3RMQQ8HhwPxI6J9gkvjxO+Ll3N3DaSBH/hklL+I89CaFtNpNR8M9XPWXVZbg1dSDMufpZ
	B5GHCJA7UsZrm8vis042jEwcVDhncw3tTWNEepjYRIIK50L5j8ZvFBCyHQuwIWkVHsoeaJjpZ2s
	J6/DyoksRVCxuKolZzhzGoQyA9WIIDbgARwcWAHbJBwvlkUXFi1V9IuTtQCWS2sLcaNbKvGE4K1
	6hqmxvJdlXWYPDkaFQVBNi+wYa43olT7Hf0hd28emuGPINYbEcX2XHYt8ZLQR2dXqcRB2xfY/sT
	U/mCgddK9kAaYMH5gEbwQmdMoY5gXEkjFrseDDaUScA8c8TorOcFE8xlgJwALSDceRGRvLt8RdL
	C711Xv++5NWrsLrwqlM7/esKi/NcV48RwLm+FLkVJlvaE5LwQ5LzfQczvcyblXZE+WI2RMCn0at
	7DFiwCeOGSmGfTVawQzk8P3Zxttj8ag1x7LgRUfOzUjwB/RwYFpH5PO5yPeq8ShrQ==
X-Received: by 2002:a05:6808:30a1:b0:4b9:a8ac:47c with SMTP id 5614622812f47-55c002cb9dbmr772739b6e.26.1792804449490;
        Fri, 23 Oct 2026 18:14:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.169.255.67])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c043190b9sm382430b6e.17.2026.10.23.18.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:14:08 -0700 (PDT)
Message-ID: <6adc0660.7e650fc9.275b8.6cd9@mx.google.com>
Date: Fri, 23 Oct 2026 18:14:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5723677897329048441=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Promote the bearer interfaces to stable
In-Reply-To: <20261023223708.76232-2-kevin@simpleble.org>
References: <20261023223708.76232-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5723677897329048441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192442/

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.76 seconds
BuildEll                      PASS      13.04 seconds
BluezMake                     PASS      170.01 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      95.71 seconds
CheckValgrind                 PASS      146.98 seconds
CheckSmatch                   PASS      169.11 seconds
bluezmakeextell               PASS      58.94 seconds
TestFunctional                PASS      799.13 seconds
IncrementalBuild              PASS      186.00 seconds
ScanBuild                     PASS      581.08 seconds



https://github.com/bluez/bluez/pull/2705

---
Regards,
Linux Bluetooth


--===============5723677897329048441==--
