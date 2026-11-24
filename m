Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497813;
	b=pFs38qHHjUgNZ+lTtzKw2KgZXPzcp6+8uKqRCRcWDpg7d3TFW9kguq7WhiXvdWo5hjIp
	 kfzy6auFEF4U6r0zvtLLkkW0nsaXWPFQQ95LlL6d06XBq5JiprbRIvSccuifdaC6i5mXY
	 xq/oodkzbRbjWyh7UFpbcd0HW3/t9JCLogU2cq6R7VlwdpLbS+1E3F1Kjpil1EpOvxj78
	 rdDLtx8Gkxz/AK3v2DVfjdvpxtgk/d0dM5H2liazhp1hqLCFKLF44NmeeUybGTfZ1lLrm
	 kh2YzL1G7zWED+mfTcOnQVoC8sURDfljP9u/6CYpL3AsFlOOZGW8HtPQIOYlZ3yhjQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497813;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Jwu7IiC2AFXPatqrZsuA4eukv4aV4ljetc5+yo5vsuQ=;
	b=m+QCmg+Q4vBUoQM5RpkOvB85sWksHbqadkMcGneaezcxvtjf1ZQJQBVsSRJyd8jOev7u
	 0iNMx/AX2RuRG2MqNG8ZmwYHxqEzC6gDCnc6ZobV0iuq8AnoRbqdDpD9rDeHx+eufwJsL
	 nkjngfA7/RxEso8DjXqxQlbleCksd5XdibqeQ1yC4chNkZvJg9kRAhCXeXubvn4pvEvca
	 aWq/v+0TcNnMGWoGsPAosG0q88lZ5BP1mdYlGgzKwLFf0MzuYTac3WvodQCALMDHyoSqU
	 /TYI4dtMEjW8WAkK82mHTz5AJWKS4qfqIlxMOlZKrEJxWf5vSdyEpsI8cNsclswepXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ojl33twjlbezbcmjhqz3asioy4.protonmail2 header.b=TQzb4zS4;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFA606A31E;
	Tue, 24 Nov 2026 05:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DFA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ojl33twjlbezbcmjhqz3asioy4.protonmail2 header.b=TQzb4zS4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ojl33twjlbezbcmjhqz3asioy4.protonmail2; t=1795497808;
	x=1795757008; bh=Jwu7IiC2AFXPatqrZsuA4eukv4aV4ljetc5+yo5vsuQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TQzb4zS4bom0jXlJqlQ9k4ogvP449iqzn3pQKLu4BQKEKaWhiPeGRK2A4w0uM7m88
	 pbz5xdfP0JKX3a0a56lRRri8PrsA6ZqPDWISqH7Qg5dsU/lQPO5roPPYCPKUM4MEm+
	 0uZSq2FrT0EjzsvE/Xg0q9tig96ea3C+PlTf/uy+PEgSMvDaAPDyMP08rq5iNEPH7h
	 wEXBjIiLhOgI1nT6LlDcmd0DiQY3Z9ZrUbJVLaBw3cGztEUfW+PtHMWSTgNZ4yAQR2
	 7xH/IA4AOg5mbMw/bkiQL9KNFEjZigJ0IdWyzXPIPF8kIACzrupTWMYl45gIHRws2d
	 MYqjkkvA30QPQ==
Date: Tue, 24 Nov 2026 05:23:25 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4] Bluetooth: l2cap: prefer compatible local LE intervals
Message-ID: <b6847b841127362e423b49f9e48118f97985865d.1795497229.git.cochcoder@proton.me>
In-Reply-To: <20261015181041.42873-1-cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me> <20261015043336.47734-1-cochcoder@proton.me> <20261015181041.42873-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 02f18cd759817a59359ded5c3dc0c21caf4dec37
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Prefer the intersection of a valid peer interval range and local
preferences when they overlap. Otherwise retain the peer request
instead of treating an initial preference as a hard supported bound.

Validate the original request before narrowing its interval range.
Leave latency, timeout and disjoint-range acceptance unchanged.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:GPT-6
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Previous version: https://lore.kernel.org/r/20261015181041.42873-1-cochcode=
r@proton.me

Changes since v3:
- Drop redundant candidate revalidation on the corrected upstream
  product-based validator (c1d50a71cdee). Validate the original
  request first; retain disjoint fallback and peer latency/timeout.

The local range remains a preference, not a hard peer bound.

Validation:
- GCC/Clang ASan+UBSan: 397,723 source-extracted kernel parameter
  cases, framing/role and rejection controls; 310 tester callback controls.
- GCC/Clang W=3D1 kernel object builds; BlueZ GCC build and make check
  (35/35); ten interval cases register.
Fresh native interval/VM/controller runs are unavailable on this host.
The callback fixtures mock peer I/O and reporting; they do not replace
native integration testing. Remote CI and interoperability remain open.

The stock mail checker rejects the required Assisted-by tag format;
source-only checkpatch passes. Attribution is retained.

AI assistance: source review, test coverage, simplification and wording.

 net/bluetooth/l2cap_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc86..4f4625b97 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5089,6 +5089,17 @@ static inline int l2cap_conn_param_update_req(struct=
 l2cap_conn *conn,
 =09memset(&rsp, 0, sizeof(rsp));
=20
 =09err =3D hci_check_conn_params(min, max, latency, to_multiplier);
+=09if (!err) {
+=09=09u16 pref_min =3D max_t(u16, min, hcon->le_conn_min_interval);
+=09=09u16 pref_max =3D min_t(u16, max, hcon->le_conn_max_interval);
+
+=09=09/* Local preferences must not reject a valid peer request. */
+=09=09if (pref_min <=3D pref_max) {
+=09=09=09min =3D pref_min;
+=09=09=09max =3D pref_max;
+=09=09}
+=09}
+
 =09if (err)
 =09=09rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 =09else

base-commit: ffb95458a0f70dcab620eee0ecf5ef7750971b2f

