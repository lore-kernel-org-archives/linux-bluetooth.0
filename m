Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795758399;
	b=qmYOLOelil7UxlXbSgDLFAeHzmVRxunkzmyWuTmKdRK2qGywyeHmI3s3UgTv9Omd5Nhs
	 6lBRM3CT5BEkTAnmUc0gqY3AO33B0kdrNlzT2klqub2fvz15eBYKtk94yvYORI7N2I0I1
	 qV1e7ChehL7cki53zk+A5/R9Gp+J5a+VZBccYoIAtPrsDBMVLhQw0e6PlhbO6kdL5ZXZN
	 OPe805dM4Q1egRjB+N6YsRf8A9CiplCl66tw/7SyHsKUUniZfz86LdunJnlswvN7j2AFT
	 ln89X96AM9WlrJkv2GLHvg31zYSZ9ePvP9QVe0dUiDzkcxGmoVHl896UaiN3PT5jh1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eIxeKrGEDcx/si0IIsZbihQ5Ht59mqfDf5pWSddd/Jo=;
	b=qpEoT8eDVmRfE4cuGypKvLfczZw4IlKc756eCLHyn0K4cN7DJpCeVOYPE2QIg65P2BmE
	 DahFNGYFJihNUp9ABDbRWtKPukW8di2GgPvB8mCRHCOtSk6D98M2Go19sD+9jIlpWbesq
	 r318iFkzNHME8Wpl2fLIBe6b1NSvActhgNYk/NKd7pxI7/5AAb2UxjoCltANmJcc5o7lM
	 DP5hicnccVRw1cnZPl48l9/gX+L+5pHFSQR0zi3jagghf2xh3qg8hTT8/trqO0IVyR46w
	 3ZZcrXgMSH6N++jZy8ThexlY5YjYTsicw+l6HxSlCyaQQAThK2H9l00kmhJCTbAxveQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NOeK8+uP;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21D606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 05:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D21D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NOeK8+uP
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33fb4680717so4067261eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 21:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795758398; x=1796363198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eIxeKrGEDcx/si0IIsZbihQ5Ht59mqfDf5pWSddd/Jo=;
        b=NOeK8+uPFFWw86IgkwInNkIpNkI5wuc5GY9yi/JkeVPVv4e8hRiE/gLNGQyuzTk6QG
         c8DYObRCLX2m3EamexFpFxVzT8ZVydzTQ9S4bxd2JI7/qMPff40yzBIWaO28DEJswpZb
         ONsrFP2BTbR9e8vC797kSbzXFuJAJGDWrHFPNPVpG0jL8nEP/XEpFLsgFRboRNhpYU67
         h7eRu//YY+2/nXF/DoDNyE/InFovtRcLGcdXGBF10NY55CEMTrYoyVEG+PRZDt1LAP/L
         0uLQSB1aWm0shTSfSzSRus+eoqyfupTovHaN4THsnJupRR9YRrD8Q+S84CHm8YBgdlRg
         +ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795758398; x=1796363198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eIxeKrGEDcx/si0IIsZbihQ5Ht59mqfDf5pWSddd/Jo=;
        b=l9XGG0TTMaHXHfCYTQsi5DNAdsgFloUZUuliyMnRTDNTrpHsZzZ8Zu2egPQHUjwWtm
         3boI5yxeqcP7/SBBoVHZN3myU2VdL2xqDOg3k+4eO3Sb5vZwjGzG+KoUclURi3vn6PM9
         jdLYGxiEwUauKQS/Bi3dIGgrwm3EvbNRl7LQX3qJhMyhZizqAl+HRuRx57AIoKykexWp
         y0EXT6J3Ytzon/Z+WkN5hwCC9kHw5aKiE518ePMYbFuHCcQO9VuTOBkyInso9SbUxAnF
         qslYeCfbymaXm+goE7d2pm+xhMvnTkzJ5Wxxtn7NZ9E054/gP8bx/Fzl+Uz2Cag2asO5
         9XMw==
X-Gm-Message-State: APuU4Z9mPBRJGYZGCRElBKP6g+U411qfxL2kR0maRyI/y266v5ZkKy56
	rI/Pvu6n+K0HypXaXpksPQl2ArwtR45L9dxsNWMaFpaVGwn0CGNE3JOjHUh+0lLBAdo=
X-Gm-Gg: AZFdTZebM+/oHHemJhNpIA9lvBCXu+D9+k6rpYfEgz0XXaeS+9X9Hs9Yrp2t/afj4rC
	AArXwJN8V+8ud4Vvh03M1EoIWYg6NTWd+McFP6Is+5PIQfc6sjDDiglaHtr+ini/ZpZtJHPe2O2
	NQu4oFDi7O+imEOkoje2BffyucgJjClcW3iMXTk7JX/S1dIK9IqZFiso2QtDXEgBNd2k9X080OM
	UvHB2r6BefTN7kwU8ju1Hk+VgymcpHcHkXbzQXwbil+NBhnzl8AHDK+iXa5YMtKOemw/9UEIM8X
	8ANZoRMDXLJukjxG9xkxpbMJ1xfG6VC9BywNSJ08PeowdH/CBKJSywYj9l66QmgmmjRRSt+L5qv
	KnddMq0x5ubb08Qg3gPDgs3aSYPD6nCVIXy1tle00GxBQny/O4h27n/Q2Hc3D15AnuxEHjFLQnt
	pzbP1Yo1Wnnmlxn1INuYXm8Waa46oNJOSMmc+mIq9rH26057m6KgM8cKV9/eU4KC58srcaIvvcJ
	r+fVuY22eeLGvzA8uiwYwCbFPzfLNX+h+nIVnc9zlVJopcibxci04wksG4B8mw/PiS//pFmIGee
	KpwJGbfY7CMt1L6FvEol+82MTjUXymW1SSgNTebnmxAyyZvmlZfZkVn4NA5SFUCZFdhl4M1VLCE
	=
