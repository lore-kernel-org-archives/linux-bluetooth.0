Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5642B2D47F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865782; cv=none; b=CRSdgYyXD0NDFUujIvweUt99qmrHPCZLpwmEWcBKsemhvRn+rPf4CigDA6LePzhwEZ0s/ghhffPgoIwyRMUhLAjkV85gpGwwBEulHiYKP1OBD2FvcldsxYPHfBpFESm6GuDNPjHgWvy5qfT7qX5VgG1s/5KmpUHgUqnaRkEa73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865782; c=relaxed/simple;
	bh=UX7sEguYIGsfdG4au/tNc+Rqa3cgOhN99rU1B7vAPH4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cjw03v433ZAEdUi0uLQbFGXJuB1f8aL3yMXR3k0TUxVYSEo3NqWjBdSv3sR5spG7HYdI8ePiGxbDUTqiWM5fwBwr86oA3+qG56IPmcezhojs3eO7JyfPqwn6gIghkNrMadpdKdLtWUPiCA0tdVrc9ajaOqaWMLy950WmDGPrRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF1gkyIs; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF1gkyIs"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b6dad2382so5952570eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865780; x=1792470580; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7Tc9/jlNR2OGQnK7Nl3hhNL5yMP4W+9frkkzr9NdYgM=;
        b=HF1gkyIsJUN8u0gqYvlf937uXk5dLX/dPTlaPPllNm+Hdu/MDi03UpXNnZf3JYgN8o
         Eq9vsSkpbTFGsi+mWCakb1rM6xdoYbFjhLJ37yxCVXpr3z7KciX1m3+ZjCLDmiKWC2VR
         ZLX+gBZ+RFnX0Oon5hjYOT0meptFfdzywzkXzT996GfErUOcG2Dc8rfVczHLohA6d7L9
         zSaI9FGMQNxIDo5ulsStc94lZndFYkyQFlaPXS+eAraaCiOWtX5/pZgeGaIbBfF3ykCg
         MsSIUMlMwnZzCR0fWuB3q/Sj9UBfH4tD7jLCrtFLbqL44ETi/j/4Vt0QUcdiI5nVd4ho
         mOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865780; x=1792470580;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Tc9/jlNR2OGQnK7Nl3hhNL5yMP4W+9frkkzr9NdYgM=;
        b=1+8bPn7iZtv5n+LtHztnJA0eepEXHTld2M8u7a5prO5a0lPXNaJehBm7vTNSujqUw7
         uh5d+sP6+iaCgonEFq09F7dG/6wvt9kNB1IJy85e5PnZzmBUZKAIscKAteqqBGRdRYtt
         3QIrILBrcPCsg0CsfYnOqn6rD/2WbmsHiwHseMwF/Tz2irjpbWc+T99wbQGVavxCNpQy
         vDvsw7CwUOqcfloeC+X7gr+lEPQa6Edwg/dJOtTPM+x/K+rYv2vZPa5AhRA+2baQJ42K
         tDPAT/iXrFHKl7FuIO+53aAu7gr2zUuaFoOY+CZBCY30AjadOUSRqX2NTWNlPc4d/KUr
         cLxw==
X-Gm-Message-State: AFq9FYLwa9d8glR388EYgr0gQR1upGFkgDXx7lv4eswVNfMFr0Lj59yD
	YaYFfe64SiS8+g3Z4tz+B1keOTBSmEp+3yl73LnXVmU0ZApM3o/tgtCx+YDuCw==
X-Gm-Gg: AYBFou2KbZtzQzawcsMtuTnP8L+v9D5PnrJ5k42gP8n3isAc9/DlWDxbAv26bT7BsLH
	Msxgr/T3u9tqTUGXlakRhOGueJldsy9r3fpvHXuoOPJE6iBI8uP5egStn3jFjSbnv9UGZRWMQZd
	U2XFLyky4lRbg8RTq8QNGHoaca5GB2rkKRqkS6yftJqjl+AaZ1HWKNQ223jKGBC0vpcOKLE1LMI
	QranhpSL/IzYPolngZEn0Lo9lotxRjaLqg3LMKuJXRrTv3gpivFe87eqaeHq6RlGm25RQ4zabQ1
	KAsoaRDt00GwTNRI3kOABs1w60rQcp1Z19lvAiCQQnJ8Jb5r1yB+cVOLzCJ4MFjWbi8yjKhJxh1
	uK0KHIZftsQakBSBRp7a6MO+8frTFJpHtvm1eN8EJmZwY4bfv/5RF11SUTVKzP6zwcozK1NOjFN
	OIu4S5loBS8fT+x8/PyLJ3ohCmFcYGD7wsUH2G8F+ET7vLMflm/vq4c31IogdoLaILWfKkpsgzd
	qvBZ4Mj8SMkdwGc
X-Received: by 2002:a05:7300:fc0a:b0:351:7ec1:a92c with SMTP id 5a478bee46e88-3537e11c9c5mr16766497eec.28.1791865780268;
        Mon, 12 Oct 2026 21:29:40 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.235.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm51837216eec.9.2026.10.12.21.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:29:39 -0700 (PDT)
Message-ID: <6acdb3b3.2c5b8305.9bde.5700@mx.google.com>
Date: Mon, 12 Oct 2026 21:29:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4023859770144404877=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs
In-Reply-To: <20261013031329.483597-1-cochcoder@proton.me>
References: <20261013031329.483597-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4023859770144404877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184325/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      29.32 seconds
CheckAllWarning               PASS      33.44 seconds
CheckSparse                   PASS      35.57 seconds
BuildKernel32                 PASS      29.06 seconds
CheckKernelLLVM               PASS      34.72 seconds
TestRunnerSetup               PASS      695.31 seconds
TestRunner_l2cap-tester       PASS      12.71 seconds
TestRunner_iso-tester         PASS      10.63 seconds
TestRunner_bnep-tester        PASS      3.04 seconds
TestRunner_mgmt-tester        PASS      87.21 seconds
TestRunner_rfcomm-tester      PASS      4.38 seconds
TestRunner_sco-tester         PASS      5.54 seconds
TestRunner_ioctl-tester       PASS      4.57 seconds
TestRunner_mesh-tester        PASS      5.43 seconds
TestRunner_smp-tester         PASS      4.23 seconds
TestRunner_userchan-tester    PASS      3.15 seconds
TestRunner_6lowpan-tester     PASS      4.33 seconds
IncrementalBuild              PASS      34.31 seconds



https://github.com/bluez/bluetooth-next/pull/906

---
Regards,
Linux Bluetooth


--===============4023859770144404877==--
