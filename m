Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2D148853
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177201; cv=none; b=aIbKk3LAYKQjtfADYqR5V1bZMksKE9yfR3sZGYgGh4t2cXHNWwXVXtMzvWkZEdwAIJsAEeJSSBfQBheaZmWATbTivhj8PSYpXOWxQ/RaTQGLbqGDC8UxlBEFDNP72ggXRRTUYSoaF3gRI24vgZf2Ax/gYPLAMBa3IfPWbTST4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177201; c=relaxed/simple;
	bh=/5SZ6MPT14iOfzr085lJa1tNNbpZeS4CAjh5aCQFr3o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kl9jOkwZdDV0FsiYMbOkFP+TofHqR+tHRLmX5AI26pb0c27iev5kXX822Zygdwhdu8riplyJhQG5OJ3MJVabb38msDB044DLXHt2Zt+bT5EFaHcY43uJkDoUEMMakKK6ucyg7+39FbttmvrK4iPpBzSzWhm/aP+bzbf9/FWPUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjeJ23ua; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjeJ23ua"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-710437d0affso911044a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720177199; x=1720781999; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2omAoe25Sghkev0sw58NGmQ1djRBqLSusXEEqc18yNY=;
        b=SjeJ23uaXwWXjEeYNofOmZuaPaByPCpwqtm4Y/GLTaaOnpM2LK3yMFNHi35vlqiJZP
         uuiYzLbfRtLmwnxU/DuXne0X7KE3N3lksZztCgaOlwe/ZiefLf5Ek/W/uNH//i6SDHYP
         dZqLiYcTTmgNe0yJZ40HzhIkDURJArMkesAOAQK/NpejB+YSKBQVNJqGrdrtPMcGRbdX
         nujgLp27ao/gz3HuWHXewP17z7aubUez0TluvYxZWlVFROOCUltFmTtjaTRunDSEdSzw
         S/2pSNbWovlWC8/5boMo5hWcTSWJPd2wxXnVy5oX82Ulnle+oDV/u2amQqz4AkDbQ1z0
         FOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720177199; x=1720781999;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2omAoe25Sghkev0sw58NGmQ1djRBqLSusXEEqc18yNY=;
        b=KwlcNVmCHoZ78y3SZu5Co3TWBqHkZLl3AixwOpC5scSddfNVh+C7OjPLU1L1mH8Rxl
         scWFvt16xyeF6GBGjOJp4B74H/Ld8wuCOpKvVDdGmQXxBA3ulSYGlrcd1JPsSd0Ybb4B
         QlAim16xjqDb9+LZdyV2Ch7RztvvXEtsWiwps2wn9/shQbBjU/la22rb8KCJxzW5kGH9
         p+/xSs0HO6++Tq8jly074VExStmoAqyZrN39QB4EVEiBZrZOxCGiByb1Mc+OZwfv8eHF
         brScWvyrKttf9XUZ+Lrwro8UViNopMORFwQky0A0l6f166kEJLMimarotrN3Y2WIAt9P
         luTw==
X-Gm-Message-State: AOJu0Yzm3/aAGUF/ijDFhdFQ2uRU9YptMY0vlE5BZGwchHrlLHFKQvcT
	z3YRhRvhqi/Qbny5f/6fTqNGnRbeLMlntYZz55vs1mFYJj3yBod0xjECmg==
X-Google-Smtp-Source: AGHT+IFZ3WICeLqMc0AQ09B3pys1Js7Bq8KwxXh65Vhj+JSIBu0SnlcEdteMX4gTufTp2Zy5O5/ejg==
X-Received: by 2002:a05:6a21:33a7:b0:1be:ccb7:7b14 with SMTP id adf61e73a8af0-1c0cc8d518emr4305789637.40.1720177199243;
        Fri, 05 Jul 2024 03:59:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.7.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a968c22sm3110449a91.23.2024.07.05.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:59:59 -0700 (PDT)
Message-ID: <6687d22f.170a0220.6f776.7750@mx.google.com>
Date: Fri, 05 Jul 2024 03:59:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5408963366340039874=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel: Add support for BlazarU core
In-Reply-To: <20240705102923.3512817-1-kiran.k@intel.com>
References: <20240705102923.3512817-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5408963366340039874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868747

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      29.40 seconds
CheckAllWarning               PASS      31.70 seconds
CheckSparse                   PASS      37.64 seconds
CheckSmatch                   PASS      102.21 seconds
BuildKernel32                 PASS      28.33 seconds
TestRunnerSetup               PASS      518.51 seconds
TestRunner_l2cap-tester       PASS      21.85 seconds
TestRunner_iso-tester         PASS      36.72 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      108.34 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.81 seconds
TestRunner_mesh-tester        PASS      7.87 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      32.68 seconds



---
Regards,
Linux Bluetooth


--===============5408963366340039874==--
