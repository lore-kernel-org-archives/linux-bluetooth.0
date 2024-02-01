Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFA1E481
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819430; cv=none; b=Y1KhA5yKsOuR/Bm680rk9Vm3eflLxtZBVzCkVQbYGjhrR9UhUQWLLnDa+p0Wk134f3Lt5I5hKxnf3HhsY5T9SM38A/mG2lrLXGS4Yud74INzBICxCq4FDmnEOEVSxv5ZvA8RslxgBxoKdGwIzdZ4lbvxQ/aprbH1ioA2IyVH4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819430; c=relaxed/simple;
	bh=H3u+wx2FCuxg/+gQa/u/+pkT9rbc3pgQfWdY2Qr10Qc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bGcmZ6E339Hklzl0K7ccKwaH1UkN86CzNwORDO290oErOHkQqGKh1HLA0WcHOatWnDBJnfdM6Q96z/ae9hcP09K2hvXOYN2toLI17UoaxolrFTRVwLj5N36bVDzFyTUvFrogqD/NHSUb3al1wjFgUKoC4oW0/1rFI8rTrMH76jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeryZLBZ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeryZLBZ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59a802ab9fdso563198eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706819427; x=1707424227; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/EFvOcrmP2xkHKGcqZ0wzsAJlENM4cLCTRFtUZMOrZ4=;
        b=QeryZLBZcAUeDrc2UdFhlJlNZLoCCarJmnhLTgBW3biGcYq8Hdj0YCQI8SeKvCWMNr
         iDXra4Qw/2Spf6i1DaACkkwrc5x0P/gBGsNYTHSJi48Tw1MFHTIOF612EML39lm/g2t3
         BbjzV13l8PrPruTdB8iTTsBR3pJ0Wl9GxXVsbmWEjIDEqny4ciTjuiC86mivgM223J3M
         4dj1AqxT8XAd6kLqfUxKL7zZ1zHcD/+nQhamwNyXX8ycYXSdMOSkWC5dBchI2pygBE8w
         D4Nv14RjgC+MTRxgYYmVj81LzBdYEkEgJF9hLbDgwLV/pU9+eKqbMI97xPyKhLwG/PwZ
         7veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706819427; x=1707424227;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EFvOcrmP2xkHKGcqZ0wzsAJlENM4cLCTRFtUZMOrZ4=;
        b=FbqPFo0J3HFyVcsCX0q7cW5+UNHVp8vnvjoCP0EgNXqe48VoWmDBWF7dryZhsyeejL
         WRIycINwmT0hntHoQ5CyjLFsrG1/P39e3MSiRYxARBteCYC0VasoTGfYaWzrZInKiXcd
         2FM4d5+5EBdHGxc8jcGYPzpoqPMmQHDbz1OyDnbTZ/JiAglyNgYkC4+3BcSRwgIGbcxT
         XZ9yoT6QaqTnSDoNUvVUqSuezLkyZl0tfu58i7QdCC1Bvg4bK19W9v5lGQR0cFPz9Ha+
         Qex3344sNpcgGvHD40SZXdgMptQce8VBRv4pt5Om07G58AvGkSaksjEaW1gTQgGE61sl
         Pm1g==
X-Gm-Message-State: AOJu0YwGpt7FPYJiEX2zZ8awTEWOpTlj3MG8h19mqAkeDTvEX/wTGPKo
	t1tlawXT1oZLrCL0WTxTdn6GEQfO2Vcf9K8I/GNjCg4T8mZrkMJqImVDAuHV
X-Google-Smtp-Source: AGHT+IHhWcKYFLl4YMH4CDTWA4FMaeMBQ8kgkElJQwVwsDoLvuF+ffOqdxJD/jYNWOVzfkUu6ibdJg==
X-Received: by 2002:a05:6871:7506:b0:218:4eb8:5347 with SMTP id ny6-20020a056871750600b002184eb85347mr6858626oac.20.1706819427596;
        Thu, 01 Feb 2024 12:30:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWSagTNCeryn1X//KEBDUbNLiAovAonYDNZRD37Sg5iWjq0JoTdeqo92T8ZDc31l+/FmYrYwsLDFDXtdv1mFhKKcmFbIA==
Received: from [172.17.0.2] ([20.75.95.161])
        by smtp.gmail.com with ESMTPSA id u7-20020a05622a17c700b0042a96eae7f7sm113881qtk.57.2024.02.01.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:30:27 -0800 (PST)
Message-ID: <65bbff63.050a0220.37149.0dc2@mx.google.com>
Date: Thu, 01 Feb 2024 12:30:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6302883048475105067=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/5] client/mgmt: Add missing settings strings
In-Reply-To: <20240201191004.1122047-1-luiz.dentz@gmail.com>
References: <20240201191004.1122047-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6302883048475105067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822250

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.45 seconds
BluezMake                     PASS      728.13 seconds
MakeCheck                     PASS      11.57 seconds
MakeDistcheck                 PASS      163.60 seconds
CheckValgrind                 PASS      224.94 seconds
CheckSmatch                   PASS      329.48 seconds
bluezmakeextell               PASS      106.97 seconds
IncrementalBuild              PASS      676.54 seconds
ScanBuild                     PASS      956.25 seconds



---
Regards,
Linux Bluetooth


--===============6302883048475105067==--
