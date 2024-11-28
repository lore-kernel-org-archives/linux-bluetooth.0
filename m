Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF424145A11
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785407; cv=none; b=fVHvC8H27qhh1Xe/33/I7fj/1jZn3uUjrvC4t/EWO0OL1f7iiuVvxi7n7z72nXgQQxGOnYDmtGAkypf8XySZmFTQDccegQBePYgHK9O+PDcd3XWKTDc4s5ANjYN2Xsqj8h+tMoAAh0z1yyXK0lVJkRMTE21xWXcZrLIn5FcuWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785407; c=relaxed/simple;
	bh=eJK3WoSkzyVDHOfWfU8Q61pjPsI7IhKgOt/rJMI4bLY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EYzHhdOrUhQkSmb6eeVvQqC3wNVbk+LpTp2DIjbPC+NHHJz1CcQO4wjm0iXjor/lmRrFNYussrVaCrCPBfr7492nWby3VKZ2S1Z+YJLgn8Q7phrvMOGvlc72/GHcr4fNK2/d0qP5e3SQFV0aRnNwm9zNvaHghaQKytd9K/QUB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErYkIAED; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErYkIAED"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84ff43e87cbso196263241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732785404; x=1733390204; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lkUgK7s82Y18HoqfEbJ39DQzDNNVEvBtKdq02sU4H60=;
        b=ErYkIAEDVgM+qbUqW+b5Zka5q8L5NPG6CMuS609u0eHgDSaRSlkkPO9lT3XG1ku7Tr
         JqvtDMQUaOydurC6/cgLo89HrS2NSCw7kSLJWcXmMxjdIDJv/sbX7eByjrs7YBBMbb/P
         Pva0ysYuDcG7XYJJNRiyEbVHgg8/3blkIbKhGoZ8AX7gk6ERZQzkntFLLC6+Uq6NBD2K
         jGTgikzri/zkGN3OJZE1KGQJyzgPwP0wK2E4byj3saLexlsQepyxFEAl4lmgjz7ZdM7Y
         rswpee4MCaTn7mzdFT0EmOr6wLzTr9Af/oEAxb0QaxNe87ZVCqWOU1STQnQ7tzsPMI/n
         EDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732785404; x=1733390204;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkUgK7s82Y18HoqfEbJ39DQzDNNVEvBtKdq02sU4H60=;
        b=kKISgN9eX4gXRLopcN/3JoyStBUyBuanh/W5XuvaSXLUWZtvyVn4JSn2vQCRRsqW5O
         5drYn+MaXukWgm5TijTL21A/rz+gCNH6KPOsp4KeVo4AjDSOC2MXYzJdfau33xnez8jf
         w7CtG9OubE1hYd5uTLk8npYYDAKkge++mqKdoW9ISvj5PklWZvgPb/eN0vd2h+VitrTG
         jP5BnAuMcI37fuDtYRR4WA4p/6wgdhR+0wHxDQyA48MuE2JxrrliNictz7p45QbCtq2E
         RRqdfVPbEs3vR2WNbtM2yZowzQCJ7avca9dvz8DNGo5ETTGAGRfaPIiRGnFnFgHcAQfF
         dK/Q==
X-Gm-Message-State: AOJu0YzkDwtBBfJBAy9v+83Pekfq/Gw2kFxepmVdb/7BLdZVczOtJLtB
	1ACSpSTKIoIAqYASVa6FcjgkRirHkfwoSHoVg4G3C5s5x8RTxcLnDtJ2GA==
X-Gm-Gg: ASbGncu+m6kNHeEvNEJa5aECdKfr+Ym9sSK/3o9YK4R9inOzC/U/5g1TQ9b+hzwQ/qJ
	VL0KWS2GKh5w/8JVIXy8z+qDz18SShj50gJvGI/7VwM27DzRGEudV4b25Uk7uVbULV6FFaPRK9B
	mkgeXcUBSzK7G3Arqq329w7E/+H3U42fpFT4JqUtNCdr//iF6NsA8fGOyuQu7mdgANcMKYFcOKP
	kYY50NaGrm8O/bdrPcBIwZGgkHRCYCzDod2QjhSQM6tVFVI2RaLiQ==
X-Google-Smtp-Source: AGHT+IHzz46HQUFXkKxMDZ3Bxq0DOQTmNkp7As0iC2hFcGLPoXm5mLmG4/9ijUCBOqxqz10kVOC+6w==
X-Received: by 2002:a05:6102:94c:b0:4ad:4edc:3b6d with SMTP id ada2fe7eead31-4af44a34246mr8497681137.19.1732785404552;
        Thu, 28 Nov 2024 01:16:44 -0800 (PST)
Received: from [172.17.0.2] ([20.55.47.61])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4054c82sm4625751cf.7.2024.11.28.01.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:16:44 -0800 (PST)
Message-ID: <674834fc.c80a0220.18c168.1280@mx.google.com>
Date: Thu, 28 Nov 2024 01:16:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7787736623365285869=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v2] BNEP: Fix the BNEP Unknown Control Message in PTS testing
In-Reply-To: <20241128074558.3195554-1-quic_shuaz@quicinc.com>
References: <20241128074558.3195554-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7787736623365285869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=913009

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.61 seconds
BluezMake                     PASS      1573.75 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      159.69 seconds
CheckValgrind                 PASS      215.72 seconds
CheckSmatch                   PASS      276.17 seconds
bluezmakeextell               PASS      100.87 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      850.99 seconds

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


--===============7787736623365285869==--
