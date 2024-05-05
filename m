Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD02582;
	Sun,  5 May 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714898359; cv=none; b=CgDKd7gf/QRFMDslUn1wtiJXAy8HjBD4XicDaP1f5taUmO3JxknhQrydm/y1dNxxhH0v54PUrGdHS/0q9wyHNjtl9QX4mKcWNauzOWRD9nhGK1B6xJidC+unKk+P6AiGL0av3XPm0OuG6/lkyD0vz3ai1K48EyIT0CS3+syG0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714898359; c=relaxed/simple;
	bh=n1mdYuAeP4uvVo+sfymUmrxvP4vV2KCkX9GBScpWDHI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YbTTs0xCPgGa4jZUI6FoqpWnoALqN8jqzR6LhRP6tj646GN9eBsarYqqg63xuTsop2+Y7MGRDT/uPEpblYhecafZOECpDW+/PjGFlhz0VRz0d5Vr774KA2F65kIasOVQMBMHyX+zIWACsk6VhN5A0NvLPCGUh0THGHKZG2rU6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BRcJ5W2V; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BRcJ5W2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714898354; x=1715503154; i=markus.elfring@web.de;
	bh=Hmm67Eh9H6ov9LhnYrM6BTLWBoQqSoIzaLVwbXrd8B4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BRcJ5W2VVGsmgIoCIqI+Sk56PveDllTGg6KYSfsK0Sjh8n9GzjNm6izFXHw3ldm2
	 qV1eh/ZajNfQxYr8WIohMa1kdJjLGLkGX2y6RzBml7IOj5T69e3uhYR2WrVKMXW7j
	 v4hjMlwBx8er3YA3Qsmw7gBPXzrw5fbYF6cG4yv57GprhbeBFpGPJZZuelz8H18ap
	 JtoGDb7ZFHQvIKDLBfmah1g+CGOjn3mMKvqLtHIQ8w2qDagLQmVYOn3udzF3zPoUj
	 zu9xUJLoSVZG/M7FJ68IWWv6dQkUnq4yaZP+0Whh6y0uxt9HOXS8ouyyPGM+VX8pl
	 1JUZUV4dgrhuAbddPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidHZ-1sWYtB1hGJ-00e3zy; Sun, 05
 May 2024 10:39:14 +0200
Message-ID: <fd9f738e-8e78-4afb-96fd-907f72fb4e13@web.de>
Date: Sun, 5 May 2024 10:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Bluetooth: qca: Use common error handling code in two
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0iNeMSH+GmRX8I7zfctCspvLyk3Uw/CSkBS/P8/9bpnr0uZPK7G
 IAuxQmB4gsT+bMhVjantpvy4PWwtw1mNl/qDSbFYsIhYe5HWMOS6JBm2PF976kKDWuvoJMC
 y7qOa0bdmKP1D2+gWyggCoSB7HxwpOg+UOqrHut1WhB7wDacSXoeemwdIkIfkrJd4yIumEK
 yVHb38r0ZgVg/RjrsGzJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gKFNHLjIIng=;aQeYxwQH4dG1wm0nev68l75Rw38
 6dr1zAuiXC1aLQHo3R7uoCUMWJzyiIkLcTtlVGUUuGaEvf33EXIcQgqQJrPBmT92DGgvVMp6e
 7mI/kh+KKPe3cl2HxbgjW4hEmoS56kOiYpULZ9/A08bRA4dHz+DxmHe2h5qrsmdUClHSlOZ54
 aMXul2ictR7RA33doJv/5rwz9jXmA/ONdg4rFgB121sAFXoefLsESYEpaBVC2wVXmP+I59WAL
 RgmGzoMwQqPht9yyBO6wd13FlPY3jQnbBKm4axjzzrRPAk9MgbQd5+c3oF6bKf4A3+aO67Ucc
 3B7zsgy7fqAg8xug0zrPYNiTRl0IOndnDd2hO8c10cq/7J3gmvfbFTOtIDGXV++vhkP/0moTW
 ptgNtJwzSQk1WZuyYvQ6QWA5SIWDAvm76SdXu/uOiS0swXTwNVoCRCj88NntrkJV91PGm/6r+
 AFD4wTHKHRMu/DLtI0YgSdCfo4LVBm+1sDMVXMpCQoijwGei+9vC/zoYitaRNz5AlJ7Mu8c4k
 JeCz+5tCcl1IL/YX8+Q9jqzfsmXKb8UqeFJmN/gbU0TOIotZMWOa5MixijdCecL7DexgUv0yP
 4oBUq9sHhg57gom3604PMVnGp2dN3ld98xHlASKr1YQpO0x76recJZ2ZDEntd0YdDloI9lEul
 wFfhBDIpRnntG9yQgjQHe1Oge+7GecpSWsoJ9OGsN4BDWSguo59oZx1GcJKDflzM05I3vxMZH
 QuCgEdBjDa4/jbgyNPxBJ+/vbbUSSOx0h3wMSwApy/xTRPI+cWps4bV/QgQ2JsfWmrAEZA4ee
 HlrZ1QzKvM5h9XIDO6a7/G3Ze/YwK3CYa2FkWYC0HY2uB+BW4p+e5prjY6Pqlj3/fS

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 May 2024 10:30:28 +0200

