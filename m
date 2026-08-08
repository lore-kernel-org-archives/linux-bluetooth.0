Received: from outbound.st.icloud.com (st-2004g-snip4-1.eps.apple.com [57.103.78.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F638AC8A
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786159191; cv=none; b=o5SadKIo5+s5DI8zPxCTu+unoT1Wt5QiNNkW7lXWxYChgOL2XFP2gPR5drSA1s2sAigukMjDyD9FZJaRqpe0vpTVuaKWaZtRqFY4WZvlZB2hCFsOS30k0ZXfjOlnbthUZU5AT05XocWLFH0E6POvHOW/N9KbqLxF+mJdUUu3JWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786159191; c=relaxed/simple;
	bh=BUkAGVnzBET75ZALsPGn6LZwGzcKdP51aUAqQgR7UZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzMd2k0Pcx2WOx+caXj3kGdACZNsrUEYqaZ8dRBv2+sEV6sbi7fTe+akWc7ltbcjVeFjmF3nlaFSXFDqbriZ0QKEMmQgBOlqZvC6hGTNneE81u1gHHA35DIYJtsyOeE1HVJAV8h9Ub417kT/gZeKqxBtyx6kvN66nOMHgKT7gGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev; spf=pass smtp.mailfrom=proxy-alt.dev; dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b=CohInzWP; arc=none smtp.client-ip=57.103.78.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b="CohInzWP"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id 5059618000BF;
	Sat, 08 Aug 2026 03:19:44 +0000 (UTC)
X-ICL-RepId: 019fdf62-392e-71d2-b5d6-e00982e7ecb4
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHV8DXRxCCkodXAFbEhVdRUMfWBNLXVgURy1HGV0IQFVSAUNFVhVPWFUJChtAH0EBHgxbHxwUXA4TH1RWAVBRHV8CCgRHBFsXRgNTRUEEFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDwBLF0sUGgpeBBccVhsXBlsUBEQBXQVdAkgJQANeBlIGQBdOBVsPXR9BFAhBAk8SHxFVDHMdRQRKCRQZXxkZD1cGB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proxy-alt.dev; s=sig1; t=1786159186; x=1788751186; bh=3rvyimbpVsn+DKmLy32qvrMyW9UAN10bz2gvMi3pILk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=CohInzWPxH4lblcL6RZp4WWarjOYSKDjS59lZtx2293TDTbzKXWldgOVRJ6F2fPjeQi1LIH+E5oD8pYDm3GbNeG2x4/9+BuGdGM037s4WsuDKvypMObLze7zLMu2egBO2hcVX3JyDVbY6XfljJZtjFFcuffxEsNtuq5LniOzqSUeoCWZG+zd0TecLsojSpgMpNQTAJqy3MT8ESRKjDrOeK2BfKRO65eKgJJt9UYSDa5xvIdzSmYJnsboQ+DxhFUm8qonmjt6yHkGnIUtt2eWMQx6DK33oX02yFptvW7M9TGFA971WZY3EYKKhmu/CCw8/sVfBSrNHwUAUTKDH3wVLA==
mail-alias-created-date: 1786144344056
Received: from localhost.localdomain (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id 327B41800090;
	Sat, 08 Aug 2026 03:19:43 +0000 (UTC)
From: Proxy alt <proxy-alt@proxy-alt.dev>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Proxy alt <proxy-alt@proxy-alt.dev>
Subject: [PATCH BlueZ] shared/gatt-client: discover the CCC descriptor instead of assuming it
Date: Fri,  7 Aug 2026 23:19:40 -0400
Message-ID: <20260808031940.66686-1-proxy-alt@proxy-alt.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iBXtRAezPbFuaXHcldn3Y9ZApmpCeiNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDAyMyBTYWx0ZWRfX0dT6XWdxOkTX
 n9mpIiZKZ4aTdRDqEYDusX1kDW+2cg/cbR34aZDDROt/+F/y+CPF7DUNpMxNM1ZHkhkTeWC4fya
 //tjsXFGOysRbkzflguJw72YZ7gkadj6F0p5QnJI9ffV6j0Y4EcqP1UKPV1NvS/U+GJbViiqGlv
 dw/9YhCY8T2CXB8N4NEeXK6ZeCL52/zEOWJT8WcJoAoXl6gZQ01KpySogotQiHd2FxkHHVBQFwO
 hl7XRDjbU5+o+wyrmAGj4m0VOWeru3jzHK1U4ll/nhMhaKkmMebns8ibxD30KY7XRa/neSu0EXb
 N27qkUFwZTuiO6QtQ9Lu8Ms8z24oR5TI+06sJkglpUXwsaqZDmVHOmlXyeC40I=
X-Proofpoint-GUID: iBXtRAezPbFuaXHcldn3Y9ZApmpCeiNO
X-Authority-Info-Out: v=2.4 cv=POkCOPqC c=1 sm=1 tr=0 ts=6a76a050
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=rrvi1uz6mm1zQBEhevMA:9

discover_descs() skips descriptor discovery when a notify/indicate
characteristic has exactly one descriptor handle, inserting a synthesized
0x2902 into the database without ever querying the peer. The assumption
follows Core Spec Vol 3, Part G, 3.3.1.1 - notify or indicate implies a CCC
- but it is applied to hardware that does not honour that clause.

On Telink TLSR825x based devices (GE Cync bulbs and switches) the only
descriptor of the notify characteristic is a 0x2901 Characteristic User
Description reading "Status". No CCC exists anywhere on the service. btmon
shows FIND_INFORMATION_REQ issued for the descriptor slot following every
other characteristic and never for this one: the only slot skipped is the
one following the only characteristic declaring notify.

StartNotify then writes 0100 into that text descriptor. The device leaves
the Write Request unanswered - its own violation - the ATT transaction
timeout expires 30 seconds later, and a connection that was carrying live
notification traffic throughout is torn down. The client is handed
UNLIKELY_ERROR, which never appeared on the wire. The synthesized
descriptor is also written to the GATT cache, and regenerated there on
every fresh discovery, so removing the device does not clear it.

Removing the shortcut costs one round trip per notify characteristic per
discovery and lets the peer answer for itself. Where a CCC genuinely
exists, nothing changes. Where it does not, gatt_db_attribute_get_ccc()
returns NULL, chrc->ccc_handle stays zero, and register_notify() already
handles that case correctly - it completes the request and registers the
handler locally without writing anything. Notifications are dispatched on
a value handle match, so they continue to be delivered, and the link
survives.

Reported and reproduced on three units across two OUI families, one of
which had never been connected before.

unit/test-gatt is unaffected: 192/193 passing, 0 failed, identical before
and after (the one not-run case is pre-existing). No test database has a
notify or indicate characteristic with a single descriptor handle, so
nothing in the suite exercises the shortcut being removed - which is also
how it went nine years without anyone noticing it guesses wrong.

Fixes: https://github.com/bluez/bluez/issues/2383
Signed-off-by: Proxy alt <proxy-alt@proxy-alt.dev>
---
 src/shared/gatt-client.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -772,31 +772,12 @@
 			free(chrc_data);
 			continue;
 		}
 
 		desc_start = chrc_data->value_handle + 1;
 
-		if (desc_start == chrc_data->end_handle &&
-			(chrc_data->properties & BT_GATT_CHRC_PROP_NOTIFY ||
-			 chrc_data->properties & BT_GATT_CHRC_PROP_INDICATE)) {
-			bt_uuid_t ccc_uuid;
-
-			/* If there is only one descriptor that must be the CCC
-			 * in case either notify or indicate are supported.
-			 */
-			bt_uuid16_create(&ccc_uuid,
-					GATT_CLIENT_CHARAC_CFG_UUID);
-			attr = gatt_db_insert_descriptor(client->db, desc_start,
-							&ccc_uuid, 0, NULL,
-							NULL, NULL);
-			if (attr) {
-				free(chrc_data);
-				continue;
-			}
-		}
-
 		/* Check if the start range is within characteristic range */
 		if (desc_start > chrc_data->end_handle) {
 			free(chrc_data);
 			continue;
 		}
 
-- 
2.51.0

