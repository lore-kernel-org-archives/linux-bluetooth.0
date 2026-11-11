Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429465;
	b=o3DZaOC7Tvh55jM/Ae6ZaB3nF6GdmU5/HapqsnJF3w4nVwtRfoF0lc1yZBLhZk7sHHxY
	 vNEaVdyUZrO1L9Gxis2wBjPIiR1BAQxBCopB5/PZb2MsOg8eSAVG30IbYd5gIlj1D6Em/
	 FGCbZBy9DtNHJUgfSAkmjTqnVg9pwaIaV1Uh1U0n3/w753rdmhr1DdO4TjVXAAqt26Xq9
	 fjDJwpE0DmgRGO8Tql3xXehN4VBLwkZq3l8ljuLUSQJS37EJQGup1VVf6zaLS9/1t25Y9
	 vDnCWARMo2FhssLqlOcIigrnbbIP2VsJKhF+kF0/EEn6ylZ3e3unk87YYRpEUOiFkrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lJ/T2ojLJz9J2y9+jRv76agWIeKrZTEIqHnZmgoDlrw=;
	b=StnU++aQf+3q1Pu1TiSmnXf5RqpZrqTW07tv7WfcknT4FUqQnwM1zdE3m7OHm9ZPuc2d
	 Vx2Cqk/cQTMJr1jFpRzfVoefeicDIA5pAOZrFpKwidLGe2xS69rvBtneaZQ01j95mRCbh
	 GhRITpo9x1QZhjJgQ+0qa6oNQ75V6GcBuuFyCe5oA3tXwiE6DVvSWZXqVAGFbvCTZcWrg
	 kjt5YzubZ9F+1xXz6oJxQe4rEJqOkjz4tCz3hP5z/a/AUEex89mlg7ESTUwTokMzfVCdd
	 2ZW2jsm20QdvrV3h0IaP1g0RmRli/tpX9XToMDD65+fFdEw88bKywQqvaa6CYA89HZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bjilzmv5;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5D606A8B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26D5D606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bjilzmv5
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc53938a8fso2348449137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429464; x=1795034264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJ/T2ojLJz9J2y9+jRv76agWIeKrZTEIqHnZmgoDlrw=;
        b=Bjilzmv5izRq+hPViFUJcmLmZX9GBp1B5yybMwVbg6pb50vT4QjJ0eUxoZKW6P5B0J
         00+p6TqvtZoa1ddZfAa9qbgJUD/4PnKiefLQNOElLS7qZNPPaE30pWfjx+IzXmSfhX0y
         lsaFcEcccIeLfLJyq6rlWFEQdlUZGqcCV1r67MQF+s9UHTaUYMQQXmsxj1X8QI5rm2fE
         l9aPod0OdFeELyjHKbGX8b3WmwgU2SW/EzH+vq1S6kkJr8Xz0qjK7tPNa+mO0OzIB8xY
         ouOT1eI+JfDery0mS/LhAgwLND0rswaeBX/NZntJe39MOOdEYw6Ejef7FE76cG6fM50b
         ROiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429464; x=1795034264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lJ/T2ojLJz9J2y9+jRv76agWIeKrZTEIqHnZmgoDlrw=;
        b=VsOjhdVnneb2IKvIhnUnudfAUGa1D5jU+kSp60SJOR57eXkpxSuTFmyx+BY9o01/nx
         fFbwuxxocdQMlBVjYRu/ep6bAucDovddB/MmJIIjHmyhLDhGZAhqY4vtBKCxkrXc1t2l
         66HbcWSxEHUEmL7F1wZ3x057j/Nr763tufgN8sNb9T/TF87gy1+pKDms8KeGs7y2CnfH
         rcEB/TQylDNelSYpeUBJQK9ns9Yv4Ajt8/aNgab36OmOe9bnstix/qeH2VUNT71uEU/G
         MgY8VZaPTr/Em/jwCcTO8jaxfhgoVJWlHMY/mTQUZVRe2X65z33X9wTQO1irXaTyr3kg
         yh4A==
