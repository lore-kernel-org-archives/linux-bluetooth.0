Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795391798;
	b=K0P4YII12CJVhUr+lLpXU0xNlm033keF9OLzlJYoHLYgQn8f5dUp34Pp7ay9FaBl3iBt
	 YVkndT2meLg5iTkOKdYqEbmfAQ4hjX/JS/CVdDWtBTkJRGPlBedxdOVs52kkQRsBIfK7L
	 jNq/RCsYW+74DXp1Y/0D/J9vbqd27OUPhigp022aT8SFpfGJUnVxGEOqfKKCItn2boEjN
	 dlDlHSHJmrOr/uOy4njx8NN5Xz7ZsUFov5WayneyKKKv8z0LgN2CEJEGuxXquIGFxDcBj
	 qnDjzs62pmt63vSLlJL75RaglxVmL01DGWjU6oD7uYZoKUC+QJ24Al58/yoPcUnLKOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795391798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=O0nO06cnKuZARiYDeCv90NSNIHtwakdgNx12CdskG/c=;
	b=caSoatF6DxrJI/IYrgGTt2ZmLKSEbGuj+8D8kA0dMwKfgscgg6ToUSvt9svhL52WGEQA
	 rm8IWvQ6kcB2UO+IZa8tUQW6hvddaw4Uq1cPFCeP5tMTA5OTRp4vUla96l9pYTrijV+7Y
	 IavnOAKnnUHv4H1/BJXbZYo9zURRv1HZpn8vcaFJM7J7mkG8kkQ6zXCC1fSRawZo+pO3W
	 YAwl/nrald/WU3DpbAczSOW0CYCzUM89tdLmOh9Z6/OEH+DoMXef5+O0YZb2TJukKSNX0
	 S96ftAyyCL71F7iV4f5k6epK1sWebfTf+G+32o+vYyTb5lgtSC74BQRyzbn8DypPP2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDPNyJ3M;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD84606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 23:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DD84606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDPNyJ3M
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53634b8328eso27769951cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795391797; x=1795996597; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O0nO06cnKuZARiYDeCv90NSNIHtwakdgNx12CdskG/c=;
        b=aDPNyJ3M7mAqQdaNyZk744lEXiVzfeBZm53ZCaBh0drrN7WjlVCYcrdCXmKK1Ym3bO
         JOaOuXT05DiCjfjdH4ZeUGD6RqC8zhPFFecdMuxn/e3amEhwM4JdNID1lh+Bo0uGJ8VN
         9QBaBnM26a16IJQL8sbvBDhquDQvjRnjUpFs38kw25VGE7LgR3XrGakHs0Rpdk91Z6kF
         ESxvxMrn0O2xqibn3O8o15gjpqjmJGv4xWlBuWTzlj0GA8KVE77TC+4mJmEwUafUPcPb
         QqWabUck5kTbJG5DGYs64QJQr7dP/LLm6+aCnJ4d0KHn2DgxQiTYkXEHZTZ+mx9gaV4P
         XPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795391797; x=1795996597;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O0nO06cnKuZARiYDeCv90NSNIHtwakdgNx12CdskG/c=;
        b=ZuXlh2KqyAWjO1D2YbKKV2tsgJ1ZbGEmFDdd8H1eJDSZwFICc+1JrKDHtFBpsBIzdj
         SdvIFGvhU+dCSQHqoQnnyeC21LQ8izB4ZxOxvnaxyVHkQ6MW9E1eCEQFzav/tuCTcgl+
         Gkpbc3KLRsxCn8626dGHr+ulG/ffoMVYtqY7JEkzURKzmwORitKN2ys3OIVDHEr/ZkhR
         sR6/Ill36NuCUOhhYNt0nl6MOI/JtO0tef8tMKlZGIVhrcWsh7E6Ms9Fstwifott0Ezc
         5wekF4Sc8jOjVl+DnhnENNrT2JDbuRa8JerWrxf4zK8TQxXOzh9ep/sdXe4TjQfE7FjV
         XZjQ==
X-Gm-Message-State: APuU4Z/7oZwADJD4cFJYidYCzOI/GQHtL97lUq44t2aREAXeE/AvjPaf
	hRHuwu3hBuFZzTl4/SatQYB+fpsvT/Y3UOYS5MK3Qu9SU7IwOthGo7CAfqr7KobLtq4=
X-Gm-Gg: AZFdTZe85pQSulkIVx59bSOu1cTl8gE8Uh6rIZuGxaWJ/iv2U6hmMSEi8iO/LjVFEha
	GNtislgDsE1X7BpPzDcoMDjjHJiuOcadeYsENEMVwISnXtUiL69hs/oVytp2iGQYwWZUhAmiJqp
	9bqmG/B/B24bzqmdr2oJneov/Qg1mjuAWePnUYzwhLrr5rQmtbcrMJlJLKM0NzF1DuRXMqoLynC
	MCYZJuzrfe48y5876mW1SfEk8wYjU16X3B9O9r/03kn/2Jm6DW1mAeDv7LsVCGJ1NHxaf35H3FT
	uB28BFBccF3ycg7N2TYG3Hx4FZUH/vVPbTSOG4KurhYp2vVMLtLpJTQVx2jSBH2nQqEZUbYFn7G
	JA8NcbRY9tz0T2zj8FDxiTkbJfhkFW5/8stka4UY5SoBLvd1I0iiM0RiqjY4jRK1a2szGqoOhxo
	Ajrf/0dj5tC2Gl7XVdcS+8MNxpUKos5/z9oUpXlNeOpnTdZwUpi/qx+g2e7Tm2RR2/KGcHcgASy
	AJ5sBXdlbnqKbci/XPOyJnI9McTkjhoinUsVx71Pg5Lr6Scr8K/dOQwskmgna/u
X-Received: by 2002:ac8:5f50:0:b0:54f:783a:f8d2 with SMTP id d75a77b69052e-55d76aafd80mr185519841cf.62.1795391797384;
        Sun, 22 Nov 2026 15:56:37 -0800 (PST)
Received: from [172.17.0.2] ([48.211.210.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788548a2sm83352511cf.19.2026.11.22.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 15:56:36 -0800 (PST)
Message-ID: <6b038134.2d457a3b.9da0d.e813@mx.google.com>
Date: Sun, 22 Nov 2026 15:56:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8521492428601087327=="
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
Subject: RE: [BlueZ,v2,1/2] adapter: Notify adapter drivers of settings changes
In-Reply-To: <20261122192955.2329174-1-simon.mikuda@streamunlimited.com>
References: <20261122192955.2329174-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8521492428601087327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218926/

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      309.44 seconds
MakeCheck                     PASS      3.53 seconds
MakeDistcheck                 PASS      145.92 seconds
CheckValgrind                 PASS      159.16 seconds
CheckSmatch                   PASS      314.48 seconds
bluezmakeextell               PASS      100.03 seconds
TestFunctional                PASS      1213.20 seconds
IncrementalBuild              PASS      318.22 seconds
ScanBuild                     PASS      1176.50 seconds



https://github.com/bluez/bluez/pull/2877

---
Regards,
Linux Bluetooth


--===============8521492428601087327==--
