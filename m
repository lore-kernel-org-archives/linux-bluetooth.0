Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1492900A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405151; cv=none; b=r44sKZrL/KvZ6+TkRYj8kV8CeS6qRRLXi3qMik8CcZIkq2jMFJ+GhXssGUhtMFJz99dqs70dGMpH7heAOmUmfhk0/wAtOdhj2xErlB/Xw1YXWFD47gXN911MMddwPx+9mvGAms5a9YJzrbPdj1ViExSrxXgwwJkIJwkX75vRxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405151; c=relaxed/simple;
	bh=acju9wOl+r5ms/K42HGsYau5NsvARpEgCS71Pa+QNt4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SBRg4azwkaxwJ4WM6HS6oSHRLSA0CH8++FZQgcGwuGizb3well/SF2FXyGehLBV5FaKZrljS3BOT5n9qH9JLF0PIlexJTCWJWCE1oHveg8eSZ7ezWLlgj+Uab5ft62PFJ6TtRiLR8xXgUrPyB3QLbN5OcLsoPn89LvWD6EN7kIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZrCICsw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZrCICsw"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4774d68c670so33740171cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744405148; x=1745009948; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bJjbk0tQnY00sqA4Mh41EydBKwd8LgsVV7Xk7o0Bi6M=;
        b=fZrCICswkDr7vab/VxBMgWDqYD17foGtPBd2pSM5ZwxvZO4HXzgkEOOCefbbV/rDVs
         8EkTSTLagCncSNgvbHyLz154Z/F+fz3Jq9nnkvEPyZkIaFOu9qDBmOtdyq7qZspzmegJ
         JsmUP3L8jYRqFOdsfIPNLd81e/pJAmbSnkJXaXl2s/mFmhbL+pXnf19RMZ3NAxGXJ8rM
         u9pXYgOKKOmKGS0KUCjPdxNrx4oD+rWHCH3X8g6oOLh7iAE1iIblHHM9r0a3QuC7FnUl
         Cya7Hmb/48ljEfQT6jAw3oXxLdGflF87GGNWk2Nxzb1MQ6/s8UqnROkTgEodqW/nfpu9
         lyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744405148; x=1745009948;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJjbk0tQnY00sqA4Mh41EydBKwd8LgsVV7Xk7o0Bi6M=;
        b=GRW66/5WEkzv94+q4Kigdc5ZQH40IIqE9kEhgRkvF8h4yZ2W9TnYawrwCnjwozEeF9
         p91gFcTfoUpqVvmDm/eoIMDdcOe2Po8BYA7MHknG7eLX+rCMlAQQJUTHCh1lgrcVUsIa
         oSs6wwyLorAlRSe0CEaoSKGFjwsk68RpxnHA3GzW7FwV2xTnmKypPDyS/KIwBDrnb8V8
         PShqzHRla5xO9IYrCse/kg+XSaOsdSv4RsNz0F5dlwwsg763kvJaf24ztbfmGM0Nkjln
         W3dC9ZE6Yxo+BjuLP+xSMH2gnDtNH1hUREe/dxM3wMov6ovRjbGUsDXsCI4KGy1io6no
         G4rQ==
X-Gm-Message-State: AOJu0YxniLm8bWEmEZo5pS8BmV+tq+C9/5Gw+eY05jxc7X6H1a8i8Uf5
	gZIWNCtSVB2mJ0gsZf5zR7mejY6+RUeb5d8hFpd0zeCJspzAvXtH9hflXA==
X-Gm-Gg: ASbGncuHQU6XvVtcB8Oa7X0Yo64xfLjGbmiSiYIJgfG2aMMGRS6ee9nsOmdQ3xUamQe
	FFWFg686lm+efI85mbg4V43G9PJT4r0gfJsJvtlqtNLLeblM0uop2S+67aqte7ulNcPVZ23gEjr
	+6o4IVfG45dz2aqvndUy2GC/7M7bdg+rTgJa+VuGtH2GaVeLGjGyNoKwOr5F5QPD+1v3Ruk9gPR
	7ma/1njVCo7CLxJG6Hwcck3llxMQ4sXDNC5mIYVOjvVQfH+BE+Ns7VpayD0Qc3dnTdegCxO9rpA
	z/o/HEPKPoKu1359vEMvCMTLvd7JmOlfJTYVo2pLr3qN/9fGhQ==
X-Google-Smtp-Source: AGHT+IFTC2Q9JZHHLP0m1F9CWw+bdAqNQYBLSfMfbizruax4KSbgEtpJazYqigbtGlTgjzcZLyIu0Q==
X-Received: by 2002:a05:622a:1a85:b0:476:7327:383d with SMTP id d75a77b69052e-47977520acamr49470101cf.9.1744405148305;
        Fri, 11 Apr 2025 13:59:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.174.102])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2b4easm30629111cf.34.2025.04.11.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:59:07 -0700 (PDT)
Message-ID: <67f9829b.050a0220.27e946.8cef@mx.google.com>
Date: Fri, 11 Apr 2025 13:59:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7262252783390873519=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bap: Fix not setting SID for broadcast receiver
In-Reply-To: <20250411191442.51864-1-luiz.dentz@gmail.com>
References: <20250411191442.51864-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7262252783390873519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=952613

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      39.35 seconds
BluezMake                     PASS      2712.41 seconds
MakeCheck                     PASS      20.56 seconds
MakeDistcheck                 PASS      202.79 seconds
CheckValgrind                 PASS      275.20 seconds
CheckSmatch                   PASS      304.16 seconds
bluezmakeextell               PASS      128.34 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      912.80 seconds

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


--===============7262252783390873519==--
