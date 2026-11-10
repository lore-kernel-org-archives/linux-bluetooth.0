Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349161;
	b=MMXqAy9/KJiXasJWCHeEHEVePL4KN7wEpJ+GUX1Ey0Zdz0/vRVW/VT+DOQcIaQlD6o3S
	 6oT4UxuxUw9DsPIzXCbSgkqZQYZ6ZYf8FQiBPxyLOq0LaQUBvBO0x4luCDIir/iOYOX0B
	 nojinP8tJlKyIZtHZNhDO6yUMDAUx84HCnQoaVEmfU5kqtmOSs8KP4w2HkAmwTuOwpD1S
	 TQ7aaPt72xwYVDP/JjmxTsoFNq0isn5s600adRoTcaK8v2lBnjp2B3Oepy11ODo4WT2q6
	 jebdPb6ImGbbIeKlFGx6xROFEPrjvsdO31gQqDb1cAykN1NySsbteegIhC8xPwFYMFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TjY9zSrkC734sNNf3zrD6jRhAI0jkRfaGTgTOHSNW/M=;
	b=B7Vo66VPeFHpOVmOq5WcS+bKufyi6FtwZAD5KDUwR0OIceIasrsDP/v+aSRyaCRwsyYu
	 NF2i5dJSmY13435mmdEdv5/tjixR/Bfblir9RifB/522MWUS4L8Z0WtCwQuawRSrlUkwP
	 PRZ1Qp23wpsM/rVkfpBCRiCB/pTatd31EfZ7ilJFQusMP6aUz5kMtKukD0irhmyBoWFeI
	 5fJW5iiozqH5o4y/Spai2M7Z6RqhMORVVUhS/6qHAU9Mf1J5estCdA51/hoWSq+XYDsSw
	 uGkkCVwypsK5hlTM5UYuh+dS1sc0OKWZn1Hqu0tNKW6oytiIzROscbHNhx/I23DkqPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxepLRU+;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532E606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9532E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxepLRU+
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5ed2f163a2fso798494e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349159; x=1794953959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TjY9zSrkC734sNNf3zrD6jRhAI0jkRfaGTgTOHSNW/M=;
        b=hxepLRU+hVEddgYY3FPaCxt3QJpScrSVX3Na12PevkLHbToClq8PqrGl3JsLVP99qE
         gsCfuwsFX49G1Y2PcRMxLCdARGhGRW9YXMC9fPviDSXl+IALNEFoA+ZaKiIhDkq7zUq8
         3K298HtvKpwVBJPYqOz068aieiP0pkMBCjg/y+och19Cw9OLMemQny7ZsZMEUDylPQ/9
         N+pvvuobj/iTZ76r4MDhyuE1uc+tKeffKgda9LoRmqWAbIBhBVo3HgN2UNVx942lQ1hM
         Cy4bvC7I1cOD7ShjKtxUE/wV9lSsW4H0t1u1VArAUZoi8/HCr3nNpKcl4boJuXUJuw7w
         TWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349159; x=1794953959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TjY9zSrkC734sNNf3zrD6jRhAI0jkRfaGTgTOHSNW/M=;
        b=ScPxDA0ydSWrDtIfRllwjxawqlDe7lcOPOqRK7ob5jjokn/inqbj9kWDHOoNW4TZGz
         95xmbtdvBx+e3uB0OJSMF/SplulwgxsHigZhc8HspWANrYJhxS/1/1zYWEt/6z3SpqNA
         oo3fuiof0qHssw/ru2QlMX5yUGSs5SpBmUrQEb6KKtdny/v5Qtv1XLrE5dJ+OARnUHUC
         xrdNJu8XY79AVWvEOXdwb0hyr894hNAhVHcGXZrHiFL/W+sZkYIlJRqcWnI+JG7Fa4t9
         cFnO/V63U4myna1pHzig5uqw/53qI6xZcDSdt7Z6j9p22HinZRI5wxt1Zllh3J56ac+O
         PQaA==
X-Gm-Message-State: APuU4Z9MDuipWUOLO0+lXTHekIwLXhX0GFBT3gR1tGDNo8bm21tlpS0h
	XTOegyRRCPbLZNMOxCvpOFeNKQ3eObYlMnRwtcaQmUvJo8Hjy6avauw8jo5PGQ==
X-Gm-Gg: AYBFou244oLDkY8UKv5GrprG1TMISY/cw4oIXW23/zVSFlq+83qIOLc79PQkC4LqHLM
	BeP8ZDjV1W8W8yeSdr6CMgHti+pUYB2iE75oSjLH7yTsVGqler+u5di5Jj/5tunsS5EyfjMDbvX
	Zslp07cwyEw/QakuMm+U2kkWhYdz3FBQ1RrY9gixdmuOvziqultM5SJMyUNPw95w6/RnwxSvrTn
	bdbgrfi3Csz/+2d5rCyx+Cl7BZFmz/+uep17L3Hirizm7ly7mjhrIqgw43WE5yclVS7aLAOvZlW
	TT5trTO2icXD0e5Ckve5p43G0ts37dWVHomFnzZ9/SOxTjCHBT3P0ZckzxKyN2DxrapPsS80+97
	un3pO3jYSV+EJD6ETr6aYZtmQxg2P2I+pbTTXBGpjcw4C5oQKZRQ0pZIRDTYH0lDHTWT3hseN/J
	6uQygiVgYjpBhP16FDi0g9SIsQJ6JgIgdF759bjmmg1MdPv/Hf8K0A3nrjST+AljDvyQv9f2b+R
	Naksdc95xfhzL/qQY9KcP5StyQlDSI9FBZ/DPAKCUw/2ZwnaG2DjCooH1/HfO6+aJv51Q9VecbG
	UfoVJlRUMJXP+y6btB0gvn0uowdx5G5l40ag4sz1M95XISYLD4WOJV8MOg/E3kmJZxTuLbCSnXR
	gtwjJz0JSps13fSVU3ey1HQ3fFL8qrDgNG+++7mGHU8vyNkqC/3GNS4jW2/4LptTRwyi8kLBYuT
	btY2E=
X-Received: by 2002:a05:6122:130f:b0:5ea:c6c1:8dd4 with SMTP id 71dfb90a1353d-5ee1c3e700dmr105056e0c.5.1794349159352;
        Tue, 10 Nov 2026 14:19:19 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/4] shared/bap: Don't disconnect a CIS still used by another ASE
Date: Tue, 10 Nov 2026 17:18:58 -0500
Message-ID: <cover.1794349049.git.luiz.von.dentz@intel.com>
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

Luiz Augusto von Dentz (4):
  shared/bap: Don't disconnect a CIS still configured for a link
  unit/test-bap: Add tests for a CIS shared by two ASEs
  doc/functional-bap: Document switching the direction of a CIS
  test: functional: Cover switching the direction of a CIS

 doc/functional-bap.rst      |  37 ++++++
 src/shared/bap.c            |  84 +++++++++----
 test/functional/test_bap.py |  68 +++++++++++
 unit/test-bap.c             | 227 ++++++++++++++++++++++++++++++++++++
 4 files changed, 391 insertions(+), 25 deletions(-)

-- 
2.56.0

