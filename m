Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A65D376BCD
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846546; cv=none; b=arCCLvaQH98Jp9ubbQ0feKZTzUGmRojIp0NGyZcvon+EW16pUBNsdIdpZnjcrDDH+5DoGx/pFzj/roneAxmBVFBvwhicvmSrQ3u3eOV8ou4rPP0Tz9Amf8e7qK3uzBgXJJ01jwHCd9MiN7g8IvBFwnk6zw/fayzm5LifE0eO2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846546; c=relaxed/simple;
	bh=rR/MHXhe8zQWgo3VQOFXpcMsQMvpz9/UgHlHjVBJBlc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wlokk49NTqwglOei2neIVOqVVuSn/GX68lgqkogUJLkpiH+FAtJ+iIDF/BAzyHMu9LGoWI3bBTMqmu/6Oj4ii6Lqiw/6f0A50ttjtOYMgFfn1suEJ6cpKo4rhhoGy/FofP45wsL2UYK2ZYtkNfdzoScn6iwbCrmnHwF+Hk074i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+w4dk9Q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+w4dk9Q"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84eb992a881so3688574b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785846545; x=1786451345; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WTLyIqv+7tIdDnljZJghukS9uz+hyCsI9/OsPYDbUxk=;
        b=A+w4dk9QgKha+g5KCKNB1quuQoPJ1OIBlG0kwO2eA6G2k+gbAGhpxhFiS9IEKRHWRq
         Rtg3dZSExfLZoLUHAdZWzv11LVu2fuQ1SkDlzH5kgX5ZtNorxqwWSqd6tRbYCOnDKEgj
         GsrWNJJ3F+H51gpNuH4QjkctfbGoBSaYP+S8MsHIEJ8i7J0WMgN/VrSBXGcNUr4oqnfU
         hqo2GDsA5pMlC69lwNNmmBSaGu/sQG/cqtciZw6nknfbcuUz7vwQMIpcdtbsInvgiKXg
         QILaSy6g2tO7N4Cz65NtJ8DU1kaiRXVbaMo3fYkXwia8R+5QByZrpE2kiRprY6DbcZhJ
         gm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846545; x=1786451345;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WTLyIqv+7tIdDnljZJghukS9uz+hyCsI9/OsPYDbUxk=;
        b=ArEW6jRBatqOX/VEu1WEH4nDmTzgLOPANbawcFi5Xag80Ychn9RV2hDzVcQk//q9yX
         bNcnfe7r3RjCP+3YLkMUw+CHIivTC6xZxpZkzUDGNjv7gj/zSUWnNfvkfJ2+CjXOO/ZB
         r0gI50xSGs+i4WBi9Acjs0eSN+2MmJ4RaiswcX1nNeu02MoD/OwU0sRmzj9BrHUfSzvt
         ABNsCZ2eyCtNA4l6TOx7j85FPU9iV3yP6jRqxFTDfcXYTWFVOe5Z2JnvOaTPScE2k5e6
         i8KWaRyY73jJsJNKJ70lQG/mGj1xyMNp5OVR/tv/a7ePz/wvqGvHvOMhVaBXmyEQrD69
         52+A==
X-Gm-Message-State: AOJu0YxsJVEvPTCgbWH8G/p11Co5EAv398utYTSjhIpwV1959kFf0kcV
	mj2GzncT2GQPXLzZ+pCQo3aCoyMKoIX8NGtk8wBAts8k3Bthe5eGtXi7LVpQyr4T
X-Gm-Gg: AR+sD12KL6hTdGB8kpM+RvtCO0QQTzfOOX5IWFiNHwJsD2HWbPo+cZE8J3bCaiXF01E
	EZ4NspUSsxMzKLS1TtunvLX/hAJPdDhe7D5oQ5SHeONWkllKLXZiskkEYtsAsyhQFNYsKZmW3l3
	7iSbXGEVzweVu8ID9SQMzmIohFL5BwhDI2EIgEo9f6o3EjlgE0kqYaNNMbtP49V5kn1rF6LPIJp
	u6Tuo5X1PldQ8Uav2xXnUQBnSBtsw6Fa+rTSJ0V3yiDX2FoI+ctjzJr2P7s00Tm2KarNomRFWTp
	wXhQQg3Qh8R2hZibXMHRb5LtGQ5BkpnFKz/urd1vnAUr2DHFehzNxyT68y3T0VZ0S1T5+4ohELC
	ipkjDGLl5ut3k7EubQD1ZWdyi5GW/yC/g72CkNr6toCzUZDRn+LEjAI2umujlS0QxnrIP0jLCIN
	YSgaOc76w6jZ4csE6VZsONC14lw6dR+U6BHv298B9Ro67gp+mxJdQL/upmkywZuGsXQdPNaqOEL
	ZY=
X-Received: by 2002:a05:6a00:1813:b0:84e:3a6b:499e with SMTP id d2e1a72fcca58-84ee49a73d3mr13350542b3a.78.1785846544864;
        Tue, 04 Aug 2026 05:29:04 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.45.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe7a243sm5110735b3a.24.2026.08.04.05.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:29:04 -0700 (PDT)
Message-ID: <6a71db10.80e81cd8.50537.7a3f@mx.google.com>
Date: Tue, 04 Aug 2026 05:29:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2095980972539808262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v1] unit: Remove Android avrcp.c dead-code
In-Reply-To: <20260804092326.2080562-1-hadess@hadess.net>
References: <20260804092326.2080562-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2095980972539808262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1139970

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      20.54 seconds
BluezMake                     PASS      545.76 seconds
MakeCheck                     PASS      19.39 seconds
MakeDistcheck                 PASS      160.11 seconds
CheckValgrind                 PASS      236.74 seconds
CheckSmatch                   PASS      323.54 seconds
bluezmakeextell               PASS      102.56 seconds
IncrementalBuild              PASS      555.88 seconds
ScanBuild                     PASS      1002.67 seconds



https://github.com/bluez/bluez/pull/2373

---
Regards,
Linux Bluetooth


--===============2095980972539808262==--