X-Gm-Message-State: APuU4Z9X6yh4EGBz6AArqCli9ZFuOHq5fOoBwpAn7QDynlgDImOvKKQ8
	JlYt7uEfUseHJkha4+usYVx5fS2GEem/wwGyOZHLCAQX/ijisI55+H8rgrRj8w==
X-Gm-Gg: AYBFou2QnfUK6trkNbi6ZEk2mSgKAzMGUi896rYW+NYPF+kBMFW7pyDEzdj6LqITu9l
	b3S67paPCL1yB2lNF5KTXyA0Vyu+TICX8oKeVmnugm9fBRRpOKdKnFNbBQ6vMbJSiJBLWlHTPOS
	F74MkeuS8TWtdg13INddPz57cKCs4iibo6W8zLex8evNfNrdWm4l7omCGPX7ALUczPHyogt71/n
	4VoHEJA9mLEHc1cIL5r6FDB5tu5bRfqcxEB52kFYFSVoHwSGPhEdeQQayeIH2vxWYur0Iz499B7
	GNvO+4TPDeBEuqcBFAEKEGqLycpJwRWPWkWt0Y55rpB95tq7X3Rj00l8HBsfWbt+CftsIEw/BUP
	sApYcGKI0/GBVPOEOmJZmKV6IWyIHjH4902NXdtUhFMt9HaF93bWva+hyI39Eybxi4MEASDOLZw
	dKH/1TLaibu5sTVD/gjKtnoK/DNfDR/g6cMTNM+/wmwC3lMcj1ErtVyYiTYHV7TdwU8rcPf20r1
	sEcXoP5tfPcjen0gSO9ewAaW54JNRy15EpK0y9Ug9Sp/kyK93Rah/7oGVmXH2XacFmwDDmeVq30
	O9cY9JpioBWss7/lwuI4145MTDWlsbzz/8L4Og5DsO+1cRlQZ/yK5LtGL83RKi/v2MwsPJxP9Ik
	syyW6JKfGFbUSS9vOAd8X45d8Wt9DrX7r59I1G3SYTANQEj4ixLle8LCydlnnYpAfxKeX+Ojqk3
	itB6k=
X-Received: by 2002:a05:6102:3f8f:b0:7a8:10eb:96ce with SMTP id ada2fe7eead31-7d4eff7be70mr1567671137.4.1794429464134;
        Wed, 11 Nov 2026 12:37:44 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/5] shared/bap: Don't disconnect a CIS still used by another ASE
Date: Wed, 11 Nov 2026 15:37:21 -0500
Message-ID: <cover.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A remote initiator, e.g. a phone in a voice call, may enable the Source
ASE of a CIS shared with a Sink ASE and then switch to the Sink ASE
alone. The acceptor disconnected the CIS when the Source ASE detached
from it, although the linked Sink ASE was still configured for it, and
as the initiator does not request the CIS again, the Sink ASE was left
enabled without a CIS and the voice stayed silent.

Keep the CIS while another ASE is still configured for it. Unit tests
cover releasing an ASE of a CIS kept by its link, of a shared CIS and
switching the direction, and a functional test counts the CIS the
acceptor is asked to accept.

v2: Also tell the streams using the CIS of a linked stream when it is
    lost, not only the ones that hold it themselves.

v3: Hold the IO of a link when an ASE enabled again over the CIS its link
    kept uses it (new patch 2/5), so disabling the link doesn't free the CIS
    while the ASE streams. The functional test covers it, and counts the
    second CIS requested after teardown.
v2: Also tell the streams using the CIS of a linked stream when it is
    lost, not only the ones that hold it themselves.

Luiz Augusto von Dentz (5):
  shared/bap: Don't disconnect a CIS still configured for a link
  shared/bap: Hold the IO of a link when using it
  unit/test-bap: Add tests for a CIS shared by two ASEs
  doc/functional-bap: Document switching the direction of a CIS
  test: functional: Cover switching the direction of a CIS

 doc/functional-bap.rst      |  44 +++++++
 src/shared/bap.c            |  91 +++++++++++----
 test/functional/test_bap.py |  86 ++++++++++++++
 unit/test-bap.c             | 227 ++++++++++++++++++++++++++++++++++++
 4 files changed, 423 insertions(+), 25 deletions(-)

-- 
2.56.0

