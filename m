Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A229239E80
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627409; cv=none; b=eiecj13/RvFeWXHlhHn3Nxl6flpx1vJRE7BedG4gMbebnMKgP/m4MCAFLzVXx29SBr5mKLLDv+lQjAqXcjnKt8K4XmIKQEIfuF16mWxwb5tt+eFgXCCoxQ5qMK/mI7ybzBQx4fuUTLbadAmUJwbycsmqSf+x/ucl102iIy+TZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627409; c=relaxed/simple;
	bh=L93RkV+OkOmlIJgeYm8hClHkkW+7T1nbLdPCRvj+2ss=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject; b=VXb1EkHpj5rxUfyE1EkeS3iuijjQfJ4SrevbTadYJkcHRyRGBQhFPphGSrZAsYe4CBNTH7oaOYYfgPO54YGMS0nhYRAONJugR2U2houxi+4dhGCD23iSjG3N2qk2lwKjTV42rw1H+OpCtWj8j4tYHDWmfP+KunOxDhB9FEN103U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVwTt5+q; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVwTt5+q"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37dcfe9b2so192204b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789627406; x=1790232206; darn=vger.kernel.org;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wyyJnAkN6dHHatypLoeDne83x7EBu/2wzO8Zvr3Btdc=;
        b=hVwTt5+qvUQTo6nXMCYO1xbh8gVXH2RJohTIFRgebUXvDxannd1P9TG7MJ4W9hMC/A
         64sgDVytyzXsZrI9buW7FH3/tMtV8QsjQN8E9DHvrLFK21X/7ihiaJcGAXsbHwjP6wV2
         z9VAuHN/+FKmj2XwBr0z6b++IkqAompNtO+sGNdo3enI27yP8V49qQRrvWW3/w1caZNE
         uges2assELWRrCwk8f5nkOYK3iCp2c+1HsQQCpRUAV3jsLcP9NEy3dFVbSbjNOR4Li8P
         T3fbb9alF/UolltpY3iq2XGyLURwZ5LAdOEfR56/nIRxppCN4ZOE81l3PLnEhcFE2z33
         vtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627406; x=1790232206;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wyyJnAkN6dHHatypLoeDne83x7EBu/2wzO8Zvr3Btdc=;
        b=v1Mk5WjYJUq7j3JMuVS2YmWj9NRnVzlffiG8maBAdYxw2ehNWpdUNkNy2UaPQZAE9o
         FUQcU37jsVxRuGCvh7icrMo4+YFZrKecZg4yfxB5QiDXjRa6nJRC00JbowmNOmBRI60S
         ZeDd4LjzQajkPdTea5eE/D3q5XgNbdVxMFzaHxteuDBSLcHccoT4eOZMsn388LeKbpMH
         vRjNT2RwR3uW++QYMnJRSpV7EfpEobv7kIqcU9Dn0cLp5auFErJME8S4ZUC4SA4qRK+l
         yiODVYABHDKvEQd/YIOK4tHrbWiCvNMOhMgrlVo1vqAaS1my6cGfAAAvUBjsyMrVbPcr
         Vqkg==
X-Gm-Message-State: AFuF++mm+ir7KiRtQ8NzlRG5Ys+kopslFVe7qmd4lSOxL0C7gd/1aIjb
	lZLGY1U/y6eZyB3YZuTDI1PadJWF97WS2q2nRuCDNqJ7IoQZ/7ZwQvAXPeXMKw==
X-Gm-Gg: AYBFou1o+d/QIa0KqEvVVxTXZuw9/mRZbvl58E8JiyBLXAxaSm9cXG2ff0nUjIlihp3
	Y5pl1aHeSVRAAuGTanop6kXCB4ZYTT5IRuKCUBpaS4wBQeFc1MDF/msCj+hVhUWz+p1A28VPrzt
	dsLgOXKkREPqKUU468jF/B/H7n4pVRp4tTVxv2FXstDis47lFHlOZtBKcLkMD1in7EmHpQhKEMz
	lmeYwa+j17xfHbeUENHqLkcTVB8frbIiePtdmFnvdrKkd8YVusXf3v6Qib48VRhrbQ+AyZW/x70
	GZL6xsr4Vvs80Gsui2zSZPMTLCHdMEFqQN97CJe6sxEK/zDOK4hTS+9RHciOKYTXz8v7HTuTIVE
	5SvTNO2uCsotuam+9LyNvQvsLh2bKMXpgr/XwpD3LNWVQ64s02U++QJTZenzlDkqSS4f3kBCXTt
	i0eLXK495Dbdm+1wPHYY4tB37bzvN7L7eZ2Wjrjnoc7cgi4FcJSeCmPNGEsJMgbNkZc+UIdsVKU
	H5l0w==
X-Received: by 2002:a05:6808:5183:b0:4c4:5f5b:6933 with SMTP id 5614622812f47-4ca468760e2mr9551350b6e.0.1789627406005;
        Wed, 16 Sep 2026 23:43:26 -0700 (PDT)
Received: from [172.17.0.2] ([158.23.19.148])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c46199e96sm1941649a34.6.2026.09.16.23.43.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:43:25 -0700 (PDT)
Message-ID: <6aab8c0d.dbb9105a.6a28.9441@mx.google.com>
Date: Wed, 16 Sep 2026 23:43:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8194515108489031206=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] Pull Request #2470 was closed: device: correct bdaddr_type when the LE bearer already exists
Reply-To: linux-bluetooth@vger.kernel.org

--===============8194515108489031206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

The following pull request was open for more than 2 weeks in the BlueZ
Github repository and it was closed automatically without taking any action.

   Pull Request: #2470
   Title:        device: correct bdaddr_type when the LE bearer already exists
   Submitter:    monperrus
   Created:      2026-09-02 05:28:11+00:00
   URL:          https://github.com/bluez/bluez/pull/2470

Note that the BlueZ repo in Github is only for CI and testing purposes and
it doesn't accept any pull request. The patches should be sent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) for review.

If the change should still be considered, it must be resent as a patch to
the Linux Bluetooth mailing list (linux-bluetooth@vger.kernel.org). Closing
the pull request doesn't submit anything on the submitter's behalf and no
further action is taken on it.

---
Regards,
Linux Bluetooth

--===============8194515108489031206==--
