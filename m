Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2878C6B;
	Fri, 31 May 2024 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717197980; cv=none; b=uevjUV9IsjhubeKEr8b3g1A6HNJ84GD3VgX8w+x6I37nSGkaSWOscMHwp6J1pgUrzfoWGrupBKDtyMPej4HG16dBrxcoRZL+VVdvQsMKX0Dy9UeGiUwjdGfJJjRxwDEsVyNI1qZFrzvL1Vcei3mGkY50gJJNit74ntszfBZo4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717197980; c=relaxed/simple;
	bh=B0pPDbnAb7hRdzyB8cEx37CKFq5iJ/SosfuXcRSxFGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKDeatvfsnQtz4ArMwJuKKzr6FN/QtyOFKp+vNr2vGjbHSlzSy+s0xEoYY28CUvV8RFGsJiWBYIGHphiFvmQK8CZ9/yxf7aXLfRk3meuQw5/sGMH7PGk0DKeSxnGFcc6FY/aPv1SR22rg2Dsjye+VLpuyl/1KcajnUYyLuSamJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kwYlGvyp; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kwYlGvyp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=D0aUf4VLrYRqzhX0VDVQARX/uQ0oFHnPScKI/A6/dNo=; b=kwYlGvypq49DTgi8
	BefjOjYXjAQd67rKGQj5iHX3o+66pY4WGYI9DSDU4lRg9LCQHk0dgimvlwLlEGpVUqAaptrRDZjKA
	JzyxI3eT+HJ8+mHHBB4m3wSRilnzFH+mIw+fQl0kN9WtV0ibC5xuFZbPJraRWyHMQKNK8UnsXCNou
	Yv65tU8nu6GZBIZ4UTSvxQY2JhZ9XxlTPs/JCFa2jD6raVF86ZW1kA4XokBpwhI/NKignde4DRvI1
	R9oIbPKC013UCgHF1bvKgDcaBh7x6EUWiQoA5beITq5LSWVqEhk60uarTPM0F1lGSN474M52BWh8O
	o6oZnJBejBhthIL1oA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDBdW-003gRb-20;
	Fri, 31 May 2024 23:26:15 +0000
From: linux@treblig.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] Bluetooth: iso: remove unused struct 'iso_list_data'
Date: Sat,  1 Jun 2024 00:26:14 +0100
Message-ID: <20240531232614.302215-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'iso_list_data' has been unused since the original
commit ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/bluetooth/iso.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cc055b952ce6..e439c5d15092 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1721,11 +1721,6 @@ static void iso_sock_ready(struct sock *sk)
 	release_sock(sk);
 }
 
-struct iso_list_data {
-	struct hci_conn *hcon;
-	int count;
-};
-
 static bool iso_match_big(struct sock *sk, void *data)
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
-- 
2.45.1

