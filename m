Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3B39E197
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441108; cv=none; b=GC0K6rMElfTlvn7xX3ZnpPhaBThGY9ipuDLjOfq4a4lgS1Oyicx7TPxJnrMsS1Dl/dRxEOO3YgObn8RDl48QhKyofp5tgDKJSrqifkbZwnf6yi8r9ujSMWiUMUYsckk6/9dQRqU7DVbeteilcVPz7nYHtCbPiQFT65QdR811N4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441108; c=relaxed/simple;
	bh=IFEB3YS/LcwIAOh8Sr2hDlFJf+GQZ/h1WzFCYcYJPsc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uP1sU+JOxvvLwe6geZltbb96RPHgN1L8KEs65zjmRBDGkDTFS41VJaOIIHE3JgSWpAzrNlgtxBygyHgKtSw9Lc2IQkMH3f1mQdowteIFRfi2fIF4o/A+4zdmAo2wsMxo6G75BzyNgKnRfuif7Ru4bEII+DIY8w9XB7zkg69JIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjubtWTX; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjubtWTX"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137eb0d76beso2336238c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781441106; x=1782045906; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=refQsOIHkSLjyrLAIbeiv/fvW6x0UeAEHN/3m2U15ZA=;
        b=DjubtWTXC+OBK2mA5xS+ATPS7Nc42KxfZMg1CgRdJbGZjFEftoTyIdz48zIVb3UAXH
         JHoDXtIz2Sw1YIcBCQRr6Lu3KI+fCSec0i7zM/STNIWDHqIoPFIuiyyBphlKGz2OdGtx
         4bihIGgpoI+sDojP2ZfYHH7GaX/c2oK3xkpebuw/9SXYDd7NDzZjMaC/6PbKO+7/+71+
         DvhZsKJ/se9Jz7myzyrrtcxyOSdNekmNf95huE8nh2h3A3LnmeCyiF0mc2cXK+kGVHmo
         A1cus3INPM/GhUMHKlrL12NhBv335ckOcxR4YfZcSDyJM9BPhfCkFXq7yeRWCUHUTiZ2
         12Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441106; x=1782045906;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=refQsOIHkSLjyrLAIbeiv/fvW6x0UeAEHN/3m2U15ZA=;
        b=a2UxAHV1Pif5Q5BtO7zfsuPIL77c2hwX3aWw1obOjRakFn3a5bnD3FCklakJzpXvEa
         s8AdA12ZhudwP6PkXSEH+V4cHG15b1n5TWI7cB7JbEoUnvpKE5vCqcCmp25GIzRHWaOd
         +d952cei5ooa5+gCzOzX/1ZPCetvxPLJl+eGDBqnak61gOotUmZcR+8y+GEpvKWuEX55
         knqD3PFqXX0GbALr3CL0ulVwTRJVPus0YCEFO5FoyIe5UG3wamnNtObGonufS2VODu5h
         lSjiITRHmyiy4puwZQ62EUW6vlHVgwuYRajoF227407vc0Njoj5vy+Js5pHXjkftJfFu
         D5kg==
X-Gm-Message-State: AOJu0YyIbmBPKzJiJyD6OaWEovrlBMkfQSncUoAeUUS3FuGlxmjqXKI8
	hAra8Cp/sxnDKrIxM0U3wO+XCg+a56QOqrW8SwzY/Xu6xHX009nvPyIDUSxaDw==
X-Gm-Gg: Acq92OFCCvDJG+Eozf6hK/GfxSDd9c46iLpNZdGbvAtr2mLp6R1Q+hQC3zt4xOG3tuT
	Hdn9bhZTWjGQ7rOVTz/p4zZlHcW2Hao1Dhy0Eji1MTEGVaXLcysvmjXEEQtnMekRYKGmm3tZ3dg
	tnth7PT2nn6IQ+LcZCcsAh93sOADEAbdjOJgclEE+hyvow8M8c6f5rHWow3KFCDXMsG4Uk7j99g
	1hqQwdGsjzHlQkJzhnG3wyFw7Iq7JYfkW9vfOP5oJF5lBSoM/S+hByRh1LofuFMs3TeAPAJKzy9
	L9q0ATqM8LGAqPngFPg2rJ43ZJegKyW4WNXqRrU2Fzy3gJ6DpkNY0QEwB9GlgWySLsxLMy2ZJuN
	tl5HYCYUdD/0JUwmr9AstGVP87JqMKe0hdkpeGsgDHDcEJiHL6S3YU/62uV8JVQU+1zcl5Be9rm
	A/QP3sVNkeMSiuzdrDPeilntFMtwOrztO5sCTNuxTp
X-Received: by 2002:a05:7300:8ba3:b0:307:3a74:749a with SMTP id 5a478bee46e88-30820cf480cmr5362079eec.16.1781441105662;
        Sun, 14 Jun 2026 05:45:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.53.118])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb9a2e7sm10757463eec.30.2026.06.14.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:45:05 -0700 (PDT)
Message-ID: <6a2ea251.7554299c.38f792.b75b@mx.google.com>
Date: Sun, 14 Jun 2026 05:45:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6594131049036189654=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] media: use custom DBus timeouts only when remote side is waiting
In-Reply-To: <499a2bfcdd6ed488104bad57b285ddc9c7788f7e.1781436012.git.pav@iki.fi>
References: <499a2bfcdd6ed488104bad57b285ddc9c7788f7e.1781436012.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6594131049036189654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111256

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      13.32 seconds
BluezMake                     PASS      468.50 seconds
MakeCheck                     PASS      3.02 seconds
MakeDistcheck                 PASS      152.22 seconds
CheckValgrind                 PASS      130.35 seconds
CheckSmatch                   PASS      204.38 seconds
bluezmakeextell               PASS      102.95 seconds
IncrementalBuild              PASS      462.75 seconds
ScanBuild                     PASS      580.85 seconds



https://github.com/bluez/bluez/pull/2233

---
Regards,
Linux Bluetooth


--===============6594131049036189654==--
