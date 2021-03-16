Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A165AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A19E64FED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhCPL2z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 07:28:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25083 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhCPL2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 07:28:34 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210316112832epoutp02f602664733b8fd0a66e21c1e4ddc1167~szyJCg9y_1697816978epoutp02a
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 11:28:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210316112832epoutp02f602664733b8fd0a66e21c1e4ddc1167~szyJCg9y_1697816978epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615894112;
        bh=zGc5atV3koVrrJ1f8I+I20BcT3fQGdNqYM5l8Ad2P/U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vB7lLT+hZ/ObRCXBgPWikc9gQOICPMSMl2vhZLheLPXF9Te0kVObjCOogDpp9pzIK
         ALbckIk6poby0anQ//E645SEb4HjWO3sYSe7Kw2ot2CnrjhL1j68j8hI8/tkTWGIg1
         caUYJP+IDBFxtLBNFvtBtIFqfb1SEfMrd++MeT74=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210316112830epcas5p25edac9b5f786c80bc4ef68e4cc76e28c~szyHjzlEN3251932519epcas5p2q;
        Tue, 16 Mar 2021 11:28:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.10.50652.E5690506; Tue, 16 Mar 2021 20:28:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210316105746epcas5p49f71a18f26a567ed3f7e0b1445c1fda5~szXR9AkXg1476614766epcas5p4W;
        Tue, 16 Mar 2021 10:57:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210316105746epsmtrp179a416b33748f351ce18effe5fe7de10~szXR8VNFZ0273802738epsmtrp1C;
        Tue, 16 Mar 2021 10:57:46 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-9f-6050965ecc3c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.97.13470.A2F80506; Tue, 16 Mar 2021 19:57:46 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210316105745epsmtip2f3ba903ac50f5e57c9672a2d5c99d266~szXRJh8PS0986009860epsmtip23;
        Tue, 16 Mar 2021 10:57:45 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ] btmgmt: Fix typo in printing Set PHY Configuration
 command error
Date:   Tue, 16 Mar 2021 16:27:38 +0530
Message-Id: <20210316105738.11560-1-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCmpm7ctIAEg3X7dSzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MrYMOMfc0Efa8W2s4fZGxjnsnQxcnJI
        CJhIzFm7irGLkYtDSGA3o8T5reuhnE+MEic3fWeFcL4xSsw/08gK0zJj81omiMReRokNjy8h
        tDzev5kdpIpNQFPi9ccvTCC2iICyxLN9h8FsZgFdiTPv17F1MXJwCAtESiz65QtisgioSjy9
        EgxSwStgLfH4fw8jxC55idUbDjCDjJcQ+M4msfH0LTaIhIvEi/9/2CFsYYlXx7dA2VISL/vb
        2CEamhkldmzeCOX0MEo8+NEN1W0vca7pGSvIZmagQ9fv0ocIy0pMPbUO6k4+id7fT5gg4rwS
        O+bB2CoSG1Z1wi37eGwhM4TtIXFgTg9YXEggVmLBsqfsExhlZyFsWMDIuIpRMrWgODc9tdi0
        wCgvtVyvODG3uDQvXS85P3cTIzhmtbx2MD588EHvECMTB+MhRgkOZiURXtO8gAQh3pTEyqrU
        ovz4otKc1OJDjNIcLErivDsMHsQLCaQnlqRmp6YWpBbBZJk4OKUamMTlz7o7WsTVV7UI7bjJ
        Pt+Bt4svsOpJfkTT3f+6sZFdAksC13Pcjy+x/hIVsGPnVfOnM0S/Ju+W9E//z55TLmR9YdXq
        XavN3vfseO9x4WfMt9yXD6rn6n45OYn7ElPb6ptrHA/6rJ/u/PLDJSGxdCvO2i4+316Pqa90
        l18/45C7Ls9Yu8LJuW7vrxtXGbYG3QiSzllneTX5bZt24befdqvt53TubPk4d/PK+OidwrMD
        WBtY8h3OXHztbj3V8wOzQHpSyP13Sy+v/2LJt3K+p4L/oTgDGbW1Ni+jvzhP2FiuLbT73ZyE
        2AADZtXsqzPM1eZcO9Yt9do/TezZS5WApcVz77/UfFq/sj1QXE+aQ4mlOCPRUIu5qDgRAOS8
        DhNIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJMWRmVeSWpSXmKPExsWy7bCSvK5Wf0CCQXODhMWd1dYWc671MVts
        W9fO7MDs0bdlFaPH501yAUxRXDYpqTmZZalF+nYJXBkbZvxjLuhjrdh29jB7A+Ncli5GTg4J
        AROJGZvXMnUxcnEICexmlPi4bDZQggMoISXxeJkORI2wxMp/z9khaj4wSrS8WMQOkmAT0JR4
        /fELE4gtIqAs8WzfYTCbWUBf4umF64wgtrBAuMSzhxcZQWayCKhKPL0SDBLmFbCWePy/hxFi
        vrzE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iRHsey3NHYzbV33Q
        O8TIxMF4iFGCg1lJhNc0LyBBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2amp
        BalFMFkmDk6pBqb+8tCsmHe2a3qDVoQqSWy4KhLRqbfi6LENws48b04lHFriKrqhaZrVgrq/
        ym8EX51+XbGPe+8T/4ZbAdoa/Q52BlaMLZWBVd/ezjlXtF/ZLqd+0cXzD3PbH5/cM0Etd/3c
        ltPLLLZOtJ5d19izYHXhVzfV1BdK2y70GEhkRZU92X66iJclXmC6y+rNAQcythzI/GeaZPij
        t2/Tiuxk+dIGCacinzBGrTdeJ9h37zRcJvjohdArx2MK2id31SlKmazYcyQ4VfX1m60n+6co
        JG09eGD5gustQcZ/j/mdjMxL1f9lf2szq6541/Mj9e5G65a+mFFrEl6VK+LBMuNbkWCtd7Po
        d6OgmbbcrUlcM5VYijMSDbWYi4oTAa+s7t1sAgAA
X-CMS-MailID: 20210316105746epcas5p49f71a18f26a567ed3f7e0b1445c1fda5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210316105746epcas5p49f71a18f26a567ed3f7e0b1445c1fda5
References: <CGME20210316105746epcas5p49f71a18f26a567ed3f7e0b1445c1fda5@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index f4eb541fa..647c696f8 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4725,7 +4725,7 @@ static void cmd_phy(int argc, char **argv)
 	if (mgmt_send(mgmt, MGMT_OP_SET_PHY_CONFIGURATION, index, sizeof(cp),
 					&cp, set_phy_rsp, NULL, NULL) == 0) {
 		error("Unable to send %s cmd",
-				mgmt_opstr(MGMT_OP_GET_PHY_CONFIGURATION));
+				mgmt_opstr(MGMT_OP_SET_PHY_CONFIGURATION));
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
-- 
2.17.1

