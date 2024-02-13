Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2A60245
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845676; cv=none; b=an0/YmV/mKZoQTueGiiBhYQTmlgfUEGg1vQpPkh6wRE9/E6iZ9P+vj3L3N+wlPkDMEo4T3FnkADyj2lF3nuEzd9q4uaeyM7ty+GtLlKzihCtWLf4XKSEU+h7TI3hz0B88xGs27OhoAVTfGyuc1sdqidIUYsGVzxbTE6cVvsKs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845676; c=relaxed/simple;
	bh=Fezv9DFmwmxfZFn9fuIljtIYUfKaa3W4UMoSVOaOXPY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V86PYidr7I1f4VaSpecqkI9SF6iZV/Pz1fVPqS2bB+cFecAlISJPlRdy97KChREpPD//Ezr9hrY56L5s2t/CURnAn+SFndjsQIR004axLzAQFTd12Xzo2WgPQVNfUqzDxVp/kPPiCpVPjyN1wlqaXlprgB9XtwGlmo90sQI0/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgg12TeE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgg12TeE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d51ba18e1bso45204315ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707845674; x=1708450474; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4KtpajEjjvfhyqIWxDAYkgzJ6PpmRFpBG0Gtd5Pg3nM=;
        b=mgg12TeEqOSrmHEFt2q3gpVjUGcdKRAietbnaOyLLN4kSUiz4Px87Co0WGh4uvrcxa
         cfEZ/n0XQfYSANyhzhCSUpP2EA1GP7LIYzIPbGe6kd7YK5iU4CC34+qtkMiPrkuZXP0X
         5THXDwlffDkQfHzJ5XsJjWWm9tTiyzo0GA5ulm9B8sJRLYPF4xJRHleYheAa1byv99a6
         2J4wScxysb2hbK8npSe7RKSywKGd0U0UAeKr6xNii/hToV0Rd1U9B5N2TNS4h8jcQwiu
         HAn9N3gBM9PvcRQWP9u9n3hZVu2QnQpzixenOxad8tff7jgKseNtfgp0+iYjCXA0GZQh
         tovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845674; x=1708450474;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KtpajEjjvfhyqIWxDAYkgzJ6PpmRFpBG0Gtd5Pg3nM=;
        b=rEps/RmpuNZMlrdb7tUO5DFQ/FTR6WQEVn9uDaUZPpVl4pKKv0e736qdsM9kCA/ewh
         PLJIodSOYCv7BG2f80cHaCT5Iig4PIVKKdSrF25Ota8OHimi2rBv32nTeNoix4HfQdN3
         mnme/6dB6u+DglelsO5kh7eKEemu1GkbqrXYXZ/Lv5CA+k/rBWYW1/pQwUMl6CCmOOuf
         q56p3PaMyd8z99YG2bfc9sPomrxflGHLHs/RD71kbxF8fJriXfWUucSV45oo2PpaoHkW
         e+vUgF7/LBJLN81Xo9TWRLjIB8rkOBrVeQkWgwBYiTyRPAv69t9sd4IXyOMCZraqODlb
         utjQ==
X-Gm-Message-State: AOJu0YxMgE2bmvV8LNc5IrcaYphnkCcElXSVdwiFmjHoPuMDJ6zQzThS
	IgiUMfohF+7EdED4sojQrVTHHwqEPTiS4JxkD7+i6y06zhBBEOACSdq0IBDf
X-Google-Smtp-Source: AGHT+IFdFkZgWkh1dcjtB+b8jfNFIjlgBpEu2mb9Zi4Idv5cNMXhlTjVMS4epaOeyUBuAwZ4Ge4PZg==
X-Received: by 2002:a17:903:2307:b0:1d9:dcd:c726 with SMTP id d7-20020a170903230700b001d90dcdc726mr265678plh.17.1707845673658;
        Tue, 13 Feb 2024 09:34:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNz9R5F3fyNphVo5P6q4b0WB4UZqfJpTruw4wEHOEClDg7K8Y5Li9PqyS8CzS2VVYOpiNRpxj1nGc/F5hUuMSrjao=
Received: from [172.17.0.2] ([20.172.5.34])
        by smtp.gmail.com with ESMTPSA id lg7-20020a170902fb8700b001da2f9c6e01sm2357947plb.136.2024.02.13.09.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:34:33 -0800 (PST)
Message-ID: <65cba829.170a0220.f010d.81d7@mx.google.com>
Date: Tue, 13 Feb 2024 09:34:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7130346585997977693=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [v2,1/3] lib/uuid: Add support to compare 16bit uuids
In-Reply-To: <20240213215703.21507-4-ajay.k.v@intel.com>
References: <20240213215703.21507-4-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7130346585997977693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825718

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      23.96 seconds
BluezMake                     PASS      720.69 seconds
MakeCheck                     PASS      11.31 seconds
MakeDistcheck                 PASS      162.34 seconds
CheckValgrind                 PASS      227.07 seconds
CheckSmatch                   PASS      327.88 seconds
bluezmakeextell               PASS      106.37 seconds
IncrementalBuild              PASS      662.08 seconds
ScanBuild                     PASS      942.33 seconds



---
Regards,
Linux Bluetooth


--===============7130346585997977693==--
