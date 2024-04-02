Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60D15AAA6
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079768; cv=none; b=deQv5sS77odJ2W0XQJaHA/pNpgwzuD9OesNH/G4K28I1rbyYP710Zjg5qcltD74Rov3D1haaGtVyBkBihZT9mnCCYs5mj2F/eTNjDMCWH3Hti1rIHe5z3xoZ5EJLpPLIAGzRkKXwDozpgafdquZW/xZXfq0Pfvem0yRc8WqaFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079768; c=relaxed/simple;
	bh=HpF9I0OXV8wkVTuK+b2Ybw3lgs7IU0x4LulUUnM3hvU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=of0QSZTNnHiRKM5exu5ZnZa/yyPqbC2sUzXrCIY+oEimzefQJcen8wB4lIqCdM3fVJAhYf3xTPxD6umihqtfK9p9yDIA3G6UsQgN1w8MgXaVLB6XZiGvrdaAXJ5CZc5smIbzSQyYcs3PkvZDEW1Uss7WODlbwW1i3EBVB5eOBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbXsft8L; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbXsft8L"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-696609f5cf2so33916936d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079766; x=1712684566; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rg3IGrNpJO0r7lghXA6VVrKwexTU+2xFwqbIBpW1vp4=;
        b=CbXsft8L80EUWX/h0rHhW786SA3ta5uFr7mLFtQJdWG+41/jK6W429c3fonidVEpdC
         sLEb0Z64R/dbLP3yect1iyoN2tYEE/cfVY5wWNk2cDcKS4iZCV2K8JQtLhpLdBmmCBKQ
         fWIjVZM+1RRoiHpGEuRtgCqM0i6RqJWwKvPLtONIDET6jwxdJFJFiAnVNozObKSNtZu3
         eT3g4Daayv1jzuFwaCFUS3twC5AO45xalqUSqYX8x2oOpdFn1gOoyFLRtYAx0rYevehN
         26uA2qYsnMWAR9n8oztG9s5g2XDngUfRIw2LwxDAxr9nb0TGvrHwaqrgiBKekdoqUp3C
         D38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079766; x=1712684566;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg3IGrNpJO0r7lghXA6VVrKwexTU+2xFwqbIBpW1vp4=;
        b=FMP12lVlr40G5m/Qzsu09Ufo2naNrXuNzllU5rYuw4gWeiSzMtnn8k70DKgM4v26Cl
         0CVBUeYcWk7GNx5VIvh84sHDYtnaA65fwyUIE0J7jUYWGCGQM8DcA7irWO/pmAJAjsL3
         ZUywTmbnsTLgaPl0UTrGv6SfUduntQaefKF8zkKkA7f8xCCbjXI+TfLSEqex6Zi1BNY7
         /TtV4jHJnmXJoGkeGudxTOxiX9+OTuopNrcbRY5ypWaazJ/Iv43OU3UTeJbITZ9890Pg
         ODcAnQbbd0MU8nAXNdmKoWAyxSALazXQ3jGqiGeUHM8nFQIpQniUCCl/qdh+DukmuPhJ
         QvpA==
X-Gm-Message-State: AOJu0YwNRmPjk2Sxcyl5RtM1y0kNSll8bdYnaxmZcA4PWi6BHt3ilxSA
	w2pAE6kayEEHyKH5KbyanInDF4Bui1FSvjN2g+K6Cey5JCYCow9nQn9ZsHbY
X-Google-Smtp-Source: AGHT+IHikgz2PE1Iq+5ixEUx+ZGqoSVH1qZxTG3j9VPvbtRBqS4qxJqHg9ms2sx7vsM6rfPvAEccqw==
X-Received: by 2002:ad4:51c8:0:b0:699:25c4:2334 with SMTP id p8-20020ad451c8000000b0069925c42334mr26453qvq.57.1712079766262;
        Tue, 02 Apr 2024 10:42:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.159.36])
        by smtp.gmail.com with ESMTPSA id q14-20020ad45cae000000b006991de7276asm646323qvh.94.2024.04.02.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:42:46 -0700 (PDT)
Message-ID: <660c4396.d40a0220.ad944.32e2@mx.google.com>
Date: Tue, 02 Apr 2024 10:42:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0271262942527239456=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: bap: Fix endpoint unregister for BAP broadcast source
In-Reply-To: <20240402154955.45229-2-silviu.barbulescu@nxp.com>
References: <20240402154955.45229-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0271262942527239456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840702

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.59 seconds
BluezMake                     PASS      1700.75 seconds
MakeCheck                     PASS      13.79 seconds
MakeDistcheck                 PASS      178.97 seconds
CheckValgrind                 PASS      248.63 seconds
CheckSmatch                   PASS      353.52 seconds
bluezmakeextell               PASS      120.47 seconds
IncrementalBuild              PASS      1456.28 seconds
ScanBuild                     PASS      1001.85 seconds



---
Regards,
Linux Bluetooth


--===============0271262942527239456==--
