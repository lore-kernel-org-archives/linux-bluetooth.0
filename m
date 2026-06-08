Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D0285CAD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933789; cv=none; b=E/39GvhEd9YyoA2phsXCIRMeYq8terE362z2/OrHr5QglQQJqmzSsbtHxfMpcNDs2ssV1es77eTDIaOTVhrLsGuSSdVRDLaX7NwUDn+r2QIVoQ1gjybiQPTv/9faJfo3KYqj7JN7mI4Zn4I9kvJ+ySJZiv7DecnGc7DhVliD27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933789; c=relaxed/simple;
	bh=htbR35gPnAtstKJUnOeCOWgHDKDwncLM6Lr+jgGfa78=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W6xv/ByGdmFab6m7fth9IkmqPQjPMKFhHf7NCR/XhzYfFori3E2fcEMvSHPGYecIo+er5NPY/pITdy8zTKgvizk8fV389tDXY2vWw0QR4JcWJ5oTsBSj8Qwun6S8hYh4LmKvTbB0ToENkGCB228a3zShO9k9/hPrgO/3uUHjJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYPJQ0bO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYPJQ0bO"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9156b74006aso322429285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933788; x=1781538588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ql8VnzR3E2zTDwT6kV9OQ7v5LbvoZ3nWE48b+AV+gVI=;
        b=jYPJQ0bO/I5Jl+25EQeg6806dj747xpgjfQ3Il55oUQu2TBY+PgwkX+Z6Zs/ec5MIK
         HjQTGzHnWD2AOo/RO5LtQL6CtQVfXl9TLam5KwibVh8lFyg7MJgX2wMrlg04dZnS1GUw
         n5fkaDgP5ReyjwhpgQIWlCah4hilFg1PGWIjnA2Ks8+EcIALVCiqlFifpqj2lG9Mo3yu
         /bi7+SHTI9zzWp4aTlSs1AWuMllkK0BlESNhcyqdm9j/XTmyMEaz9SeMq2T/410tTwCh
         H7iF5FsQFRl47rVVlTeYc4tZP/dZQzlJgZfTaAwtH5YH49wKx0tYkO4CQWt8PoNoPX1h
         +C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933788; x=1781538588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql8VnzR3E2zTDwT6kV9OQ7v5LbvoZ3nWE48b+AV+gVI=;
        b=gyHNm5nTYG7Y0ANSC8UZu93df5Bdpw12YDqZs/EC5gtzYR+7xIbfi51oyiCpNG9R4t
         vCjGLuiXeYIOrjxYDh88h6QgqPS54c5Zsv6jx871+ntqlr7xann2kuSKWgJq+vKDw9Rb
         8TyR7THIPyb6B2lnE77Fbu6C0EICSwmrkgChT7QOlQYlNscs5PVzxRYqW0+sbVeiW498
         a9ZpraxCv1AoCDtTqQT6cZOU7WFjXt03a3E4p+utVdkvgtRkU9ObyTN/YLLZcK4s0GbZ
         PSNFclswyrySGHJBx49yVkGjXNrU945BTNk6zLLBixPKq7jY3j1DL23ACiJXjYHG+Byu
         HKEg==
X-Gm-Message-State: AOJu0YzPhgPru4T7mnh6I5GfsCBxeodbw29nXan2sMFKtoUdvN9/UbmF
	xLuIzcxXPylGtcj5ERrE8oJJNTmT1jY54NQ/P5Ikvl5xHxt0/kHdonf+D+C2sw==
X-Gm-Gg: Acq92OE/BNA9CkWSZZIKg8k391TXzC3nHALI34U8e4a7rPKzD1tkqRPAsASue/axVzc
	5A0R01tZd5FY7GkJpFxjekI6O4uLej7fpMypvZCKhQFC6aHEHUVnRKwkrYWaz7wvB8/tK2dxX5i
	qPjy9kyjA1bPiSf5BX4dZU9vm/9mPk2XCpwgUbc8C8Kw6pZRWkWpC8fOubczx3jXBAwG1+3E+Fo
	9ESJzd/pkD8/4qSZWuojniJAAFb0DaKIc57gbUrl8YByBf5ulLjS2RWociH/i5471QQH7T2u30f
	qYaftmu0swcumaAmBQFzvW23v7R9q7MVERk5mq/xsmGuSA2QXIbHdNY/dKjoGtJtf1aj78zZPTO
	4TAvFP2shlJoMISsYNGGBxdcHrJ53+zoVv5QyASZdQDU9BXq5k4R4Od7xPMahyjVmzSMBBXyFnM
	gclww1UiwYvyHqvhpVAAss34ZUxuByLloQQwU0SV5IS4Q=
X-Received: by 2002:a05:620a:2993:b0:8f1:5e8f:fff3 with SMTP id af79cd13be357-915a9cc266bmr2568040085a.26.1780933787746;
        Mon, 08 Jun 2026 08:49:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.118.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a411333sm1869788485a.46.2026.06.08.08.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:49:47 -0700 (PDT)
Message-ID: <6a26e49b.6f516b66.1f5c45.a4da@mx.google.com>
Date: Mon, 08 Jun 2026 08:49:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0128928674280825638=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] gatt-client: Add PreferredNotifyType property
In-Reply-To: <20260608142050.3742000-1-simon.mikuda@streamunlimited.com>
References: <20260608142050.3742000-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0128928674280825638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107894

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      607.22 seconds
MakeCheck                     PASS      19.31 seconds
MakeDistcheck                 PASS      233.45 seconds
CheckValgrind                 PASS      272.52 seconds
CheckSmatch                   PASS      321.85 seconds
bluezmakeextell               PASS      163.91 seconds
IncrementalBuild              PASS      609.86 seconds
ScanBuild                     PASS      915.31 seconds



https://github.com/bluez/bluez/pull/2195

---
Regards,
Linux Bluetooth


--===============0128928674280825638==--
