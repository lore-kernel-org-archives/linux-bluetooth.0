Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED21311977
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474357; cv=none; b=erQgTjz07iliR0jJRgCZMFNHtYRdXcZ+YwpGnFZ3pvM/1RfQAa8/7YF55j5TvKMdNgVfqAty7d5oOKJIEhlImX2if9vzDXbnbLzWvN6W3mug+hQEh3oCbBYk5oVnrwq5QHywfvCniYNdpODThyHsXEVAEiwHUAbAvQRA+ZZI3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474357; c=relaxed/simple;
	bh=W8D7YevbzeAakqdeygQGjnX/x5BGwAuIquAITKOGot4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RdH3ZdbWCXDzy+anYsc9uuWfdzNp76847wc7MrNu6YQ8O5eNy9G42Za67BpiopgiKpbkuunCXs9wbWLH/DlA2fJX1U8BAJ5/IWUeqFc4usCq58mokFiK9GKgCPmS9sx1jEorESgFlEljA511SwSaENfnq3i0KkxXXWmWl7dcBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcpC/daK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcpC/daK"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9125284a8ecso872201785a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474355; x=1780079155; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I+Ovo6OO+/rTB1wIjX6VPrrpn0K46v0o1EOaUzjuuPo=;
        b=GcpC/daKNRi6EN6ykqUklXSFRVLh0BSemmRrmcRjEwhF2Xen9xh3W6nuFEzbmE2Wwr
         JUVFphk0XClnKTPUH0xbeAbExoY8uuDUZjtObS977ijDzpJbN/WDur1uUPruGpH+AKdw
         tDh5j1MvKL4bYcnCsbwPQvVZ+46VPIVWhVF2OKkTF7Lk675PYpQUmAKKm1oaMqn/3O8L
         vGm9EMtDLFNebkzgRLAZLggaizD3+T3liCyhvwgL2Str0BIK5gpExYLqMEkWc1fTx8kR
         jUQXVAWvCGd0gMxgjGncZmCMaeQKmuQPIIftcx7m5uYY1lAtVzOCVqoKy+YmwVnJVF2p
         TI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474355; x=1780079155;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+Ovo6OO+/rTB1wIjX6VPrrpn0K46v0o1EOaUzjuuPo=;
        b=YemkqFbTtZx/ER5nQCNttGEBbP3zOjdJ796LZrwP5VOlSvlrr5ea8at2vKpwSFY78i
         HHD/HmrumxfkMSPUc3r00ekVUEHy6TV/Hhwsd8LY5zjCvnO+0nO1RrKw650wvcwQrOiJ
         z48mRXl/9nXKa5SsDUqWLc9b50k0MyBpKTJdYYwV11wDiTT6r7i1/66LXKmPOxNQTFCA
         Aj/I3ipJnCODOXV4mY75z7CAclcLZAT+jM86HCSe7/2CP0skUtBVRW1yYPIbteFHC1rs
         fq/Rqs4ZE0qrtsEJamZSZR0zA6315nLCIqpk6GRxlSwGmvhEOwr5+Yg9evcYbso//xzg
         OUVw==
X-Gm-Message-State: AOJu0YyrR83mQJq/5MLAq4mLsRAcG0uQc2Nb+HOLkcv6mM8KvnNVmJLO
	cNrxAf2cdOwN3/e+HWsY1j2zbLRVceWEbAKIZizP1tWpS0joMBjX1KACI8iIjA==
X-Gm-Gg: Acq92OEP5xnaX7Mq1wZI3ujs2WuzfH/Vr6Q8UqbafgvHRrQH58aeMo/BOxpUbiE5MmI
	tlJWCP+K9wfm3eXna0ieQ9P2/RMtJvNLCYvzuZlA3Y9b5TaUsCHt/KpUY/WCuhcBzHizi6/6D9H
	NgWiE88DR5AAq9oKe21H+kTWIsg3aIk3dtj4G5SfnQX2mEVMS1OZ9C8zWtfF+D1+pOraA3l1E1f
	tJwRNBIjRPT7KBTH8FzHpKLGKpih6jTwvZH0zO7djO7W6puycePD3MK7dNsEUoPM1UHl6cR13H3
	lddqN1zoVLEZerb9C97ILNS9Ar90qHuN8zCPBouc2c0fPcfBGbcGn2hHf0SkYGQopSUuWCluqXU
	KTFu0kaWks2uAqOkiw60rkTodNHZ0Rxe5HcMNSCmqrUfuwMvxtNSSgreJnzC+n94ac6zNbsLYqD
	pSR0Da26B2m+dD9q9jjC0B3EboJZiW86LrC8lVlnBIsfzWau7Loz8s
X-Received: by 2002:a05:620a:a2d9:20b0:914:babf:9f54 with SMTP id af79cd13be357-914babfc9b3mr331454285a.34.1779474355463;
        Fri, 22 May 2026 11:25:55 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.133.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb397a81sm196431785a.0.2026.05.22.11.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:25:55 -0700 (PDT)
Message-ID: <6a109fb3.2224c765.3d2b31.8588@mx.google.com>
Date: Fri, 22 May 2026 11:25:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1435203657828449033=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: Bluetooth: RFCOMM: add length check in rfcomm_recv_mcc
In-Reply-To: <20260522175658.41667-1-meatuni001@gmail.com>
References: <20260522175658.41667-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1435203657828449033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1099548

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.77 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      26.55 seconds
BuildKernel32                 PASS      24.89 seconds
TestRunnerSetup               PASS      524.54 seconds
TestRunner_rfcomm-tester      PASS      25.67 seconds
IncrementalBuild              PASS      24.39 seconds



https://github.com/bluez/bluetooth-next/pull/234

---
Regards,
Linux Bluetooth


--===============1435203657828449033==--
