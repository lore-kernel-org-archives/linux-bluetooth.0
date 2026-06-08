Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA19372EDD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920057; cv=none; b=koJ0MbGOC0xsGpwXsOONUfrIkhc5Ss9WTqLbLR5mcoz3Nug6nJ7iz3L/UtEdC6BnaUXNTQ1YwrhB/1cc46VY1uGazc2f9j8ufsscB715ThvsAOEfqBRrL6bgJSs9bEI59KJ06QeoAwI4tFOeuknpD5cuhjguPDHuNOCREj59XRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920057; c=relaxed/simple;
	bh=pfb3Y2AN56PPYzb/Ab6oXw5P/jRa1+lkmeDJMe//6Lc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=drImcn4HKkna9jGZfUz1nkbVmQnYwbBAxk1PPQE/6i3WXXCzcjZ3EzWJoDxhdqQfPt+BDEFFflOZ4VA13lSmUNHBSimAmsVP9mRWtiBYCvD1/UD+I0h5YW+jfqIcc41MfuxTt7mcokh/3Tl76KZvxGFQWkOT0RzT48sBooOYGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw5NPlTD; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw5NPlTD"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304e83724bfso4947691eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920055; x=1781524855; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/0+d7yr997gbONRsGH6a+/aITer8u6NCF1XyST6h4k=;
        b=Fw5NPlTDOSrxC50XeB3Ozqip+YbJuGHbsJ1x9popruLkMUw0r89ZxVUYR+j4xIyOgB
         JvEPMgFY0IqAgJQyM9b+JZPBbTYMZRJOm7cwgFLPPUiS2uziIDUQY+lBAmDNiAn0EWNa
         htqV3KrMUG2GKmBG5ESXnlvoSk85a5vbXjQxpGbaDuBpVEPnX6p4zcAtBJftKlRtx2Hq
         iP9y20YShOL/pkdS3vDp05DmYCmCed4h3+8RDRgZzbijG3UqzHNhcEFE0nYR0AYKemb0
         HJ99HK5j6nq2qcpVtmBv+fJ8aGgEvT7OFxJW37eziO8o2c+hYgR174C1A6qkKzSP/AbE
         XNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920055; x=1781524855;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/0+d7yr997gbONRsGH6a+/aITer8u6NCF1XyST6h4k=;
        b=eV2S1tRwR+mmUecatc+0AZVks/v13ZlEdJMzIJcH5dS1L3KHLEKbf6H5WvNFna4QvW
         14C4IFaIR+IKe3m/kiLNIVMRt/vtJVaxbHB3cQSJ/yvLL5Kx1VSPAINO+NRaFMPsuH2N
         o8NfCICAYpTC2oiWqP2uEbnhte1ZSdH9qsRdXKVuJ5ykEPdX7YnnA/K71G4KMRLGaybX
         wcZ03TisV1nn664k66BLxQOMvYU5wLl3EZauVk0O+TyEzRQnXD0UauTUA09jxuUbFjGM
         Af5UuqqEM85j3riYQ6/2G9/vX0cyiiOfSS5eyyHDUe3HNRGion8j1aKuLZUsh5xOw7BG
         aidQ==
X-Gm-Message-State: AOJu0YwFizRYbgy2dhkPq2lOo1dG4+q04cGZREqtYowIeBQeiyi7f334
	Y5DLRMsik71T+dLgkr6fgJNLG2Ivq/yH3vp7Ut5/P5IxiEpcUtq/ZO8VoZrElA==
X-Gm-Gg: Acq92OHuoM7x+NS31IvkQRdl68jfyCSyMbpX1E2CVf4gUv8mnYQL+iZXivt2q2fjZ9f
	W7kT1MYqilY1skwECXD0gZdbuwGPfUfdYq8jksz8OxfCLzOFKX5aI9YLEs21lBQDOzKUgON4Jv+
	NMbdHpIzcdXlsNudrQsfYS8+ZrDAJZrhcYUcFL902TJ14GI9ZLegI+E9O0wda40tG6EfV/dgK+7
	4tvIFbWBPOFF2AZp4fOPJzWQQSKFTN3emMXLcQzYcStnVsZCEE74LvjSUvKniW/FrT853/rTBiy
	E5QKF/tivkt9R49YUksmXl7DSQVrQVWDdqVlRmHX5mXv2XpLkd/uycGPUTWgpgjGdPGIcD6VgSc
	yX5SpXcqT6KTnGda0C+BMHonRCpSfORxTNNYO4Os49PtGYAkhbTjAr1JHml6C+UhjlRDWd9z8Rl
	yi/huxKgZXXtPl6tkMWhwJ5XLHhub2V3mH4WCLFCk=
X-Received: by 2002:a05:7300:7494:b0:2f3:3daf:3496 with SMTP id 5a478bee46e88-3077b7811f6mr7150947eec.26.1780920054643;
        Mon, 08 Jun 2026 05:00:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.53.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm24584834eec.21.2026.06.08.05.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:00:54 -0700 (PDT)
Message-ID: <6a26aef6.44930dee.3c8499.3424@mx.google.com>
Date: Mon, 08 Jun 2026 05:00:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7924412370152597685=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] hog: Fix starting encryption on some BLE remotes
In-Reply-To: <20260608091140.3606008-1-simon.mikuda@streamunlimited.com>
References: <20260608091140.3606008-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7924412370152597685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107612

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      12.59 seconds
BluezMake                     PASS      379.88 seconds
MakeCheck                     PASS      0.57 seconds
MakeDistcheck                 PASS      147.74 seconds
CheckValgrind                 PASS      116.75 seconds
CheckSmatch                   PASS      184.84 seconds
bluezmakeextell               PASS      95.68 seconds
IncrementalBuild              PASS      402.48 seconds
ScanBuild                     PASS      507.29 seconds



https://github.com/bluez/bluez/pull/2184

---
Regards,
Linux Bluetooth


--===============7924412370152597685==--
