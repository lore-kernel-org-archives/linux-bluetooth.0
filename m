Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087A13C695
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 04:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730434180; cv=none; b=lW6wbOclWwbcGu8Gy5RpqsnBXbdOjIBQap/tRBHQ7yahWtrzfxQA/YeVrhRTsCSfd1ZmauvQWECHLq+mUp0I4LV0HNMqFaketsbsdtD3hfU26uUfKPe2mU9PA5TJESRGJJr1XMTKBuxJjejwjKWLV5EyidL6aPJs5VRRiME4s4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730434180; c=relaxed/simple;
	bh=B/93gAWygbQ1f7Qn/nPUjj7wmBB8/5J5jcaBgYzaUWo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rkth8rakqo7cjy5z10ffY3aPAQhFjrueHamzxB3NEeFXvVcU9yB3CPd4GBbizlMCK6okjlKabljdc6tlD1t8eHxkiH34/eVCGTlrexCaQtRY2ZYwmsYfmzptPmB75AVvjQK0wKWcqRnMU1jtOEKMtpgXfHGwqCZG1k4Sytq75fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ccy9QT9M; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccy9QT9M"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b15467f383so113344585a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 21:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730434177; x=1731038977; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1NjDPy0IMbwqjRMsezzzE9gMgaISa6bYwq0qF0mY5bc=;
        b=Ccy9QT9Ml9Jyo2LcRlFp8gS4uZDMHrY+Il1BXIbV/WemjN4nr2B60SPFyfY7w5eM9m
         V5tdtmXq6ApszMWTr04ODfuaeYNq29bWrqIbIT+rWgmy5M42UaM2dpV4QhFskBvmPXKa
         t3nUJgNGsAsBn775rzI6wDCknB2F/ssIt+oC+2h9EyJE8IYt6l0ozHugnEp9uyeeBaBy
         6p5/VyhtAiDV1841CikJiKdHF5KyNW9iJnsiMxxj/u2ZXaHuZP2NaywMjAJmdJlejicV
         iTHJV2y4T8BOSnHHfoilCdbJm8f2Ac3nMENqSXDDNqjPOPS58lCJt3iJxNqQVtHnwIHG
         rWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730434177; x=1731038977;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NjDPy0IMbwqjRMsezzzE9gMgaISa6bYwq0qF0mY5bc=;
        b=ByWUhyU9SxTvfu2B4bZLyTZG3zu1jVi0SfUm7f9AukvEM5gufxTDCppRr6q4BfhBH4
         3r3Lezc/u/mDoiqbjTwu7pf9qUUsrfohTSPxvIzymzWb5gSZ54c9Y4RvzE2P566GJSEC
         C6F0fEKmo+unKG4cnmC/fmI/fwwmnXheDWsJ/oJ8WhPgh44A2yy/Cuc5S0JaDejxyahP
         +dYG095VXvXizPq1T8DWCzQQKZX1Cxz0pwAMA1loIohcryPlDhZPLgQ64SBn5yYhzaHv
         nANps/znv2cg/Am4TjFNzL66fGuDQxiTWUPJy8K7EwX3lBD130FmpMb+Pg17vgpO71nB
         uCfA==
X-Gm-Message-State: AOJu0YwnPvkQRHGJqaXwrd8R1/5piV9gVzIvuB+Z1S1rAKN5FAC7EaeS
	ELFPQuFKe3AXBHRKB90bDeSWFvPNKtUwbgvTh4AYTVZMWJarV2iZy+J7Xg==
X-Google-Smtp-Source: AGHT+IERmpqwicFjGUX7v8me8k409302gaD+FbvJHY783RGc8beYZ4OmG/vKFJLR0peuSqnGsRugXA==
X-Received: by 2002:a05:620a:4453:b0:7b1:1223:5a02 with SMTP id af79cd13be357-7b2f24c603bmr666394585a.8.1730434176899;
        Thu, 31 Oct 2024 21:09:36 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a0b548sm132928685a.54.2024.10.31.21.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 21:09:36 -0700 (PDT)
Message-ID: <67245480.050a0220.1edde8.466a@mx.google.com>
Date: Thu, 31 Oct 2024 21:09:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3412667206422963917=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v2] textfile: Fix possible bad memory access in find_key
In-Reply-To: <20241101101345.Bluez.v2.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
References: <20241101101345.Bluez.v2.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3412667206422963917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=905230

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.50 seconds
BluezMake                     PASS      1602.43 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      177.50 seconds
CheckValgrind                 PASS      251.72 seconds
CheckSmatch                   PASS      355.53 seconds
bluezmakeextell               PASS      119.58 seconds
IncrementalBuild              PASS      1378.91 seconds
ScanBuild                     PASS      984.15 seconds



---
Regards,
Linux Bluetooth


--===============3412667206422963917==--
