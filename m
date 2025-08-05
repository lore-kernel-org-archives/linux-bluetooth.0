Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611211F30AD
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395342; cv=none; b=a6MsM5mow6qfNBsBiMI1gcFM4shRcWcHoSQc45A5R+fBU0ICtBjR2pRGxAV4wjww7WxwY6B4KqQaHR/4PCCcVd2Mzmo+l0HXPyfvCP9IplflGscOVc7H5IyRINpDKhMGXMZegNkFhdl6uSBEBt+Kiujkl579LMUz+W8gkoUcCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395342; c=relaxed/simple;
	bh=avMZ7UIRHmV9exYg9SaKTGraseyKQ75pII+O5cwbBKA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=epa2+wFluPaYqpT3N07A5TjUN+Udu7gni4szVaE/5yymbfcWyK+Nf+gyle63ntWztjoa6pGDAqjP/sMnxQm5DPLOUCzkiYMIHiGReBbJ1UAFGxDwOtS+Ft/Fr5qWr7OEtYAZ1ypCayCcgz0Pqe8Ol+6vStxDrDdH1j/wAHnOK9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYoZTEcN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYoZTEcN"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7682560a2f2so5428569b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Aug 2025 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754395338; x=1755000138; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+t3V18i3D2OKX4ytkYyHkrFI2AxKiWUMK4IHpOrGAc=;
        b=eYoZTEcNZHatW2XzlcKjSNUrBikTcUzzkMAR2GOZpcY7fkE1DppUkQiaWlFkPDyeBr
         A9u9zt7A2E53p/mSaa2gZ3nMJxfc9YbkRj/rcg51YnjmWVVobqcD8x5ikWlGEoy8WHBP
         6NN4vWPDWaCI219J7gpj3rKHnenrbdlTB3lEbJ4UuHCTveGg2UNksDRFDWzVpK3Wpsut
         whA+OO2JCSsUkR4uDGVy+VNAG5pzDbjYiXyZiRHsUsVc6iVLxl0hqW1fd1WIlMRva32U
         InxNxdsu2UwA72CXYLHil+FbnTFjx9ahZ/QJMGqoRwydjc7WXFjGIaeQLshq8opHc3kq
         Xzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754395338; x=1755000138;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+t3V18i3D2OKX4ytkYyHkrFI2AxKiWUMK4IHpOrGAc=;
        b=Uxg57d6ynl+CyIcYyd3+hX0SxaT5MXOQ6eMLQBCoH6wpUO4Q0oVeT0PRjxmDtoNHxz
         +DZR5+2CPOtKowntFu640Dq9q/lXb4vqMfnVLrVVkGCYzHDJup5EQQsOTR7zJGEt1/zB
         LgOPyErugIev552tm2sWxzp0XoZt0qdq7RCFKsu7kDntOCzvNMCwJpI96ttIM/ahwige
         HSRlIyNxk/FuvjDjMSctM6oD8xWhslSrqZe2YF+/h0OkteupW259fn7Fn6airi2EGBD0
         SFwDFZFJZiSao7AySpFY9nEs7iiPyCGyCzBew32Xoa0FgwlXO+SvNSwP1M7TRdHU2IEw
         d/0w==
X-Gm-Message-State: AOJu0YzWfRqiNU/SvXoaKtEqnuXSs2JTSV4saKVzgTIBE46vxhyvjlDQ
	zVkomLK3xLgQKoq4ozWUYcEn6ZK4ScUoXN5ZcKXicgZWQbPB80SBIQo8r3uwtQ==
X-Gm-Gg: ASbGnct6VBnNnFEPSEyUgAQ2o6eLuALKdVF/keK40AOY176kbTqL1P0qrBoxmV27lrU
	bC8cvQhzPM3biTGRePncKdz/vOh+yY7A3AkJC2DzfwFHF7c/hO/hifypAu/oFWPIDKx3MrWlkoC
	dh7E9wqbpUpBZWzsBE67gh5JFlH/MyH6avldiscuYv7M7KzoGp/7Si4/bVbNycdBfMQlfSWaA1k
	YODSBuLmy7WxQmeUcGsswM6QD/oRxsntUiqQflqNJFH2+trQKTb/DCa09uAq497GKQWoa9BLFdM
	3eGstkTN1FCmoup49nMlUF8p9GHgPn1cMJrytHu1rRRTWXm9aPdZEmuSVJImRJnTeiDnI8l5AUb
	vJksxnUbLcFOEFI7UQ2zz9D/QWCU=
X-Google-Smtp-Source: AGHT+IGPXS+NSXxFlySheqiS0mPIIEty0aRMnR6rpeqih1sscvTAGTBhbRqB7xWr+FTOVEZ1pTH0kQ==
X-Received: by 2002:a05:6a20:7f8d:b0:234:e109:6bdf with SMTP id adf61e73a8af0-2401eafbff0mr5460077637.19.1754395338249;
        Tue, 05 Aug 2025 05:02:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.42.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7095b5b0ef6sm22013066d6.67.2025.08.05.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:02:17 -0700 (PDT)
Message-ID: <6891f2c9.050a0220.6340b.82bf@mx.google.com>
Date: Tue, 05 Aug 2025 05:02:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6277235679340416989=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, myrrhperiwinkle@qtmlabs.xyz
Subject: RE: [bluez] audio: Don't initialize device volume from media player
In-Reply-To: <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
References: <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6277235679340416989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988417

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      2701.18 seconds
MakeCheck                     PASS      20.14 seconds
MakeDistcheck                 PASS      184.68 seconds
CheckValgrind                 PASS      234.98 seconds
CheckSmatch                   PASS      304.73 seconds
bluezmakeextell               PASS      128.95 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      911.45 seconds

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


--===============6277235679340416989==--
