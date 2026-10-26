Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792985169;
	b=qS6H2cFUe1gDgbNbOZ/pX7boi1UXQ8XPfpTc4woWE0N3b/yuXun6Eqa6zRt8T6JpyPl9
	 WBa23LasQkDoLog7fZQroqgDL3gBS2/CErzdl7CiW0T8owHiX2glrYj7QSDhDY2bdBdx0
	 vO6dLCYurA/6fewwCQ7nmdKiLxcCAY+gbbnPtYMnYmdIXsbrHygdYx0zR+MBqvlPeE5wn
	 HVmFKj/JgrjwokmYEtmobPqVgaqTa5eaH1ZEuEJr8L/1x5pxTNXaTeG3DHtu148Ggc8yu
	 2maoXMYo90GQdWd1sovQCXBuv2Z6REh0NGOorCZ8rnQwujm4Wox5D4r861k8fvpovoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792985169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ulPL2nNj9KkRXxCPGvNYqMctAR2mapAgUIZrTOBCP9k=;
	b=iEEd4LXC6UpDAEP0oIysFtggnd2TpH9gwOyKymNeCQkmB/W5vmgKyvnEebK8yyRduHhK
	 8sXX0PrI1ydMxveWzDECXyr/fC1K11uvZXHiKAB/uB7MMXGn7IkGrDT1nIQABXxVTZaJv
	 hd/gvVLLM8YxNXAEZY4PBTjuHAJBc9ArqZ4GNoXGGB2lAjdNNlXZpG3/QVkf802N+0F31
	 mKVDz95CjoBTpEN6JPw1S7t47+kIA0cOlbK533SpdTu4VlVpgy+RgjtZ+kSJcQkvCRssx
	 XmGPi/QEUPyhx9n8MBjSCX4Yzz/oRfxMD4Zzt4+T+DReI+xPEGqNSPZ07SVahg9cspg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kotfu.net;
	spf=pass smtp.mailfrom=kotfu.net;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32743606A320
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 03:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32743606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kotfu.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kotfu.net
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4678669eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 20:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kotfu.net; s=google; t=1792985158; x=1793589958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ulPL2nNj9KkRXxCPGvNYqMctAR2mapAgUIZrTOBCP9k=;
        b=Q5TLjEEaelnj9fNz7UnNkOr2isgSM4tpBOntJD+vHsOUs0ve0hLFBCTU4Z/HSO/2wj
         Ym0lo0CKx4gNoXIJxdJQW1E7j5C7gEvJGJlqS1bM3TJeVF5hfCwc0vtyPrm29Pn2dGWg
         vFH/7DovZV/+1+PnsTw715g2NdZiZS6HJ2ra+/uhXA1CTR4oWhml1cFvF9dj8Z6tG+VQ
         Pn1yYyrItTvJCUx1xn56B6xd1if/yaqZi0kxwjQP9684xgQ6cwauk1Vh+dnj6KQqqBpZ
         c31psaVzRgT+7ccCOEfxJw5zWsn+BL/f9L/TgXoQ7XlG1Z7Btj+N2bAiM6u97K6xYXZp
         hdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792985158; x=1793589958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ulPL2nNj9KkRXxCPGvNYqMctAR2mapAgUIZrTOBCP9k=;
        b=Zw5qm9rB5P7kYEZeHxW0nwb9SoxJbP0d1tHv6gv2x58kejq1LEgx5WDIHzgI+jJh6Z
         PP+pldbvPmaNdwPbqCasytw1hjs09C9hz09L8mrFl5BUo9JRuxdjfCuhZPgzjhxinSuO
         yJKGiVSfOtojLI/KR1RudL90GODm8VRti5T8udMV1w77kp8Wnn5PAls+F1f8GdNtgpbM
         y0tgKRbATbs2VkFRr9HMb2Czy3FyK6tsOzbhsBU2EWEt9c2YZFo303yCknxlCC7QqXQg
         lLXWY1eX+/GVpWgA33NySi0DxcCoqmxeoSqijtyjBvxKnL20dt4v2gwjmOIVbnexwihx
         WVBg==
