Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013C21C17D
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616440; cv=none; b=Vsw95X4EdvD97zWJHMzEsqgbNjVDYoRG2pZLnrNEgVw/FWuC12TBXME8qvFOCV114Kwc0ldSgK0+wtrrtQ1hmIY/QzTifOHBndViA9d+jGJz8OU8WQeu8I31HkQS6vrm7B4EmI88SCqBoqUiK7EAEoxkuNiLC37WPYdzVJWBM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616440; c=relaxed/simple;
	bh=H8LND1oRQx9u+9qSdrLAbypkNtU0RInN7PJ8JwU0xjE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tWoFzsUvKMQSGxx4Xk9BhMxTDMRD5kBzFvtHRSeI5Vkoya4vmy3MR2kjplrkmvU+MATCo9M/mdz+Me/CkOgbvDJYRv44KW/nxw+s5uuXT+Q1v1wJ1u15uD5IS3ZH0vf2Da3E05xX4Pd0sEq7pZQdy853Xe9ix90a3LjFBlvJMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwAh83lq; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwAh83lq"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed82e82f0fso37477341cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Dec 2025 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764616437; x=1765221237; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IcPdif2iPm66Co2w/uECvzV+qnD2fBwsoy/LhMCigC4=;
        b=jwAh83lqASU6u1wvOylyf+tJAugMYtR6ZY9q1jNagmcToml9jifHiFiKhZSTy9M3RA
         xsz80tuVzY6h4ZxmUKFzs/+XncuUtmuu6ohoMYjwq5M2PYPhDPpFnmc3jbaRUKaYpdT6
         NnQRclNiXfO89iryLSBrZgqdro7kqIggQ/jJORhc5XgrvHva/rxkb/yW2bHutUxxjCr+
         vAJeb/CHxXuEKM3s8PlpQFBcfcFXDByNLBvqHsKPEccM4U2h6jAC5LJY18Mrc7eEdv7K
         aHHbCJ6h9TC+OsrlllIk6YivFBCCGiyRm8cApwIggom/xRdre9VJcbZLsNNQ3K5a8Ov4
         c2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616437; x=1765221237;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcPdif2iPm66Co2w/uECvzV+qnD2fBwsoy/LhMCigC4=;
        b=Y/2n/AqjIPBKx69pm9ROhaLyyDEUfyB97mnUPHzu9cxCprWc6/WCU/bwoA522ihxnq
         wUc43eE4yXIkGnBhg98tCrzgz+4NPDOD3YJsxRG/JhOs5Aprwk1R5ApSmNc11MhtJw8j
         SgMqQs8BK5rTcAfGr5mre6mXpn9FKjOJmy0J9Zsq8C19dvzNYQdBW0+yhJn1kjHLcu9Y
         vGGqO8svwP94ajFjmmXr3hO96f8dgsydeGNQlg4T7nr4F0dxbK15+tUHRdkWO0Uwywxy
         f9VND2Ihf7hxwDC1OxyX91GkDCORwNli4Dd3hm3Ogner67ZNFCE0If7DZOWK+JguwaHR
         25Jg==
X-Gm-Message-State: AOJu0YxPp0OHIIIRdzaH3GMOu5t9XQEFprX3FpduAeKMiRIeYWpIjqt+
	s7OqqUJbjKbM5jd9xyq67Iot4yj5eSDUD5S702MbnM19oEjjX+8vXRe5LE9BXQ==
X-Gm-Gg: ASbGnctnAqTseRWLyRlYTg5ahdfrt4tOXdA3335aBY43Lme4PhXJf1aXdDDXhERGx58
	6f0eZHtpP90sP32vkm1tsWQL+SqqSr9EIjgfIrgood6WfuAokiGe45ndoUGagPopMXhBaKFQTmV
	mLULs3jqKZ5RelW/B9yYr65//9u37HeV4BiWaWeV9FRKOrmIGXYv6wEl8nmyvz5u9cwARv6FI9I
	tOH68ltzdfugNPsirInemSYfJ05Ah4Lf1lLSQ6RZGJ3Po2iURG9IkiGIcPnBUdwRNV3kd0GfwBZ
	gEuJCo9iMDo1/I6exsjhRfxeQkL51vwNkz5d3CayKMOF6LfyXmYOKz1tHC3gwJ60M1zwrrnF3NC
	+mzZGfbU/tn5nxGNowvkWwleFkKkQfVRWilDlJZ3QluRx7vvJwmvgkWTHr92+j8rlKT4jv6R8OI
	6rigzyrCxyzBpk1fWXqUk=
X-Google-Smtp-Source: AGHT+IElQFDoBeXhYR2cajyLRqQ14h/5xzbbHFgDg6XfKec+jH/eioeAM4SZKRrLKO7q257vUvKLng==
X-Received: by 2002:a05:622a:2d5:b0:4ee:16a8:dd0 with SMTP id d75a77b69052e-4ee58911609mr645834851cf.53.1764616437316;
        Mon, 01 Dec 2025 11:13:57 -0800 (PST)
Received: from [172.17.0.2] ([172.183.134.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd2fbb8a4sm79049951cf.8.2025.12.01.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 11:13:56 -0800 (PST)
Message-ID: <692de8f4.c80a0220.23ef30.681b@mx.google.com>
Date: Mon, 01 Dec 2025 11:13:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4638654512173999352=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Print MediaEndpoint.SupportedFeatures
In-Reply-To: <20251201180608.168392-1-luiz.dentz@gmail.com>
References: <20251201180608.168392-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4638654512173999352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1029386

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      17.69 seconds
BluezMake                     PASS      620.11 seconds
MakeCheck                     PASS      22.10 seconds
MakeDistcheck                 PASS      219.13 seconds
CheckValgrind                 PASS      285.89 seconds
CheckSmatch                   PASS      310.12 seconds
bluezmakeextell               PASS      168.26 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      902.11 seconds

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


--===============4638654512173999352==--
