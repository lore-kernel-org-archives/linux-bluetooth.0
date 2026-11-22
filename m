Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378417;
	b=vneLRQdA0W08EVWDzyPTZmh1Wd/HHZ0GEhEhZT0BsRyJDCCuwcHWrANUOSHfBFiOFp0d
	 ABgrUDVOLPJx6CSUQ9YCWXflMTejn2kl7kgUITAcK6FezsmGPSNnWs736hVlR1FxhOrZm
	 SAxw4HXRU8JlUvj7bV2dgWDX1+QpPfuI1iTS9qu+/oSKdT+P1KxscKtF+fx4xZ3cFeSVz
	 siE4yBSsDLPDWnT+XwSe/PVtY/hsSLcOWy8z+oZCKe4D+m9d6kb1FOGp4zSkP1vWImeJO
	 G3fQ79v8k99vFJ6URXs5ufzFtp8+4m5Xl96et1fWYItsLnUG98v4Lh6Kknn6LeKeeXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=az4c8uFxaP+bAYm2Iu7Oftkn//TMVI2T4Dna6cZvyXo=;
	b=5JLbwhrIf4x0Ykyibv7wn2H4w1k1Mx2rMhK6ET2KuG2hUs9Var6DAR9TmSCYbrIvjdRe
	 5vXrPCM3h72Ar+M1i0kaRPS195/YCvoPSBrEtxzENWVLi/ppfQWx4xobJbBOZXpOCwUmO
	 BUGkoOcP8ok33TxlglY6YN4Ug6zLhhrLcSVyLm3tKc0mEK8hNsLAPnlQM9apv9GSx3TD1
	 +cfmAxxjksUf3y8UtRyeJMcks3DLVDOBJ0Jo6Q1Ir3BWleUwTCB56FNsgT99ttBGiyaUJ
	 9Ify8krdYmpHWZ/5XuiqefOEjrXjoe7wltu7SpMEXFMmMaWzj6guBlvNp3UT/pSY2Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="v/Pr+VMc";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DFB606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25DFB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=v/Pr+VMc
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492f0a1b685so1815635f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378415; x=1795983215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=az4c8uFxaP+bAYm2Iu7Oftkn//TMVI2T4Dna6cZvyXo=;
        b=v/Pr+VMchId+UWKgeQzY1IFEmInsZrVI3L89HQCVvNm77/VHDkTa7m8Vx+BAJp3on0
         erNXCyX4DIrFWp9KKYV/6T3IGKFCYQauu0CJP16Iv6VqxGjzAOpNko4ZDi56r1ayTFQ0
         ckfj1YsNbQBrn8FhKV813W7xMVNsx2qrcqDxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378415; x=1795983215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=az4c8uFxaP+bAYm2Iu7Oftkn//TMVI2T4Dna6cZvyXo=;
        b=z4radcj5RhCw6X58CBYggkCov6d+Rcy7SsZUyGjpmSCGH3/Yj5J6EpElAfz5lO7vYu
         VLUoQICRMuYXkuZnpGAP/o1ceXq3cbGt7wJjX57QU88/IwYNHE3p86OyieJO6VpiMldr
         /xQ1YpnvnLmnifZz/qS3//OWIQ3643YPNFVSYFH63KNKVDvloMs+EZm4gVqEpNssAmdW
         VKAQSGqMidWJHASRN5/h5lTWmej9O5ICmGxsVhy84S8Em3vlQs15pBp8dREfW1IirF9Z
         jhQEioAUu8zH9OBkx3T5RQafLw1lKn/GscLThsNr3ma7Fo0W+GVKQlFZSaOoo9qTD9CG
         d5kg==
X-Gm-Message-State: APuU4Z8JgXFlTgp3w6bZnultrvRBBr4Ggz4UmK+E5JUYxuI5EG4Cg+7T
	SdLJbYEgrwddvRnuEJ2StzFePaUGnLbBMsLjXcZnrYbFau6EeUUHAyE+lgGG3FBSNjjsD/NAnxp
	UQOQA
