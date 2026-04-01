Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD36D1D5151
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072914; cv=none; b=kAt8994oywO1aT4+35A4Ih0tgMJ5qO3yDCo/wVTVtNMIZo8DsBgg3SBFqhMop/XndTI+MneNpSZV8zJe1lRhQw1UUDdMU7d7iaQzk/PUu+NYcdY1twdgsxj8V0feyR6zrd3Mgt7nIAN5/qcKRFeygW+gPtDf2VHeGoGn+77toMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072914; c=relaxed/simple;
	bh=edQ7UV4MAK+xuGn4+pH0jc2DEzt3IKbG5B5YJ68DMKE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uRoHXW+tQ2+RjuYR+gipJ9UcBzkKHLBUsizC5m6oH7xjGYe+PvC32B9WQed4WHmp2K/FzA5oLYc1g3gLN0YuOwBFvcEj0Ea3tAtb7lRmYqNrlzRFWcvngyMMZPIYPQxbKUqCmrosaIqb0YY/XlHVnGIv3EeYe3A7MGTea5T1iLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCE4RTb2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCE4RTb2"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cfc1aced74so22876585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775072912; x=1775677712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0y4ifFKePVEaS7N43SPv7Gka0QvK9WyWUPWs0kmRho=;
        b=kCE4RTb2/0b4DM0eeNw/1ER9Qw4QIOQ6v2E8ELdxDzHea9JOMRdPr66oVSbqlbk+kr
         ziRm99brmwSfjKeFbg4irqziGkmu3vQHHxfAdYRDZBEBrBWG+ck1dLxOkQKz9CgdmmAM
         DvZT9FLhVY6qFae1rofEYGPPZaZqHYB4LXMbB3MA5LX+S5fMH1+er7BIUWZrkauVyyxs
         643+7iE9KsHgPp1crm+AZRcaAiAVYjSfMp72p2xKJtL0lmop0MQDdonQFmaPVAhFTByn
         GGmvLDTQXUcWNyeaBZ5kVxh7vyoevZZP/VUX2zTsJrpaM4HCVSyH2cEFCAyBUkcrY76+
         NcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072912; x=1775677712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0y4ifFKePVEaS7N43SPv7Gka0QvK9WyWUPWs0kmRho=;
        b=DNHDAj8LwHGNUn6j57DnC75bSS+TIBUQvGI6IPU2zkHU4pCVdT6rGwT27suzt2qMxi
         fOIpP4uUBNh1nKV4+LPML8VNjugkQ6qR6WhAX6DlIAhmFzg31uGbrHYFLUaTN9unJGlf
         roFeVjnUup00R3pGaY+EN5Uz8jTIi12N0hjD0Y9iyneSPJFQr4bu3SWMUW/Kgks3U25M
         udsFs/0HH50s4n/mSLzG6W8XY7ahNkgG3P0/Ooc8e40sShWyPA6JRi81jJQ0VSjJ3g79
         KPQbEIsLLwsi1Yz6FaC9Y7sxIvnOOJZy86rsOaJ6ACiW4GW7QUCQ7L4SqAFdJJDeZjii
         w7vQ==
X-Gm-Message-State: AOJu0YxQr8w2AclOgFDSTGa9Cu46XT1poPtjJAFmhR/aYozXGO9QaXlu
	Z2MHZDz9gBaLZLKs3Fcp28fscoqAFXDYl67Yovabsyn/0i+XXr9A4NLNbxBk9A==
X-Gm-Gg: ATEYQzwncIaIwsWsW2W6xAvdVeazprlH6guyoC7ydBm6Mycjzlgi77yfuBz+C8j6TAs
	pB6eH9WYxZvuNEbn4AimmHcjf+vN1KYYHshyAY9hyEj+OODKxJ7L14ylDg+SGY+nkw9A/FLuDSL
	ViJTXYVNZCoYtODscGifyJEkCkPtK2GxAKGZCmGK+LXtzcF5rbTFK+gB8c0WAJXYyAI7DG0YYkQ
	YSDJZF1odViFhxttBna2p2IvEawH9I9oHBfdJ+PJlUHCshvWOelosmaznHXF4HYHbgzmkAyxZ6t
	1tiODEnsNVEoHX0VxZzaM60yYldjTq1ZtwwfVpxXZfUu2+uk3zyX1Jz5J4Mm5A4uumHtO1qt0X1
	eX6jGnD/j/gnTqVsh0z+ACleNjRczSdwGxsvMYQpLpFK85eIQDSLxTXWfIPhwEAaXF1AeA+q0/u
	/l/SOPLSK3hlshaBr75IbJjoga+lqn
X-Received: by 2002:a05:620a:7085:b0:8cd:b33a:a4da with SMTP id af79cd13be357-8d1b5bde03cmr709545585a.55.1775072907835;
        Wed, 01 Apr 2026 12:48:27 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5d5a096sm54093685a.19.2026.04.01.12.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:48:27 -0700 (PDT)
Message-ID: <69cd768b.050a0220.b4801.9d7c@mx.google.com>
Date: Wed, 01 Apr 2026 12:48:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3135910502601722272=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: add btmon-mgmt.rst
In-Reply-To: <20260401180746.2074659-1-luiz.dentz@gmail.com>
References: <20260401180746.2074659-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3135910502601722272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075991

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.44 seconds
BuildEll                      PASS      19.87 seconds
BluezMake                     PASS      641.83 seconds
MakeCheck                     PASS      18.83 seconds
MakeDistcheck                 PASS      241.55 seconds
CheckValgrind                 PASS      291.43 seconds
CheckSmatch                   PASS      358.99 seconds
bluezmakeextell               PASS      187.38 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1063.61 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2001/checks

---
Regards,
Linux Bluetooth


--===============3135910502601722272==--
