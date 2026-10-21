Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587431;
	b=gWnAkIqTz/Y4gO1e6srkpgsf3Xmvjy4pyRzvyvcUZPC+TU4h0K8nP32EdmgCNZswv2UJ
	 NUpBT+12j74nWrLAMbgWzV7IYrvM7978I61c+PykJTKP2k9CC6VboD8dByvTL/wW2A18y
	 JEjeBrwFaDj3f9fGVA/3qMdGjbMfcvMtJvt2IrWfoXING8P4mUcabZB0WVvl2klvxSadc
	 AJCNTTdjyA1MxtR0KmPi1XbCk9Z29pq/x+iH2UyVhkRfShwlJbDflcd8DM3vWAikmpgJ+
	 Vep8r9IXqtud8lcxTf2iw7hm2l+nr3N2NrI3lQXJ6vwAxODSpIQwKO+/mTN0w+OIVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ZPxqlfNOPHyYie8aVdhjG4kVhQIETaL8RCs42yACSmk=;
	b=CmSwCvt5OYUkVeehGTT8sNgzW5JP5Tw0sV04qFND1DyTSAIucvdWbPeCKJ4tVE86UVkW
	 q6UF2MJavBeMs0X9eIYVm0lD0uybuvvcmqOYSJoGOTqeuDOvHBDnjN31Nf4KtflOZL86q
	 AWAz9wYrwjPjNcPs/rsd2RK0jWWPFPPl5vqNVXHSTw+aaV9EJYuxIGNi8SYH7pkZyj8MQ
	 XLKmyPa9kYe2XvJlCehljCPudGl0UPQiSUzmA5/xLla8xxAdn4W5f5UToM92V4eCZgO8z
	 OIqx//DxV0QFcTJvX0BdyGe1g3N4hdrSzVHV5latLzvwm2W/WXTsl3owQ7NgILXWWnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rq/pqejl";
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE6606A319
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 12:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CBE6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rq/pqejl
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6dd059478dcso385484eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587430; x=1793192230; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZPxqlfNOPHyYie8aVdhjG4kVhQIETaL8RCs42yACSmk=;
        b=rq/pqejlyiaaeyRfpTrKXypjW4APykjayvd0gt20sslE1BrZ/LKTn4y9G/MSQNbQk1
         QOVLzgGsUBvxdyJHQLVKuT1E55wJZ2vznP/TMsKemmR/arbe8xGE150p2LbTPuoX7B5S
         jPXkG97hB7KbgWgfV+CTcqnO3KMwe+xmlCWR5cczI/G8w8C0sawsiunZxyK7fYJCxMH+
         7LMEthZCmEVb4fJe2IySX6nIf3AWTpnUECybOsHMb5BWT9nRw0mlo/85x3dvU2TR4yhc
         jyhAQV9b8unVJ1cz+ak4WE2QCiYE4zFppoAGi2Obc6QrZJ4T+24pnZdtU8DMAMvgW/sk
         cWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587430; x=1793192230;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZPxqlfNOPHyYie8aVdhjG4kVhQIETaL8RCs42yACSmk=;
        b=vCtru9W8ITLlAsRwXoU3F0gwZqYy1HafLieU9A8sp3M5rFDG+LfOmDAs7HdeKEaS/g
         x0ZQJfDMaqS1t3POxLi1OnT6mbN/E6R0WQax2n8nD4aRGMmRge6oYb2ID/Wh2WqkDU2f
         JJbZ4yTtrKt/gSFBNGb5vqWMIGNG+G2ujsIfDjio5D8L9ho5/jSIpLLReCOlVzOw/l75
         taXlkuawN131msKlrxxS7m4E1jBuSzae6kNaQ5He8A7YK6QEuVsj2aRGRt//C2ShEWyM
         hd6QT2iZzwmOoYOnUzxzEK2D8j4D2aFCl2EDDSKwA3KyAZfyWCTcTgdjA4IS9ChHOB07
         8tFQ==
X-Gm-Message-State: AFq9FYIw1ydHfdQ9OFxgk3Htty6pgB0h9vYcr3wEbg0FHvm3XwXc98Ra
	vyMo/ke+rIjATzjXD6kDU8sMmWNSxTib3pTufPTf30Z7rBQ+JeHXv1G4bFrHp5RJ
X-Gm-Gg: AYBFou2kXP3UX1IoU3RyOQo0dn3p+fBYca+9Cbeo9JVbuESxAydCMGB/KXyULTHeTtn
	Je/E8FGA1YHwfVKjOJEBCpNXyBq+AmSRbDcb2nwhJNqLf/gZFFS8QK+VxBHQMkJOxEbaWy1D4gr
	/6aJJghq9/Hl0j0j4yr2pLrSI3QxGFaNfKNAGPvAk48SCh3S2veVmUjq69DTmMEzLNMyBc0qfk+
	TE/xuvc4+eD2/PMHbVBclAeZ7HR2ywak/Vf3/9FN9BmhTo+/jiVzbTqIckUCIZ7ZgftvjVuf+RZ
	F96NoxgiTbn4qfFOIFyglD0QIJPg+/rKKNe+itD2GSYlS5REguRWg5Xq4bVbDmpG3HYtEJB/imE
	4jsQeD0H0bdJqZtqiqS9j8FB0y/UugNkd/dDgwDOii9rlTJHaxTPsS+P2oAtCqQI4+q/cqVD5PF
	AWkLO6tKBOZLdCe9/EdPPiKBdaCzHXW9jEsJWpx866P8Py9462xhb/AkGAKF7CaTxYElMLA5qCJ
	pWMNOukhYQAVgdb136eJxq4UZFzpc943VqPiQAcsQrIJOcgCevh0F/hropQ3BJh
X-Received: by 2002:a05:6820:1388:b0:6da:1f1:9e6 with SMTP id 006d021491bc7-7093fbb9e65mr1144484eaf.19.1792587429970;
        Wed, 21 Oct 2026 05:57:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.55.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-709045b1555sm1870268eaf.14.2026.10.21.05.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:57:09 -0700 (PDT)
Message-ID: <6ad8b6a5.2feceb42.42020.6a31@mx.google.com>
Date: Wed, 21 Oct 2026 05:57:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0835058049324175888=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, joeyli.kernel@gmail.com
Subject: RE: Bluetooth: SMP: Fail if the X coordinate of remote and local public keys are identical
In-Reply-To: <20261021093522.3536051-1-jlee@suse.com>
References: <20261021093522.3536051-1-jlee@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0835058049324175888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1190369/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.55 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.28 seconds
CheckAllWarning               PASS      22.70 seconds
CheckSparse                   PASS      24.06 seconds
BuildKernel32                 PASS      19.64 seconds
CheckKernelLLVM               PASS      20.36 seconds
TestRunnerSetup               PASS      431.11 seconds
TestRunner_smp-tester         PASS      7.00 seconds
IncrementalBuild              PASS      19.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: SMP: Fail if the X coordinate of remote and local public keys are identical
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")'
#120: 
The 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys

WARNING: From:/Signed-off-by: email address mismatch: 'From: Chun-Yi Lee <joeyli.kernel@gmail.com>' != 'Signed-off-by: Chun-Yi Lee <jlee@suse.com>'

total: 1 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14904963.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: SMP: Fail if the X coordinate of remote and local public keys are identical

1: T1 Title exceeds max length (86>80): "Bluetooth: SMP: Fail if the X coordinate of remote and local public keys are identical"


https://github.com/bluez/bluetooth-next/pull/972

---
Regards,
Linux Bluetooth


--===============0835058049324175888==--
