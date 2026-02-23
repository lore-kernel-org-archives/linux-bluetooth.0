Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371322259F
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854150; cv=none; b=AC5iJRVa2QisUZSMES9tQ+TEWc9DaBRX7MTgwPmlXTS7b/zxgA8VOao9gbWkF9/PrnrPGti9NmiBFaojqTwCjuV0KDIXDnibLZU+Y+PbOV7ZSyxs8IC8cqLuXBYZ/GecHLwkb3MSA3SfKhpxiPzTvHiDxiQ6UaQu8rTAUs3tRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854150; c=relaxed/simple;
	bh=emDa59tcX0pgqrpSEcGMqXxOjPZTRbGa6+KSnz3KVug=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F1DDAjaD6HIyCjIIvNneFgwAGwNnqDwEM/u45uKE22Lp0F6n099b4w0+n3hY97GlVenX6QFHPg5JGBybFLSrYiCZnIVNYt/ZMcz8dnc5KccjUt+xuSfszRkrWPKK5n0Q/MibiItTRVDHDsVZqiESU94/tNmIbT/+Vn1Ivk4sZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN85QxcK; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN85QxcK"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb5c9ba82bso708371285a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854148; x=1772458948; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HwXhY0u9QiKrRWlvDTdUcxFHQ0Ko+3LtU0WaZN4xBlQ=;
        b=fN85QxcKV5a4Lm+92g4nRVXZ2uLCvypoB7QEVsvxMZ9juObV5HnDgAlwp+Rs3z0Hlm
         mMX5KJ/y/Ae1G5OCU2oSKIAPYyQi/GiqQg9H1R7PwNrx8+Wxj6MribQbXtB/9eOK941w
         Vk0kn1sXQPP6kSLSW4XShrYzQrydg+SB3msS6eXYsaZdj7iCvRfT+UjNYHVqJkloFiXq
         gnE7ueaw2vOAUNSJZuKBFE6HQnah0o0s3kA8JLMcxl/4qWHi98E4BnC02AloiS4V5xi1
         aV/s/0B88HQwf8a2rY+qhm0XOMYF/CRRiTDxFLII7SWeqrkrWl+q/Og3OAfC50ZGHHiO
         jZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854148; x=1772458948;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwXhY0u9QiKrRWlvDTdUcxFHQ0Ko+3LtU0WaZN4xBlQ=;
        b=VO3Xe/hp2Q0txl3ISwWE+J9QV+BgmFy4It8zskyEfSF5X9+drZlHTha5DbLQ3DiIaO
         rfQR+8tTLp99JjAv4UCj0OgAFuFwAc9NuqaI0PjK8qmHwDgNUTji2vzqEu7QUCPdTKbd
         +E+LyeWmg78JACJVbodDqHKI77FnUe4ufvfYba0EyV09VQBO0kQjY9IfDnbpIYH08+DG
         PgGc8aBvaRWmpAbtwa3n9L0JzaEYaHEGX+gczfWeEiZsbO3BFWJFthrdi4S1sYw+21MW
         cuu1TV5ycJ1o9fPDufVe2xuqzJh9p4pdqPrWfr9Nnnk9zVnOC0jgSfhcAUubO6S6g7ca
         se9A==
X-Gm-Message-State: AOJu0YyWFz2Fb08fEjiHS2XtRK8CUhT0H+9OqndXlSjlSslYFVJNEXhS
	slwQn6xTA5zU2BSHDiEKZ4tAeNVdUbTflX7YEPcb134wBJWAbo6hBbC3TfUhVwF/fyU=
X-Gm-Gg: AZuq6aJUWD2BQPQjyym6tbArYEmJPbeo6ox65wVgxYPCggCyuyNABSNhzPd3O3OAlP1
	fP0ydR40d5pGWOLxgNNvTIUszT4i3sKdd859Ez+OnioNDFlw06Y6dRL0uKKTnHBUNhlxpjr5HAY
	g1FKnQwq9hYwIecXFBCeu9GZVmn/ffFHUQoffiXMFGHQHRKy+vbOzocLiHFEyraxXpCVZnLID5p
	qIoJfjASeb1cGZWyqbL+MBiMnuwhFITYIzPXYLnZrrYdckIDnvY8RA+QkvjO6aEs6PXTZlzMjSA
	KGmP8Hbo7V0OvPe0BhBJbwrJbCRxGXmYOEEV/y1K7vVyArNZzk/kcNfW+MV7e3C2TAvGJOuzFzE
	8jXKUDe3yJRBmtmhLT/Ky9osQhCaTUQ/ZaEiirRzpdpeklYFbHYob60ujEyocTJNNMmxfHfp006
	BocG8Qoq0muDt9NweOjgZhrqMHmCZwTA==
X-Received: by 2002:a05:620a:319a:b0:8c7:10cc:758e with SMTP id af79cd13be357-8cb8ca6e517mr1095437085a.45.1771854147776;
        Mon, 23 Feb 2026 05:42:27 -0800 (PST)
Received: from [172.17.0.2] ([48.211.212.217])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb0fasm761956785a.23.2026.02.23.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:42:27 -0800 (PST)
Message-ID: <699c5943.050a0220.12c000.a9d0@mx.google.com>
Date: Mon, 23 Feb 2026 05:42:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5124017294008448387=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] shared/bap: Fix endpoint configuration
In-Reply-To: <20260223120142.205159-1-frederic.danis@collabora.com>
References: <20260223120142.205159-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5124017294008448387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1056469

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      653.77 seconds
MakeCheck                     PASS      18.89 seconds
MakeDistcheck                 PASS      246.51 seconds
CheckValgrind                 PASS      298.03 seconds
CheckSmatch                   WARNING   356.49 seconds
bluezmakeextell               PASS      183.28 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      1037.09 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5124017294008448387==--