X-Gm-Message-State: AFq9FYJOttDvuWRj9dFpvjvl95NRc4torQ4sqO8SpKM9oIYMX/x0Lx7m
	wk1nPYmZ+LSupp7Kl7R9OWTlx4P6aCeG57s/DriFrCkwidErUXFVazK6U17FFTDVEXLoz3hfBYr
	PVTX074k=
X-Gm-Gg: AYBFou3Bnt7ZGlOZIgT+J0rwfzsAADdxQAyVubEohB6vuKpSIi0D24xqBS9BvhJ9eIS
	CseQKry9gVtX9QW2w+nl7ImnR/lXRy8fbqHAo+1XGJzb7ZQnv36PN5coGTW/MByB9QGz6gTz567
	+mYhnNp0G9xBr5wgEHqwmf5vTT2gewsewnFCXgkubXHKa6ZR+r3NqWhLgIFWfrwATUX60FYhLok
	ZdvGWbf+qbgERQaYFLExk+aAtsjH7hhJlKiXf0ine0SyhDLHtf9H1rPg6uhMBAn0+G2+i+JxCJI
	QMdznTWBGdEuUeig+l00x21kDotXudgg51S4X5x7X389x6NzPKvabinr7SX8ppvB6JE0u6V928M
	tMoG4mkEgsTWJf3T10uJ3Pxn4mCm+uCATHVUOb+FxbK5EciEl4UMe/e/ri2BtamrDnzvcY1Mb7d
	AFptk1hJ3ki4eO8RxyFnlPgT8oI8J88QdGnSY5cbTKw08mXeptm5Piu7JI2lpIB7edcMG3ONL1D
	buLIivMz1vZ9F7dAuFfhFH2qYKpUj+8wSSMUY9eAbldJNuzDmnIrNfx/IXC85PTHR17tAaE3Drw
	ilZwXdTklw==
X-Received: by 2002:a05:7301:78c3:b0:35b:91da:7cb with SMTP id 5a478bee46e88-369e850f691mr9528378eec.35.1792985157886;
        Sun, 25 Oct 2026 20:25:57 -0700 (PDT)
