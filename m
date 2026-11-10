Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349164;
	b=DnWrH8aP/qwB2uw96mPET8qakXKD2ZandhyvSUZcuV8I4WKvRrhMu46nrhAvl78GIQZz
	 Qlc8OyCI1Jn5acjSQNpCwGTeDAQEt3wRX1S5ozTGgVa6fJfZNd+Zd9lLHqb14lqRiKhAb
	 Ds3VLXflmYQ/5xq1yxC+GKWeJTO/R1Dwrl/nxI4g1a5TQHaVkChmOjToOPPSyPkoPYyo2
	 yoSu+7eg+oR8NBX2sQtaOapXJAc4099/urf8PfzsGUyUeu+kkb5NCvaOY7Fa+BsHq9r77
	 YkJ9kCaw2jIFTCUfGK3JO+YiWvdw57jozG255lCpzVWHgkvkEsKXYvBD3gg2LY6zOfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h2a3lEDqJDeuHYVlnbEcRteuBYly6owVVVK7Yu2i0o0=;
	b=CQFAg/qv3bLwcT3Qg8dPHmhNQqbr2FpuhYgOAwOrUi+dLTthgRHPY+Kq2ZRRJFcpqUW8
	 RHWoO4odpPK+Ng2aG6LST67YfuNlLzyuLuFYoOLudr7zrbDnK965pqjdhpyi1XGcZIz1r
	 7a7NEuHKlD+JoGnIupX6AcaR+jDxEhT114M3bv2dKXXcY676cQzlcO4CGNzUSDVXtLpmY
	 A/6dTv1pJgutvHgQ3w/bqTTI9mdAUY111OFBwu/dWZ21sdOu2OES45UsVXtE4eM3YCsic
	 FMIylgxIRswXtN4iEfRxqwWqMmYP3bHtd3k6TRx5C03KAYAWO/BB7HfZXBaaB+mCsEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ddx9Scx1;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0892606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0892606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ddx9Scx1
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ec6f271883so1589409e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349163; x=1794953963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h2a3lEDqJDeuHYVlnbEcRteuBYly6owVVVK7Yu2i0o0=;
        b=Ddx9Scx1tCzjI4BXOnepGO+Uhobo0RJ4O4MRs+rPCo2iRgCHOBvvl2jtrpudTImn3+
         2BI7v6c+Cjf18SW02G62jKWhW2M2AtSLabBrrsZ1bbhDuduOAxecgV/QRTFZC6kf43du
         kak/8uNi3wm3EAI/8rabnP6kaTeDmAe5Kq9Cat1IizPET0eXOAdp+OzqzZymMx15V7ai
         ewO6bfAnt4aAnHGGpkSpmle7sUZ2oOZJ8QLbY/Xy6wCFBK6sEZ6rEUfUq59qv3hntJc5
         jvOIAMVUKMecqnvl98mXnFgCYS7DDXXgHLNiiJsaC8YXeXrZB/VLUjZGmXEkvTe9uEAl
         IgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349163; x=1794953963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h2a3lEDqJDeuHYVlnbEcRteuBYly6owVVVK7Yu2i0o0=;
        b=bPtmwWzaH18wfZRmcvC7YdP/3hZqZB7N78K0vGKmAy8KntbdgCNPPgad2bpS2R08Vz
         uZqArxK1oDXn4MNTIi1VokM/I6Bbrlti7nRxqOPU9nG/b+MdyDVnt1PCxKjds1Anruut
         FrGvoViV3ILRmbNEYitP2PVlqdWzzNYpKzg4yZpwQ/ZdVhFq+QjI7udbWNNil05o1lBi
         hSbRvvBgzqJMpuvwJ3Ixi4B/j4H8tKUs/8Et0QDqhffw2wajgrYUuSZ8Wbera8smM9Iy
         aPghxEWAtqtV6DNfZGloHnuxfVP76fL2QGcgDM0QZWLAm6Kn+gIo2u3yQDkvW0BU+EAa
         5YKg==
X-Gm-Message-State: APuU4Z+Xd42qESI5XY205FSmMv3gVzFR65FQ7zURD4+gD9hj99KAKPdC
	CFJjlwPZV36B1X8Gvx3jLy5U8NeaRtot3V8HtZTBkdZrDZqzjc3pqdsRMhUL4A==
