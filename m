Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A438F65D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280951; cv=none; b=sGS4P+zParqF9sAWd4TI9wZVVCt+C+BrPIqAu+ZmiM8wLE5oFhqDwRyj9NKJc53OLB04LmwqSBJ+XGMEOrpu0x0Ss5hF3T4ejN1q6nm96nXfrZelAYQbrqv+8ggf/Rjvt/bR6UYE0vo8lMiLfcuv6Ti0jqVm22aqIJoJsjqL5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280951; c=relaxed/simple;
	bh=v9cgUK4eEVA8Zl1Vfk/RtE8UlpGKrzm/qt4yOoj7gEM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fy3KdOpdaJZwT+mZdBtk81gbrGZoQKfAar7W347HXIHFNn4Gik+pyj4qN0SbxwXrGvN5s2BYzOZ7npOtPksN9aV5K1ZCSlWlS4Ru8FvaCiu7uLeNF+tkGqxxI3W3+94+0YxvB+AVmlYMk0pUXBXTRgYGR+Ipj7aB6HT8hYK1V2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXgxop9P; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXgxop9P"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517b1f2c6adso10265881cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781280949; x=1781885749; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNRjOPGq1Kd1+aI+bI9g5lWYvfroFTnamc+s2YTlTBc=;
        b=aXgxop9PKAI/17R5tTLjRQr0RIdjHg7HzPQ1bpX31ugP3+ub1tFq/PP4ObShTGCV8b
         kCRVjLY9YsOvNBLdzTUaChhSsthffA4fwCVQMFe7qP6HrtSA0HZTprHQtMqnSVuwEBQY
         yV62IXebzL3U/bMX3j9ukNlPnPGf5lCgTe/em15k9lBUVz3THRnca/FsvxuuWx/XrjAc
         bI0Dflve+dXOIMOjJtiRto06B5wKigczd2pFgyIP3QyTHcohulpRfMFrnJlk1asZP/OE
         etlwpN8MGv9JM9mJVY/lKAxELvV0tsOBYYBvUVIXEjIF1V31z3nm9tpcVJOKs3hoWmnL
         baFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280949; x=1781885749;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNRjOPGq1Kd1+aI+bI9g5lWYvfroFTnamc+s2YTlTBc=;
        b=FkFXZVeDh/hMM26S++Xs2UUumfoXe/UQxuUwstxBUqSLTv0XLQ4DTL8/WEgH92GqPZ
         qPaHJAb3BJ3+irRpMrDq2dCFucGJeMHYFg9fkFFHSNyLP2pGqsLm7iubj9HvFNqjCb7y
         MDVTtGCvYHGYF8Wu8VoI/N4/lST7LqRl2WdEFuvU2O8qEucQEeSVXWgrAqnlml3ETcNT
         0kDEEd5ATjI93Eo9oOUZ5IE4QEWtLWySTRzH7Ce9pHn8Vufy4aD7S0lIRL6+TShyv01Z
         kuQ1jW/jNw+ah9KZ23xWJzXUvfa0/oM+F9wWQjQ/W/BwPXZc8zDCJoLFwBFZBgsIunTB
         i2AA==
X-Gm-Message-State: AOJu0Yxj4Eq49FD+k1BPz8BoUjdCvA2b0gtt2Fynrmyw22HIuVCDPLf2
	rpMuLekC8Iz10zX/laCZgA0BkiCdK+XMKNN9sRFSwBYJ6wMxYS5FCjW/BeLHiw==
X-Gm-Gg: Acq92OHCfQQHYF7ccSuDKKKP5P3rG/BGxFRG7nEZA2vT5GuXDQI2bST1vvjwb93ygO1
	WVU5y7R9W7ft9SNbVwPwT8xijo+xsmgp9Ay0a3ZUoYHbY6Qfa4TVzNoIT0I+Ty7X1GaGFl1a3PF
	1GZ8scQ0FfDsO7A/JzuCCl39npkvtJaFEEHkU5LhFeDto+vtQ/k/LYPAVE74ZzSl9iZmpGYjmQH
	fQTD8IUYX4whmN2rckCsZZjXEPDwPweV/gMf2rzVCvHA/wneB6qe005DfPs5xZj5VMQg7ooSZsD
	bjrVGPdKu55Hk1IZFB1ngOjqouDvKuc4O/uzWRc0Kb1W2xpS1hZC9hmWOO4uPojdv1CLVtr5b1u
	A8ZZo5HduzqpgST1gdwzc6MXUoRvmfX6aLhwdOAFz+P00v+O2fw0BqhbJ14IyVbVdnWQ4y9Q62f
	NIgw4FrLxRcJmvQ/SWJ71IT6JlGpbJ+DU=
X-Received: by 2002:a05:622a:1348:b0:509:44c3:5ffa with SMTP id d75a77b69052e-517fe5734e7mr51849431cf.52.1781280948632;
        Fri, 12 Jun 2026 09:15:48 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb815976sm24893311cf.25.2026.06.12.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:15:48 -0700 (PDT)
Message-ID: <6a2c30b4.158b57ef.2ff1e.fa98@mx.google.com>
Date: Fri, 12 Jun 2026 09:15:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2671313962670089025=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev
In-Reply-To: <20260612142957.524526-1-luiz.dentz@gmail.com>
References: <20260612142957.524526-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2671313962670089025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110712

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.16 seconds
CheckAllWarning               PASS      30.27 seconds
CheckSparse                   PASS      28.60 seconds
BuildKernel32                 PASS      26.79 seconds
TestRunnerSetup               PASS      591.54 seconds
TestRunner_6lowpan-tester     PASS      23.04 seconds
IncrementalBuild              PASS      26.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")'
#98: 
b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding

total: 1 errors, 0 warnings, 0 checks, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14626271.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/308

---
Regards,
Linux Bluetooth


--===============2671313962670089025==--
