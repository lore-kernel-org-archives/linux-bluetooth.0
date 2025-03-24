Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2010F1
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827165; cv=none; b=FHECIKPIWmBEQr9aNHWby8LhjQTW0vTiEQSvb+GWdavZ+ScJCerNRHwoE9KPPDHdPCashJY9GNNp9qr7gFvmnRfcxhwJY/8xMDyzZs1afP6ihPZ4wvuMIrnIdEjgi2fCZmbFAIuF/Z/GD4P/1wLC5STZilXHXdZOamt5CnhaI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827165; c=relaxed/simple;
	bh=OZJZeoneYGew+nnpZrHb6ITmFbZ+jJx4ycgFEpqgmKk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=StiPU5+4YIZJSiwg6q42NcbBftOOA9oNRZ2P9CDbyzuQMulAxV2fcFtxsZLWCbGy4348XJIzLwh45vM3TJUfZBJy7u7K+96n5QfyoepXHZP5OkwjGeYiizxmjC4AATDvjd2Eeo4Pf5n0Lbn34ArDci4jc9xafAPT1/sC3d92c2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGUEdO6f; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGUEdO6f"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8fce04655so41993566d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742827163; x=1743431963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xt+VR1vhtLl7DQ88F99hcNtducM1ou8y9qT/thN+hsA=;
        b=cGUEdO6fjWBYOADBPnElRTRVlQFmrJBvdmzVXOEtsQJMAKZqtzlG9DmGbHQZuVZ6wb
         WoqEZR3uu8GQyq75VTE/jN5SGeNV/kBdmkW7sbJ9L5ivUNtCFUb7Jmc+eJIFcqjdab29
         WCALwVzPcWT2Deh99cRWRPJgBdbTmkf6NxeOibjHcL7/geCZY4e+ftRvGG6dP2KoN8On
         y1XaoTifwh+Okg/WeUF/9xAf3I+4oOtvy9uzkxu4PAxkj7QAr2eU7BSWpIS3cXtQjeZH
         r9GVOFh/4FMGAS8O1Svmv6eFnFXTG1Jj4KZzkLCUVQhH0+0nrjilgtdUv4n9z2Cs1XRb
         owLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827163; x=1743431963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xt+VR1vhtLl7DQ88F99hcNtducM1ou8y9qT/thN+hsA=;
        b=v9kf3atTF1NQxCaO5dbo29cRvv3ITyx32yy9pJ/3i4aKQxVShFOeYS00VJ4blM/t/M
         dN7cXXF5XGbRG+QPr+J3mTKkYM3sitEVYxYXQyshnfftBISQ8kiJK1f5n5jCYIKgx8sA
         Qi0QpSxkrhi3BxOcAU5FftEfp4WbdmMbOeWEJktOg+IXXdYqleUn/R+oMRuQKvXTOGKU
         0gP+nd3h+zVB6AMaP2gud8fOJ2hpAF9fiROr2AQB+0x+5+0SAAF2+EIC0zfKWkcvRcbj
         0SOp9BKGfaQiRMdC7KESze0eEvzQh73KPeHC4U56Jm9RBIQLnJZBGfJIzUGYuY8bO1YP
         M9XQ==
X-Gm-Message-State: AOJu0YwRwICEhrW8PxNNhoQvGQC3mBGyxEoEjKrHAKcW1FzwKGFNJyJ5
	ip6L6Y84PrU4VYBMTL1dJUlPcc0RjdHIY1vwajFjfz0VWQn226LyhPjnMMhC
X-Gm-Gg: ASbGnctNo16G7qNwwT6XVq3sbv04aX8JzCJquClNQA6uoPGi2Q1C0JG1fYfaVIT5TkH
	dLgtOhOwPl4omeWkrgPG+NYLq/DxM9+OSy+5cuf9En3wQH6ubju5VHeZ/CN98grWifmhQH1GpYE
	yoDS62XyCSmUCJ7DjgUvpbCeJ2GMGji58ewMIxwl67/yiOMKM1wBm4tOtS/v4z4wvUD3G/6rxXi
	AQDdeqIOSVnklVqb3ih/Cjl+swXqNK5/M8Q8m6c3iFZGZO2p7xEqAg2lGLBUefkc0mLrsbovaOH
	QKTYfGL2oraGWgM1lbe4t77U/SlU/bzEyXMqi7wDbizZOSH8nA==
X-Google-Smtp-Source: AGHT+IH6KpVerKKwIb02rvgt0hzo+Oca2BidrdeIZA0dtn8KkCVtYEGp6KJ1NcDqB/m3bb0yp89cww==
X-Received: by 2002:a05:6214:529e:b0:6e4:4085:9f72 with SMTP id 6a1803df08f44-6eb3f26e8c8mr183832926d6.7.1742827162851;
        Mon, 24 Mar 2025 07:39:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.44.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc5593sm45078076d6.87.2025.03.24.07.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:39:22 -0700 (PDT)
Message-ID: <67e16e9a.050a0220.1ed581.134b@mx.google.com>
Date: Mon, 24 Mar 2025 07:39:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1117476423429849339=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] mgmt-api: Add missing Device Flag
In-Reply-To: <20250324134112.2108216-1-luiz.dentz@gmail.com>
References: <20250324134112.2108216-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1117476423429849339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946842

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      1560.39 seconds
MakeCheck                     PASS      13.72 seconds
MakeDistcheck                 PASS      159.08 seconds
CheckValgrind                 PASS      216.26 seconds
CheckSmatch                   WARNING   286.65 seconds
bluezmakeextell               PASS      98.72 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      869.27 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1876:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3607:52: warning: array of flexible structuresmonitor/bt.h:3595:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1117476423429849339==--
