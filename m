Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3E4DBD69
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204029; cv=none; b=Gp0s/Cd55c583hBP/5eWe+zAdy2nngiWDQ7nNbGyM5dgXuGvMiLfIc6YrPWgRLgtsmXnTJnkvl5pQoTpi5BoG5o1OaXU0RbLvVkSLNnyZVQQIEB4V/MaHqpcl5CqpKN57pCbQG7PXypJnNaebAD4ZsL+9vbnhZNZoHD+CWvoe/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204029; c=relaxed/simple;
	bh=k8KEjAhcQZN7jQSAMHgKHMAZt8bt0qzQp/gsmoI6Nwo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nr7qjXfJPmwJQZYFwUOFEkJFkXvc5fCxV2qXQcjSBoVUuER4ug8vo/o/GX0Gp5gYJ5DNrE6ib57FgLGXTkN6r7+GKzZFSdDLeDbVCwvnrF7Kmj4WlFsr31isSeFRspgNg+BKV5ssgle2HFugBkZ+jAAaVVVLNFJVscQ5ZT2JVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKXCHfV5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKXCHfV5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9157b895c57so18616885a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781204024; x=1781808824; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t20/t/UE0SB7ZNKITbFID3bMSuXvNm74HS188ZT+11s=;
        b=EKXCHfV54jRNvbIH7dza+BSuuJ80dou70Qx3MtRZiTYAWByFYQTgOwKPSihTRfHpmQ
         fDrUdUnkC7gLmf/jasKa8hLbhrgrMKixHpkSJuYEy77cIxr7s68rCkh5PiBZc67crjyA
         mNjr+jyl4PmgexT+bGR1X/cJPUWztdChhs2B5UTObCyLSqqmIkGzB0jj6PZAPD6K5LyK
         j2EQFbkBDla1OZitqUHHa5B0Gfg62gUsSRvRkT3EYNnlkIQQJMlDtMMfMRzxBQTdOujY
         ja9NJ1lXyGxjGw0ig/8jBFp/uNHLjo6hml+EPtoKSR2K9NJ62L6lF1eG8/lLL0NgrVXk
         IvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781204024; x=1781808824;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t20/t/UE0SB7ZNKITbFID3bMSuXvNm74HS188ZT+11s=;
        b=P6HuZvvFMOpnbUxzoDXofUns9BAqPD4ehoE/hjlqFy04HPws0wv6MY5+L6qagRzwTU
         Vais7+a/PVopD7TqMnR6NtwraTIAPVH+lJVPIxOAM+qc62Dg05IPXd6A0QYdIqIEMUiZ
         zSWzgPgvC4nDGQwAUv8GHEvQsN8f4h1W2MgYEAE7udWSwSDgMDwBzRdUmOmw91cjniFG
         eF5QEdujedONKRghj19WFYi09X/jW1N714ntyiEnsIFMGjgnQU+aHmbMs9hZ4w4C5ZUb
         j103RdqkjdqAfToESw+CiIYoVuodHYhkXLEB7JiLYvChykZtTrJH6dD1e+r8Uv4YyBBY
         +L6A==
X-Gm-Message-State: AOJu0YzBswruD12UjMGzP5aRbS2x/h/68Qd+1OGzymeVeSdg1A5rA0Hi
	lc6Bec/J6QYi7lKVAUCdGPl97STjHqVIthEXHLn3EGDaEC5YezqV+/9+HSvKMw==
X-Gm-Gg: Acq92OFZ48iDv7IoxdzB0Pk58HrAXacJTejTaZux9pVLHuLwUh7ZjdRvVEom0B4+Q1A
	yKxMjGmQLmXnzBXPKcRcVpyZ28LeOT++FWAvzyv74EoDGfMbDY5ttY2e65Bz5YuOH819ziYKOdY
	ZtF4aqX/VEuWeP17HNCw80OexvhoDaUKNhoS9XeXqiycIUFW91+wiH1E8J0x3xBkFUg1Xu8+nj1
	CqIuxf516UNWDtsrr1g48mJ8Q8y4hB1S5txRNRmGwnREZ2wPzZK0swRfBQoVbDuFj+J63q1Z1QJ
	ZkKJKY+hdiRY7WMNEsEzWAhnERasGhkcn9udZieGhsdL5dKvNVQP5nSF0hfa8qzHo9FJO7JS12j
	3jtoN5b0dGktqVOwWhI7OfifO+PFuTFJ0d8U05qQUaGnk3ZST2rUThdVIV3MheHwnFfDcJLoKCK
	TmdCBXGMx6x19+/9M8SgBKbUZO4uaXeg==
X-Received: by 2002:a05:620a:4626:b0:914:e3dd:17ea with SMTP id af79cd13be357-9160aaefc21mr645910085a.12.1781204024410;
        Thu, 11 Jun 2026 11:53:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.210.0.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160accb383sm264037685a.18.2026.06.11.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:53:44 -0700 (PDT)
Message-ID: <6a2b0438.a4791f72.5925a.516d@mx.google.com>
Date: Thu, 11 Jun 2026 11:53:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3686824111312672530=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] profiles/audio/bass: Use BASS_Modify_Source when assistant is active
In-Reply-To: <20260611172235.92930-1-luiz.dentz@gmail.com>
References: <20260611172235.92930-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3686824111312672530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110215

---Test result---

Test Summary:
CheckPatch                    PASS      2.09 seconds
GitLint                       FAIL      1.33 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      674.75 seconds
MakeCheck                     PASS      18.45 seconds
MakeDistcheck                 PASS      253.93 seconds
CheckValgrind                 PASS      297.55 seconds
CheckSmatch                   PASS      354.26 seconds
bluezmakeextell               PASS      184.12 seconds
IncrementalBuild              PASS      688.14 seconds
ScanBuild                     PASS      1047.70 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/4] profiles/audio/bass: Use BASS_Modify_Source when assistant is active

1: T1 Title exceeds max length (83>80): "[BlueZ,v1,1/4] profiles/audio/bass: Use BASS_Modify_Source when assistant is active"


https://github.com/bluez/bluez/pull/2218

---
Regards,
Linux Bluetooth


--===============3686824111312672530==--
