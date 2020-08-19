Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1225BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 08:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E9620738
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 08:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dptechnics.com header.i=daan@dptechnics.com header.b="FoUF9Ag8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHSI2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:28:44 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17155 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSI2n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 04:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597825721; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JQOd6sEjLn8ovrXXo4MGubrEV/d6ZJ4JQyFUC5q6U79j7f67R2+W4dihcN1XGitKfUYzz/WVt9ZvjAhL9/y+ZsAjDp5fOKYDusbbyHYPGVv/4k/bes63fEmjwOUl4EqMGhYFaLuUq7chmFG/q4IIHqR+uUFcbiJxAv89bAJWjg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1597825721; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=d9boOkysEGDCONb3wvtEktaiZH+gsA7O/zLknqluH/s=; 
        b=R5TC4TVy7c2jiS1bJgg1DMvY3nRbtKfY/koi+n9knU+ZYbRxHAPv0KUM/PXtCyboIYDdMTcOVuuFwk8BPF6IA+fWrReEfCDMnpDEcW9xkzMo7m74emDe2Vfxaw9ZY0l53fgqeXYa+jlh1kSuygTsRYNp4gfsIcHkb9MrT9j3AXE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dptechnics.com;
        spf=pass  smtp.mailfrom=daan@dptechnics.com;
        dmarc=pass header.from=<daan@dptechnics.com> header.from=<daan@dptechnics.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1597825721;
        s=zoho; d=dptechnics.com; i=daan@dptechnics.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=d9boOkysEGDCONb3wvtEktaiZH+gsA7O/zLknqluH/s=;
        b=FoUF9Ag83GWiLjTfMUvGy1HoZREFwU40b75shq6oj5Fh7pDXcUGH4lNVHxtLjr1S
        OZD8hmxWki9xAO9vRpp/l/Q3oDUtbgycoSnEhTQJZiiRuVYlmooMDl7pUSqyGJW1XX8
        x3GuSC30R9uhxL7YNPVG/ADWB1pvsuA27Vb87PAg=
Received: from daan-devbox.dptechnics.local (178-116-74-88.access.telenet.be [178.116.74.88]) by mx.zohomail.com
        with SMTPS id 1597825718141948.4507996388694; Wed, 19 Aug 2020 01:28:38 -0700 (PDT)
From:   Daan Pape <daan@dptechnics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daan Pape <daan@dptechnics.com>
Message-ID: <20200819082822.64903-2-daan@dptechnics.com>
Subject: [PATCH BlueZ 1/1] Added random address in mesh HCI initialization to prevent error 0x12 when enabling/disabling LE scans
Date:   Wed, 19 Aug 2020 10:28:22 +0200
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819082822.64903-1-daan@dptechnics.com>
References: <20200819082822.64903-1-daan@dptechnics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-io-generic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 67b13a1b9..67304d201 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -209,6 +209,7 @@ static void configure_hci(struct mesh_io_private *io)
 =09struct bt_hci_cmd_le_set_scan_parameters cmd;
 =09struct bt_hci_cmd_set_event_mask cmd_sem;
 =09struct bt_hci_cmd_le_set_event_mask cmd_slem;
+=09struct bt_hci_cmd_le_set_random_address cmd_raddr;
=20
 =09/* Set scan parameters */
 =09cmd.type =3D 0x00; /* Passive Scanning. No scanning PDUs shall be sent =
*/
@@ -261,6 +262,10 @@ static void configure_hci(struct mesh_io_private *io)
 =09cmd_slem.mask[6] =3D 0x00;
 =09cmd_slem.mask[7] =3D 0x00;
=20
+=09/* Set LE random address */
+=09l_getrandom(cmd_raddr.addr, 6);
+=09cmd_raddr.addr[5] |=3D 0xc0;
+
 =09/* TODO: Move to suitable place. Set suitable masks */
 =09/* Reset Command */
 =09bt_hci_send(io->hci, BT_HCI_CMD_RESET, NULL, 0, hci_generic_callback,
@@ -282,6 +287,10 @@ static void configure_hci(struct mesh_io_private *io)
 =09bt_hci_send(io->hci, BT_HCI_CMD_LE_SET_EVENT_MASK, &cmd_slem,
 =09=09=09sizeof(cmd_slem), hci_generic_callback, NULL, NULL);
=20
+=09/* Set LE random address */
+=09bt_hci_send(io->hci, BT_HCI_CMD_LE_SET_RANDOM_ADDRESS, &cmd_raddr,
+=09=09=09sizeof(cmd_raddr), hci_generic_callback, NULL, NULL);
+
 =09/* Scan Params */
 =09bt_hci_send(io->hci, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS, &cmd,
 =09=09=09=09sizeof(cmd), hci_generic_callback, NULL, NULL);
--=20
2.20.1