X-Gm-Gg: AZFdTZfRBw1frp6fqMnuZqOvUV759gDMScAnkK5gZV7omzfUSZyi9wamiDjOhovWXAc
	bfHZlZugg0p+joac7VrfOG7RfJbFc/b51mo5wZpY1CWYx48YeiT2dAFnSn89uCX9zQhYkQc6tjq
	HzFDH5VXPeEZvfMTUC68LpJLjgcxMi4H1/dFr0Tcw8ISMctOgWFTo/Hgur0goNLzrufKwVpeddD
	jTY+LSPzXzuI1qCcZ7Boy5wWrzK6aRndEmPe/R4NGylhXHk0+JYRAvPpyYgfcwRfGWqM1Ahx75c
	D+4m9XUDZ3aRlZHFWrn+bachVZrXYvzF0+gXptxaj7b3MrSz9WgMfdNZhj4Mm6Scr7zg4Ao8T6N
	62IwNjRrn45aoEp3Q8Em7pxSqvArcMuw0fBYtB1gfI97fHHbu4rr+OUFm0K8++u18xsAJn9w4Kx
	FYBiDjr5sbUJSkZ5560W10qB+5M46gEMUWBrcPGS2lcl6aPcOev9iLDh2r4XxhKAtql2N2eyGW9
	Is3H1ZItSrNbmDbSjtYy1WSyvcBjjiCjA9Qqu4lnNsYH9Feoi8qv6T39ezfKqlZBBKgqXm7d2v6
	N+xT3HD42WbtB7yLfWIPCRXifnjhcCqBTkDBxLjXOSX1Pfntig==
X-Received: by 2002:a05:6000:4812:b0:4a7:9630:7b32 with SMTP id ffacd0b85a97d-4abb5518569mr17821820f8f.46.1795378415409;
        Sun, 22 Nov 2026 12:13:35 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm18701566f8f.4.2026.11.22.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:13:35 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Sync to an RPA broadcaster without its IRK
Date: Sun, 22 Nov 2026 21:13:33 +0100
Message-ID: <20261122201333.2853192-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

hci_le_pa_create_sync() waits for an extended advertising report of the
broadcaster to learn its SID, and while HCI_PA_SYNC is set the passive
scan filters on an accept list that holds only the broadcaster's
address. hci_update_accept_list_sync() then enables address resolution
as for any other accept list. A broadcaster that advertises from an RPA
nobody has the IRK for cannot be resolved, and a Synaptics controller
drops its reports at that point instead of matching the address as it
is against the accept list. No report reaches the host, and the PA sync
times out although the broadcaster is in range.

Leave address resolution disabled while the accept list holds a PA sync
target that is an RPA the host has no IRK for. Such a broadcaster can
only be found by the address it advertises from anyway. A broadcaster
known by its identity address, which a bonded one is, still needs
resolution and keeps it. Resolution comes back with the next accept
list update.

This needs no quirk, because it costs nothing on a controller that
matches such an RPA as it is. The resolving list cannot resolve the
target, and the accept list drops the reports of every other device
with or without resolution. Nothing else needs resolution in that
window: hci_le_pa_create_sync() holds the cmd_sync queue until the sync
is established or times out, so no LE connection is created, and
le_conn_complete_evt() maps the RPA of an incoming connection to its
identity in the host.

Own advertising is resumed with resolution off. The stack already
advertises that way: hci_pause_addr_resolution() keeps advertising
paused during an active scan while the host uses an RPA, but
hci_stop_discovery_sync() resumes it before the next accept list update
enables resolution again. It works because with privacy the host
programs the set's random address with an RPA from the same local IRK,
and own address type 0x03 falls back to that address when the
controller does not generate one from the resolving list.

Steps to reproduce:
1. On a Synaptics controller with LL privacy support, listen for a
   broadcaster that advertises from an RPA and is not bonded.
2. The PA sync times out with no advertising report of the broadcaster.

Fixes: bba71ef13b20 ("Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_sync.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 638589f77081..1a920cd83df1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3216,6 +3216,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	struct conn_params *params;
 	u8 num_entries = 0;
 	bool pend_conn, pend_report;
+	bool resolve = true;
 	u8 filter_policy;
 	size_t i, n;
 	int err;
@@ -3258,6 +3259,16 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 
 			rcu_read_unlock();
 
+			/* With address resolution enabled, a controller may
+			 * drop the advertising reports of an RPA it has no IRK
+			 * for instead of matching the address as it is against
+			 * the accept list. The SID the PA sync waits for then
+			 * never arrives. Match a broadcaster without an IRK by
+			 * the address it advertises from.
+			 */
+			resolve = !hci_bdaddr_is_rpa(&pa.addr, pa.addr_type) ||
+				  hci_find_irk_by_rpa(hdev, &pa.addr);
+
 			/* Clear first since there could be addresses left
 			 * behind.
 			 */
@@ -3383,9 +3394,12 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	filter_policy = err ? 0x00 : 0x01;
 
 	/* Enable address resolution when LL Privacy is enabled. */
-	err = hci_le_set_addr_resolution_enable_sync(hdev, 0x01);
-	if (err)
-		bt_dev_err(hdev, "Unable to enable LL privacy: %d", err);
+	if (resolve) {
+		err = hci_le_set_addr_resolution_enable_sync(hdev, 0x01);
+		if (err)
+			bt_dev_err(hdev, "Unable to enable LL privacy: %d",
+				   err);
+	}
 
 	/* Resume advertising if it was paused */
 	if (ll_privacy_capable(hdev))

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

