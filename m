Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FC23AB8A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415875; cv=none; b=qkmTehIKpuQ+qNTFKv2xyt5w9r1YFm8/DvBHSspHJn+C1alZRvVGn3cEjtGyKedBhms/VjRlQYPYm2ecI61WFTMUSlpTsm9HgrxTPou8XVwSPm/qf4hN/ErzSX31FRd7VbdPya+ujgDuqt1l5qTTrXFf542CQOFtANMzm9FSFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415875; c=relaxed/simple;
	bh=NTRUg+PJJbAPJJvssa1aiL1XAAshzFvCpUSSfWAxDGE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oFUeMaoXm0iXtPvygtj6HGztRXtXgYXgxIobp5qY2S2DJCmIhnYYYffs7oZwxwEea9ZhQLEn3vJbQoFJ2xYEgFskSse0MGPO3GlRcRzN4VFAZrSrTlijGpvDQs6u8c12gufF8a7QNBdlHO6F94uWQfIilLz7Zzx6Py9NIrT0PIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kmc5xQJK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmc5xQJK"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d3f5796755so129034585a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750415872; x=1751020672; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=txedv0hH/n0hZfbR7NS/17C5NOUpTHM7YiZ6da/AxWA=;
        b=Kmc5xQJKtlt3bjGR3de8C2stIl8BdyxmJ4g9YIXAr86Jb/tyhmeUfjVfTIiy/ZSTsy
         H1G1jz/dEGEctAJDArVK46GFkp/Mvr1kqincDTeMgb+LoGMP03Cw6QLGqZkq9f0q8VwA
         zoKf/R5+Ixh7OFfZD2Dh+17Ty9DwHu96T8fi2XqDVvIanjdFGSLW22VhXz6mEsNUjYUu
         A6Dm2hx8prIVi5HbaA/CyLlEuUhCXnTuPnd43FXa2qQPzwN4wyohzhA3fTve3d/IUBiX
         amTx+SnIs9kFBF9OMXnohHfYu0J72sjIVtpw3CkIgySmerkCDB5PT9N70iVxDUCApsAC
         m3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415872; x=1751020672;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txedv0hH/n0hZfbR7NS/17C5NOUpTHM7YiZ6da/AxWA=;
        b=wWoucmJoeJxMx0sCFHbKk09Aq+Az2TGgZ8CAQdVx6ZZ75WmtCznwWt5iGa/VaGBwWQ
         wOLCsC5WlUXjaNdHpZ200jlNjLYYuNY11qxry4GFHk/IgbFjy41vdfDBdp02Q7xeawI8
         VQIYVYJQH0Vww3xEuEw0qsIdgeDIXtrsDQbosT1TCUrrl9T4k8+VNKimfadMZdS0g/Vu
         Wqoa0DsjmtPtbEVbFjA48xjkASMiZZ6efFgiGBglyl5RIZcE/kPoYCaTDcSxNTVS2Apn
         AHlCoKQDPrh2b0K9T+mAB5P9v8lTe5E2IZyvCJggJJ622mAft0vqWUJpsy67wi6Sdr/Z
         GuZg==
X-Gm-Message-State: AOJu0YyXrWsGpQ3PEIGx2fS5bfRw8NeBxEViPjs3V8PAiZlUsK0qoexV
	70Y/YA/p5dj19Vl6FeHUfxQkFNhgvN081+KjnXi8N8cQxek3ka+57rDUrs+9OKOi
X-Gm-Gg: ASbGnctK8gfFz+c70aiQhidyPU0/ijUU68QeUsI10CpWVeqQV+1pbvFUvBCDROSthFA
	3bDYAsBQYariikhbYxm6RAWQCx9c5j/CQyrqhqxSXDmNC4buL8Wb5YsSTFBfepr6TJiN027A6RV
	0v7z7kDqVSi2z4smp3mIWEbatRHREVzMiUHK0EtWamgObNvE7CLT76SZ2E5AQlOLl47mWq6qzWZ
	u4U45EZ9Cocw2YftvKiMMdSebxeWs//YsLcWl+s7HYowpjQrF9g+/99/9wtZ1Iv4Y+PhaPBKInf
	eLzWrOFlrkUY2OlxrCCxTbDJU4Ti8lhoIltCFEq25A1iQmVS/0/TeUw1NtFOCuTr95FaLA==
X-Google-Smtp-Source: AGHT+IHxJe2SA0uUkNT9Lub2HjI7iivzynj1HjGCD0ABFO/Fyl1eQPvumab9g37pOZhbxfZt4Pmz6w==
X-Received: by 2002:a05:620a:46a1:b0:7ca:df98:2d7 with SMTP id af79cd13be357-7d3f98dff3amr357089785a.25.1750415871754;
        Fri, 20 Jun 2025 03:37:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.208.237])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e7a160sm7257421cf.60.2025.06.20.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:37:51 -0700 (PDT)
Message-ID: <685539ff.050a0220.362ffd.20e6@mx.google.com>
Date: Fri, 20 Jun 2025 03:37:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4361468952195006314=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] bap: don't pass in stream's own metadata to enable()
In-Reply-To: <c257288ce21dd2c25624d0adda2f42b0428f7a43.1750409838.git.pav@iki.fi>
References: <c257288ce21dd2c25624d0adda2f42b0428f7a43.1750409838.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4361468952195006314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974152

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      2698.56 seconds
MakeCheck                     PASS      20.22 seconds
MakeDistcheck                 PASS      203.25 seconds
CheckValgrind                 PASS      278.09 seconds
CheckSmatch                   PASS      306.96 seconds
bluezmakeextell               PASS      128.53 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      921.31 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4361468952195006314==--
