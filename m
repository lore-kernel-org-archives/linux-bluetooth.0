Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0F426D37
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984190; cv=none; b=W/VHsR6mb8TO4m5NRy9V8pH9naqMH4UdOqKWHCrbML4r/7fen74+8AvUDmr5GN2/5triS+K4TYl0SJ3Cd0STQubGr6FzirR4eB0MmguTTSXx8GuKic+oXPEhYWzwL3BHOXPb8yL8nmR7bPW6b8toXGMiew67L3+lXnEIrnRFIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984190; c=relaxed/simple;
	bh=iraUmYeKJEaJl3vIQ0o+Nlpjr3RrMEWiMGAe9+O9x48=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NIkeCFeNoE3sSQ+7vQgOb3nNLb2ybqmvbgG2L79NJDMxtejyRyvAb81BgcDdFVpRGMdcRZ8q/sB/pvqqfJ+/pgWQDCOrIak4DiPAiFMPat9XLiXzcHgQTE9DLcO24y9+fitKcxxyOIliwRrx5NkU+GXref5AwqaWIApJFdu/bIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2LqGZPH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2LqGZPH"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so4736256d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777984186; x=1778588986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oDlJ9UNil+qIZ2adq8NMxBducs7i1sp18XDHxGJeE2I=;
        b=k2LqGZPHN3rU0M2K4PC6M+8n6LwtaOhfKlNbzscCL3Vf08QYndGhWvP53JAqKYLb0I
         tIAcoP3m0bbCfp1KdwyV1vH0Z68xvZdI/qJJwshhHoO79f+I4W/cRdCDOrAe/9eMuUve
         AZPh4wIHTphOao/vSsVpi6y5t8BAcEHMxQedZfpN8Pc4uDzxGbT0bZ0oKvy6rzSw0g0V
         b9DG4bkF/OgVoqqlzK/syt3lEQZnhFSG4zPe47vvl6RTRbTjB0jUHoEbzJa8bq8LN5o0
         OYtpQIZenQzzwcyao5XHegv25UyxWBXIS7MWsNlDyAvquX1GINnxoq1V8zxIkQym4VN2
         HA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984186; x=1778588986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDlJ9UNil+qIZ2adq8NMxBducs7i1sp18XDHxGJeE2I=;
        b=o3crmWhrHj59Iq1cmOni/u0ZyBGt7uv5a6tKDa85nfD28+zSNg8y9aLDfOn+bpYTEr
         haH+RLn7IRbCdpB0jjCnquvGyqR3hh+BFJ+00DuBkC4ZWM125SOUiNuNmAG9wru+joYS
         86XT3jjUa684kqHT/k9S/PQ6ACNCjhiAWO1lzeK4kvbSY9SuW7xyQYsW4WZDVSKU6w4S
         VZkNtHEpanDA3k0omsTiN73Ae5ZXYp27EmUXmlKOiTA2VZOYMhPxlFVlinSCEzW15aoe
         AA8j8mY5Ig30UOSIW6Kwp2pHw3CLOdWOCQdDfOMUC2P8Sn5F3RWnu830lRvTakMbJJl5
         O22g==
X-Gm-Message-State: AOJu0Yz5llntFL0syefA/VXup2ECZwFj2tBcczeKSB/seYHVR//k6MoW
	HgXTJ89e/GyOTzkImqHdG32WlkTeeTYmo8e3/L573/sRqpbSPJT/XiPmJG7mMw==
X-Gm-Gg: AeBDies2kB3kxxDh/iLull5jwgWtZ8kW1SHxQtMR1R5kLmKb2HtJLklZjuWWUXTrirx
	veww2+O5kgqYRVZBo9213rC3BNQFPyGHLbw0nqupcoduWKRHVQ3s2L/ZwNo+cTTsHui20UuptcN
	C2/YDrht4GpcwfSWlTJtq6tOFJ4h0cMCpCez+DLEgFxHduJjsDfNUik4bi2vEeVkNJNgYGR5Ov/
	jx1t0TwedCDzVXmcbCfYA3/8N0e2XdN2qb0TSv8If9tFAhYQJpc5gih2b0d4RitNOauk22ir4sG
	Gnn5EYNJ125Wduhh7lIC+89tIO4h/YbN7tr/PcyZSU9hB20c+YK5w5ER1K4v0rH77v4p6nUzEYk
	XMR7vXDcN1yPYUu90kCyU5xANo35O/3VyoeFzKAvNPtnY6lcu+bxgKLC7ZQ4RoABzdxxjDok18y
	AvD1CLbM7kSlWfsHYLbWgWn8OMU/cS7ktXVjoMULPPRQ==
X-Received: by 2002:a05:6214:3d9c:b0:89c:4ea7:a70f with SMTP id 6a1803df08f44-8b6665f1466mr232485816d6.14.1777984186489;
        Tue, 05 May 2026 05:29:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.175.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8123sm145235356d6.35.2026.05.05.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:29:45 -0700 (PDT)
Message-ID: <69f9e2b9.d40a0220.29f164.3055@mx.google.com>
Date: Tue, 05 May 2026 05:29:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5813938032381109408=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v2,1/2] mpris-proxy: Fix possible crash
In-Reply-To: <20260505104847.2550550-1-hadess@hadess.net>
References: <20260505104847.2550550-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5813938032381109408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089833

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      19.94 seconds
BluezMake                     PASS      644.19 seconds
CheckSmatch                   PASS      347.95 seconds
bluezmakeextell               PASS      180.52 seconds
IncrementalBuild              PASS      652.82 seconds
ScanBuild                     PASS      1007.53 seconds



https://github.com/bluez/bluez/pull/2098

---
Regards,
Linux Bluetooth


--===============5813938032381109408==--
