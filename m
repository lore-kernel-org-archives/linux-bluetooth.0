Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74093C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D1E21527
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 16:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dptechnics.com header.i=daan@dptechnics.com header.b="Y3AUOO6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgHaQLl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:11:41 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17170 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgHaQLj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 12:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1598890296; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MWVWWnCvucgCabNqJKhKA9tHKAcbciG4m3ed9Gkq1Cqp1+g3+65BDTdkjtFxiDYZ+jkAi9mlexiqx2Pp3DyraELcVtO9Ey6O0Oz+4HshzMLkHKa8OZ2saDAEk1ITrvfnGfUe/u9lhJP8PBUelv5zcW7vQuVmt1haWMBHNQGLoCI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1598890296; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=i5ITdA55/iVGU4KTx2BMYFv/ttFKT7Cqa+Gi2cSOLb0=; 
        b=UXOhM9RDA2yQsMruZWL+c48Q1LLP/gHM3nDc/1WR3YVLcbk+kOZIyuqvZ6/CvYZ+7m0mvTtqDi/EWsA4pcaV9TcpV/xR+UvhRsKfkYOZ/5SgAKSOC55G1xV1gwn8Ebrs43G7dCFu+OW3P0BAynKh7y1vxVo9jj/AlAJ1kWTNVo0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dptechnics.com;
        spf=pass  smtp.mailfrom=daan@dptechnics.com;
        dmarc=pass header.from=<daan@dptechnics.com> header.from=<daan@dptechnics.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1598890296;
        s=zoho; d=dptechnics.com; i=daan@dptechnics.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=i5ITdA55/iVGU4KTx2BMYFv/ttFKT7Cqa+Gi2cSOLb0=;
        b=Y3AUOO6lj4IM3z0nn1Z+OTh3i40DFZxZN4chC13Lb0fifM2HrM0eLOj8hOsCNHVW
        TDqNW2ydxSyQ2g1jhcfpv88kPLys+qQf1L6hT5hhT6p0dd8rK7YEcogXIfa5GKpaFo3
        ++inUWrMdUq5FforKNrPSsrcTaSygksT5ASsvTXA=
Received: from daan-devbox.dptechnics.local (178-116-74-88.access.telenet.be [178.116.74.88]) by mx.zohomail.com
        with SMTPS id 1598890292793348.33179098134076; Mon, 31 Aug 2020 09:11:32 -0700 (PDT)
From:   Daan Pape <daan@dptechnics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daan Pape <daan@dptechnics.com>
Message-ID: <20200831161116.15975-2-daan@dptechnics.com>
Subject: [PATCH BlueZ 1/1] Mesh HCI interface init scan interval fixed
Date:   Mon, 31 Aug 2020 18:11:16 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831161116.15975-1-daan@dptechnics.com>
References: <20200831161116.15975-1-daan@dptechnics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 AUTHORS                | 1 +
 mesh/mesh-io-generic.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/AUTHORS b/AUTHORS
index 291d9b049..fd5d20cb2 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -107,3 +107,4 @@ Micha=C5=82 Lowas-Rzechonek <michal.lowas-rzechonek@sil=
vair.com>
 Jakub Witowski <jakub.witowski@silvair.com>
 Rafa=C5=82 Gajda <rafal.gajda@silvair.com>
 Szymon Czapracki <szymon.czapracki@codecoup.pl>
+Daan Pape <daan@dptechnics.com>
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 67304d201..e65d87aab 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -213,8 +213,8 @@ static void configure_hci(struct mesh_io_private *io)
=20
 =09/* Set scan parameters */
 =09cmd.type =3D 0x00; /* Passive Scanning. No scanning PDUs shall be sent =
*/
-=09cmd.interval =3D 0x0030; /* Scan Interval =3D N * 0.625ms */
-=09cmd.window =3D 0x0030; /* Scan Window =3D N * 0.625ms */
+=09cmd.interval =3D L_CPU_TO_LE16(0x0010); /* Scan Interval =3D N * 0.625m=
s */
+=09cmd.window =3D L_CPU_TO_LE16(0x0010); /* Scan Window =3D N * 0.625ms */
 =09cmd.own_addr_type =3D 0x00; /* Public Device Address */
 =09/* Accept all advertising packets except directed advertising packets
 =09 * not addressed to this device (default).
--=20
2.25.1


