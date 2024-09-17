Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD8A935
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726549290; cv=none; b=HvW4GJhAprWKNCbdNIseKl0PDxwM3GIFZGwwpb/ev514IyEqTk5UAPS+4vRwvn8kamdb8h2KekiPhcS8c3+cOSz7GChOxiEJgdYfS1xikXezDoSjpSYQ40vARfrDFPlbE+NIurdpkKTTp6ReleXIxd2JoUCCNZh8a73+IMwHDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726549290; c=relaxed/simple;
	bh=mg1sfqXjKkc7K4jI+lS2mVbzMiK7hKPqpBdJAaeaC+E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NId7j4GWTFqVdRAfCYvPkOUpExeKDboHywI9qT76kmKAyBMK24x1PkAeg7JwJJxWMziVnI4wYqwMUqoiQpGUnullfoP7tefZ6Z5Xd8iF2Z/C26vduuV//U1fGEQ1ddG2aI14bvZ/nCnyutV/8BgiDQsVN7yFW8hYCnW5fEiRMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QToBKuvI; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QToBKuvI"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c579748bf4so40429126d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 22:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726549287; x=1727154087; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Azv/E4SskXb2z5dflyiez0I5gvUqp88E1PQupHH4fiA=;
        b=QToBKuvIzzShnwpMFa9VbuYsEjljcpJOB0y2zN6wmpE+kIe2iwAhdC3ow0ExP913aN
         5jQxIyg2UBpyBLjfYPV/AOFNit7aO3y6syyIlHsEif5HamOr2hOU30XvpaxEcQPVax3p
         E7bJ1oe+76qF81rcWtVqbo3QeFUVcXxAw/w1u3dycXTUxebV6XoSY1JSdKQW8j0ON1lz
         9Mt8n0fjD2RvmUD5JELRRDbI+W6GjSl2b8Hn3iRtiaYAGLt33AcWcW1qPnjEoN7G29DJ
         2nD6brhbryzo6bDvKpIjJ5qmvukkiKclNPmkRFeWssksNhq2nlmSePbAnhd5vIF2IYs/
         DBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726549287; x=1727154087;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Azv/E4SskXb2z5dflyiez0I5gvUqp88E1PQupHH4fiA=;
        b=pAKwOue7cALYIm0n638ws+5sx/mtW/uxayKLClE0DiHf0GkCYrpupKFNWYHsqhdirK
         mx56UN1fuRdDVozP44iapB0xRxlwV69qlaP05NOw2z6uEm1mcd+cmyA3MDh6tatirjfA
         zbxnLS70cZ6rzYhpysBaBC+L5t1sJxMaTmtz7yaia7suCtk+zTqaap/0M6Q15uuvee+j
         1PLMbIvYj3DveL3lFNoGO9veYRN2uIIuLFDOfksSgH4XxdhEJSNW6JBL8SVIRIyjw3OC
         RqdEVDDr3PgUoXzUZEuFzk8CrZ8Ik/32+be2IgsM0C/Vxld3GZmRuTVl1y4rBjxHuhlK
         Xbzg==
X-Gm-Message-State: AOJu0YyTrWcd8DrxS7OMxsw8HScATgCGSKsijzP+TgkXB+r/x/AHHcxV
	zJF62akmNIVAwnwKMEcqnc/HXmWkskGnWtLAcwtcNh5Qo6cpjBICvirjOA==
X-Google-Smtp-Source: AGHT+IHNuuQqC/JPFo09qcMeowlIjqYwqY5Kj0H3Y0gBj20dYBeahMIJE3SwFY8Dmh2t9u2F0Hd6Iw==
X-Received: by 2002:a05:6214:328f:b0:6c3:669a:13b1 with SMTP id 6a1803df08f44-6c57e0b544dmr159277096d6.31.1726549287424;
        Mon, 16 Sep 2024 22:01:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.214.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c691eacsm30946136d6.75.2024.09.16.22.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:01:26 -0700 (PDT)
Message-ID: <66e90d26.050a0220.ee3e2.b2b7@mx.google.com>
Date: Mon, 16 Sep 2024 22:01:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9009036646236893280=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raj.khem@gmail.com
Subject: RE: [v2] mesh: Move local basename into utility file
In-Reply-To: <20240917031745.1641153-1-raj.khem@gmail.com>
References: <20240917031745.1641153-1-raj.khem@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9009036646236893280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890809

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      25.04 seconds
BluezMake                     PASS      1608.99 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      177.00 seconds
CheckValgrind                 PASS      250.78 seconds
CheckSmatch                   PASS      354.34 seconds
bluezmakeextell               PASS      120.50 seconds
IncrementalBuild              PASS      1397.43 seconds
ScanBuild                     PASS      990.54 seconds



---
Regards,
Linux Bluetooth


--===============9009036646236893280==--
