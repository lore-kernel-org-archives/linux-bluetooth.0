Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794505254;
	b=R4hc6mjsOMJZWqKbAR3J806fGYJ9GKfrsbUT8f9H02KrxhHSNpaWq81SZYKVyKa0UqRr
	 NnotZ8tDQh+shnkm73BfXJRP8faGAnsVNUWpPejRlypG3NCuo80rXxa9l9l7KCDE+L4PC
	 jikllHQ81n3vpl7cYMjiWRt1ZFzBqmm6dLWEVuHh67YXws6Cg0VmiL1Cf6PkiAmPlsH0O
	 FJwcH0KkDuca2dMRtl9WY8SaKzQwYr0GDga1t+J2aj7XWXmZvScEVSPenrO+f0de6czqL
	 hYG0YCskCElrSYTwIz2FgB1t9FRjyor/EjBUNi57W3VF3dmFwI2CTQBVOjClPO6FgPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505254;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=FT/D8h9pnAh2CPXVmiOkBMfR8/2xjKixdcmUIwUrsDo=;
	b=VF89MRUXSoHpYmIxShH6EqgqbfVmKeFlGORC58MAaeJ637l7/OZPrvatoR7vDYbKKLZV
	 3Gk58UnjFcN5/YidXMWNPvB4+ly3Z5I3L9rtIImDsRI9c9zJJMDAHvPz5KRojbF/5EGTT
	 5al7EZ+6CsIYSVdLHXA0bsPfbCioqWek3/nbsggiXq02Nl9Mpe5aPx8dA5We1t+cv4UGZ
	 F33Mux9ezLmi3qJ7o/eOPvnaVf2pSQAcA+opyACjpGuK0KDZybyhFg0ImzAZvFqmlahll
	 DI9s9QVqWm20zNjhi8pXQhh7e+29jFf7gK/BPa4iqHO3D3IoqDnaAa+srgQ3lDp3IGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL1Mam5t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35128606A211
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL1Mam5t
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794505253;
	b=nBx4ykkYs70zzblk06oMcM6DZwId3DCZjXjT9bpGLlmDkOxTB8E4Pxk7yqsfhTM1HjQT
	 jSFyaaViL2pYIRMGNkbc92743Q/U9wn4bOxJOQQa2ZWR1tKi9JevrNR0/R+VsY7biiMz1
	 DNkonKLFJXZBhBx5pY7Zly96iJRp+l3AxCNlrb07DPSpldEoRDxVznvvtkFerU0lkN8Lu
	 To1sPh4BqUEx59SGLDm2alcw+2PjQzHuxV3aJ83SLNBo010U/eLM9ZNVnZJ2vaHka4sKi
	 vDP+LywioMfIgSFerxFsMGF7aZmJh/8HG8Wql/++L+sb+2qt9jOASH3KcJateCoUNjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794505253;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FT/D8h9pnAh2CPXVmiOkBMfR8/2xjKixdcmUIwUrsDo=;
	b=DmnfUNjhKqZXyHqENrwLXBhP1EGSnbYjJUR/uusSguyAAl5tiJjGu7tUnzR+RWQoHqgY
	 RAPpqUVRW8K8/1Jxj18nqodkoHCkArsnCk7CbGzbZBBdeBvjfwaWrldeOBgAmcieGnx8y
	 hw1yNaM/rN8JCVdkUnZVDKq6VJfSDfwE3zsbeg+uciYtF5dleAYf1PUBGrlJzFo3qFJJ/
	 e/de9rUjNC9H2EsM/Mco/0bLcshfRYn2FBXCtXpMcrtIUrsEVGpdRGFxMiLDXwCxUlROi
	 eOUR3+g2xnYZ2Tb5ixIteW4vRrWmbcWx2d1lfjzgkMGNDLqdVN+eeIOSQbnbg6P9VRQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A10D1F000C4
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505253;
	bh=FT/D8h9pnAh2CPXVmiOkBMfR8/2xjKixdcmUIwUrsDo=;
	h=From:Subject:Date:To:Reply-To;
	b=jL1Mam5t8fGUdNARIy8q/S2iolYFqingEZdTShBQlIv3pxlgx5+Mh5P1IQRlLNcIx
	 IJCLsT7acoYeoholGOfZxh7C9QOt/WjazH9lJ/InkUWG2whvL2KU+coBH+eJBiMqpT
	 ethE2maQuF+MMlIFWdZ/pA7TAyxAO4cji0geaLaadzOAT8C14lbekCERgbifj2ukPt
	 mg1o+XKCpgNYeog8gVJBaIORGG+Wg+Gyam9na462l75aB0J9q1Zq7AMKIW0bmKnoud
	 AisQ52VXRZxUVhIoITP/w/YrxPzEXXT3317fwHuGU5SSQ26cT9grkUORs6WooA+0JE
	 nhDMEOA1flHow==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DFA6145A78
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:52 +0000 (UTC)
From: Marian Poltak via B4 Relay <devnull+marianpoltak.gmail.com@kernel.org>
Subject: [PATCH bluez 0/2] shared/gatt-client: Fix init when Service
 Changed lacks Indicate
Date: Thu, 12 Nov 2026 18:40:52 +0100
Message-Id: <20261112-svc-chngd-notify-only-v1-0-c7db7ac47acf@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAyA4VeRnA0sVQb6KuLBNakGJJV2kznx3
 Vc8fof/PyFLUsnQVyck2TVrtAKqK/DLZLOgcjG4h3sSkcO8e/SLzYwW3xoOjLYeGIiJu46b0LR
 Q2i1J0O/9HeC1fuQH43X9AU98HdRuAAAA
X-Change-ID: 20261112-svc-chngd-notify-only-f1d1d99d3f34
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794505252; l=923;
 i=marianpoltak@gmail.com; s=20261112; h=from:subject:message-id;
 bh=A66skHcAAlDfhvBqoejBHvaNOhKROvLL9YnYeX/oPI4=;
 b=eq5rpINfsdVrWv+ryg9t6cZl0lvGMi3CaZGG6MXfCcDKMd2EvKJVzjD9jGlazGuwCiutaJjFN
 gJS62XMtZ9zBTqPCLp4ims6qslSWWw9wyfyWtQT60yse+Gg4Eol7eoK
X-Developer-Key: i=marianpoltak@gmail.com; a=ed25519;
 pk=VPxSnAMaNkyjfVbKo8tQ1gFPwqOoZoPqtVZ8znSiAiA=
X-Endpoint-Received: by B4 Relay for marianpoltak@gmail.com/20261112 with
 auth_id=1502
X-Original-From: Marian Poltak <marianpoltak@gmail.com>
Reply-To: marianpoltak@gmail.com

Some devices, e.g. the Aqara Presence Sensor P2 in Matter commissioning
mode, declare the Service Changed characteristic as Read | Notify only.
The client initialization then fails because indications are requested
explicitly, so no services are exported although ServicesResolved is
set.

Patch 1 requests indications only when the characteristic supports
them. Patch 2 adds unit tests for both cases.

---
Marian Poltak (2):
      shared/gatt-client: Fix init when Service Changed lacks Indicate
      unit/test-gatt: Add Service Changed registration tests

 src/shared/gatt-client.c | 15 ++++++++++++++-
 unit/test-gatt.c         | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
---
base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
change-id: 20261112-svc-chngd-notify-only-f1d1d99d3f34

Best regards,
-- 
Marian Poltak <marianpoltak@gmail.com>


