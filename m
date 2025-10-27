Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9CD27FD62;
	Mon, 27 Oct 2025 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545417; cv=none; b=mODdmOGCW9HYboIIHOgVeZPLFjfQoswAAZw6tvJVOYtqT7SP9qjcnVAVRqD8Rfjb6/1ncVqhAuXAYkMj2JxOoVfci6Gl+nOiyiI/3jfUodwcHlLnbOJobC4b+3wlCiWpmIOvBixpYPYLKsA6DMwlzsWixwAmRFFf3hq2JSSwEPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545417; c=relaxed/simple;
	bh=h9JriAPmuh1uotOOsR61tvnQRtT3bWSd8EoDy0CKcTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J4XJG8EsYh91jOUlHvpP3Rs77gAgo4Gcv8RgDv9iHNIJjUlBMNNFFmffmw20Ufr+f0mOosjcoPKxmF9ZCvWypCHBitNRg45AElsFoWZl5NEYU5nfB6IgSKVaFm2KWFNMpMQFqyWFKFr/sLyqVqbBWyBMOmXcXrX0fE/luWsifEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLt0AUNJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLt0AUNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA627C4CEF1;
	Mon, 27 Oct 2025 06:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761545417;
	bh=h9JriAPmuh1uotOOsR61tvnQRtT3bWSd8EoDy0CKcTg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pLt0AUNJjmhxOLN1H/SFXF8xuwr9SvFsN11D85hsnFQoWZYfQf6E5jzWEko53KhS+
	 JVf6xU1y9G3K7uE58Qg33epTHg9Imw4U8ClDekMoI5ZXppXsuiPz8oLubUBDmTcC5T
	 5hpzZs9iSOtjARGdQrVeUpoImH+WyBqjZgPaDqTQAMLKYrqW2BDK8edrM5BDvDdFG1
	 VvqvH5gdTCW274mPpjBfio+LTdBf86ccdd7wWwZDNXaj9v8mTrdldymZ12/GZVfwSA
	 BgMeM3Q6xlkxERdGlgchrwrFbYOwfWdoLtJdUpgMx27supoZJrk6/ihyhpnsXUG2rV
	 estC6iX5qwfiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA96CCF9EB;
	Mon, 27 Oct 2025 06:10:16 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 27 Oct 2025 14:10:02 +0800
Subject: [PATCH v4] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-bis_cis_coexist-v4-1-81c4e890fa6d@amlogic.com>
X-B4-Tracking: v=1; b=H4sIALkM/2gC/3XOyw6CMBAF0F8xXTumD2rFlf9hiCl9wCRCTUsaD
 OHfLWyMCxezuIs59y4kuYgukethIdFlTBjGEqrjgZhej50DtCUTTrmkSjBoMT3MdsHNmCZQTOm
 q4laaipPy9YrO47yL96ZkH8MAUx+d/jqS1oApQObAwGopWssuhtXipodn6NCcTBg2rC8NIb73d
 Vls5P8hWRSM+bq1Z+q8YvwHa9Z1/QAWhjGH7QAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761545415; l=2169;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=P7v3HOIQyUuNYvPT/4u/6kC7UJH3I86TvRUHKxEURak=;
 b=2eH6P+2UC+a61nkUhEGrcM/JDCJpYPDeuW9w1KPe4+iDMakQn3d/PMwjsPd/0f7QE90F8ZNPO
 1zg9zdUDP6KB1yX0jd1GRZnxnSwNRmQ3VCTndaFnH/0zDWPs4gjDEvJ
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When both BIS and CIS links exist, their sockets are in
the BT_LISTEN state.
dump sock:
  sk 000000001977ef51 state 6
  src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
  sk 0000000031d28700 state 7
  src 10:a5:62:31:05:cf dst00:00:00:00:00:00
  sk 00000000613af00e state 4   # listen sock of bis
  src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
  sk 000000001710468c state 9
  src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
  sk 000000005d97dfde state 4   #listen sock of cis
  src 10:a5:62:31:05:cf dst 00:00:00:00:00:00

To locate the CIS socket correctly, check both the BT_LISTEN
state and whether dst addr is BDADDR_ANY.

Link: https://github.com/bluez/bluez/issues/1224

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v4:
- Rebase code.
- Link to v3: https://lore.kernel.org/r/20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com
---
 net/bluetooth/iso.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index aa63c8955a53..74ec7d125c88 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2021,6 +2021,11 @@ static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
 	return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
 }
 
+static bool iso_match_dst(struct sock *sk, void *data)
+{
+	return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
+}
+
 static void iso_conn_ready(struct iso_conn *conn)
 {
 	struct sock *parent = NULL;
@@ -2105,7 +2110,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		if (!parent)
 			parent = iso_get_sock(hdev, &hcon->src, BDADDR_ANY,
-					      BT_LISTEN, NULL, NULL);
+					      BT_LISTEN, iso_match_dst, BDADDR_ANY);
 
 		if (!parent)
 			return;
@@ -2374,7 +2379,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		}
 	} else {
 		sk = iso_get_sock(hdev, &hdev->bdaddr, BDADDR_ANY,
-				  BT_LISTEN, NULL, NULL);
+				  BT_LISTEN, iso_match_dst, BDADDR_ANY);
 	}
 
 done:

---
base-commit: f63037a3f252522504774c98960282fb776ef3ca
change-id: 20250731-bis_cis_coexist-717a442d5c42

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


