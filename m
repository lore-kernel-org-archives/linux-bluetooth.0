Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A807A13A
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817648; cv=none; b=b1XpkN+5ns6s6NI6MOiriCII/JRSi8AU8CBL9HD5NcIrUKEeY+DJ8gC/qzOeK3A4NzOnWezQLyPWuR3iQ3gblWSLxXTQUQWxjnRS86giYeBAkPe0nA/jESrLiNbsG+iE+1fMIFtmVeP1E6sVTLqiGFeByl4/2tcjguHtj88okds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817648; c=relaxed/simple;
	bh=jtSgx1bnI+9NbUigdUVLB6tIeCWUYVCM0K5ohQBxcCE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WRQhCdYcGj05/v4ClalWIfv4wHADEaLqueQuzKOvUO5QFjZX5pXyCOy+VTlffnhLZ/FTPRxA+0KTA4nRz/upwIM4AHkGKQWP/5pZqM2KoSWTpByGQbP6HmcFViG5krWIWPq4MN5eK6vZKbwpgZIj8asZV3skT3AJQY5sG0dQ2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0+ZAqOo; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0+ZAqOo"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7b28442f9so67815086d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721817645; x=1722422445; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RHRJPMLLUqTCJ2P8MsgcXelElhxkL8bU3mULJH52pGQ=;
        b=f0+ZAqOoLFbv1X86mioqytHB/sR82pywo62W1+rnJZz5Gstlj/epKt9ft1u2YbKTo6
         mIBjP201nMivgZIk4qNVQijAHA79KaIUlJ8ypeRpNCd76JC8+gVtTFt29cu3Z1nIkKvJ
         yENx5Qr31tywa2gDvKCoZYZ7NmAFcoWStEIZPJcwcwhzc1izo5p6c/9Ntiza39qywNfv
         +p3nFdyMululP3xlAEYrxEYn0Dj41kA/eonEojKQDGbh7+qSGMi0IQHBLVs4qJGCt4w/
         M+vvTfQIdmIkRrgEci5V1z6FbG3rz+cYeUxoT7Tej0RbXVPKDXloIjMuhJqUqMm1n5T8
         44Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721817645; x=1722422445;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHRJPMLLUqTCJ2P8MsgcXelElhxkL8bU3mULJH52pGQ=;
        b=g76YTMkR4lQAsi74/s/D318dJxj49k0ht1ilAiDl3Hq0crZPd4uLRBxhzHBgnvM/T8
         ZGggGMah0vWe2VCPKb5pn7XDOzLq2o3SJMtQ0k34DN1PmJGbvGmcEc+WmO3yL+BGnuft
         F4R6eQyesHeDQUpz7LOfh8O4gCgBCN2tGzojELLV929uOgw9dB6NkXQR8RLyC6Dc/E0F
         HEqe1anLFsxugtCmZiWXoj95JxuZcjh/TqODSjpyhnsFPwGYgXnXAvWEFEXGFUH8WaGZ
         p5bENZAZhi5+CoYdZWX9mE0q4JuhD0wNnyYuuXbsXhVQi5z9dvIczd4qSQXzUCAN9Z5H
         GKLw==
X-Gm-Message-State: AOJu0YwPAEVSQC/8HL9V61b7oZYt/M/PvEJ4a0KWgn426B2G/MPntO5N
	hU1ot75NDlMAf7KaIIP2ARVxXAlbkGPhAsBQey1Z2r6KvSRBcWl4BlQgXg==
X-Google-Smtp-Source: AGHT+IH268AkNqTNqV6PYwIrnxmKul5pZGb41UAP0PkFaiQGM23vZ91u1d0/yRQtSeKVdcoM9DMheQ==
X-Received: by 2002:a05:6214:21c4:b0:6b5:468e:d417 with SMTP id 6a1803df08f44-6b96108daf7mr212204356d6.23.1721817645373;
        Wed, 24 Jul 2024 03:40:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.122.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7e773csm57233756d6.58.2024.07.24.03.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 03:40:45 -0700 (PDT)
Message-ID: <66a0da2d.050a0220.45df1.1423@mx.google.com>
Date: Wed, 24 Jul 2024 03:40:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1909817782191566376=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yanceychiew@gmail.com
Subject: RE: Fix com.bluez.battery1 randomly missing percentage
In-Reply-To: <20240724085318.209318-2-YanceyChiew@gmail.com>
References: <20240724085318.209318-2-YanceyChiew@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1909817782191566376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873475

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      24.83 seconds
BluezMake                     PASS      1661.64 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      179.23 seconds
CheckValgrind                 PASS      251.92 seconds
CheckSmatch                   PASS      355.14 seconds
bluezmakeextell               PASS      118.93 seconds
IncrementalBuild              PASS      1448.45 seconds
ScanBuild                     PASS      1011.74 seconds



---
Regards,
Linux Bluetooth


--===============1909817782191566376==--
