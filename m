Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0B13DDA3
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999801; cv=none; b=NBfCZwAnbLM5o6dl6u4TE/3xWevCY9AtDFLAiPXyFav5kr0ANl+/IVna/k6ipQMKR3p2dRqZSbp1i9rRTjDECsXb5sT5JusXAR/p+NuA/gz0E9j22zpo4FM+E91cB/VM2l4eFUV1QDuVjRWz8kC22Rvfr+ota/xl9YtzhjbCYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999801; c=relaxed/simple;
	bh=PLzSuXUU+TsqYJvfP2j7Z+0nwEHvSjsGRcwxQm8/trc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aZh8+59vc4q75ALh7at5iqgQwxwB6K/15gNkoH2V2WkDKcXUpGl0gCCJk6FxDB+zTj3SCqtNXEmFei/wKsGtX6F/hwUjnoqja8lc+rwz0UNknBzISgNosvquzLGZlOFnJpU6RYk5PJHNynpv2o0qGjFfzEWIorDoh8w1f5gu7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtrYmPzt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtrYmPzt"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c10f03a94so34534985a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719999798; x=1720604598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3NhC1j26I7olR2ak+kF7m/hTQeVWvw0t3rvv51U3QZg=;
        b=NtrYmPzt5AW5kzKbxxnJvhxlk9/vQSaIQWqaen1W0ixB5kcoaKlAu0aALHk5Y7F0md
         a/CZNUPDS66S8+ulItYF5bK/YRyLVlSUqvhZ8DKItxTPwmyZiDORD+s85M0b5u7l3Nho
         Xu2RFKcKvX3NSSxLtT6PFWleQD7mRVHDJOO//nHu4XrYycqG2BVssg0K+OJ61mzwk5+C
         v0XPkUgtcot5OopLOo//yVpXXngaLWrVo+XwtC8iUc1S/5NoHbZhJbJIUUfuQXQO0EH/
         DDPl4DgdWA6anu2Qp/9WSoSsZWnwfhWxmtxqH5p91X2z3e8aN1fZELDPiPfxglMWfZTG
         nKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999798; x=1720604598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NhC1j26I7olR2ak+kF7m/hTQeVWvw0t3rvv51U3QZg=;
        b=IRylNkegXsf7RHvkQLdo+kzujNy4LpvfanpY+boVdYWOLhbTS1ln4mYIPBJWjXRR7H
         HIlP/GF6HLEZk8YkxMN+IolDJx8jfZ55UUP7c6cJSdZPSo8bgX6LR6il8gxmFTTxiJEp
         Pybi26NSdDZy7721W2QwHugww3Ll/9Dd1tfF9bVVRaalL41r5UgjN75dikULUZes7AZU
         AFY25m3q/+yjn+nDF7sp7x5x/D01jl7S6CdWNMhY8fZRSVGMH0l8Rj/XhcZQfOrbe5Nv
         QtZW9DgiassyA+AJxnt+rs0d++qt9g/fAjXukTuUl57rtmnGYLNZueu+U32pmpY/DPR+
         UT1Q==
X-Gm-Message-State: AOJu0Yy+8HCTvgySY09s4CwlHWeruvoQfSupOxxJq+EbuemgOCocPlvt
	dE82DHOLN1uz/oNx5rpNmclqHJvIg++c+58s1qNevBl9B1zyXri49gy6cQ==
X-Google-Smtp-Source: AGHT+IFSJ4goSxfQ7U2so2QB9MIWePD2t7pZG18YlUREQl+KSVSShcdnfSV02BFYrOxfZMBHC4Fyyw==
X-Received: by 2002:a05:620a:8116:b0:79c:c3d:9c22 with SMTP id af79cd13be357-79ee314a45fmr160440385a.8.1719999798431;
        Wed, 03 Jul 2024 02:43:18 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.21.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69303cf7sm548190585a.110.2024.07.03.02.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:43:18 -0700 (PDT)
Message-ID: <66851d36.050a0220.fc915.5522@mx.google.com>
Date: Wed, 03 Jul 2024 02:43:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0936133638692037385=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [v3] Set BREDR not supported bit in AD Flag when discoverable is off
In-Reply-To: <20240703073712.32149-1-quic_prathm@quicinc.com>
References: <20240703073712.32149-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0936133638692037385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867869

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.48 seconds
BuildEll                      PASS      24.68 seconds
BluezMake                     PASS      1669.35 seconds
MakeCheck                     PASS      13.64 seconds
MakeDistcheck                 PASS      177.63 seconds
CheckValgrind                 PASS      252.73 seconds
CheckSmatch                   PASS      353.20 seconds
bluezmakeextell               PASS      120.02 seconds
IncrementalBuild              PASS      1409.33 seconds
ScanBuild                     PASS      1015.35 seconds



---
Regards,
Linux Bluetooth


--===============0936133638692037385==--
