Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177147;
	b=T+aySpryi/6/YRLw66LLrtsBN+DFpYmbpJkl2/x1C6Qim7OIKpr6FhXzZitpREBZxuGl
	 jhlciL67TpBcSHwDRtAhZKvlRHDA3nfuVPlTDeUHp09Eq0NhEOQaQ15IDwSqJnQ5LwovC
	 5Ib5CcDfpmudxujGfI6jJLYPjNNQv1zVrTfv/JKPDcDVL8N79r3eld5F/BZKUsfg29tPg
	 FT6JHpufBNVM+y8bu4mQshnRQ4NuaruYbIyV1c19EUvpsvA7ClpCjarQuZi0vdeZZluXe
	 ob8Yc5JFQrmg2Be60n4VB7Q1+8JPdPjOhP2uuvqc7w31PHDdJyVee1XC7YuRNgV5X3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177147;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Juzz98ntU13CCp/TLaCHsvZ/8NK1KiioK2hi/YLHnQU=;
	b=Ihj72zWwWh2rPDRlhCRrQirDzJwFHT/A4O2g7lDuK2WD+XPM5c9XSy20ZkIbAuEch4St
	 C3hCSEFTq8LOlH5pokHQIKWuJBvTdnD15wP/Zutb1bVxvFMTHek4Q0eUNqVm9FBZvj+lu
	 bmHDiXrtZRzcZT6r+XLZx9nx/hloA8t6vlkk1Jvv5qPX3q6uaIGnED5Ht4sIEMtXtQzDv
	 /QnI28xGmmBqZb8oT0+m8z+S11UpakV4f+npBvQtg9nwyhUQ6kKHvslq2HnLPZK/m5rX3
	 q0J0ZWnyIAKAMGuVUZOIPJbqIVVRcBH2hoP04UbqZlozYqCAeBOqEnT2sEdwvuKh6xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=igly3tGh;
	arc=none smtp.remote-ip=79.135.106.30
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4088606D80F
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 22:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4088606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=igly3tGh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794177144; x=1794436344;
	bh=Juzz98ntU13CCp/TLaCHsvZ/8NK1KiioK2hi/YLHnQU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=igly3tGhTru4U1tGL2mX8y4MzhLBR59dUXCio+68tVbJlBTn5MnnjrUOCq7+5W0ab
	 22gBLcdfMRTEHiZD1mxnsMIPaOZtxQjXU3fvknS3WT2btWMiVGEF4WPz0Ttqh8X8BG
	 9brZ9umM7HAQew7+6Bt9WuRt6y6gK7ZZWh1dczrvbZqTgJb5l1Mxzci8UPFXQfZYOk
	 d8u7CSD5UPpGs1iURj+ChDvjwKEuBljGJp1i7CY35jSeOonAaG0GQ8XkpGPBHRPO4H
	 Qy6AktRgUE7rWTM6TvBe6JV0IT1I7UrmjdzXKptFyqoRNCHZVu2yCsuDKE5ZsRgLfX
	 NwKxp6SFBkoVw==
Date: Sun, 08 Nov 2026 22:32:22 +0000
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb_qcom: check reassembly bounds and pull results
Message-ID: <y1Xe58FtZGhXfycy9vp3QaGjUElg-vc5EA5FocwznmudOVTgFiYfbqilI4Lj0CRpayllrrY66pkMv9TlGOeq83VQIdL6PEjDbDIEwi28Yk8=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 0a6cde5d3810237058b2afa9034cd408b7162d2f
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

Hello,

Three hardening gaps in the new Qualcomm multi-subsystem transport, all
of them patterns the sibling paths already handle:

 1. btusb_qcom_recv_intr() computes the expected payload length from
    the device-supplied header and re-enters the fill loop without
    checking it against the skb tailroom. The bulk path
    (btusb_qcom_recv_bulk) rejects hci_skb_expect(skb) >
    QPERI_MAX_FRAME_SIZE - skb->len; the interrupt path relies solely on
    the u8 width of the two length fields and a three-byte margin.
 2. btqcom_recv_vendor_pkt() dereferences skb_pull_data(skb, 1)
    without a NULL check.
 3. btusb_qcom_send_frame() does the same for vendor packets on the TX
    path.

None of these is reachable with the current in-tree producers (the
empty-vendor-packet invariant is established several call-hops away),
so this is regression protection for brand-new code rather than a live
bug fix. The patch mirrors the bulk-path check and adds the NULL
checks.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), drivers/bluetooth/btusb_qcom.c:4387-4462 (recv_intr=
), 2624-2628 (recv_vendor_pkt), 4258-4262 (send_frame).
New driver merged in this window.

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
---
diff --git a/drivers/bluetooth/btusb_qcom.c b/drivers/bluetooth/btusb_qcom.=
c
index cc4cfcd..3c41e60 100644
--- a/drivers/bluetooth/btusb_qcom.c
+++ b/drivers/bluetooth/btusb_qcom.c
@@ -2623,7 +2623,13 @@ out_free_skb:
 /* Implements hdev->recv_vendor_pkt(). */
 static void btqcom_recv_vendor_pkt(struct hci_dev *hdev, struct sk_buff *s=
kb)
 {
-=09hci_skb_pkt_type(skb) =3D *(const u8 *)skb_pull_data(skb, 1);
+=09const u8 *pkt =3D skb_pull_data(skb, 1);
+
+=09if (!pkt) {
+=09=09kfree_skb(skb);
+=09=09return;
+=09}
+=09hci_skb_pkt_type(skb) =3D *pkt;
=20
 =09switch (hci_skb_pkt_type(skb)) {
 =09case QPERI_EVENT_PKT:
@@ -4257,8 +4263,13 @@ int btusb_qcom_send_frame(struct hci_dev *hdev, stru=
ct sk_buff *skb)
 =09pkt_type =3D hci_skb_pkt_type(skb);
 =09is_vendor =3D pkt_type =3D=3D HCI_VENDOR_PKT;
 =09/* an empty vendor packet has no path to reach here */
-=09if (is_vendor)
-=09=09hci_skb_pkt_type(skb) =3D *(const u8 *)skb_pull_data(skb, 1);
+=09if (is_vendor) {
+=09=09const u8 *pkt =3D skb_pull_data(skb, 1);
+
+=09=09if (!pkt)
+=09=09=09return -EILSEQ;
+=09=09hci_skb_pkt_type(skb) =3D *pkt;
+=09}
=20
 =09pkt_type =3D hci_skb_pkt_type(skb);
 =09need_lock =3D pkt_type =3D=3D HCI_COMMAND_PKT ||
@@ -4438,5 +4449,13 @@ struct sk_buff *btusb_qcom_recv_intr(struct hci_dev =
*hdev, struct sk_buff *skb,
 =09=09else if (pkt_type =3D=3D HCI_EVENT_PKT)
 =09=09=09hci_skb_expect(skb) =3D hci_event_hdr(skb)->plen;
=20
+=09=09if (hci_skb_expect(skb) >
+=09=09    QPERI_MAX_EVENT_SIZE - skb->len) {
+=09=09=09dev_kfree_skb_irq(skb);
+=09=09=09skb =3D NULL;
+=09=09=09*err =3D -EILSEQ;
+=09=09=09break;
+=09=09}
+
 =09=09if (hci_skb_expect(skb))
 =09=09=09continue;

