Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B7C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94077206EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 10:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k5ZqMSha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfLCKBk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:01:40 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:31115 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCKBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 05:01:39 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191203100136epoutp01a0ce642b38c4d0fea316c9f2f9b7bc7a~c1DWR-KU00168401684epoutp01i
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 10:01:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191203100136epoutp01a0ce642b38c4d0fea316c9f2f9b7bc7a~c1DWR-KU00168401684epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575367296;
        bh=w47gJNYGUXlX3404PYfJS4iqrop+WjnQz5+h3OIgESQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=k5ZqMSha//Tl5BoLpAclvs7+d+k7zU2S9qdQtrj918lztl3D84LNJO5aOOROvvMij
         hO9PQ7qHUc33mpoBS5wtdAsuFoxpQj55YgE61qIoZcE3aAPafe8narGh42N6hQgAzE
         Jj9HuOcuXIUyTlz7GsBB8Io+mI0C944Jw1Xtt/HM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20191203100135epcas5p1b6566cdbaa8367d287ee79e69cfc5e3f~c1DVSlP131446414464epcas5p1k;
        Tue,  3 Dec 2019 10:01:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.195]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47RyDs4KY5zMqYkb; Tue,  3 Dec
        2019 10:01:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.A0.19629.D7236ED5; Tue,  3 Dec 2019 19:01:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191203100133epcas5p1bf4b021f6cabcba3b5ff67965ccfec56~c1DTf4h5Z1452014520epcas5p1m;
        Tue,  3 Dec 2019 10:01:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191203100133epsmtrp1ba5b875c3fe660d621db67a531b2f076~c1DTfRE-X2246922469epsmtrp1S;
        Tue,  3 Dec 2019 10:01:33 +0000 (GMT)
X-AuditID: b6c32a4b-32dff70000014cad-86-5de6327d700e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.FC.10238.D7236ED5; Tue,  3 Dec 2019 19:01:33 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191203100132epsmtip1b9a7e5945c12577d3b6b661617289e9b~c1DS-Kov60036000360epsmtip1W;
        Tue,  3 Dec 2019 10:01:32 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Fix string of public-oob and static-oob
Date:   Tue,  3 Dec 2019 15:31:23 +0530
Message-Id: <1575367285-8098-1-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7bCmpm6t0bNYgyc7FSzmXOtjtvi/9Ba7
        A5NH35ZVjB6fN8kFMEXl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
        Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFegVJ+YWl+al
        6yXn51oZGhgYmQJVJuRknPx7jb3gCUvFm45OpgbGJ8xdjBwcEgImEsun53YxcnEICexmlJgx
        8RYLhPOJUeLj3ReMEM43RomXE9qBHE6wjsczFjJBJPYyShx6/pYZwulgkvj7ewYzSBWbgLHE
        +ZuvmEBsEQFliWf7DoPZzALaEpPezASzhQWcJN4vPc8KYrMIqEq0v2hnA7F5Bdwleha8gdom
        J3HzXCczhH2SVaL/miPE3S4SH16zQYSFJV4d38IOYUtJvOxvg7K7GSV2v3EFuU1CYAqjxL0X
        EDdICNhLPN00lx1kDrOApsT6XfoQp/FJ9P5+wgQxnleio00IolpBYtXUiVCdYhLrpn9hhyjx
        kNja4w5iCgnESpzapjyBUWYWwsgFjIyrGCVTC4pz01OLTQuM81LLkSNmEyM4mWh572DcdM7n
        EKMAB6MSD++BP09ihVgTy4orcw8xSnAwK4nwbpN4GivEm5JYWZValB9fVJqTWnyI0RQYYBOZ
        pUST84GJLq8k3tDUyMzMwNLA1NjCzFBJnHcS69UYIYH0xJLU7NTUgtQimD4mDk6pBsbGw/Vs
        R569tE/Y6L/q3oms2A92vL9va/J4eS7w0WK/emfmrb1WHd9kmcJmd3Vsne/MK/Dx18dX+W1x
        Hf/iQiSYbHrWGl9QWFzxtHTC4SDHz7M6M0sf+6RXfveWSK3St+92jSn7YsT4WiHk1bcHpt/M
        IzVlZ87f4X8x95W+8f0gDkGX4hsPmpVYijMSDbWYi4oTAd20t1I8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJMWRmVeSWpSXmKPExsWy7bCSnG6t0bNYg42/2CzmXOtjtvi/9Ba7
        A5NH35ZVjB6fN8kFMEVx2aSk5mSWpRbp2yVwZZz8e4294AlLxZuOTqYGxifMXYycHBICJhKP
        Zyxk6mLk4hAS2M0osfDtT1aIhJjEmxUn2CFsYYmV/56zQxS1MUnMuzqVDSTBJmAscf7mKyYQ
        W0RAWeLZvsNgNrOAtsSkNzPBbGEBJ4n3S8+DDWURUJVof9EO1ssr4C7Rs+ANI8QCOYmb5zqZ
        JzDyLGBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJEex3Lc0djJeXxB9iFOBgVOLh
        PfDnSawQa2JZcWXuIUYJDmYlEd5tEk9jhXhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQ
        nliSmp2aWpBaBJNl4uCUamDUeFj73+xHe938y8GJN5YfWuJl+2Tt8VvrtafrsyQvMLJPf/Fm
        ys26+E4hEbcCgdonx6XFgq/PVbmyvOOjiNxq13v1tW71JXsdYqT7Xy90Sez8pJkqJR7hcoRH
        e7NS+vNO5hzXIONpWjtPXD//dvKZ2cH+p6ZPuHBwzuSTIfUt2+TmuDhzypgrsRRnJBpqMRcV
        JwIAbii3OfcBAAA=
X-CMS-MailID: 20191203100133epcas5p1bf4b021f6cabcba3b5ff67965ccfec56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191203100133epcas5p1bf4b021f6cabcba3b5ff67965ccfec56
References: <CGME20191203100133epcas5p1bf4b021f6cabcba3b5ff67965ccfec56@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Fix string typo as per mesh-api.txt
---
 mesh/agent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 5a5570a..9f9399f 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -131,9 +131,9 @@ static void parse_prov_caps(struct mesh_agent_prov_caps *caps,
 			break;
 		}
 
-		if (!strcmp(str, "PublicOOB"))
+		if (!strcmp(str, "public-oob"))
 			caps->pub_type = 1;
-		else if (!strcmp(str, "StaticOOB"))
+		else if (!strcmp(str, "static-oob"))
 			caps->static_type = 1;
 	}
 
-- 
2.7.4

