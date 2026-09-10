Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F757F732
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066098; cv=none; b=W6EZZ/e8HxhjuNwzNdlC5IgKOzOfkFJlGeX6subjV3pZqdL3AULBMLG0sKLpFDar7Rywe478GPMSSOGX/nHAWJ5NLbQpCwvRt4Y0K4JwzxMwNsQsC/iY0vTjxz/kZIw5P/OHv2i8ujOYn2DVAAldb6XDD7lAeqqbMWyjUOEVneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066098; c=relaxed/simple;
	bh=VQJh2F8ThH5vjw5Ge4HjB1vtmMoO+26S/ZQu4vpuCE8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gi60IYksae2lQT+DGITpAX1zjtjZow94Nwdl0cCCOl7k9P9w/aZI6qB3iTMafkXf6x5a8sjszkmO+6YYbJp3aTvGndBIs9476QHHXIsO6A9wm2S6dwn9F+ZlCJxzoFFoiBohUOqC3rqbe3konytdlZIfmkwbg4aKy5TmBj76VsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOtUQEs6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOtUQEs6"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8520161fdb9so20269b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066096; x=1789670896; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PwM1uvU8cQqx9PqIrPWIVAskcRvUHhC/sub7bu8rlqg=;
        b=YOtUQEs6Bgteb8Q0r9OcuAKnBjHUoLuuapzcxpolBQ5EWlLnifxqK+SE8mk0Eu3qdq
         P0SAOOeFTiDfdxOXZ9PUEcnrjNLxAT2g1OpUN+OmhcdQCxoRcnGUztYL0xUCN72ejvK3
         3LMzpZNi8ssZmKR03At6ZhHU9DSX2c0+ZpIZQWCEMT7UJy4YuXPoIJUp3PNNfNESvOUH
         ggA4AAeZniNWOME8Nkd+o+1A6JryOp/EITYGaM48scTuJbpEf0rxikUjaTM+nomqKmZU
         HtlC8SRJsKVLApIW+1EWMC0m5xIKMA4Uosk0TzmIYigPds+vGabKTOHRL9OFaH4mt6UP
         I9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066096; x=1789670896;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PwM1uvU8cQqx9PqIrPWIVAskcRvUHhC/sub7bu8rlqg=;
        b=hl86ofNtchI6EozWKvIuCx+KniifRhDUC9cCyUspLq03wgerxHEOBPcton9VxqaeQL
         hNRlwGWVrzaWHbC/Q2WfSU5Caz+ONZoNtfHuef2jnWVYE1ccixgqaf6MPodc3iA1S1cn
         O6rWCT+4rQ8mn6WcEvYP6JKd3Bs5gUnqJ+qk47qTf30bI345Qh4eGBl1z0R8quYU1X4d
         N2qDBAeScShfVmDu2Jna4OoQKPhjhg3VJz8tryK5Yz+fS0CPkbl8etZK1oC0hq6xom3Y
         WM9gBkKot9NugBixEHGd8ly29spYO/qM/4VIrhUxNiqH4fiortNzFwcxfxaybrX/qRCv
         Zefw==
X-Gm-Message-State: AFuF++lAO64Ks8/f6T0bK+NYyqLC5I2ZJBJJEe5WVIKrxvH2ULHaTb6J
	gvLxqqNG9wCzVDMDOn8/M9C1OiQpXcEyOBIpA+HhHMUWcsJbvRknkwffjIo3TQ==
X-Gm-Gg: AYBFou0ps7aUt/U/Zn2YRJIDCTbKOCXyLHU4ruLgGt3xU8Yqcsx8LAuFKIXd2U5SfHt
	cqTV01qoLYsSnTccvzjtAltf8ctXL2jlJhcLYABEwttd37woqw+jszZgMjLGPBBqpVwPWBe+yCb
	NFojMlknPkORRJH+upe6qmkHCGOlEPb/hAEKwiUCoFTnRpUpwVVwwkB+68PH5cnrU0x6W6EUJO5
	SovivSzaaST+b9fJnBmiyXN4Pc49EWSEN+1ZC0HFJyYUYxbXMDG2+OTNwGVy47ueVfQd0YrbiDx
	mCyRTLFaJ270b2XuAiHwpLe4Ql1Byp/46rP4gyhn8/NoosgJMRJHp9Z6RvBQuEZHjNrBjatjCKU
	GGv1eH6aerBpkext6iZstFAqwiCYnPJlY3wg4JL92LaTBIbTwx+M824J7d5XTc3bPnAeHyWxkpi
	tcQqbk28Mxi5WcmIBg9qW7bR8TMKDxvaMHQhXSDs99GQ8DzPHjVEf/X5L6QLx8Q1hYusxWmFB0G
	g==
X-Received: by 2002:a05:6a20:6a15:b0:3d0:88f5:f813 with SMTP id adf61e73a8af0-3daed5ba08dmr297882637.11.1789066096445;
        Thu, 10 Sep 2026 11:48:16 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.4.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm470854c88.11.2026.09.10.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:48:15 -0700 (PDT)
Message-ID: <6aa2fb6f.46c6f052.151402.9ba0@mx.google.com>
Date: Thu, 10 Sep 2026 11:48:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3400503917966776794=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Route firmware debug event to the diag channel
In-Reply-To: <20260826111617.1175698-1-chris.lu@mediatek.com>
References: <20260826111617.1175698-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3400503917966776794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1152025/

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      22.53 seconds
CheckAllWarning               PASS      30.69 seconds
CheckSparse                   PASS      27.35 seconds
BuildKernel32                 PASS      22.49 seconds
CheckKernelLLVM               PASS      23.42 seconds
TestRunnerSetup               PASS      562.17 seconds
IncrementalBuild              PASS      23.60 seconds



https://github.com/bluez/bluetooth-next/pull/747

---
Regards,
Linux Bluetooth


--===============3400503917966776794==--
