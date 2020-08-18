Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546DCC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 16:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BE7207DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dptechnics.com header.i=daan@dptechnics.com header.b="AihgrU43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHRQve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:51:34 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17124 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgHRQvc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 12:51:32 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2020 12:51:32 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1597768587; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=N0GrxEhOEDYs/e1/1yq7Crb2xLfUfNEFauIXrRH4OujoFxhGCYvTcjP0pQqmS2yUpAJf6qoDnNIlYwF3zSS9HSoK3uxQh7Hu4UG0jJo/52L1CeweAvDl3gJYB5o7EoaF4HeS7UpXjlEpgufd/kg9dMJshFKDMD8+jRs7IpxRKvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1597768587; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MT2STI3D/C0IsbHcGVmVjss1gyVSWlFxJWLW8Trr2tk=; 
        b=ly1OCPZHpJiV2owQhxFIJd0SmHYnZygJUASqKCtTOuSLdLlCTW3EGWi5jtcJm71kMweDQUCE0WNVO8pdFVSWeH6WZQF0aoHwjHogF1yIuXRXMrOPElYsX4P9FeAvBeJwp/Dha1b2A9ahiwoya6IhKrfrClR3SKLbDWYMabL80Bc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dptechnics.com;
        spf=pass  smtp.mailfrom=daan@dptechnics.com;
        dmarc=pass header.from=<daan@dptechnics.com> header.from=<daan@dptechnics.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1597768587;
        s=zoho; d=dptechnics.com; i=daan@dptechnics.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=MT2STI3D/C0IsbHcGVmVjss1gyVSWlFxJWLW8Trr2tk=;
        b=AihgrU43knZAUw9Qiwwa6Y8I0DN8V9co7TN4uZK74HAqqpVaEFLpbk1SNy/c931g
        6tukEMOoWPQlBSk1iwmbHGrm7ScVFadJ81fMeBPTXyg5DOTb01X3fWQFnImKwARwVxN
        42LXrGK/13HQ04YskiNJRtK8/GxudRrQhRAExnbg=
Received: from daan-devbox.dptechnics.local (178-116-74-88.access.telenet.be [178.116.74.88]) by mx.zohomail.com
        with SMTPS id 1597768585055945.5832986315066; Tue, 18 Aug 2020 09:36:25 -0700 (PDT)
From:   Daan Pape <daan@dptechnics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daan Pape <daan@dptechnics.com>
Message-ID: <20200818163611.57656-2-daan@dptechnics.com>
Subject: [PATCH BlueZ 1/1] Fixed issue in bluetooth-meshd which causes HCI error 0x12 when LE scanning is enabled because no random address was set. This is fixed by using the default HCI own device address option.
Date:   Tue, 18 Aug 2020 18:36:11 +0200
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818163611.57656-1-daan@dptechnics.com>
References: <20200818163611.57656-1-daan@dptechnics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-io-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 67b13a1b9..65fd1c7b9 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -321,7 +321,7 @@ static void scan_disable_rsp(const void *buf, uint8_t s=
ize,
 =09cmd.type =3D pvt->active ? 0x01 : 0x00;=09/* Passive/Active scanning */
 =09cmd.interval =3D L_CPU_TO_LE16(0x0010);=09/* 10 ms */
 =09cmd.window =3D L_CPU_TO_LE16(0x0010);=09/* 10 ms */
-=09cmd.own_addr_type =3D 0x01;=09=09/* ADDR_TYPE_RANDOM */
+=09cmd.own_addr_type =3D 0x00; =09=09/* Public Device Address */
 =09cmd.filter_policy =3D 0x00;=09=09/* Accept all */
=20
 =09bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
@@ -579,7 +579,7 @@ static void set_send_adv_params(const void *buf, uint8_=
t size,
 =09cmd.min_interval =3D L_CPU_TO_LE16(hci_interval);
 =09cmd.max_interval =3D L_CPU_TO_LE16(hci_interval);
 =09cmd.type =3D 0x03; /* ADV_NONCONN_IND */
-=09cmd.own_addr_type =3D 0x01; /* ADDR_TYPE_RANDOM */
+=09cmd.own_addr_type =3D 0x00; /* Public Device Address */
 =09cmd.direct_addr_type =3D 0x00;
 =09memset(cmd.direct_addr, 0, 6);
 =09cmd.channel_map =3D 0x07;
--=20
2.20.1


