Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E2C43215
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 10:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1029206DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 10:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VD/bZyr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLCKBk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:01:40 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:17360 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCKBk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 05:01:40 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191203100137epoutp042258d0115849d4bc773d65e1b27c2eb6~c1DXUm4393135331353epoutp04f
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 10:01:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191203100137epoutp042258d0115849d4bc773d65e1b27c2eb6~c1DXUm4393135331353epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575367297;
        bh=/egjkkrbZQd3JZdSZw6O0s2yStriS0XUYekqK8USQrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VD/bZyr9d5NUkfZM625DSbQtcnYKZW1QjA+7fUgWF6L5IfM7epO6l/Pivoqma3Pd2
         8lRld9cTGdwJ9QGzOlUdNKur7SBuJCs7ECZvhoNK1MV75j7fVJu4QV4xXPMw5p8be+
         UOnnCE+wnob0CrlNynvgvnk9Bfvu0RoeLehy2/uM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191203100137epcas5p46e05cfe4ea0c1f236d4d17d0abbd5b3b~c1DXEg9fJ1037910379epcas5p4E;
        Tue,  3 Dec 2019 10:01:37 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.195]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47RyDv0zydzMqYkg; Tue,  3 Dec
        2019 10:01:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.A0.19629.D7236ED5; Tue,  3 Dec 2019 19:01:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191203100133epcas5p190c7b3e7e06d84b1db57ec85054876ef~c1DUDpk1f1446414464epcas5p1i;
        Tue,  3 Dec 2019 10:01:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191203100133epsmtrp151f806f04b989e394272403bc2c5592f~c1DUDEPEH2246922469epsmtrp1U;
        Tue,  3 Dec 2019 10:01:33 +0000 (GMT)
X-AuditID: b6c32a4b-345ff70000014cad-89-5de6327d4922
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.FC.10238.D7236ED5; Tue,  3 Dec 2019 19:01:33 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191203100133epsmtip1c9a7eed4fcbdf56f941ca6f6eaab69ec~c1DTklMGn0499004990epsmtip1Z;
        Tue,  3 Dec 2019 10:01:33 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Fix invalid transaction number in PROV_INVITE
Date:   Tue,  3 Dec 2019 15:31:24 +0530
Message-Id: <1575367285-8098-2-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575367285-8098-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7bCmlm6d0bNYg39PmCzmXOtjtvi/9Ba7
        A5NH35ZVjB6fN8kFMEXl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
        Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFegVJ+YWl+al
        6yXn51oZGhgYmQJVJuRkNL6ayFawhK3i9tN29gbGDtYuRk4OCQETiYUfHwHZXBxCArsZJXbN
        62YESQgJfGKUON2kC5H4xihxd8pn9i5GDrCOxw+qIeJ7GSV+3O1nhHA6mCS2/fvMBNLNJmAs
        cf7mKzBbREBZ4tm+w2A2s4C2xKQ3M8FsYQEPiXlfT7KADGURUJWY+jkQxOQVcJeY8VYG4jg5
        iZvnOplBwpxA1TP2JINskhB4yCqxZcFeZogaF4kFNzZBPSMs8er4FnYIW0riZX8blN3NKLH7
        jStE8xRGiXsvIM6RELCXeLppLthfzAKaEut36UNcySfR+/sJE8S7vBIdbUIQ1QoSq6ZOhOoU
        k1g3/Qs0RDwkllyuhQTCbEaJjiNbmCYwys5CGLqAkXEVo2RqQXFuemqxaYFxXmo5ciRtYgQn
        GS3vHYybzvkcYhTgYFTi4T3w50msEGtiWXFl7iFGCQ5mJRHebRJPY4V4UxIrq1KL8uOLSnNS
        iw8xmgJDbyKzlGhyPjAB5pXEG5oamZkZWBqYGluYGSqJ805ivRojJJCeWJKanZpakFoE08fE
        wSnVwCh1PU8ywajuhPQpKQeXDpW81l6B/bZOae81Fs6t/T/jFt/rMxuu7JnJKfn7/baoSw6z
        +Fs//tcuevxy6oef5xd84Oy99tn5YLv4zXlW/89uX1OWG3voQezKu4bHOCaHFu46Nm3pS88J
        lmqn+U8EqK/etsNvwuQZjAf1rr7ps939oW/xvTMls8R/KrEUZyQaajEXFScCAEEM4VdIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJMWRmVeSWpSXmKPExsWy7bCSnG6t0bNYgxeLdS3mXOtjtvi/9Ba7
        A5NH35ZVjB6fN8kFMEVx2aSk5mSWpRbp2yVwZTS+mshWsISt4vbTdvYGxg7WLkYODgkBE4nH
        D6q7GLk4hAR2M0qc7vrG1MXICRQXk3iz4gQ7hC0ssfLfc3aIojYmiYXXuxhBEmwCxhLnb74C
        axARUJZ4tu8wmM0soC0x6c1MMFtYwENi3teTLCDLWARUJaZ+DgQxeQXcJWa8lYEYLydx81wn
        M0iYE6h6xp5kkLAQUMWXR5PZJzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJ
        ERweWpo7GC8viT/EKMDBqMTDe+DPk1gh1sSy4srcQ4wSHMxKIrzbJJ7GCvGmJFZWpRblxxeV
        5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cDId6/+rPe0Ay+j/MP1K6c++5L3
        JWNfqOdUO4m39U/M37zem/30tonD4oAVzTW/Z1Rv7Qg2/NL9YOfZ8JtqqxOUu41avyte1+5n
        /DYtm3vOvwqenDALr6eW+bzla+ZNnyravPTU810rH++aLWZVbnb+atgfBd47F7/raTQq6nJE
        8ly6z2s2Zd4UJZbijERDLeai4kQAtlz6iwsCAAA=
X-CMS-MailID: 20191203100133epcas5p190c7b3e7e06d84b1db57ec85054876ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191203100133epcas5p190c7b3e7e06d84b1db57ec85054876ef
References: <1575367285-8098-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20191203100133epcas5p190c7b3e7e06d84b1db57ec85054876ef@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

For initiator, transaction number starts from 0x00 where as for acceptor
transaction number starts from 0x80. Since transaction number is
pre-incremented and sent in every packet, initialize it with 0xFF for
initiator and 0x7F for acceptor.
---
 mesh/pb-adv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 6b4a700..19d1453 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -292,6 +292,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		/* Only call Open callback once */
 		if (first) {
 			l_debug("PB-ADV open confirmed");
+			session->local_trans_num = 0xFF;
 			session->open_cb(session->user_data, pb_adv_tx,
 							session, PB_ADV);
 		}
-- 
2.7.4

