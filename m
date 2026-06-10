Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43437F8D6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096858; cv=none; b=QI1h9s3CzfDUguROSw4T0aPZctiJmNVUwXwHNagaGio4Z+2nGJBleaXDt9/ofeufcu+q/NuPhpDYyJJ3CGenwFT4xIcOqoCT9semAOEIbUqJJ6XeKGi3xUgzjiqNvIVQBLLAz8+rj+VTurStAInJBX7mmuGd3t5PlURL2dUI1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096858; c=relaxed/simple;
	bh=/TYS/6pwP8Z+vcQdTyI0NcBOM1/FRDWLjWRbltWe7EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAUTkt5LfRhsHMA4lSWTJMs+ZTabuGuqbfCaWYZocPPVVD2BgVINn27NL9lOXXE2ptjlQ4pK93xoA373ZAbTmLACq/5X8nlfeeOpycGkagbjYDJU5aNZdEfxERDQqIbeQjeDeo7BjuGzF39VmOkRIisc0Od30gXkwY7ZM026BF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=QsrsYSiS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGetkHBZ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="QsrsYSiS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGetkHBZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D5CB7A016E;
	Wed, 10 Jun 2026 09:07:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 09:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1781096855; x=1781183255; bh=njZ7HCXA42R1pJaHWqCJ8
	2cE/aCwZRjX4//xFw44ccQ=; b=QsrsYSiSRdyaJElzHPnKxkU6q9TGp7M0//HGY
	M8qGSPl4XdNhU1Ou+WH9bSzSbV0zhjtpePZr0kXkJMX0+0DirTiW3N26mjyyWDnE
	HpCt93H870qfQUxJi/1LneF1hhxmLDPHJjOk9oxXvjRlhQXS8xu9cEQhQA2q7pwL
	r+fXVi0WYuSX7ejAvqsLoC2s7H/CF27aTcQ2UpC0UW7rSsFmRB6mcryI2NPWcYfT
	bRUY7z+vgZbnDGA/boiWQdUIaithkGJ04kB6KSzIGL3rC97ykwxm74oRXs8Dw6mf
	0o93SsFy4Kpgbgt7Qn5ZubbGELouWQU25clsQwzrMbJd63vCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781096855; x=1781183255; bh=njZ7HCXA42R1pJaHWqCJ82cE/aCwZRjX4//
	xFw44ccQ=; b=BGetkHBZHiOJtWml85GSvD9dQslAca8BKLAD9IrJdGZriZVf6AE
	+xs9aeTJL8sUxF3+rEhJfD5o6gDqXhbJS9Ym7PA+bVXWqehlksywsI0JNhOmgoWP
	MCn5CcyWjC3Ua/rmSPG4i493p3ul/w5Qs71wchE2M6TwCk6ECKg0DeKh68LeR+aR
	S17WyFvvw6q1tFKNTUhFlPADT1pz7Eq7/4DEgLg58AvOR/7OvLnjjwa47WEBQJUa
	fsw5Di8fWAnS/6MEMLMjPFakNTGjdMZJ+jEMUmjTDJsuue7soKLhV0xroy6AEPzA
	c3Uwzt3Wu/IqpWj4/0OU001mljQyqsTvE2g==
X-ME-Sender: <xms:lmEpavifjCoFynUnD3pWke-b9ZjtTnrfC7umETEsY73zEQkULCb60w>
    <xme:lmEpajfkCrDKW_h8XpW3mcC16Kk4c-1XpHKzinu1ZomOiOtZ_1YOMIXmOOhwZVi9t
    5x8ZCb7Oky-4mHV__HzjAvhjSAGf0msj4fdlCheUDGhrNeaa9NTe_E>
X-ME-Received: <xmr:lmEpased3gYGexVQ9-oNw5JYutAxc0CEKWYqSrnIPw6FoT74tEclqI8QLA_-a3ptzJQu5cg>
X-ME-Proxy-Cause: dmFkZTGaBWgkyw+UyRMxZOB1n8e/cBQoxUgCwXBF4uCJDirP4sjMNzwMU9spFbRcgIFs44
    p1jTLFYESGQXaP8IizUU1hLqRarzsdOdI1sS0T+1Qj54cqOJktp/4Y9c4XRmsmHmDMa9oT
    XxH4sScS4BntM4De/IDrLNY8NgVAMTQzFPP+RFC5bkouTQHd0fMcVrvp74OcIjKchPWaDC
    D/hjCvOpdcHeYz/sCnJ5NtM/nnjiwlSbTyNYooNJF0kE2Y2YCwZmeg1xsIOxG5BZlj6xo3
    GASJiTo4Q1+mmWpMyTRW+ZXal6aZhIBkMG6QyPCsv06UG5vTRx4xQxn8qdp1LN5++9xCIb
    i5err0LUUdOSWUknBEtTLHd1YemYpylpH8+NSwNt/Hq/sxkbK+o5zCFi9MjE/OaEexOAE8
    4NOWOKU4Al8XhgksMTtvzPQ9wXAouv2eETj1dyOFEk/aBeNxsjNisMpSVCRnqNxnFARNai
    dc/3eoQlU8YSvxEu03jyJPFn8i333MwkSq198q7l6TWSfgVo0ntwHORBbyx6Dsq3Css6aO
    Hqt8uoW6omZ2Ko2bIKTw9lC6iEUu4LHQWhFvqhXJfm2VnWAhIuIWjXeEWHS/glwyUhPHZi
    CpSRfiYPvpLCXQSPw4RIGC5kh323+lM6VuzVFHXjhYeLRgBXthqmoF9sMJTw
X-ME-Proxy: <xmx:lmEpal97yNxrWkR-2Q8IEt3Tv7ZSVhk4h28xZhUDQn1CXrg1A08kOA>
    <xmx:lmEpagldKahruBqwXPN55ZUS9Lti72Fnkmt08k95k6lP10ACa2EZiw>
    <xmx:lmEpav8zEGAzzcIZbHMcKiehM3K3AGvI9QdM3L8ifVNugP1ip3KDUQ>
    <xmx:lmEpamlHhPSVWvFsrkIt-zSdwN_A6Nmgu6_k-s_d3AEAAM_Ih-Kc2A>
    <xmx:l2EpajdZlFJc8EVJEPEeTufizyFRNdrgbj_8Y2MTh3bRMQfO-huDx_Ck>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 09:07:34 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Date: Wed, 10 Jun 2026 09:06:24 -0400
Message-ID: <20260610130648.1091326-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_abort_conn() reads hci_skb_event(hdev->sent_cmd) when a connection
is pending, but hdev->sent_cmd can be NULL while req_status is still
HCI_REQ_PEND, leading to a NULL pointer dereference and a general
protection fault from the hci_rx_work() receive path.

Check hdev->sent_cmd before dereferencing it.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Cc: stable@vger.kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/hci_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 54eabaa46960..43fdacb2c9b2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3188,7 +3188,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * hci_connect_le serializes the connection attempts so only one
 	 * connection can be in BT_CONNECT at time.
 	 */
-	if (conn->state == BT_CONNECT && READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
+	if (conn->state == BT_CONNECT && READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
+	    hdev->sent_cmd) {
 		switch (hci_skb_event(hdev->sent_cmd)) {
 		case HCI_EV_CONN_COMPLETE:
 		case HCI_EV_LE_CONN_COMPLETE:
-- 
2.54.0

