Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D743636B
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519409; cv=none; b=A00hOuqMTBE55WY+jVX0VFUm/qnaCMxN6OKo6wWqTBObSIvX34b4EeVwtnJs/P5WJFCT3BrtTnseqAKo3OEH7EsjN7ga7VuT80KhKqIGElwW2BrLzrOt/SKPRDRjFejZR9fQWInpm6qnOlHWye4TIEIjS9IDDPvenoAZ0mQq27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519409; c=relaxed/simple;
	bh=f+7jRkAzarS79PoyS8sxoClars4I8oRflxhY0dIdHYw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VGsOjMfKsOszosdn7yShLVSZ9biniiTQSmLIFxAApbORfEz9tCQFn1JKLwVipLgsJrjx0vNCTicTscQHYu0uDQI/gCLDPWVaFrd97oicAJc+333FOZy5OoFZY99kb949bygmFIoESJCuvMmma00ri57CSilXL6PHEpNaeUdwBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOeEdhTV; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOeEdhTV"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3293054eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519407; x=1779124207; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RzC8JO1YBkbwJHle05JwX7XgODrC5e+2s9uq6eYAYw0=;
        b=BOeEdhTVFd8e2Ke09J6+JgjrhXen6Atp3+EE1SFv9qLJAV90Q248KC2k9+oPoBOzE0
         liV3/jYRRh/Cvlf0MHsdB+Sp6oHS1iVKYVgA0ZJ+OwM1EvxaPgaMRgVK3X5Ihu/z7uVY
         He20HRvJa6jVTgT8HsRck+l6XDmaHtAQiI1fUSLhVGb1ihevuUG2lKUFvMp5U1c9q91H
         IKfnYnrDSgPsQBhqRBUwTmzi/v8EshDXSSYRzqDuqtE9QAjXjmoj01v0jgp+35CySOtC
         sjYp7roNg9PmqPEhQXLeEmBAlrasHIvtC8GbNmergN6ofvZQ6pKdoenMDtNPH4spI0AV
         MzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519407; x=1779124207;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzC8JO1YBkbwJHle05JwX7XgODrC5e+2s9uq6eYAYw0=;
        b=UA6tajRBRI1rs+7jKK3uy9OpiCeScy/2L8qIqY9xalmkEwuIGCwQ77UR0E5Reic45U
         sHFK21tYIf2wneu1Z6iSr7WLiFspqEzzNjbSHq93+STe3u3mGcIT261zJxIyz0dHsVI8
         3dtdDKp4QBLlfGaWwYGXn7pMaXNVoWIKZM0A+nTPd5YluoC5dacCKekKDXwjplJKFMLz
         Wkz2FdluEUHE7ToYa0TQLMOVllsSjstzWnKiyG5qsZ8WlovNpudqFz9/8cnvT5TJPhRI
         l80Ps0yiYdoJfzMCEIratzjf5pDZTAGoKoysGS3KXnQ5kCngdqDMdEXU3YP22gJXv8OH
         ndoQ==
X-Gm-Message-State: AOJu0YzVj4ZijVvs0UWVRfnwK7n6jDwR5re/LCajD5aY2g7/yCjjRhfZ
	BnZBox2jh8axTv1TeSyz0ivy7K0rmGst1PL7ArJcfKME+Ft5HLv3Q8SwnXFS1A==
X-Gm-Gg: Acq92OEso+X4mjustj97lOpamyfTjJl9gPXiuQxwKgNvC1kB3YW2EeeuENl9gyAUNHb
	rjws+PGDVJPCDY+7w8ErWe4G+DzZq0QQTFxpPXnTmXSCXVn4DSWQqOY2ey7jZ0JHVL/t6Sao3QB
	AK3lc5EqBEopeBOSrIGpSVuVV8tEwIccKWWhSe9td8LC6pxjwrlaOWPaBVtR11h8o1/cYWjXqYl
	E45OiicwU3v/W1obStSBFo5+xRtx4MtgtMbTuGYnP8ITvmwH+3OmBX8oPpEe19SRGVlhNt023Zf
	samS0ckSA0i26OkbzwmRzqzLyAlOSJi5stBkSC48y7g3FQVSvbWHb+4FsS5TXhMGizKOd+AD+jZ
	mi8HFoXgNHXkuHl2oT1aJmT8XAj1AdXpeQU0YkdrcSWYNY+cHZMgwy/4sB/HL6vcFhV1JsJ3z97
	X3RrlHucXLkh7XGdA55zH8YekMhP9kiTrM
X-Received: by 2002:a05:7301:1297:b0:2f4:d190:37bf with SMTP id 5a478bee46e88-2ff95887d43mr182599eec.16.1778519406770;
        Mon, 11 May 2026 10:10:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.204.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8860c7accsm14286443eec.8.2026.05.11.10.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:10:06 -0700 (PDT)
Message-ID: <6a020d6e.050a0220.16a319.5ae8@mx.google.com>
Date: Mon, 11 May 2026 10:10:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2655691639295168526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
In-Reply-To: <20260511162306.654747-1-luiz.dentz@gmail.com>
References: <20260511162306.654747-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2655691639295168526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092944

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.94 seconds
CheckAllWarning               PASS      29.81 seconds
CheckSparse                   PASS      28.86 seconds
BuildKernel32                 PASS      26.45 seconds
TestRunnerSetup               PASS      581.85 seconds
TestRunner_l2cap-tester       PASS      378.38 seconds
IncrementalBuild              PASS      25.40 seconds



https://github.com/bluez/bluetooth-next/pull/170

---
Regards,
Linux Bluetooth


--===============2655691639295168526==--