Add a jump target so that the setting of an error code can be better reuse=
d
at the end of these function implementations.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/bluetooth/btqca.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cc61014ffbc9..1833aaa6d87b 100644
=2D-- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -108,10 +108,8 @@ static int qca_read_fw_build_info(struct hci_dev *hde=
v)
 		return err;
 	}

-	if (skb->len < sizeof(*edl)) {
-		err =3D -EILSEQ;
-		goto out;
-	}
+	if (skb->len < sizeof(*edl))
+		goto e_ilseq;

 	edl =3D (struct edl_event_hdr *)(skb->data);

@@ -123,17 +121,13 @@ static int qca_read_fw_build_info(struct hci_dev *hd=
ev)
 		goto out;
 	}

-	if (skb->len < sizeof(*edl) + 1) {
-		err =3D -EILSEQ;
-		goto out;
-	}
+	if (skb->len < sizeof(*edl) + 1)
+		goto e_ilseq;

 	build_lbl_len =3D edl->data[0];

-	if (skb->len < sizeof(*edl) + 1 + build_lbl_len) {
-		err =3D -EILSEQ;
-		goto out;
-	}
+	if (skb->len < sizeof(*edl) + 1 + build_lbl_len)
+		goto e_ilseq;

 	build_label =3D kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
 	if (!build_label)
@@ -145,6 +139,10 @@ static int qca_read_fw_build_info(struct hci_dev *hde=
v)
 out:
 	kfree_skb(skb);
 	return err;
+
+e_ilseq:
+	err =3D -EILSEQ;
+	goto out;
 }

 static int qca_send_patch_config_cmd(struct hci_dev *hdev)
@@ -224,8 +222,7 @@ static int qca_read_fw_board_id(struct hci_dev *hdev, =
u16 *bid)
 	edl =3D skb_pull_data(skb, sizeof(*edl));
 	if (!edl) {
 		bt_dev_err(hdev, "QCA read board ID with no header");
-		err =3D -EILSEQ;
-		goto out;
+		goto e_ilseq;
 	}

 	if (edl->cresp !=3D EDL_CMD_REQ_RES_EVT ||
@@ -235,10 +232,8 @@ static int qca_read_fw_board_id(struct hci_dev *hdev,=
 u16 *bid)
 		goto out;
 	}

-	if (skb->len < 3) {
-		err =3D -EILSEQ;
-		goto out;
-	}
+	if (skb->len < 3)
+		goto e_ilseq;

 	*bid =3D (edl->data[1] << 8) + edl->data[2];
 	bt_dev_dbg(hdev, "%s: bid =3D %x", __func__, *bid);
@@ -246,6 +241,10 @@ static int qca_read_fw_board_id(struct hci_dev *hdev,=
 u16 *bid)
 out:
 	kfree_skb(skb);
 	return err;
+
+e_ilseq:
+	err =3D -EILSEQ;
+	goto out;
 }

 int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
=2D-
2.44.0

