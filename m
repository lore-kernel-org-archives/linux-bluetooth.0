Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A234A6CE5
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826842; cv=none; b=gHJFnSZokaA/N6lDWdUSLVBiSvljgebTeL4rqAzQHGMsvm5u9cNg4MQXvb15HKXn+zpRsFChOr6aRKAvTZucma0kPAoyRIhAicfLiUW8VD6ao1+NgyN0H7EqyeRZCnPizVAa7cxvudUlPQCDJWkhNGhVNUA6CWURHq4/DXdNEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826842; c=relaxed/simple;
	bh=d6pI+vPRMHsi7hWOW6/hbJbDeEpqWjveYQPcwV+kfh8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cxi2p/FoKxIRxoXyRO48HPuyUDdr60WLoRfPlCBj+WFbfZKwTeu7KCgUVP7hPaDzy63abYtlKt9TuLzAcbgBc6XlyKNjYHa0mpCbYzJg/AaCSCoeQfo/8H4DXRimkLU1YCqTzf+en7zISbl0Oae/kL3y+XwyiSeYomPNETzMcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeQ1WrNr; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeQ1WrNr"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-154e9d2d979so1387842c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791826840; x=1792431640; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QJfNqbaq+MAm2NfFKyyUSRP1aESZp85mIi7XOxZtmd8=;
        b=CeQ1WrNrmojMpYn20NIh9hZwGKy01XPr2ZWMPh0tvzyTPCSF3oEr/WR2nPqFQ6x1mf
         4lFrUvq+jlcZ9VlITg0WoL9bHntHHzfzOIQtiltf55hyI8MeViC4G0Jc/8fWacblNCnI
         eBDDRGT9IQvMAzxbVOyqkSLFBC8hWLVwgDRq3ADBxY528+ez6rGReV4ySAWYlkKpT4Ea
         KYCBUf3Uj1w2Mx594g73/Il0zyOiKNibeicV6KU2vbARn/T1Vpm+C5WY+xclvkD6y0Ao
         bKqMQPj/n7SaWatxeMZCpSpAQlpji0YwAO8xwzSDWP4zNfeYdpPzy8xWao9kJSBxlSl0
         PrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826840; x=1792431640;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QJfNqbaq+MAm2NfFKyyUSRP1aESZp85mIi7XOxZtmd8=;
        b=gUtfxIAbimbUbuadE/07meqttb+8X6YPsEOmnnv8/UgB4yYDconOnX0GpoIOIltYSy
         GOoKyje9zSilSVMcMFyisODF5HFYsRTwjrAwjiygD6g+0nmouhPRdgMGp4XiIA3IyR4a
         pGLR0nQj6v+ix6MVbEysnlgmA47PvZt6i5O1OIckqQQOSU9i33ZcQH1QmfV7ab5933KF
         XtvzxQ2sj3KBmNICDjO9FBSCNAOh3RIKxMAs0CJm14XTj5+wt9aFc9ILvRyQ6BXSYeId
         Nu3rj5Ms5+gcTatn+0LwyAYuag7XiOcRe0rYHUqQInxz3Rerq2VqKro1YuCFsmiLa1Ee
         8gCA==
X-Gm-Message-State: AFq9FYK8MQylhm13hrgJ38vXl+U0TMXY//zKPZ4BASYzoY2eyDJ1Ycof
	yskZ3cHGQAjQAxd/6Z+ho+sQrLpRmJQMAL7p+ZyXIvO8uVwM3xsn0gf58+0bgQ==
X-Gm-Gg: AYBFou2Z55krbd4yzGGVWAUAEncJRaUF/gcvWaK6jFtZft4FbZnfdWBraQ6sTJzixGK
	gEy6YP7dHGzWm5yZiTAvz2CbHElyaAI7eg4flbYV27Ie6IasJyqgyixF3OuuFvZ4soEiJMPoWAM
	NwGfH/7+0IQp/3hi9azhD4VKf//2Ygtalnj/ssHE+uAKqKiQ0CRTgdc55dR3zrJPK6JV6yXHXxv
	LxM3PtFjqP7zL/uUJJW25x3bZAv6kSDROZL/y9fxZ9VRwAbm2hFlpTXlYs9uONdyfoMAzlHqVny
	WQfOqo6TGzWEB/CPkEdhcRpSMqN1qehqX5J9YMLXFNRV7duAtS3S0AOYOOe5MusvBVRNEozdeMi
	BE1yT1R/G4HQzjM+EwO83EbzwtGOmhFlBfn+9K4r/XyMSlS2PwPnQBNwNiWzQJzsSB2pM6pxUKn
	+tAg+hmpjyIbwRie1TyWDOgwKeaUoeGdZucfQR9o5RN793aUlXHbtP0WCyqdom3WuwX7ers5DAq
	F3P
X-Received: by 2002:a05:7022:5f1b:b0:16e:a290:12bc with SMTP id a92af1059eb24-16ea2b0303emr7574328c88.12.1791826840007;
        Mon, 12 Oct 2026 10:40:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.213.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm46920560c88.18.2026.10.12.10.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:40:39 -0700 (PDT)
Message-ID: <6acd1b97.c4af216d.3391ec.45c6@mx.google.com>
Date: Mon, 12 Oct 2026 10:40:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6005653531138952432=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Retry FLR on device lock contention
In-Reply-To: <20261012092017.3275428-1-ravindra@intel.com>
References: <20261012092017.3275428-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6005653531138952432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183728/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.04 seconds
CheckAllWarning               PASS      35.52 seconds
CheckSparse                   PASS      35.30 seconds
BuildKernel32                 PASS      28.70 seconds
CheckKernelLLVM               PASS      34.56 seconds
TestRunnerSetup               PASS      775.88 seconds
IncrementalBuild              PASS      27.55 seconds



https://github.com/bluez/bluetooth-next/pull/904

---
Regards,
Linux Bluetooth


--===============6005653531138952432==--
