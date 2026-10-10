Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5C37CD4E
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791641298; cv=none; b=uHG4EHwUgDeP3DeB89ujJbHxGTy22SWHdmbhfjBw67ug205DVRZAGLwv4qdjW5ElwN6lZEBj4NC7fLxT31Jc/h1H0zQ/WajRNf/Mfhil88tFtZp+/+dakXhGrd2bcO87rVhLa7yrcL0S2jxUqDZ1kzhMeHKT6PSUvu9izThw1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791641298; c=relaxed/simple;
	bh=fQDInI1W10eUugdQwet9qBPWjoYFjRiuPOXtMNncH3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RW6JGWMSfXbuMbS5Hk2+cLebrkYXPmOeBHX7cQyuyz/7xpe6fsrQhKnOpstcZRoAnM1ahZlUmtcGF0i+hoM/paFBnMQeM+9ZQd/3lkNqapn7kbtNm8Cp6CNy4DIePgOzvF/t9Oilqp2cOhJdZsqlensyOm5TJBHjsLW6RhzNL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LplsGtum; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LplsGtum"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso195669a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791641296; x=1792246096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UjpHf4PwjNUxYMxzaCqn9UvI9tlvLO9Xt3mhcZZZJjI=;
        b=LplsGtumBvxlcxVCxVtDFskVDbhTW1C1o1HC5hbyu+af+SNe74BAAZ4xFnwo86gleC
         GTZwwqbrz/OtjMrmK1YEojLlG0v+t9el8ub17p4/IY6ETeYEZeo59YKDfRJZPtsptzbF
         0ddfLXaS/1dhR3y3Tol3BDo35XNeoAvuLqacgmxgEzMnC5d3dzdrGb/7Ih0Y+4REmZvw
         ugsDmZpHm1DSEJG80BsRvjGFBg5racTIDE6pHj4iXRQRPs3v1BhMI+YtsTXK19lSBGVS
         KZo264Irsmuc6d1GxXxmUc8Dv6IbRdf1Ewq2Mv+3GC2p3uFno5wFvk7bPr6n/nUM+hRt
         Wt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791641296; x=1792246096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UjpHf4PwjNUxYMxzaCqn9UvI9tlvLO9Xt3mhcZZZJjI=;
        b=DaE1p7c0JhkZ6fbeLugwF9j4bxzBWmvL4E6NyjC5EhziDz9Shtfxnr4ivUnypW1AoF
         FMQZReVBoImDiF9fHltPVrmkubTChULNZ4TTKHQfD/F7fNu/91BAW1Mbi50HndvK8kbQ
         zIr58PAUEzW1ORGLhG4anDicJIg/Nar52Ml843kB8sBUzUwYrNV+9GPam1roVQjGq/6N
         /Tb3nDL+4by2KkM2xHCQzMPA28qACY1rf/ISHbaT7qkm2hnpaCf+TI1HQeFINqIXJEoc
         VC0krZJNAXU5DkUTF0gjEPV7A/K6w18Ymcsz6x6UwdvDC03TjB55pDMhSS/hRgdHRpIm
         FHnQ==
X-Gm-Message-State: AFq9FYKAhZWwpQKW3edmjnobwdDWEzlMmQuYb0yEjFU+tu/sFgWmD9cL
	u29/y/14YwsBj9EhIYJEWSZdDKIoT8y0aXQ0rnK4/ooAG80C4lJMva+j
