Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76A1459FA
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333933; cv=none; b=MWeuuU/8zE1v9EybotVByGMr7US8xJvwXgIwtWeFlFddFiCTsgdmqq3uyUMMNMdOVo9iszkt80qdtjZAd4tHvqoQR0KzAKz4n6GNfKCMks+YUnBD4estehrEzsoOnQulRnvwk5U15Mk9eSZYR6pVSrkHRaAXAuFL7mZWCHNtsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333933; c=relaxed/simple;
	bh=2lUMZaHdlqAgCubhr8f9wSJcKvg/yVpVgldsKOao2Ko=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jGzOTzBf1vOgpLEl8EpNkvRgJjCqExfgxwoYOdHscOHA4CF5f7hEtcbgT8cQe6rMzBRYMr4btavO4rrffrRLZaIYYZ8Y0mnRoftK/gJtHMoRUSP0GKFa7Gz5W/PlziqCAFBiVdpKQ671CyrXcscpgn0Ebyo4mw2/Lvb4P1taWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9KT4q+j; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9KT4q+j"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-859b2ec0556so925785a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 08:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759333930; x=1759938730; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m2GfdRj4jdruWCkPh14FwGNHuyOJyGsyXhf7OfOGgmw=;
        b=O9KT4q+jbeHQukhwsQ/69g3JOiML6jgJ5kCjJTkmUKKpfmN6Laj4Ww/iTSEnzR6ey0
         zOX4fdfftPH+nHyqK9FmwRDpg52ProSb4fUa1ifrfBOB7wO6Jgt9q0BSnKZ7/NFv3UId
         SnicFON4aQ4Sin8o0Q5EVZCVTazfaIOBmqXXPpMfVe+WumPNxmdK/bHTN1UnKbn4wFwq
         rCfz3fKtl9Y8qPwCzj4RsroFDnszdgR06T+gZ0v27ixCgIzlI4COEzjQ0ydittMVAue2
         Ucf1mCS5kOtJKmqW2184+/DfUV4woCG60r2gFrtsnDYZyDQuG04RkkxLNdiz1GkGS15G
         Ks+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759333930; x=1759938730;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2GfdRj4jdruWCkPh14FwGNHuyOJyGsyXhf7OfOGgmw=;
        b=HI3Zr3uHbsv1zlY06FoZq9c46tUcdFVCXb0s+q+KKQV+kWXw4r997or0fk2D1/gDwu
         oTY0BSsDBJeD1zLdKcdR70wIsa63Kc6TeVmTJz9Jw1/e3DPTE83yt+k5VmxmFBaiSt/c
         YjzT1unB8/74n0lm7TLfyVpbCQ7Oa32iYlCOK+r0zJtU3TFjC/FZ4HbwHgG+RqiELZCF
         lofja2ko5UcfiXhHLezaDBM1qSNaAYjCXouj5Anm7i16au3/tebB6PRTu2pxxrf/N4HJ
         JA9JWN3mth4hR29U/du7STjzev1qWRA61At8lpWwOQlWbJpfXF6Lbxrds0/18p7M2J+6
         cfzQ==
X-Gm-Message-State: AOJu0YxBB39FImQ5+k1mSpZStYJRF/m0lgLGYgLDiHSHGlo2oX+O8IE/
	imRCvG5vLGK3mo6Aze4wyGXJKKTPifqlD1caxSkuwUYKwiZbGSs/bjI6dZOv7/dJ
X-Gm-Gg: ASbGncvq3jpmQUOqksbY82WRcRJk/mUfyYuyTtVhx0iFJ5JOrwmVjeZGlObYhxm2keM
	pt4Ft4+X+fkyhnLDgzuKylFpYTNUBMEAbG+fKKSULZDv25VY2u3VR+l5+MetDEVVSQNqDikuqG0
	HQuG3bJ4dlZMwCTxvy1Y2zwhGjpA7OzU3kD2K3dS0WVvgilgp13BskMoe7FTMvVgp8bvuQEnC1x
	AuUgkccH6qg1tOnD7kfh/UN3u6XFTgpd45Gfx71EYK8BhT15ZnCOwjBzQ6VrqxAh1UJ0eZ8D5Gy
	Ui/RsFAhPgSZbg0q5dDcLjr1w9N0Z7i4piGyckz/Af649wAHOOekBTv2bCVdMyhl/gTMGC+kxkX
	vAVpxiTOV8uWdeqo3991HbreKdpznet+X9aZ0jJdoe9mj76taDKY=
X-Google-Smtp-Source: AGHT+IEHLE/COjbtU0AJmiChljD9zeKzyPIc7qtz9lrzS0gckd3LvEX452TqEAPK4sw/T2VHLDw6Hg==
X-Received: by 2002:a05:620a:462a:b0:850:8afd:f715 with SMTP id af79cd13be357-8737780bafcmr585950585a.72.1759333930374;
        Wed, 01 Oct 2025 08:52:10 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.53.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877725550b3sm1544685a.26.2025.10.01.08.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:52:09 -0700 (PDT)
Message-ID: <68dd4e29.050a0220.3a25d8.0120@mx.google.com>
Date: Wed, 01 Oct 2025 08:52:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5012294263778232377=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] device: Fix privacy
In-Reply-To: <20251001142738.17892-1-luiz.dentz@gmail.com>
References: <20251001142738.17892-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5012294263778232377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1007714

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      2698.94 seconds
MakeCheck                     PASS      20.72 seconds
MakeDistcheck                 PASS      186.51 seconds
CheckValgrind                 PASS      238.73 seconds
CheckSmatch                   PASS      309.40 seconds
bluezmakeextell               PASS      129.61 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      919.45 seconds

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


--===============5012294263778232377==--
