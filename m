Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190323EAA7
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Nov 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763306018; cv=none; b=cTQQZi/2xH+FhVLVUCEGUzmqr+Ehju3vW6/oiqeyt+vsFK+LsU6FI8VJdX+5HYoSaD5Po9OvSVMep4dKts+Y3uw3ujPC+vyWTdUy23ow6sO8ssyrcN29icyEKcaQVFcPUDbVuOgT2KnhviFLH7oC2XKdWSn2auLku3XExpiFBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763306018; c=relaxed/simple;
	bh=me4gomam0SiYFkNtSyP5VLLp2jJCe9R6yWz4RrAqEY8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=han2wuC1xxR6aE4FGpMsnAUWvZp+xNXgM/yadOf9/pgv+/0UqPsc5N05p/yQzHY6jVGBBnXt6h83pXwOHjjHPUMooeTjmsvEI+3tAfk0Uy/GJ+S3/1zqX2FkQ9EZ2CYhM+Kn/JoedEU651vQwP1bC/SQDB+zAWia3IKwaBbgrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRFz4dOI; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRFz4dOI"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4331709968fso12671955ab.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Nov 2025 07:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763306016; x=1763910816; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=79u9tEapCPWfX7RE3gocj7gmDmUggAdyvkLydxbTetk=;
        b=iRFz4dOICL9o70TQxYEvrWJzUXDeIuVol2d+2ReepsKpu9M/9kU+cbLFrVXB3av8Fs
         p/aMpzPje+5sW2lu9jkkY6MXia6cOJIJbHUu6fe/S/HzVT0IZJEA2AcZK63n9PLa6gGU
         3V7rTe2+7cOsOh4HwRFCBPeYMq8NAJvXCoD6a9Zi+VTqVsvZ9e4HfR1Z5oFNTijYq1DX
         Qyh8AaNVEq4gam9YhYUyCBbUfdP+07s6Kn92lFgj4Rfjpx50lEUCgnXAAha+DfD5O1kP
         /1iHYB52ZhfktESlg8j7CmsgS3dPBCDckpk0RY6g6snvwnDCeahiF97Le0USSUfy2nEP
         exkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763306016; x=1763910816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79u9tEapCPWfX7RE3gocj7gmDmUggAdyvkLydxbTetk=;
        b=neOsBpTTmSzBy8FypHNS0TKBrFHpaJsZwOmGQ3qq1f0av6P1vWMs3esrf37cTP19Zo
         VQJgFrdexasjZWpUxYRXWRY8TtUrKd/cchNA3WnuOr9HUR2FLNUNoQ01ScBVajVKQgkZ
         X9PwRx0TTKvSChIdnLW/f3i5/Ut0DJF90wJqm4bIHQeTCHrbkp+T2zgLh3n+UlUpTuzw
         TvFhYps+qHaHreg54+e65dg5EiMMjbMk6VSadaUGsIXa2NtuPXzXLomZKfO6cjLj4sFh
         jpVc+wf3exgsRUGM+/v4TJPEol/gYJZ6yiKpoMSktq5DmM1yKHXIhoWRAKUB7eefUzqb
         Qcjw==
X-Gm-Message-State: AOJu0YwfnJslsTBPC9L6PrPw+NsVJ1ZuLLaFAzcVFRK2xZJjoDy+Yh6B
	hOJK9589I5DuZUdiu1TRVZGirUfLoMyH2eLeG0Z7n82uuzpjSNVG66+hZhmbvw==
X-Gm-Gg: ASbGncv9XYp3NHRe0V1RUX+T0duvj3dHcz8Hqtf2dmVpdsrsQtxcC2WXW5sTZ0n+8A7
	TzjfbKjZTNI4tEgy3wUZ7e4BW+H1P1tlaC3nW8dEH2/3xyFvomqEI3jv4hFTJHpW/jLMr/6vNyr
	L9RoXwX3X5CxWsJTVqBykWzdOjL3GvHwv13/G0jLG/xGk5vNR0eQHs0YGJpEAyD7QTWGejiLugX
	iszLb+kbUNVvOMVaZ9j21kUniSa8sZxOLuNwRQyCpV9RzB8JZHn04Afc24SgxxnyeIKsCTaQYza
	z+lZzIBbHg9cm7rlh1OF+qgCqaHWHCIrxSy2kGGD6SbYb+n/ZYSyFK25oO4CJxVq6BpufqKWTxN
	9sbkNBWukL9g3T19ed9ouIIHLvSMEDdRlTMaEOW+35Pkyw9K7p6qt7w+01p7w5fAtJ1Z/gL3PA/
	hT8DJD
X-Google-Smtp-Source: AGHT+IFG87sros1YYl1aiXF2VXkRZUqgVbL8BL0KsZ5Oh/mHrhfUtDaY1B7md0PX+9W4mVvLcfl0jw==
X-Received: by 2002:a05:6e02:1a24:b0:433:4f00:5d0c with SMTP id e9e14a558f8ab-4348c8fc17cmr109235975ab.20.1763306015881;
        Sun, 16 Nov 2025 07:13:35 -0800 (PST)
Received: from [172.17.0.2] ([52.165.58.32])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839c4275sm54187875ab.29.2025.11.16.07.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:13:35 -0800 (PST)
Message-ID: <6919ea1f.050a0220.16cbc7.9de8@mx.google.com>
Date: Sun, 16 Nov 2025 07:13:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0598650947597830369=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] mgmt-tester: add tests for discoverable timeout
In-Reply-To: <134dc6196bd704f56902f17ffc72119c9babd7bb.1763301095.git.pav@iki.fi>
References: <134dc6196bd704f56902f17ffc72119c9babd7bb.1763301095.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0598650947597830369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023990

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.27 seconds
BluezMake                     PASS      2635.21 seconds
MakeCheck                     PASS      20.62 seconds
MakeDistcheck                 PASS      186.26 seconds
CheckValgrind                 PASS      240.25 seconds
CheckSmatch                   PASS      315.36 seconds
bluezmakeextell               PASS      129.57 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      937.58 seconds

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


--===============0598650947597830369==--
