Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FA5788E
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168606; cv=none; b=Y3uyuZewYF1kH+uhZcO6Z/0KH/oEaJK5etq4ZmI+LIaaYw8tth5Uh7rw0yjfSc4dI4FHgGHQdmSkNUCd96hZ/lHlB9wv+lSYa2DPxXIZrm4/og2jOfZebF3Tq878Eg7inNZyNCG2aWRtL4ybH66wu+9y56FNxj84H/Qo6XAr3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168606; c=relaxed/simple;
	bh=+DvqvYYhle2gFBjSOqVU3Xv5hUVqVO7ZiJf3Sj7d3Qc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gcLm9217zkn9JHmQkFJb/5Xj0nmZJm4ViMhdgk3ubamMbD/LoygvNTOG7Ci/pE0GO1SN8QNFeinGFYEGu+eF/ALiNcjVJqqfsJMHBgmkzIUdKga5toqdZVVfvHAHYhMRmQy/1Qo7GeClgzncZ+4C0OQeiNZfb7PJ51wNBDcrA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckVTx2Fu; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckVTx2Fu"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6dd9bf348so4124452276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Feb 2024 13:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168604; x=1707773404; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NQc9CoAqjRgvPcdja5ui/CeI8hD68HOUtuTrL2bjuBQ=;
        b=ckVTx2FuH+WiwTPp/RUC4Ls59MqaG8xn12/GouU/dvsaZSxTMfxE5zx88y60k2+VNp
         PWQSxO6fjpLdqUOAZHNWXaPXrGD6Zy+Pl33Al0zPshIL2r5zOZsVZ0E6bTCp84VkzVg3
         MViUz85l4D5sAcxJ0LnBG39UwwI8IpupMPVIw+xMyVSA0E1jFJk7w16C2E5+4BZeHFpx
         p51eqvDQHHcc8BqehJhLxbL7L7t6VVPSMZMXLX0CmxZYnKemRio9DsOxTzGKrlmOEYHP
         Er3nLXHVWCaWFGjC8ofpqz3NxVYG2dn3YHgK87JcxUtKmT3L8YdpGWnFftVVMGfeccvA
         DWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168604; x=1707773404;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQc9CoAqjRgvPcdja5ui/CeI8hD68HOUtuTrL2bjuBQ=;
        b=Y6TYFoyUf4Cgo7avAaYiIzbfA97PFQLwFatKUJkk5n8KCGxblKUkAR8qBzHBlkX/OR
         vW87XDnmifgu3QQD+amxFkF/CnXR1q45WOFzALUN+OmRD6hY/zV0/UjVXRqQIP9jBMOs
         MgaFWaJtaBH8HBmPyeY1KavRifrNL8DXnZx6MgMLtxI87cKLA/mQmXqe1zzceKiXB/rx
         EdOk4Dei1L7zN2bG5dDam2Ns1mlevntbSmcwbKpU3w/4sgiq+RxO+e/VypUU2+0H1UYV
         1JQqqw+diKxz7Pa7g7kMk7ev6ol8tdsQD+LWWHnapVvTMibdXGMshI964ADU9wFw56HA
         PezA==
X-Gm-Message-State: AOJu0YxJplKO3OnBCYmkPepi5MFzUJgYPfle3ztcqK0032mMl8ntpt+1
	0txxVjRyveFSaKL22aTYTIs0hXlEAYkqp4ChJMWQjAq7PsC08CNjFpREW8Yu
X-Google-Smtp-Source: AGHT+IHIZjR9dFkjr1sVp6LNcrsbaxp3VZczzH0M2GnuhIs/hfTjTb85PpYClo7+gE0CcrIxfSrH9w==
X-Received: by 2002:a25:9c46:0:b0:dc2:6698:2c7f with SMTP id x6-20020a259c46000000b00dc266982c7fmr704083ybo.33.1707168603686;
        Mon, 05 Feb 2024 13:30:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGpPvRUhMTo7UJ94UV4bsH+MHynCvxFq1FKqyqVRLZLZzLpEnBg8hxO83dtEajlq97Fe1KR0/eyn6z4nvONHmzp10Pxw==
Received: from [172.17.0.2] ([20.75.95.208])
        by smtp.gmail.com with ESMTPSA id bj28-20020a05620a191c00b007855472264bsm312969qkb.67.2024.02.05.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:30:03 -0800 (PST)
Message-ID: <65c1535b.050a0220.20507.3160@mx.google.com>
Date: Mon, 05 Feb 2024 13:30:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6544866690032074941=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Rework stream procedures
In-Reply-To: <20240205202754.2295477-1-luiz.dentz@gmail.com>
References: <20240205202754.2295477-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6544866690032074941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823316

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.46 seconds
BluezMake                     PASS      713.42 seconds
MakeCheck                     PASS      11.82 seconds
MakeDistcheck                 PASS      163.04 seconds
CheckValgrind                 PASS      226.62 seconds
CheckSmatch                   PASS      328.25 seconds
bluezmakeextell               PASS      106.87 seconds
IncrementalBuild              PASS      657.58 seconds
ScanBuild                     PASS      952.33 seconds



---
Regards,
Linux Bluetooth


--===============6544866690032074941==--