X-Gm-Gg: AYBFou0NS7HdkCIJC8O8RFZ/+J1IKBN9/JcAPNN6PfcVisEKyQDPbFjYS8Mw6JRCNW2
	Ri4mTSMSkzr7OsWfwzsBYlScvopznBTvxmjplrUNYNClUIKKr9O3HybzbMQi15YStDRMgbtjY/q
	1d4GQHGMUDkROdvQt40fzajxfMMzfFiQAiWtZnuVA5SPu2qBkU0cNwgihsiqAXjsCZ1BTjJ+zdU
	amzcQ+rRiUOFLkE2XI5CpCZ/jzT0TgmahpXSg6yGaetRvY1Mlu44C2cyl9bCTzYaNb4Ilqgtilp
	QPGPQRwNMT9UUVrbno5DPyGrBvfJLwk8qT7Tcx9FvNfBQh3WTZGnvf9XPtVanXG/TkN+4EjlpUo
	t5GMAxyks/z+NsKndOFkeYJG6qYbX3gqnhxxAeKKByYs1u3fhz3JBykxjC2XbApQB1mpB37mWn7
	6gUdd7wIUbhp6SPoENL+AYNMBpPVPC1wSzkQP25qclRHwyh3GLKJOxJIqfqgJB43uaLelirAJ3g
	utfQrCqF9/6NZsbXkUddkDUnQ49KODhsAhbVWEyNxl5gErYTtPkCunH
X-Received: by 2002:a17:90b:2ec3:b0:3a8:240e:b493 with SMTP id 98e67ed59e1d1-3ab3acf5c6amr4385332a91.45.1791641296024;
        Sat, 10 Oct 2026 07:08:16 -0700 (PDT)
Received: from localhost.localdomain ([58.186.105.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b9639bsm7968831a91.4.2026.10.10.07.08.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 07:08:15 -0700 (PDT)
From: "Adrian.Nguyen-Qualgo" <thenguyen1024@gmail.com>
X-Google-Original-From: "Adrian.Nguyen-Qualgo" <nguyen.ndt@qualgo.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Nguyen <thenguyen1024@gmail.com>
Subject: [PATCH] Bluetooth: msft: Ignore vendor events shorter than the event prefix
Date: Sat, 10 Oct 2026 21:08:06 +0700
Message-ID: <20261010140806.65929-1-nguyen.ndt@qualgo.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Nguyen <thenguyen1024@gmail.com>

msft_vendor_evt() is called for every HCI vendor event. When the
controller defines an MSFT event prefix, it pulls the prefix with
msft_skb_pull(), which logs "Malformed MSFT vendor event" when the
event is too short. A vendor event shorter than the prefix cannot be
an MSFT event, though, so it is reported as malformed for nothing.
Before commit 3368aa357f3b ("Bluetooth: msft: Handle MSFT Monitor
Device Event") such events were dropped silently.

A WCN3990 logs this 20 times at every boot, while btqca downloads its
firmware and the controller answers each segment with a short QCA
vendor event.

Return quietly when the event is shorter than the prefix. Events that
match the prefix but are cut short still get reported.

Fixes: 3368aa357f3b ("Bluetooth: msft: Handle MSFT Monitor Device Event")
Assisted-by: LLM
Signed-off-by: Adrian Nguyen <thenguyen1024@gmail.com>
---

Notes:
    An LLM helped track down the cause and draft the fix and changelog;
    I reviewed the result and tested it.
    
    Tested on a Vsmart Active 1 (SDM660, WCN3990) with a 7.2-based kernel:
    the errors are gone at boot and hci0 comes up as before. Build-tested
    on bluetooth-next with W=1.

 net/bluetooth/msft.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 6f4b7c38a247..a3f07f35a1b3 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -1082,9 +1082,13 @@ void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 		return;
 
 	/* When the extension has defined an event prefix, check that it
-	 * matches, and otherwise just return.
+	 * matches, and otherwise just return. A vendor event shorter than the
+	 * prefix cannot be an MSFT event, so it is not malformed either.
 	 */
 	if (msft->evt_prefix_len > 0) {
+		if (skb->len < msft->evt_prefix_len)
+			return;
+
 		evt_prefix = msft_skb_pull(hdev, skb, 0, msft->evt_prefix_len);
 		if (!evt_prefix)
 			return;

base-commit: 964430c038967fd06643e866f68115664e1a1bd1
-- 
2.43.0

