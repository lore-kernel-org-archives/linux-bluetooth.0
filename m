Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0EF1E5B72
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426419; cv=none; b=ClhWxZDWJCuRDObbxVy0/YQQ+jGGbK+h9SDkqu+BZcZobb2hiz5Fwaa65Jt8CvT+HsxUsIUTg9Pl+XL81StP3jMqO1hGlfKuUpyYWC24uOzHrtnjYbLRGtIEwtL6P1izQRMHjYujHeQ9Bdc94irKM6EeoO8GCkQmvaL6Cgfy0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426419; c=relaxed/simple;
	bh=+dtR6cSbS86xYnRd9gdI3xKB5gJdmQ6tfbSU/uMMpjs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eU54CNHl5D673diKe4bsjsVAQav0OListEEfDcmxNNCHKZ71PWnsUN2omx8MXaggd5hvfNS4PANa2zwT7zHuJN/htVgBG6dEzFdCMk/QiJe0SOvtSx9z/lpYPoJE3xWwz1+XE+tuOOZuNRisWVx9W5OZBT1YNsPShHSRUB3ehzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5EpuX9i; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5EpuX9i"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109c6b9fcso14036121cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759426417; x=1760031217; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CgcONycec1Upc2YFKqbnrUdR9mfN8pBck1EgWHbbAAc=;
        b=H5EpuX9i2RaI8/VXllTUBefMnpObMGSJeHzxsLLGCMNRoQX4/nTG5ZGZcX75aGLpz5
         AeSXTeDxefOvuEVYB8WOnZyPZM5sGcVtWv4N/OR6VREt5xRTdvkzHcwfVAFyfISL3Wli
         L79enHA+4RPpOf/A6ie//DTn7+zMABxy3CQ1VXZWTNDYxvVan5BSbS6xe8J703UPVxWf
         fJZRonfBfW3ws7ws8hZPgDrlHQCOoUcUiOtJE7VzRinL46CEcXfgND4kDkTO/ExclbS7
         eUJ6HklXUGT23EjgrKwR9F7oPWU3dBAkt/0youQob/RXwf4NwY/oixf+hDB0PLxs4O27
         HfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759426417; x=1760031217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgcONycec1Upc2YFKqbnrUdR9mfN8pBck1EgWHbbAAc=;
        b=Hi6vlp3mBlg4kHDKhdA6tv2zcqB9Yk6uwZ03tlCNFIh0wv8zcy7UuR+55y3flHtiwF
         bBMeRVKS+/4T9zXODYHKqMOqQTCDfNGxKt3ClvHHsusNDIe5rgLo0rGd+51Kl6PLrgT5
         2Gl23w4B3xYwvY79ExnsPyMDHiBH70RHDRQ8naxvnfTfpmaRhOXXyxtg6h9+fJE37V2p
         Kqf/M+hANdRApZmesLzyewmT8HgegnbCSys4eaSlY1v9qwAhZ+Y7lk4pOy6DI0OZA8H4
         mPE/GofwrkTY8Enr84YXGFKnCTUCap1jtzjUDb7pEmN6ihtA3OT+7KwUb+Xh8zdRiTNl
         sASg==
X-Gm-Message-State: AOJu0YzpqoEEPm5f9a8KGcv0Jusl1PV854vHIcOH00OH+h8FBlkowqrL
	DclA1JbQEJo4jKq+E1OOdw6vukLC9pOemg/PO2YYdx8qhBbXQJQvcUIzv7PwsQ==
X-Gm-Gg: ASbGnct365HODQXmeU6jVwsGTP8eMvD1KlDSNWQ7VwufnSgDgCcJzMZWnV3FwvSqafs
	62C5zTEVBO6gLaluYnIxtwyCRBuJFyfLIUiVeYdaN1+pf2t7yOCZ9GC/JRHN86M1nK769ptLg1t
	Lb7eGxAPW6WQZ49+7Sv5x8vEZIlriTqcckaE1tsiNRc5GlL+u/eGwZ7gJO0AJ9YDNSj856vv6aD
	ATYOq5t5ICAnrQXk+PDLFxEJ4dhJkGw3e3rIdKxH0AlYAKHzvrDmtbE6v69jhc5HNno2M37Gvdn
	qC10oVakYqSPGIuYQIm/s2ofm0PQGDkRMVPXdLv++1U9XgMjTov9Rq13cr5DcwtdzvjwEeBmOvv
	Tm7tk2/e1j0N8kwxxnxBvRRppp9DAzBxs1fPJk0255aeZCMDiGw==
X-Google-Smtp-Source: AGHT+IF3yzuKuK3RWJqG9kPgUZkxG/WwjGwx9jcz46b1HzEKHyqAT0MfiAXbnyivdcgaRS/ia1VYZQ==
X-Received: by 2002:a05:622a:4813:b0:4dd:e207:fd0 with SMTP id d75a77b69052e-4e576b21f42mr1500681cf.74.1759426416744;
        Thu, 02 Oct 2025 10:33:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.61.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877796a23e4sm246080685a.48.2025.10.02.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:33:36 -0700 (PDT)
Message-ID: <68deb770.050a0220.330556.7987@mx.google.com>
Date: Thu, 02 Oct 2025 10:33:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1874874846762887286=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/2] shared/bass: Fix permissions not requiring encryption
In-Reply-To: <20251002155855.241787-1-luiz.dentz@gmail.com>
References: <20251002155855.241787-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1874874846762887286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1008056

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      2776.52 seconds
MakeCheck                     PASS      20.47 seconds
MakeDistcheck                 PASS      188.77 seconds
CheckValgrind                 PASS      242.47 seconds
CheckSmatch                   PASS      311.37 seconds
bluezmakeextell               PASS      129.77 seconds
IncrementalBuild              PENDING   0.20 seconds
ScanBuild                     PASS      929.69 seconds

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


--===============1874874846762887286==--
