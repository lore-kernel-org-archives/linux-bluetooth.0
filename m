Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004E610D
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140627; cv=none; b=VTcGXIH2YCsGZ9xTpAqG/6NPMv3wFoLbxZlUg9C1DfIhILk3s3TqmS4sVeb5SM7R/Dlvc4KbqeJEtmHVHJslad2sH3QxU5ZwyZcY8ji+b3dnkqOUnG5SELnSCHk/UZrJUKKYudVeHrdShf41xiVTjLM+JhAyOZCjfxxyY0NNWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140627; c=relaxed/simple;
	bh=g3Tz4ZZccviTH/T6F56YpUrS5BjaDN/H/A15Af3aqcc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WR8YiwCTVx46Cr7xpP0yjH87d75jYKfyYWblndYbDupx4IIKFEfzqjVdncpI4b4MhHCoYjt0x1wgOLtd+b8uTQ7/LuUzgYBITkbrb+dr7ivZKqvkdUwc4A7THWePEKlNCMYj0yjzAlcmREb70B/LTok7FhD+ylO8f/soAsAwtRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKETQFgt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKETQFgt"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b49dcdf018bso1071099a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756140625; x=1756745425; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UWk15dCyhl3vIZwAX9RPt21zDryN+YIt1f4pdAFlbMo=;
        b=jKETQFgtiPHYo3PmzcL/ffiY4apVvS7ntk0TsQ+pf0LUhHjqxghreIcBu4XoeAZt8v
         hYIMRRgVvtRuWh6UrJa3giQ3oi12Yj7Qvzl244r19M5dTP0llMpBF+dNN++himQ5wTcm
         RBF0xVkWaCFSjzYk9U9KbI7Bq3eHRb22OTYa11KbhGwjb2B143alj4zWp4zxriaEU/fs
         lyWoa0t5TfdnNUrhljkyZ8KM3Uvc+fetWD+vZGoWs4E56Y7LNRCxj/Yw424Gubi3/Uf7
         x1WKMAIecRVG9YpvxMdhIhUTseuHa0DATG1w8w6ut+BFeXxwk/GeS8t0cZ/VqbAm/dck
         GYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140625; x=1756745425;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWk15dCyhl3vIZwAX9RPt21zDryN+YIt1f4pdAFlbMo=;
        b=plUrqF/Vf0T+tRn7LHwjR2dw3YpZbzESfxR8vNF0CS+WpGpt7v0yy+m5yEHpR1A7+K
         sFGytNVu1ZyGKMBnHHjNJwlB9Wd/H5uEEKs50/391tedFHyTsrLS+AxMWXTbPn7oFMR9
         4LtyZ9dlud1TS5T3lOoX3BJpK8nlzZm2EyE4FBFeQXw7gq9UDpYgPtoMrHPLC9aYPnMU
         2JrunyfjfZHYbGeZbuyCPj5KJOhCha65GHtNGSLCIATuRVIJApC6h30D4An5zckWcFjf
         3Qs49OLgPuMKjpngOfXSquGaGWfLR5wZhnx0/egGclZbY5uAkI7utLMutMYZ/hxNxTvW
         CJHg==
X-Gm-Message-State: AOJu0Yx4rbsld0KUzgcGReumYOK/+1XZb6WIoA24+VfhTlD1c/VznYgc
	zbLf8WgOznIL5MZmeKnoADDg7KD27k65gP/qATk1pMNJgdyWqreILRLnKIIWkA==
X-Gm-Gg: ASbGncv8va84qV4Wk5eBmf1NeFfC/CRMfxLN4ZJGTjdiFXGAqfTVFuaXE4KMPypylmh
	eQpgxFE/q6YZpEYQhDS1uaznO5UjePG8YHW7w+UPqliiADHa4gU4dVUpZ/F/FIErgoo4cPChqma
	x3TXGqTDUajIeD7cAJXuL2qVhHE8hYHpF83X8Ylv+fdK3pv0OLYHn1b6xVlmOewwNsqSFUd8rjH
	GkJFGhMIOQ9JzJs5WIJPIzeMkmE6glwuHPYedifwp3OlOe/KBWgjjfuijCqseIIoqCHfcv/QnIq
	dFz7F9qnsO51xFncs9KLIbNXJwdn6VQwZGQRZKHsTlni4ua23VfifRU3vpc1S4jQ3gm5FTAla0D
	mR+To1/EiChPWtHLWCyFUT1OBckHyWwLRgAkdw0lHyWBqROK7Cfk=
X-Google-Smtp-Source: AGHT+IGiWoGjEno/q2yUYwJidVmNSAO3iu4V5Uf7JhX3leyVeRBCbN3iWuH3kUZjS2KdYYjh7OWQKw==
X-Received: by 2002:a17:902:ef06:b0:244:9c27:9829 with SMTP id d9443c01a7336-2462ee0c6edmr146636175ad.10.1756140624692;
        Mon, 25 Aug 2025 09:50:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.243.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688647acsm72760525ad.87.2025.08.25.09.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:50:24 -0700 (PDT)
Message-ID: <68ac9450.170a0220.1a6c9b.74b1@mx.google.com>
Date: Mon, 25 Aug 2025 09:50:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7336382563485504313=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,v2,1/2] lib: Fix out-of-bounds write when concatenating commands
In-Reply-To: <20250825152706.327235-1-arkadiusz.bokowy@gmail.com>
References: <20250825152706.327235-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7336382563485504313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995289

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.47 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      2712.51 seconds
MakeCheck                     PASS      20.31 seconds
MakeDistcheck                 PASS      190.31 seconds
CheckValgrind                 PASS      236.44 seconds
CheckSmatch                   PASS      307.77 seconds
bluezmakeextell               PASS      126.66 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      939.51 seconds

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


--===============7336382563485504313==--