X-Gm-Gg: AYBFou28UC1Q0k8pZ8pk0GL1RqPVo/WIKH3r/ABi01ATvb1WkqmOt63kP1vj8UKnX6t
	kf5FEtJwQRWaOXQqOMH1OfcIOxY+qPsY0dYmNdOu9m9SJSOerH65tz9dEHEb4kvktBKN0Fx1blp
	UuQCF4H1Xa1jMdK0aretFNqotxqv9GRr950mGp8LoYoX9uDvXY/PJfcRPvByTHImtV5bMmdEgy3
	08GH+4yyMdyuvSE+uAlnm73BueBLbTnxIipZ3d4uKQW4cGVZEATsczvvCadgsJkgTtjN62A0kon
	UOEnAJytmRW5IoupWXwURkXHbkiyr5+r8IMraPuXke9U9Fj56KxNjxVRK1oYchvtlRsk353PZrb
	KdjiDqqQnVFngOtrCCoGcS/8hNXaNHODnn407v47gsHJiHV3gAvuZTpZXCV900p9aCaH7xMC7uU
	LKjDxMzDl/ttwgc4/kqZJVYjkAkuSxHEewe4GeFovCKnxULxJGLa/i56YJuK3TVQ0tLky1EQETJ
	sQYfULIHn7eLL0K2P7EEU8xFAipfKg/6/wKVqoNd49IesAP58KIJQADvyCPTgTBC3CjUSFeC9/F
	SNGM2D5JbTS2tjD/q5EHue0nZm1n2kAH5qZuFaTwaGKRAbs37d/h9WJRBAiyzijE7mpUknpbe9W
	/xfzOcLEFTeN/ejvmMhFh0cM6qS3RaqAFW0KBjqS33eAuYshnxfzLFmhyuwuZQsFlZbluj0AolE
	/mFIK/
X-Received: by 2002:a05:6122:e230:b0:5ea:b712:8281 with SMTP id 71dfb90a1353d-5ee1c433612mr122252e0c.18.1794349162724;
        Tue, 10 Nov 2026 14:19:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] doc/functional-bap: Document switching the direction of a CIS
Date: Tue, 10 Nov 2026 17:19:01 -0500
Message-ID: <71000f351a34e86285487d714d071113cadd08e9.1794349049.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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

Describe the test where the initiator disables the Source ASE of the
acceptor and enables its Sink ASE right after, over the same CIS, as a
phone may do when switching a headset from its microphone to its
speaker.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index fc367e0f9181..8f3f8e62cd4a 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -269,6 +269,43 @@ test_bap_unicast_duplex_enable_one
 	made active through its link, so the test checks the state of the
 	transport rather than the result of the acquisition.
 
+test_bap_unicast_duplex_switch
+------------------------------
+
+:Setup: As above, with both transports created and linked, and
+	desynchronized on the initiator.
+
+:Steps:
+	1. Initiator: ``transport.acquire <source transport>``.
+	2. Initiator: ``transport.release <source transport>``, then right
+	   after ``transport.acquire <sink transport>``.
+	3. Initiator: ``transport.release <sink transport>``, then
+	   ``transport.acquire <source transport>``.
+
+:Expected:
+	1. The Source ASE transport moves to ``State: active`` on both hosts.
+	2. The Source ASE transport moves back to ``State: idle`` and the
+	   Sink ASE one to ``State: active`` on both hosts, over the CIS
+	   established in step 1, which neither host disconnects while the
+	   Sink ASE is still configured for it: the acceptor is asked to
+	   accept a single CIS up to this point.
+	3. Once neither ASE is enabled the CIS is disconnected, and the
+	   Source ASE transport moves to ``State: active`` again on both
+	   hosts, over a new CIS.
+
+:Notes: Reproduces a remote initiator, e.g. a phone in a voice call,
+	switching a headset from its microphone to its speaker over the
+	same CIS. An acceptor disconnecting the CIS when the Source ASE is
+	disabled leaves the Sink ASE enabled without a CIS, as the
+	initiator does not establish it again, so the Sink ASE transport
+	never becomes pending.
+
+	`bluetoothd` as initiator establishes a new CIS when needed, so the
+	switch still succeeds when the acceptor disconnects the CIS, over a
+	second one. The test tells them apart by counting the CIS requests
+	seen by the controller of the acceptor, recorded with `btmon`,
+	rather than by the states of the transports.
+
 BROADCAST
 =========
 
-- 
2.56.0