X-Received: by 2002:a05:7301:4209:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-3857054b988mr25679637eec.39.1795758398488;
        Thu, 26 Nov 2026 21:46:38 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm83217843eec.5.2026.11.26.21.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:46:37 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Weihong Guan <weihong.guan@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Use the fallback address when no Local RPA
Date: Fri, 27 Nov 2026 05:46:33 +0000
Message-ID: <20261127054635.3146219-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
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

With privacy on, a controller doing LL privacy advertises with own
address type 0x03 (0x02 with a public identity): it makes an RPA from the
resolving list's local IRK if it has an entry to match, and falls back to
the random address (the public address) otherwise. Its LE Enhanced
Connection Complete then gives the Local RPA when it made one, and zeros
when it fell back.

As peripheral, le_conn_update_addr() takes the random address only for
own address type 0x01; for 0x03 with no Local RPA it records
hdev->bdaddr as the connection's own address, and type 0x03 with it.
SMP hashes both into its checks (resp_addr, resp_addr_type), while the
central used the random address the advertising came from, type 0x01:
pairing fails, Secure Connections with "DHKey check failed" (0x0b). It
does whenever the controller falls back, as it does for undirected
advertising with no resolving list entry for the advertising's peer
address.

Take the address the controller fell back to, by type: the random
address for 0x03, the public address for 0x02. The advertising set
terminated event, which fills in an extended advertising set's random
address, checks the same type.

Fixes: cafae4cd6255 ("Bluetooth: Fix handling of LE Enhanced Connection Complete")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
How it was found and tested: on a Raspberry Pi 5 running 7.4-rc2 with
net/bluetooth from bluetooth-next, bluetoothd stopped. The peripheral: an
nRF52840 dongle with Zephyr's hci_usb (LL privacy, legacy advertising
only), privacy on (btmgmt privacy on, add-adv -c -g): Linux advertises
with own address type 0x03 from the RPA it sets as the random address;
the controller has no resolving list entry for the advertising's peer
address, so it falls back to that address, and LE Enhanced Connection
Complete gives a Local RPA of zeros. The central: another nRF52840 dongle,
or a WCH CH583 running our open HCI controller firmware.

Steps: btmgmt pair -c 3 -t 2 <the peripheral's RPA> (Secure Connections,
Just Works, both confirmations answered over the management socket).

Without this patch: pairing failed in every run, 7 of 7 (CH583 central
four times, nRF52840 three); in each trace read, the peripheral answered
the central's DHKey Check with Pairing Failed, DHKey check failed (0x0b).
With it: paired, 4 of 4 (nRF52840 central three times, CH583 once). With the
peripheral's privacy off, paired with and without.

Only legacy advertising was run: this controller has no extended
advertising, so the advertising set terminated change is by reading.

 net/bluetooth/hci_event.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a9b6a6cca..6c1d18ea4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6323,14 +6323,27 @@ static void le_conn_update_addr(struct hci_conn *conn, bdaddr_t *bdaddr,
 						  &conn->init_addr_type);
 		}
 	} else {
-		conn->resp_addr_type = conn->hdev->adv_addr_type;
+		/* With own address type 0x02 or 0x03 and no Local RPA, the
+		 * controller had no RPA of its own to use and fell back to the
+		 * public address (0x02) or the random address (0x03).
+		 */
+		switch (conn->hdev->adv_addr_type) {
+		case ADDR_LE_DEV_PUBLIC_RESOLVED:
+			conn->resp_addr_type = ADDR_LE_DEV_PUBLIC;
+			break;
+		case ADDR_LE_DEV_RANDOM_RESOLVED:
+			conn->resp_addr_type = ADDR_LE_DEV_RANDOM;
+			break;
+		default:
+			conn->resp_addr_type = conn->hdev->adv_addr_type;
+		}
 		/* Check if the controller has set a Local RPA then it must be
 		 * used instead or hdev->rpa.
 		 */
 		if (local_rpa && bacmp(local_rpa, BDADDR_ANY)) {
 			conn->resp_addr_type = ADDR_LE_DEV_RANDOM;
 			bacpy(&conn->resp_addr, local_rpa);
-		} else if (conn->hdev->adv_addr_type == ADDR_LE_DEV_RANDOM) {
+		} else if (conn->resp_addr_type == ADDR_LE_DEV_RANDOM) {
 			/* In case of ext adv, resp_addr will be updated in
 			 * Adv Terminated event.
 			 */
@@ -6707,7 +6720,7 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 		 */
 		conn->adv_instance = adv ? adv->instance : ev->handle;
 
-		if (hdev->adv_addr_type != ADDR_LE_DEV_RANDOM ||
+		if (conn->resp_addr_type != ADDR_LE_DEV_RANDOM ||
 		    bacmp(&conn->resp_addr, BDADDR_ANY))
 			goto unlock;
 
-- 
2.47.3

