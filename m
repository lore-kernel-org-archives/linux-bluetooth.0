Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B071991B4
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650844; cv=none; b=MHny7E+ZIk91y3XFoQ06UVB9um9wNftD1NASDUtPS0YVHx2IRGWgTmc256LZQ78KWVD2uzlKX8bzJvraql7ng3g+Z3kgviJwGXsIrZOtKCkRjXAxBUyNX9TPSlF7Ox7hHfXALfJNHPzYc3k6IUsfFGplsXDFn4JoxQncfCn8ugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650844; c=relaxed/simple;
	bh=Czqi1WFPwfv966eM14/YkIExeNB5KFFKp+pdcUKv3zs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nTwO79aZydl4r7BOXF1laaVE05zvXQT8hb+k3galCwWwERkKAP2HbSM7ohLKVLj6W2rDa4MFKYEMjVNL3ZORSHKHx1PsSMyvr268EtAB2GCMqqQi/ho5XcZG8ek/+KXTm9vp45yLHpv3H/P/RCRpaA8ODblkMp+5TD56shV04gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDEkbGDf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDEkbGDf"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b07937b84fso24543096d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718650842; x=1719255642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7e+3RqBPFLEiGLp0XN1D5J/iR+IAkibJqlyvCOf71Og=;
        b=jDEkbGDfM78QWGAr1mv6IkzEtPQ3lGeIZMcrC/l0hA7ljEKwn2NciC+GN3EqaDhCQ7
         Pn1BXZX7h0weu0Xv0ETk0WFTRYSMl6ucf8xzxfQCbZ0J4fghbi1AIxx0Y/G30MmWMS/g
         NnQZpvvgqTvyNw+JBc+OUpFNj7PPvpU3fVBEsZgSFKzn+g5WO5H86lNNk3mbEVqgafS3
         xPSP3d/cVBSiefNoVmVB0/7xz59atpnFJHbX9qYTFDQlPZdx81l5/rT6HQrOsNS6QFRM
         cAPhD15mHYnAehdvhDFJbI0pxW891pUyS2yAycgvLz3Q+ka2IzhKFx3O4iuQmR9Sr5Fh
         X16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718650842; x=1719255642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e+3RqBPFLEiGLp0XN1D5J/iR+IAkibJqlyvCOf71Og=;
        b=btJgkUTiTpfG2BagHAqpYbVXIi8e+mbjIyEU8pmOkj3dUx+Uh1YNQLsyoWQq966DeP
         nxEXM0iJt+t5UTDRW1ZW+z3HmfhQaU+wLtq0KlpELk3yZT0GYIbvwYu4HlyrXpkeFgIl
         7gpg034vhxK2VntAQOpt1xsu+tpS+1S4qTMvnQ8eQNfMFDjOodwA0vDOjvhbn2qRZZey
         u/eTY8jMcL+t3ScX5va39ktenVtm6XRN/dG959tuaVTqvXCZLyNg2HgMwRMTzazO/joy
         JbS3slI17CrwDYngBG1aC2cuUCORGzuGcmHCROMW32l1hyiiNasRsJoZ+T608O1Um3Bq
         81vw==
X-Gm-Message-State: AOJu0YyN1QCHpcyH9L+Dv7NsnF6KSryxfsfcbUSY9zg4OoyMQxP5+HIj
	KNYQePFS04gWpFEkz3+bmA4pi2BDb7p3T7RN0odJBr5h/DkXc+m3CyKZHA==
X-Google-Smtp-Source: AGHT+IHbXldzLixHYB42jSVl4qBxhNq1HDwXMiBF8PKd/xKgjLIJRBcs7eJpP3MsLJWr/FFSaU/a0Q==
X-Received: by 2002:ad4:414c:0:b0:6b2:cdaf:300e with SMTP id 6a1803df08f44-6b2cdaf3159mr61694896d6.1.1718650842155;
        Mon, 17 Jun 2024 12:00:42 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.39.8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5edbc7csm57640296d6.109.2024.06.17.12.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:00:41 -0700 (PDT)
Message-ID: <667087d9.050a0220.1ddf7.14b4@mx.google.com>
Date: Mon, 17 Jun 2024 12:00:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5797756479867753804=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] transport: fix crash when freeing transport
In-Reply-To: <ee5b81f6306bb9ac014b02c028d159295acc469a.1718644267.git.pav@iki.fi>
References: <ee5b81f6306bb9ac014b02c028d159295acc469a.1718644267.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5797756479867753804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862692

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      24.69 seconds
BluezMake                     PASS      1674.95 seconds
MakeCheck                     PASS      13.44 seconds
MakeDistcheck                 PASS      177.77 seconds
CheckValgrind                 PASS      250.71 seconds
CheckSmatch                   PASS      353.47 seconds
bluezmakeextell               PASS      119.23 seconds
IncrementalBuild              PASS      1393.84 seconds
ScanBuild                     PASS      1013.24 seconds



---
Regards,
Linux Bluetooth


--===============5797756479867753804==--
