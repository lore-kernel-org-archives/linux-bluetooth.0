Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B2144D3A
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331907; cv=none; b=Hmz6aMTZFgnGl79F3mb9kZEkii6g27hM6rbHDAgGWBDjIAteCpFP5tQe1e9k/FodAHzV4YxCO6R0YQuckq+lMaqVX8Txw6EzqJiXYB7PGZNtBGGHlM5hmRwY+KR8dLwADUZ+hVT99xw7rzY6yAces4qq4ehFgxCy4lOFAm+eRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331907; c=relaxed/simple;
	bh=ab1t+OnBQ6L0cF7I2qlpohbMP/kl2+7OBWAuyrAlUB8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XqKYxeyx+olB/loKAHuOsw+BNpxv70i6Se8NU2IqcQh4D+je5h2la/DbSsLMRW3cPsbBzTg2RrNHuZqDdg9A/zdI65Y56TQ7M2bOKOHaMVKKAraRn63LNmOfxIZfPJdIPASrUH5XpxjMMVe3Aof7jhnthdBKMSGvykkJ88VeC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiQp1IFU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiQp1IFU"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79f1be45ca8so43709885a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721331904; x=1721936704; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3s4Fw7C4Q7m/ogt65Q7YLzFcxHdS12+pj/ALPRN6yaw=;
        b=KiQp1IFUjMdojcT4BFzM74Klld//+Wq/zA3rm4n34r249NFgIEdcGQWioLa40ogN+X
         ++dKg/UuHQ+TXHAfhzWh2x6Kg7mGF/skQCznXtcdUdEl56sRVpdOi0Hk3pTZbZqcn2Tc
         U3ZtuSRaiD+QNtAWHkQbiVxdK71YQPQlnzvkh9Ciy49rVokLC1KFUsJmJANK49AwrZE1
         XRMwfVzURa/9QDTtPzt4UU3HAh88OqXgy/oKhhi58Ide2v5sh6v2Qwxb1x00/pXjfp8d
         wwuBI2fpu962MtYSwkju+p5fGTY7QWWcrt78rTEJFp2svVBfw3jALpJix0cT6z1m8N4q
         jHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331904; x=1721936704;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s4Fw7C4Q7m/ogt65Q7YLzFcxHdS12+pj/ALPRN6yaw=;
        b=MynoMWSeLBdENTVq3ocmrYi2zV4yKqXu48+pAocL9iCJfQUNtqp7ORTiGO7oCr82MD
         LpnW6jlL2EFmwB1g8PHitEGJk8w9COX0fqsZKi9RuOd7308IS8qr7Tg59dlBUSR91/hS
         tEZx7a2lksJRVktjlhG0TbUO/Ua4gxqIOfjjF+VaxQqEL6hlptnKuQdIqJMuv6sMpFyw
         D58UQ6PbI7zM4oStA4bF0rYOL7AcjitcnHoA8V/CmVlTJ5djUOsv35rizVD0zwtY46+j
         1FWWTTtpq452f+JCr24dAIZALP2Npbzh1FlFNVUPvTzzkhHMmlRsQIAMl1XrLnZXTcfp
         xpZQ==
X-Gm-Message-State: AOJu0YyIUsMl/ypc3bJ6PS8comQMppwPP/LXgdRgZfebaRD9YfWXS8um
	6xAeOFVXfVWzOnEj7FceweCxenYaWue24x5aeSsBqDlIbWk4O3ICso1J3g==
X-Google-Smtp-Source: AGHT+IG2ZT0GQGFi4Q4IS9XxIG7Il3pCO0kFvrieklwNjMD/h4ednlv6TD37X4MV7/aKKXiXlVadew==
X-Received: by 2002:a05:620a:8003:b0:79f:17cb:7046 with SMTP id af79cd13be357-7a187518577mr658327285a.69.1721331904331;
        Thu, 18 Jul 2024 12:45:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f96a9e7cfsm5693261cf.70.2024.07.18.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:45:04 -0700 (PDT)
Message-ID: <669970c0.050a0220.33243.30a4@mx.google.com>
Date: Thu, 18 Jul 2024 12:45:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3907768561246143132=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Add support for name custom presets
In-Reply-To: <20240718180059.1159551-1-luiz.dentz@gmail.com>
References: <20240718180059.1159551-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3907768561246143132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872319

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      1662.29 seconds
MakeCheck                     PASS      13.43 seconds
MakeDistcheck                 PASS      181.53 seconds
CheckValgrind                 PASS      252.94 seconds
CheckSmatch                   PASS      355.44 seconds
bluezmakeextell               PASS      120.76 seconds
IncrementalBuild              PASS      1425.15 seconds
ScanBuild                     PASS      1009.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] client/player: Add support for name custom presets
WARNING:TYPO_SPELLING: 'overwriten' may be misspelled - perhaps 'overwritten'?
#92: 
just one "custom" codec preset which needs to be overwriten everytime
                                                 ^^^^^^^^^^

/github/workspace/src/src/13736628.patch total: 0 errors, 1 warnings, 223 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13736628.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3907768561246143132==--
