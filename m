Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920198;
	b=W6fWpjNE1zcLG7LmZ0rrh4OaVPsm7Lf9VqzMFqvPGDc1Xq+i1v9OQYedZoZ4sBYfpHoS
	 DCiMU9rUTnuxpINwuUjnMzsckY7gvBu+TZsE95DRMdBIX6VwRMSit+BRB0DCCMA9OFtQe
	 C7cFvuFvCA+IJBpeB+ygHFp8AJzIjPJs7q638V7PBfigLfLlUKGy1SkY9kty4kMsXnQkm
	 ebiHwLu+8UCx2B3+pVijAEUBZSE0dcPrDP6ALMzwzHfkCRn2H7a8IgXBTzkYyScrA5y04
	 vC2xmD5t6iMfPnrKfa5YEJPfsF2vpqIOvvVHtbkYAbRl/zsfmSyfIMuAiTP/eizfTYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=3haBfEOyKolR1Zjr8sjf9RMgoZ9DodRbmrhIp25/AzM=;
	b=e3hin/APpiO2ftHPt1f2w4kJR0IX+q3x8/wLdAlUMv3rpOBOhlgL65YrB1/LWw2zLKE3
	 DITmDmCu/vsMUaxmIrc0hpXVsavqMD8xTgznlucBgiZ9ALp8LfWLapU7oEy7sCRv9mqpQ
	 d+ACME4AF8vl8sfutxi3Hb15jdUbgB6JFmHIv1+KBjuE+d9YIkUaND1npM+RkAgMIfkb8
	 XKGsvKWFH4IEqjkTeu4c8aXaNJSa7iGgOl7PSFIi0Ap19UA0/XgtxKhShjX4GEFYaHPxq
	 fXZuMe6wCAw6jl9eumHuAjkLwxU7R2ywUVuil33TSBiCEOKZgzUeVU35n2qS2XePlAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTQ2bUUF;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C126606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C126606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTQ2bUUF
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso2604246a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 04:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794920197; x=1795524997; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3haBfEOyKolR1Zjr8sjf9RMgoZ9DodRbmrhIp25/AzM=;
        b=XTQ2bUUFh89N2pmkCW8jhLgjaLz8B54Qpk8hCZVwpTsVirCYjSx6shVJTw+k1bgRpW
         ySgM9FT1h+K5o4a544dPN1rDKsWSEenpByOCtTFx0swQeR+lNv0lvKQBbZ/rCoYtxhMv
         gZketsRh522i73TElZHasFUitRJmuWIxdEmKcvZaXj14+R0/Sip3hoOTVgPdSjjFUutQ
         +1KUPKwO4IeSV+4AHvur6kQKj7RoI6tW+tPE918QLHQ/n1me1XykeuwlkLoT+HAiwv1Z
         173DoehYCU4YH9qBxAwMDlgdiL1rjnpfuiTgAgIvuLSnCAmzi/SEIdYXP0bnzAVwtQjG
         uCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920197; x=1795524997;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3haBfEOyKolR1Zjr8sjf9RMgoZ9DodRbmrhIp25/AzM=;
        b=Bk86jz0b2+z1T7kBw/WPGBE0gRWeo/QfduLDBgfehWrxM/Iaaw4op0pqI9+Ulu6fdj
         0x0GQzo8xAmZsrSjye18qp5PMWkq8olhMidqMM1qsC4y74mDNaDcEBC+oXYIlv4UBivD
         hdOdFhM4tvm8bTjOjtLcxymX0NPBz0MU8IYCgsPF9o7GltS0hM8r/CsaA4jw6UhQWNDk
         c9s0/2+K9iYCQmTbiPyaIqtdcLmFLLp3DMXE3j7UcWK4XE+7iLw0axcALCLil33+RU/N
         6r60MoUrA9UzFYW8lMwnWVadswtvsriAryLNzYboXbfNqQBP+iB57HEKsmPydpiPlkT7
         d9Cw==
X-Gm-Message-State: APuU4Z9Lbo0LQpyl2eE19ebRYOu+fiFIEokPZubhYzPaeqMtfzucXa8h
	AJjEywhKoIWSzzN+XaSuQto9dAU1fZdGK1iHO//oC7fVOgug5TpQdooYMLZGkg==
X-Gm-Gg: AZFdTZfyP9rdWjY5xOgJx7NmdA+Q8aHagkdxSeURRd3xCtdVbPwhDJQFqr4EU1c0YDi
	keFIjQUVP4ik8Krr/dSIVKkdtauPAk5L6P5bDCADvVIQNQ9a28hAXQYdYO0ObvvJK1kYFFYk05F
	c4OTES/aTFGv9nf7TfZJCrIN9ceJhzLPwz6tGC4b1AWOi4tZvI7/xeE4JT6w6YMvJvzr5RXybvb
	c/ECoRvTy8FJO9fAr0Fnbcdsn7/ZOfU/Njfybuiwrx1QsNGCTOSq29Gjz7BsyTIZFTdMF5HdqyP
	opV5fMUvTWEtkbOmooWPnqdu+G8zoqGIhWDigYhhQ7D4A9DhqBMamxT9MtKvMHgFeildJCx/Wnf
	yIxRziHmF3gyKmrxwQllmfGJMiHEQy+GHQcjyUaV/J3bXbW04SLauSA5j2yOy8uc2Tx53PYQ0w3
	c2AJOGrJq0XlNtyaOUOoUtlrDoh+aTUDvHQDbvtkt1Wm89k6KRfxXfPJ0KEPx0Hv23BrsA82Ijl
	QOoJ5Lj58yb+lopTH/FgisZ0P/yNs5HCnGRm94pcouXt8Hil7S3hCwhxh2qtOPKnuYaGIo7h11o
	IRdagD7ttRAu1MRdFcBgxgDpxefwB4eMGsibaw==
X-Received: by 2002:a17:90b:1dc4:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3b1b0b5e500mr13605869a91.60.1794920197366;
        Tue, 17 Nov 2026 04:56:37 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-54.us-west-2.compute.amazonaws.com. [3.42.157.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3eaf732sm10770827a91.3.2026.11.17.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:56:36 -0800 (PST)
Message-ID: <6afc4f04.c1f6a46c.1fcd25.2496@mx.google.com>
Date: Tue, 17 Nov 2026 04:56:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5686755779968549919=="
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
To: linux-bluetooth@vger.kernel.org, MAJO@bang-olufsen.dk
Subject: RE: [BlueZ,RESEND] adapter: Set Audio service class bit for A2DP sink
In-Reply-To: <7d8bc3183903a1016c6b69bc64dfd4f275891ada.camel@bang-olufsen.dk>
References: <7d8bc3183903a1016c6b69bc64dfd4f275891ada.camel@bang-olufsen.dk>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5686755779968549919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1213596/

---Test result---

Test Summary:
CheckPatch                    PASS      0.22 seconds
GitLint                       PASS      0.16 seconds
BuildEll                      PASS      13.37 seconds
BluezMake                     PASS      203.24 seconds
CheckSmatch                   PASS      180.03 seconds
bluezmakeextell               PASS      63.95 seconds
TestFunctional                FAIL      938.67 seconds
IncrementalBuild              PASS      204.16 seconds
ScanBuild                     PASS      690.42 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2839

---
Regards,
Linux Bluetooth


--===============5686755779968549919==--
