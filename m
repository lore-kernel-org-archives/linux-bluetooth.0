Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203378;
	b=j+/pwiKL3gyNhFeLPKVKgHaklD2enknGk9MmvtoeerXoWC2JP/ur5lhX9bXwGvCZsJcd
	 hyQ1xbeL8VbG1u3AEC5T/aIyHPy1ee6CegtxplVSfbS0FE51iADGEhCSlMRE7MmkjyueX
	 zv97WX8S+t5/lBaO2eLT76QkKPQrtN2K9beTvsXxe7Q4unh8iWn0uEDre2gXj3E+lL/Oo
	 u4yYvxCdbBwN9dAopz6IYUIpE4Ver9kP49JLMCVyhR6PmUPGwrqnh+zBGXWYmWs4AdZT0
	 ve9lm3H8Qy9J2lco+BoE/mpshwMrrDYWo1s202J+oNNBJGn+N4x3EvmYmPA2HVahTuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=sS5Hl98eK4T5sMYbhE7ldn8KyBLv8JwPN1d8OfdibOw=;
	b=FRMFj/F6LEc+JFGaiz7qsEqfvigtL4+R7G1SAQxRtItGinuO1b6Y/yjCvtgCLUBljd9q
	 MCVDq9B8Hg6O/lJ0GnvNNRJhuM9BxKvnLPcL3KDcbW5Yba7HIYvCIhuupxkb90c5NnPpA
	 DF8+sfG46wuhDUj5FRGGeFdTvlVGAoa/TVHsODx0fMdcqr8q9pGbZBldtmZFPTCEerpap
	 ZEEuBatXXkubc9bVhF6Rwa2N2jU4Ww9WGoe2LMOesDzEoChiXh+HW7zF1rOdcryTKBYHY
	 w7T12wFKBL6+etoFv9EBmYNwfTK1FLWtnbjDyzd+V5V/TeFWzyf/Ah06FHSS6BRr+LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9cR9YId;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A358606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 16:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A358606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9cR9YId
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b1afdf5196so478500eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793203377; x=1793808177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sS5Hl98eK4T5sMYbhE7ldn8KyBLv8JwPN1d8OfdibOw=;
        b=r9cR9YIdXKEJ18lbCVRzqV8SgY3AfusFsl0dn3PAVQbXFw4csZCvfUDNHyCMf65Kaq
         uHBsaslUCUwyZgMOFN8zcSRpEjuK5QFAgB8j0XYyxVi4MgModMDQ60kwLUOPV8zA0tq4
         HUrNyxFhwh8xIo7ZOWTLJXcbMAtjpyGQ0dqIgeqlWjyO+gwRR0kd8jUq8XoNPswiPl0p
         NqT8CJ2PgYkxtG2qAuY03Plenk6ZP+eILsY7oWod6TfsBWKepND0Gk2OLW6FkGOo5ThY
         qrIEsiRoVKg7rHPyzy+b8BYS+XJTywkrKU47e4RRpbIY09VfwStfWXJwjjty3VVF7lVa
         7/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203377; x=1793808177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sS5Hl98eK4T5sMYbhE7ldn8KyBLv8JwPN1d8OfdibOw=;
        b=ElJtFo+20TQa+o6LDQaROguQ9C0kOFwZA78nLE4qedMgaW/JpxHPxw8enS5CriROgc
         94JhjWpfsEin1Mt9/mXzZcEjITeMhmiDXvQe90Fxwd5M2xffiHlwDOd/oA7Y80WI5nhz
         pMAporQZwlD8CW187gHMpe8e1ZW7RyvfU+6U6gx82Hz3+2OITCO3XWlHmhNmHEMJRhSu
         0f3Gnv26ZljxJsUyNMkJQRKqhDDAnGqQ8JpvGudssjqjhX/5WSF3B9wJ8Z5w35haz8MQ
         KTekq377de4sUFRAY+rGy/CCV4gUnLk7mkHf9wNLRvuqf2WWt8ZjdEOiTUf4GG9TDmqP
         /npg==
X-Gm-Message-State: AFq9FYJg3arQyKDCDpiuBD8pJinCj3yy+C5peH3Sf1mW0JKc9/KsOMBA
	83H3G+Cywm43C0iQE7aHBxoada4Xr+CFbSvQthGN4afsQ2t9IDH3YC5ioDLYzA==
X-Gm-Gg: AYBFou0345fvXoMSce06xkCvtl+4xgmTJrUFhpd1ZgCf7gwa759wzlg26hKs97M/qs+
	SMdgAaZjCJLZgQuFTOKzsjzykasK2B+CgjmAetUEnyQuecvCDznJAZt2HusZdgbURpsC5CjBw2j
	RqOmKLAmC00rOnfV93q28Rz0ZB9OoQATiZ1AkaRe3KxtVkF0pLNz2ZoKhedVRyzHOm/mNd4oL4H
	M2j/8H+HVF5cv+JrCKFhekmQyjO9S3G6tCjb07KRN9zvUjxihM3nMRbNLGEKRDifUbDrBG93Y7Q
	InRW1mruQoNCtjGf2bEU/9J9z6sa74pdRAHKk5fNp6ps3Ea+b90j8JPuA6NE1GHPZ4At5a6D9cd
	iA/QhlBVARJAz5qaBTrVXlPzXWgiwqHf5kgontrnl7aeThcpUWajW6tBHfNTeqb9lOoP3XL7m8B
	amZUS1UzEzKIWk9r+Et4ezjwVkCumhTyIkXyp75vg6OBGU6P+FjjUn5N8fLR0B8epIFnF42eFcU
	xgUF28qsgPieCzT4YwVxZbBwharyuKqZzuMkjintRDuarlCbKknHR0xalAc
X-Received: by 2002:a05:6820:c3d6:b0:6b7:46e9:96fa with SMTP id 006d021491bc7-713ef0467b8mr836572eaf.42.1793203377389;
        Wed, 28 Oct 2026 09:02:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.64.58.73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b7830d1bsm2843206fac.7.2026.10.28.09.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:02:57 -0700 (PDT)
Message-ID: <6ae21cb1.f81d2e1b.69ccd.f768@mx.google.com>
Date: Wed, 28 Oct 2026 09:02:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8460053858028620320=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RESEND] shared/asha: send STOP without waiting for a response
In-Reply-To: <20261028133034.261833-1-cochcoder@proton.me>
References: <20261028133034.261833-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8460053858028620320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195450/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      13.56 seconds
BluezMake                     PASS      187.44 seconds
MakeCheck                     PASS      13.32 seconds
MakeDistcheck                 PASS      106.43 seconds
CheckValgrind                 PASS      170.71 seconds
CheckSmatch                   PASS      187.28 seconds
bluezmakeextell               PASS      68.42 seconds
TestFunctional                PASS      862.10 seconds
IncrementalBuild              PASS      184.77 seconds
ScanBuild                     PASS      639.15 seconds



https://github.com/bluez/bluez/pull/2727

---
Regards,
Linux Bluetooth


--===============8460053858028620320==--
