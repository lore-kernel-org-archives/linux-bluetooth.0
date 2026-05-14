Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90EB3BB102
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761066; cv=none; b=j15IGeKprs4H0ZQ9URsvgIPqYSwQhCXWlag4Xl4mBGYvmk05I8FXOBHHMdagkSiJ9/YVtfjiFa05cLe/HAmAzkxn77vWfIB5Lsu+e007hsfi7yXOLyL6gRwXBvv0vXdGYoN+cmZVGIwL5Mq5WVaUq71eQZGELFoccbg5umL+h10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761066; c=relaxed/simple;
	bh=FABbjozjbXcKP0I9N/cv9nqdUv2mtNNYV4Bi3pDlCi8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NvaA/Y1X5vFMVwlrlJmUpOwkYsLSUNg51uFNCVyTFLrkSl04HhY4a4jCy2c+6c/CHylfVyNkqFM/G0s2nzrnEr3b+ItTwp2RcA2v9jcsJO4Gm/ylxEHaExS+RBPEkmzmKhfaX6fWT9lrqySxNz/l0IwZRVJCAdqEal+tLosfFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKV7mENp; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKV7mENp"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90d042fa745so476359985a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778761062; x=1779365862; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ah79B7lYmPt9G4oNCVorBp/+gJRZsVzX+s5ELnSdiCA=;
        b=nKV7mENph7xSJCCYiTwVEzoBx1f7xW+0wCk9hkSbJ1ajYd5873kC2YlkpIlsuRAXpw
         swxVPYjSTICWVIDhPkWi06CxKHHlGZitf7rbQy3ctqbIspDlOTQmAH0TiYcAqDx8oAJL
         A+DO+xo8jRmdX/TGnX+n0fN0Dl/4GFM42KJet0aoWHIeGhstFPI4J6Tn+tg2kRSjy0jl
         Wi8hfTjFKOesP/La13fgDcjyUK1r2422AuxFzzfW2YtDH4L3yNz40/zvoDCphaN4FUfC
         UrtzUgcVd4Kr4GuLfcbEItffnGwwAdpJ6J8oZadSf++Krj3roPqbOdCi1RCSJ1FbO3Bq
         ISyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778761062; x=1779365862;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah79B7lYmPt9G4oNCVorBp/+gJRZsVzX+s5ELnSdiCA=;
        b=RBiU3Sndw2S74eVw0dxIxlLWOHGiBslXXmIHMQ7CYYrfPWtCPK0vftuHCPvzLch17c
         38n8D25SvwI2GoHymrXQcMFlN87diQTJ4laa3LJ2sZCi/u7OZKWP2J8vsCZLliO1MoAn
         JoJIOTtOgwIskvWmvPwdR/jX9o/+YUfvOGyrmyv6Iupg3kT5rcnyOz/nI+Fir8Mku3gK
         FPPywcZfCDfAfxmnETmmsKheoWazDicbDwwh0rEbxg/lN7YTT+n8Ps0nfPzjCJli4cTp
         kbK1CCqjPON4155eeHGfW0cdsPqGMJrdg5jgxkzsUCK3qPv1fJ+iDN7dRUWsfKHx0UOm
         ZyPQ==
X-Gm-Message-State: AOJu0YzzaW0tNMXvb+6lbnTKwdOsvFMcgagMJRDPrNS8TufyI5mt7pNw
	VD9bCd784UpJH7Q+dp24XalVfMk7wd4BkknkYMLnpl0dZB7aIsIYOy4sFtKKNw==
X-Gm-Gg: Acq92OEHERl7etmuHPNauRoCKyMZi/bfAF5RnujtBFrbbNYftGCC5JwtT+c8Un3Dj8P
	VqMzKTyHPqQrwLmDXTTPntbNycXD7tFIqtvAa0l/f0tP0wHjeDCanaYdbAh2WSB8YrkumACaNtK
	Q4ozpVg1qmNdM9aXH1B0vLYVfPtIJvWe7k7cKQ0MzqrkKJPNtG4BWLRqBErUYCiGXTEIHw8axkH
	1ySeizt0L7JawZeVtksL5jDNsAUaIf8FyZieaD/R0iS+pN/MISugdc7q2klGp3ZkBUxAsnaaBKH
	XnSUAskN7IRMauDPt/E/Hl/wqNNsp4Jpkl8s9D/t+QYzUjCcwW2ki5RF0+SzLHTCKfFtODPtgma
	/auoQDh8uylcpC18bANPBYrvIcz8GrRKPBMWuDBDjC69WBZ99008q55LJqVDV09vmSfT41a4Tty
	IAeQUMMzQCSR+jk5pH426vK+sb24wiEP/+d0wgZXoJRQ==
X-Received: by 2002:a05:620a:4102:b0:8ef:f1c0:ab7f with SMTP id af79cd13be357-90f88e9d34emr1152657885a.24.1778761061529;
        Thu, 14 May 2026 05:17:41 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83b85asm226515985a.25.2026.05.14.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:17:41 -0700 (PDT)
Message-ID: <6a05bd65.291b994c.1423be.a4b8@mx.google.com>
Date: Thu, 14 May 2026 05:17:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4950568447135559882=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: [BlueZ,v2,1/1] shared/bap: set QoS state when CIS is lost
In-Reply-To: <20260514100545.54572-2-raghavendra.rao@collabora.com>
References: <20260514100545.54572-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4950568447135559882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094712

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      614.31 seconds
MakeCheck                     PASS      12.67 seconds
MakeDistcheck                 PASS      233.13 seconds
CheckValgrind                 PASS      253.24 seconds
CheckSmatch                   WARNING   320.88 seconds
bluezmakeextell               PASS      164.03 seconds
IncrementalBuild              PASS      603.36 seconds
ScanBuild                     PASS      908.51 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2127

---
Regards,
Linux Bluetooth


--===============4950568447135559882==--