Received: from gryphon.kotfu.net ([37.19.210.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm22641473eec.27.2026.10.25.20.25.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 20:25:57 -0700 (PDT)
From: Jared Crapo <jared@kotfu.net>
To: linux-bluetooth@vger.kernel.org
Cc: Jerry Wu <jhs730127@gmail.com>,
	Jared Crapo <jared@kotfu.net>
Subject: [PATCH BlueZ RESEND] gatt-database: Fix freeing wrong client notify IO
Date: Sun, 25 Oct 2026 21:25:44 -0600
Message-ID: <20261026032544.49563-1-jared@kotfu.net>
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

From: Jerry Wu <jhs730127@gmail.com>

When a non-bonded device disconnects, att_disconnected() drops its
device state and clear_ccc_state() invokes the CCC callback with a
NULL pending operation. ccc_write_cb() then takes the notifications
disabled path and calls queue_remove_if() on chrc->notify_ios with a
NULL ATT instance.

match_client_att() matches every entry when the ATT instance is NULL
and queue_remove_if() only removes the first match, so what gets freed
is the head of the queue, that is the client which subscribed first,
and not the one that went away. With two or more subscribers this is
deterministic, because the disconnecting client's IO is still queued
at that point: sock_hup() only runs on a later mainloop iteration.

The victim does not recover. Its link and its CCC value are left
untouched, so gatt_ccc_write_cb() takes the "value is identical"
shortcut on any subsequent write and AcquireNotify is never issued for
it again. To the application the notifications simply stop.

The disconnecting client does not need to be handled here at all, as
its IO is reclaimed through att_disconnect_cb() -> io_shutdown() ->
sock_hup(). Only remove an IO when there is an actual operation, and
let the NULL case fall through to the notify count accounting. That
also restores the StopNotify call when the last subscriber goes away,
which the early exit used to skip.

Fixes: 8eb1dee87e01 ("gatt: Fix not establishing a socket for each device")
Assisted-by: Claude:claude-opus-5
Tested-by: Jared Crapo <jared@kotfu.net>
---
Resending: the original posting (30 Aug) was picked up by CI but dropped
after two weeks without review. The patch is unchanged apart from my
Tested-by, and still applies to current master (a0580da).

Jerry's notes from the original posting:

  Verified still present on current master (e814134, "doc: Remove obsolete
  security-bugs.rst"). match_client_att(), the ccc_write_cb() disabled path
  and the gatt_ccc_write_cb() "value is identical" shortcut are unchanged
  since 8eb1dee87e01. Originally hit in production on 5.83.

  Reproducing with two centrals and an external GATT application (one
  implementing org.bluez.GattCharacteristic1 with AcquireNotify):

   1. Central A connects without bonding and enables notifications on a
      characteristic of the application. AcquireNotify is called and A
      becomes the head of chrc->notify_ios.
   2. Central B connects, also without bonding, and enables notifications
      on the same characteristic. notify_ios is now [A, B], ntfy_cnt is 2.
   3. Central B disconnects.

  Observed: A stops receiving notifications at once, even though its LE
  link is still up and btmon shows no disconnection for A. A's notify
  socket was closed because A happened to be the queue head. A never
  recovers, since its CCC value is still 0x0001, so rewriting the CCC is a
  no-op and AcquireNotify is not called for it again. Only a full
  reconnect of A brings notifications back.

  Expected, and what this patch gives: A keeps its notify socket, and B's
  socket is closed by sock_hup() as usual.

  Steps 1 and 2 must not be swapped. If the client that disconnects
  happens to be the queue head, the bug is invisible, which is why a test
  with a single central always passes.

  I also have a small standalone harness that links the real
  src/shared/queue.c and exercises match_client_att() together with the
  ccc_write_cb() disabled path, showing the queue head being freed before
  the patch and kept after it. Happy to send it if that is useful.

Tested on hardware:

- Raspberry Pi 4, Raspberry Pi OS (Debian trixie), Linux 6.18.50,
  BlueZ 5.82-1.1+rpt2 with and without this patch; controller a Realtek
  RTL8761B USB dongle.
- Peripheral: an external GATT application with one primary service, a
  write characteristic (AcquireWrite) and a notify characteristic
  (AcquireNotify), advertising through LEAdvertisingManager1.
- Centrals: an iPhone and an iPad (iOS, aprs.fi), both subscribed and not
  bonded (ReverseServiceDiscovery = false, so bluetoothd doesn't start a
  pairing by reading their Battery Level).

Without the patch, whenever one central left while subscribed (the
application called Device1.Disconnect on it, or Bluetooth was turned off
on the device), the other central's notify socket was closed at the same
moment and it stopped receiving with its link still up. With the patch,
in the same three tests (disconnect the iPad, disconnect the iPhone,
Bluetooth off on the iPad), only the departing central's socket closed
and the other kept receiving. A central that wrote CCC 0x0000 before
disconnecting never triggered it, consistent with clear_ccc_state()
skipping CCCs that are already 0.

 src/gatt-database.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index b511e13e3..d8e45581a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2977,8 +2977,15 @@ static uint8_t ccc_write_cb(struct pending_op *op, void *user_data)
 		if (!chrc->ntfy_cnt)
 			goto done;
 
-		client = queue_remove_if(chrc->notify_ios, match_client_att,
-							op ? op->att : NULL);
+		/*
+		 * A NULL op means clear_ccc_state() is clearing the CCC of a
+		 * device that has just disconnected. Its own IO is reclaimed
+		 * by att_disconnect_cb(), and match_client_att() matches any
+		 * entry when the ATT instance is NULL, which would free the
+		 * IO of an unrelated client, so only account for it here.
+		 */
+		client = op ? queue_remove_if(chrc->notify_ios,
+					match_client_att, op->att) : NULL;
 		if (client) {
 			client_io_free(client);
 			__sync_sub_and_fetch(&chrc->ntfy_cnt, 1);
-- 
2.56.0

