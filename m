Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADA32340D
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272705; cv=none; b=QtvGlWDu67u6PSbVhkueogGWKlR/6uwKL25CvfK4yKWjuMev/Yzll2ywlUFgO4BLsu65Ydj+h5ys37TZ0WktDjj7K7xLpt3BUQkDM+ihhT4IHLN//SOr1c0h2ZjMCqQ/I4UMdSerMkqcRZJkj6rlf/pQPKEDliPtJB6Zjrne//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272705; c=relaxed/simple;
	bh=3hf9WzC3Yfq1c6FwfDYSgcmW7fsz+XrzRZKTBNgcSAs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nNcxW0DlhB5OLUBgHvcwSB7Cn2AhRUhYGa2XErvrMEbmN08L6XfKIcDhXdOx7uvXbe4npayN5xghIUE6+VlgXdBZugE6ePkr3HbSoIth7zg27FjSBHd1rBSmGJL6UVd451TbxNnqGyWIeS66s+4ZVn1aMg+LZTkMf/UAAgEJwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJa5a1rZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJa5a1rZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so72991775ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 08:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762272701; x=1762877501; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+tUYNbfrI3sciT+yJtFNS9UZRx7JSB2Kth6mZZb+0BQ=;
        b=lJa5a1rZ+uhKr6PleXl+fnjGy2ICcKOZHT6s19id/I8gGIMAM1kr6m7sxCJBtia1cT
         QvOOn5yPHDYvoqOGubtogOWaFhhsjSRMJQs6NfovFvy0bcuRIpylH8Yu01n/0WRYkZ6L
         08b05JIxIwleYKxPgRk9XPdYa7YSvEyWEByg4w0FfHuwHD4NQEkgLlaS8PlwoAMJhx48
         GzWKZ2l6cgY/4rTSF71GbZYeiax2jtd12pudHBG2HbB7SHoVJHG6H69vmwFdRkRto8oc
         kgrWQIVqefa4U+4nqQXDf2uhdgJ6uvFKZ+CBaGnADYkfd3sTypZvJG0hmAou08NXidpi
         XsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272701; x=1762877501;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tUYNbfrI3sciT+yJtFNS9UZRx7JSB2Kth6mZZb+0BQ=;
        b=D7KJ0OLhVIR+N56oWl9C320JhJt9Q8KuWvJD9ljomd7lgHI6wGVuzR1c5kSFMNM5qG
         5ya2XASRIKA+p3qWpjPB2/qxyD8FTv3UOnRxxNIat8rh08e2O2Z0PGy0/YnQxRkSLLTR
         +kzuH/FQTJRQ1q23N1oZFBsusaWGoYc8Nj4zNn2EW3UjwBBJWK9DtSiYfnVTNjkoG2S/
         yMOwuDvEzVFpYHI+lvpTfkVznSeFkgJsffv2S+pMz8AL+ItJSdj2A1pOFva6mql/g1Bv
         +KFwR+QZeH5gL5jyc6xtwXSt/7WMehS9yd0ehJSZqZitgqsP1CYomY2aKUKC8IfrKNc/
         Upkw==
X-Gm-Message-State: AOJu0YxU2T4LWY4fEsNfYxmgQfKJkL09qIqv8BPN4TN1+z+o2E9+IJoK
	je0zMYbGn6z6xRxBTLxx9lPTK35yfEJ2CpTcj5lB6mQiJuPjxj1p8Q+/S1MQUg==
X-Gm-Gg: ASbGncvPG3P8VdRIgc+gLkocZwDV9jUxvRcqInAliRWtQaOkrBOnhhjeBS3dm+xS/bE
	YASpFXId7vlrQ0tO600yN7ay33bKBZPeQLyuT8DCilaWN9rMLf3zag59MaXjsbu6jeHdTrikGBD
	IIXnNoyJjFoQzUsmYeG96oOU34Nwdtd1JS5NuwA7xflmxuBGth0tiRYEVF5B6ZTlSa4WaV/XDyf
	c++VUMpNiUujT2hceAkTfToTQI/5J82DOYFKYptDTfHIz0kadIbUs/3ao9RrT/zK6s+RB6xd1rt
	aM8PwnBnpQFEdJ4CRp51FAzUGIk9dCR5EQHp7PR4Nh639CA7jFABcJKezl689r/JDTg/3/DjAY4
	51TMa2pp55gn1bKUGkToBJnpa30IvRevEYd6HQq48WbtvWi4tumHMukNFxZtEdM3lneUMZ4t6oy
	GbdF7jWRyGsaUz8A==
X-Google-Smtp-Source: AGHT+IFkLdhN/evNWSQPS8gGok0BgSKIUncNbjyosykIoFRyUeikFAzjYwk7qW4vFDWzPR2feFxZDw==
X-Received: by 2002:a17:902:f544:b0:295:24c3:8b49 with SMTP id d9443c01a7336-2962adb2398mr2136385ad.46.1762272701288;
        Tue, 04 Nov 2025 08:11:41 -0800 (PST)
Received: from [172.17.0.2] ([20.169.72.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a941sm31115145ad.57.2025.11.04.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:11:40 -0800 (PST)
Message-ID: <690a25bc.170a0220.244c88.e102@mx.google.com>
Date: Tue, 04 Nov 2025 08:11:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7780431284633391568=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] monitor: Decode Bluetooth 6.0 version
In-Reply-To: <20251104142506.12356-1-luiz.dentz@gmail.com>
References: <20251104142506.12356-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7780431284633391568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019482

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      17.81 seconds
BluezMake                     PASS      3985.14 seconds
MakeCheck                     PASS      19.65 seconds
MakeDistcheck                 PASS      172.50 seconds
CheckValgrind                 PASS      231.76 seconds
CheckSmatch                   WARNING   270.30 seconds
bluezmakeextell               PASS      121.60 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      838.63 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresemulator/btdev.c:459:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7780431284633391568==--
