Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC623ACEE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404285; cv=none; b=Xq9+NwQgNZrXcejhFSfZ7IPY73Wn2d58pSsWeuzTo5dsSQ4eDGAZpchfMQUbai0ZvSPuuHwwi3gOLw5kg0KZUHdPdAwzeylOxrGHFLNnottDjTVYfOBDOzrMEmqYt2HcUq8YzHRVGO8ivQo1GHaToKiA38ggLm2z1W8ICdmhyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404285; c=relaxed/simple;
	bh=4Z6g+8sR857eSF9biNrASJh4yXfpwNl/5+HNWMP04F0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WBeVYwyv0UIHuZFYqZl8lzdG1TEg/0PglIrjmk8N9dn1vF6Ik6n0Dx1QIxIRr3B5RI9NlqZ3BjaMy4ikkBG31QwQeuXNyvFmrdbOsiJAnJONhrFbBxiZPcZDpE2uywMYostH+CKorVDwToA2Y6ZAj46OpejROyl/UV6AW+uzl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAsTEsaD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAsTEsaD"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5c92c389so112137185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404283; x=1786009083; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FcdeREYN9PuGyQneFvPeDgCPBG6hUM/4vutPW2TvlZU=;
        b=tAsTEsaDPMLA3QI1/I7J/BjW3TDjmPjinPJ/gqQuuV1UFqoNMr0VFNLF+esUIqzZFL
         v3+QCINmtFqgE//ieoHSxS9E2c27WPRaNmcmV6KYfQzqzdmiYyoEufxVEOJDPz3z6U+A
         iEq4HXF7jaXNRFqMgoWEg3CuRypgmBe+Wfdf4orzDbgVCPLOpMWKYoaW43GgNov50hmp
         TrCXAtQH7wGpQUI0Q37P5IJVgqlOnROC7pTcPBbOjXTNfFWHHIQkvx0NMgsvCt59cwCt
         smoyGoD32n/qVAgz6pkpiWPT66HBiiEZXb7Wi3DPOhiUTfJCh+jnvONs0FwifMI6cdI8
         rShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404283; x=1786009083;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FcdeREYN9PuGyQneFvPeDgCPBG6hUM/4vutPW2TvlZU=;
        b=KTGEQLeIs5t5ZziegV+Hj7NblUjjeG3IYXIGhwvtGqoQRGXM8mikEFzWbaDmqMZx/o
         m3h3D+27mKRZQ6ihx/UWQ9eoVt9Eiz8T2iExCxAt7qutx6hv9UFyQU0y6rab4jjkok6f
         aSYs1v8J015X7CPa7ZAW4wKSpU/Fwj/R4EhFk6uj4gBaAJkrAINlrcks1w4wYgzbvYzq
         uw+J+Fw0+oL5xxPhdWb9v6dmcAjUnsxF/RXhwzxgtT/XnX1zaSsFPcDwCDp9mF6O/9T7
         /9DywzHhoFJVbEghp68dcUoYVB/53CSi6wtzjRdvKF4J0Iit5kIzH6zis1VLAqycJEr1
         ZovQ==
X-Gm-Message-State: AOJu0YwPdbk9+KbNYjy6rZDSss5I24lrGGZAVmD47rj5MwmEx0INP537
	/+ponzmXPQLlhxRMbPDDwxXH/9ZEwufaBKY/IB1hpfh2qrdJ5TaNJUSySVEqpg==
X-Gm-Gg: AR+sD11FkBDLsFdJFgck5qwkJyLadtble7TPxnAm3ciV9Ua6hDXGS0iMegwr3QmNG58
	5XOPktS7bccNfGA+Iz9m8IsBf8T+7y2/G4BfCT7GPf2KqKo77Eel8Htb+W58W1y8QxaEWykWryo
	+MrYpDRzW3Ke5JIn3XzjQ3F6GM0mXMob3DybT5rgnq2juO3RHcpQU2ShWNFZjJrsbXkCC2OSR9H
	1Xr+q9X7+zuJycDaJEPfxcR3ddW63kcDYvZ/jWnl4ZP8fdhIboOV3jgPuuTSGsHgyzcLFQZixvj
	Nn0M1z4/eJ6Sb+5tIMMAJOppVHwG3cT36ctbaS4GTSUGbfU4/1oV230B+bVyJxC52HmFXkS+Fys
	i/UI6EZ/qnoA02sUULqIRnDo1uT8CCKXUnnehkWn39c3JX/tG6quMq7PBaIg4kD2stLklX0fywv
	7iyXwG2+N8MuqkCoyLNa8ulX9/Ib7V2J4IiGgjSZzHdwuWQgUBkPD8XtQCyl8xZxRJ/UfwWvNzk
	iG60TSr
X-Received: by 2002:a05:620a:7112:b0:92e:c117:5ed6 with SMTP id af79cd13be357-9348722049emr163028885a.86.1785404283293;
        Thu, 30 Jul 2026 02:38:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.254.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e733d933sm387647685a.35.2026.07.30.02.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:38:02 -0700 (PDT)
Message-ID: <6a6b1b7a.517c639a.12d8d8.6df0@mx.google.com>
Date: Thu, 30 Jul 2026 02:38:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3733967846800653032=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add CS procedure data aggregation and D-Bus export
In-Reply-To: <20260730064007.1229304-2-naga.akella@oss.qualcomm.com>
References: <20260730064007.1229304-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3733967846800653032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137145

---Test result---

Test Summary:
CheckPatch                    PASS      2.23 seconds
GitLint                       PASS      0.99 seconds
BuildEll                      PASS      20.89 seconds
BluezMake                     PASS      545.82 seconds
MakeCheck                     PASS      19.66 seconds
MakeDistcheck                 PASS      158.94 seconds
CheckValgrind                 PASS      227.97 seconds
CheckSmatch                   PASS      312.51 seconds
bluezmakeextell               PASS      103.17 seconds
IncrementalBuild              PASS      548.86 seconds
ScanBuild                     PASS      983.39 seconds



https://github.com/bluez/bluez/pull/2362

---
Regards,
Linux Bluetooth


--===============3733967846800653032==--
