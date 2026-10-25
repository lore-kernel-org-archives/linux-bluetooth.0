Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792934155;
	b=xBmYDamm88lq4u6eS5iYb8UYl/Lzg0hnM049jCpb7utfO4+ebXrDNEbUJ8ie+RIoFOrZ
	 B+rp5WW2/rtjzux3tGKR13w3XsRoXYPROcnpDM+spnbKOGJAeuhl7FTbuLJGcDSulSfAZ
	 QqIEh5P+OsBaOAEuhrtE8mZmTX7HFZ91ktSMYfsi3jgcO+0YaHwmmccczQredu5WgzzYe
	 /YHvyEqrRwTCfEi1mGeawbUNfyXMysCtvByqkG/af7l/hIt94gMVZJPtRj7f07Y21zPIf
	 oCKXsgDmpwQ0oCc8i8t8F9W6qjvcpROvjhxrYOlUWO9aXXH7nUKXMynpsrYXTgyveKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792934155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=FjOh+DC/Xb/oUu45KCHWmWh/THLkvZtqTx5vo3+S7YI=;
	b=xkKXohzDtOCz2jki+pReGWVLt6j1VNZPtzJaKS7acDidsNqE2U2cU195sQX9xDOGPkRC
	 B9+hV6AOo3gqin7lk90rWt6XiwJnIFt5aRvsUF4eSTPg4TFZC9OVMXYPD5jBy6SqFYptr
	 RaOtnlqAhnnuDBQMqUq8puarGnMZvY30uMQIk14xucFNPmxrrm8frrLUrLIS8Doj4WRsW
	 tncp7CCDtyD+fMvPbBgfM+ontrmuXxHvHUbWrXf6w5JZrPS+9dkd+TtMMOC9QTeOWhHzJ
	 SU5Vcxux+OmG9nUNMMpCS+l4IVRLI2noDBwZjaH366MJqCKY1RBkYu6yTg0DkvSL18A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FRCQYpwj;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A04606A31B
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 13:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A04606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FRCQYpwj
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f269e335eso242252985a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792934154; x=1793538954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FjOh+DC/Xb/oUu45KCHWmWh/THLkvZtqTx5vo3+S7YI=;
        b=FRCQYpwjwXMCynFE7/b+NIL8u4+mQnzV8DW3H0SPXS9Wyv4++aVpJMpED9sOUK5KBq
         I9WmU/A+HzvhgRWLXGWu8BRxz5mBURZvBKlgPjkqsHYj+msttrHQQfBy+neWveN29NCo
         SuOFJA+mOU51Taz94iXO7iJrIhfaC1sqkf/7/ycgBtz3o3bgKjZFzxWeAqowTgODCRuk
         t0Xx1F1Z1bzf2asXX/hayAx1l2xHNk6DtgCz+InP+lvRWQyO3aNTckNFpxi9GObvWDw/
         EHllmR/+jLcEiRuBKU0z8zeE/CKCz3hBzABZHRDuAy7+ESKNBgwKQQX4hJUhYA7XsZQY
         ixKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792934154; x=1793538954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FjOh+DC/Xb/oUu45KCHWmWh/THLkvZtqTx5vo3+S7YI=;
        b=s0r/t6v3Isg82tx3bVEyXIDFOPKR3Xwk4ywN9J9EAxCdqf1usCaIlhX1k8EPzFobAa
         z8sPqgVLIF0nCPH0tCQz05Tp1j9wO8iIo+/eRZRPWclTxTGxV+XFWtgX/MKk/Xniaalf
         cTrHioAKYNgbdt9fxLxetV/bvWX75yNM58hzfexfqfbI3kRvFDlWf0G/EH1cX8WhwkYT
         LxUPPhawRdpD5yLgr0di8gjW69MMhTwKBbFYPg4/iUDgxU2vAeuuPzkdPkpZz4zM4hQL
         Abe/VLOibJUqrig+Nbm1hvxdGuZhB3dFUK3DfTh3oARSDorpT/2clN3zGANURYLxeAhK
         R2xg==
X-Gm-Message-State: AFq9FYKxa820VzoHrisOw+1XWKp4lkpDFUo4CKbBUZnie7Ij13h9NmSS
	1POqLxWzZ5RITJdpvTUx6y6DnWpvhaGsKyqzjV68BYZaWtSuD/aDtB+IifrgPA==
X-Gm-Gg: AYBFou3MdaL7yu88VCv1iml41ABwAH78LrGItKT1wmLhBSRirmT+4064wjMPG7Tw/bj
	KbhV0wEeBDyo3sD/rhLhVt1+p25IyNK33f+cHFcPORoiriwFH8Xs18zH2q+fqI5fhCg8fADkbEc
	SCXg+HKrRs3iHlkVmjye1h8JPB13qkPcdFnqxhUgskDz5wWrYGc3G8WGbPJQtIJr8QFuxUphxF1
	g16A79NP+tGpL2aXPi2tmD39y7tDxKNlkw7VRCaBWU9tCozFF7gfi/B3xKEHPo5RC2BPQE+VxaR
	XnCLwN64uj1SUSgh0oXvLrPwktHOmbf5JETbw990BZL6lt4J/9qVdx1FjcaKIY2onhDZzN5wiK/
	HngUqs5v/645C9Y2+WtGEYpuP+sPux6jKAWttEp9CxWqnAciHK2pGHKYxTuaH1WlpAmKawhPTl9
	YO7FxVRQYyxdv0c8PTO98qf0VeVyV1MlbwPZ5IeH8k39HnBo50brVVaCOhZOF4kW3ALkVsTWLWW
	MhD8rbQbHdclDv7cPVmXkjYDYWRCSPnJ00XPLNNJpIg0VQUMrXZueEHEMsDhnw=
X-Received: by 2002:a05:620a:4144:b0:93f:2c95:658c with SMTP id af79cd13be357-940ef8bea71mr688290085a.14.1792934153594;
        Sun, 25 Oct 2026 06:15:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.158.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0787f33sm418820885a.25.2026.10.25.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:15:53 -0700 (PDT)
Message-ID: <6ade0109.b4e4a258.350353.0a2e@mx.google.com>
Date: Sun, 25 Oct 2026 06:15:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6182057533854766113=="
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
To: linux-bluetooth@vger.kernel.org, sadiq@sadiqpk.org
Subject: RE: [BlueZ] doc: Improve obex MessageAccess Filter Types doc
In-Reply-To: <20261025071533.2567150-1-sadiq@sadiqpk.org>
References: <20261025071533.2567150-1-sadiq@sadiqpk.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6182057533854766113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192930/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      19.47 seconds
BluezMake                     PASS      295.64 seconds
MakeCheck                     PASS      14.53 seconds
MakeDistcheck                 PASS      141.29 seconds
CheckValgrind                 PASS      234.07 seconds
CheckSmatch                   PASS      296.79 seconds
bluezmakeextell               PASS      95.14 seconds
TestFunctional                PASS      1121.76 seconds
IncrementalBuild              PASS      298.20 seconds
ScanBuild                     PASS      1137.82 seconds



https://github.com/bluez/bluez/pull/2711

---
Regards,
Linux Bluetooth


--===============6182057533854766113==--
