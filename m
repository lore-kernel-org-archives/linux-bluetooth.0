Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA8C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C520861283
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGVFUl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:19892 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhGVFUj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:39 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210722060114epoutp02317fdbed6fd289a92af616a85635f2b4~UB46Pe8_i1764317643epoutp02T
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:01:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210722060114epoutp02317fdbed6fd289a92af616a85635f2b4~UB46Pe8_i1764317643epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933674;
        bh=SAwXS1k1o4yo5Auivr4AhoDjySgx+LKBBteqHFADDks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpXj7ozycHsJhwjD2qLWkYFxlnQsc2ac+mDld4jbPFqB1nNsaIzRUQjYUZ+Zrt+VJ
         WFIrkADo9Se4CxlYzXZZGJtsOdbZdW9iS1buygpuVslMb/JpK61rfkuGqv/aurhBEj
         Nkoy89VXsCRtfeuym5STlh+5QqF82KJ+wpAFrm3c=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210722060113epcas5p21054d9e9332a933e3c46fa4d2bf43cb6~UB45TZ7kI0861508615epcas5p20;
        Thu, 22 Jul 2021 06:01:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.33.55882.8A909F06; Thu, 22 Jul 2021 15:01:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722055017epcas5p4da91b311c34a5fb869148b369338ed07~UBvWmN6NT2536725367epcas5p4S;
        Thu, 22 Jul 2021 05:50:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722055017epsmtrp10a46a9e16cd5e37f85eb9d3904f6ceba~UBvWk--v63119631196epsmtrp16;
        Thu, 22 Jul 2021 05:50:17 +0000 (GMT)
X-AuditID: b6c32a49-f4fff7000001da4a-41-60f909a8d3aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.14.08394.91709F06; Thu, 22 Jul 2021 14:50:17 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055016epsmtip13f66d616a4cb9a62b862955bf6e75a91~UBvVoxwtG1278812788epsmtip1C;
        Thu, 22 Jul 2021 05:50:16 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 8/8] monitor: Add support for LE PHY Update event
Date:   Thu, 22 Jul 2021 11:19:51 +0530
Message-Id: <20210722054951.8291-9-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmlu4Kzp8JBvPmmFvcWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJWxa+E61oJrPBX/Ppo2MM7h6mLk5JAQ
        MJHYsWsdUxcjF4eQwG5GiVNNN6GcT4wS87e8YINwvjFKNNxcxQLT8v77SVYQW0hgL6PErCdp
        cB1HX14AS7AJaEq8/viFCcQWEVCWeLbvMJjNLKArceb9OjYQW1jAXeL5xPdg9SwCqhKfjk4A
        W8ArYCVx9u0DZohl8hKrNxwAszkFrCUOPLrJDrJMQmAyu8SBT/fYIYpcJGZOmg1lC0u8Or4F
        ypaSeNnfBtXQzCixY/NGKKeHUeLBj242iCp7iXNNz4DO4AA6T1Ni/S59iLCsxNRT66Cu5pPo
        /f2ECSLOK7FjHoytIrFhVSfcso/HFkJd7SHxZ+FxaED2MUpMev+WeQKj3CyEFQsYGVcxSqYW
        FOempxabFhjmpZbrFSfmFpfmpesl5+duYgRHs5bnDsa7Dz7oHWJk4mA8xCjBwawkwqtS9DVB
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOC97PFBKID2xJDU7NbUgtQgmy8TBKdXA5JZ4Q+e+lpLr
        p+46k2bXhpM7ikK45F04qn9PPHo8ffve3r2lM81tP16cseDo8+nsDdq8F9lbQiekLN28b+v2
        ORkdcjVX56sFPr7kuaBnxTTRx4nG5zZOXtf/Ipxx3R2vOy6vW1qrHoVz5M19XubMXZpa1TN/
        dlx2drbCnFeS5gsZ3pY//vDaNzfuYLrWWcPCBbPDOw5xu5xkEPnno77iXYfxiTklfw83nJx9
        tYNxYeOEB3/mq33dNvHcftHaqe80gz6Vrnu3+4f4xQ8b/ddkzJF8c+Nx+EGuSbwh5fbzPJb6
        5xnNOrUjhidp+okzStumpalM6E1mzH0uJMf35dz3LcZXL02w0Fm7bEHfSz+jjCVKLMUZiYZa
        zEXFiQC1CQwYVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSnK4k+88Eg7+fBCzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MrYtXAda8E1nop/H00bGOdwdTFyckgI
        mEi8/36StYuRi0NIYDejxMrfE4AcDqCElMTjZToQNcISK/89Z4eo+cAo8eXtPXaQBJuApsTr
        j1+YQGwRAWWJZ/sOg9nMAvoSTy9cZwSxhQXcJZ5PfM8KYrMIqEp8OjqBBcTmFbCSOPv2ATPE
        AnmJ1RsOgNmcAtYSBx7dBJsvBFRz7/UW5gmMfAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfm
        pesl5+duYgSHipbmDsbtqz7oHWJk4mA8xCjBwawkwqtS9DVBiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqYE51358Tqnz64I8boVty7u3+KsahGJWeda
        463uHjINc1HV/LPDZPFnDYvg1X5pEmuYZZ43Riate2e0qOW8UVXi5/oqa8cZ9utLwo5ev6Le
        9d516l3mFq/2p++O3Q1+lGzwN2xJmPi22S+SfovEF3a/8G2/IfNnsfei6E+fjGU5jn76w8Cx
        y9u28N5VgTVmanO1/02wev/phcmpk5GvCn4p9F4OOWJz/ImwuRL/w3MzZW7/dN8/8d2WJ733
        Hwcn/xJR05X8V+7v9+PKq4+n/srlWTdFWFociF9+hK/t1MdH09dZlm+W+Huonu3JwWkOGw5O
        Olk05+BH9eIuntL+so0rryRvre2qPKi5deaUOVn+SizFGYmGWsxFxYkAf5wGU4QCAAA=
X-CMS-MailID: 20210722055017epcas5p4da91b311c34a5fb869148b369338ed07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055017epcas5p4da91b311c34a5fb869148b369338ed07
References: <20210722054951.8291-1-ayush.garg@samsung.com>
        <CGME20210722055017epcas5p4da91b311c34a5fb869148b369338ed07@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Verification logs:
=========================================
> HCI Event: LE Meta Event (0x3e) plen 6
	  LE PHY Update Complete (0x0c)
		Status: Success (0x00)
		Handle: 0
		TX PHY: LE 2M (0x02)
		RX PHY: LE 2M (0x02)
@ MGMT Event: LE PHY Update Complete (0x002f) plen 12
		LE Address: 45:18:F8:CF:23:7E (Resolvable)
		Status: Success (0x00)
		Updated PHYs: 0x1800
		  LE 2M TX
		  LE 2M RX

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 monitor/packet.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 52d22ab21..eaa3070de 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14304,6 +14304,18 @@ static void mgmt_controller_resume_evt(const void *data, uint16_t size)
 	mgmt_print_address(data, addr_type);
 }
 
+static void mgmt_le_phy_update_complete_evt(const void *data,
+						uint16_t size)
+{
+	uint8_t address_type = get_u8(data + 6);
+	uint8_t status = get_u8(data + 7);
+	uint32_t selected_phys = get_le32(data + 8);
+
+	mgmt_print_address(data, address_type);
+	mgmt_print_status(status);
+	mgmt_print_phys("Updated PHYs", selected_phys);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -14393,6 +14405,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_controller_suspend_evt, 1, true },
 	{ 0x002e, "Controller Resumed",
 			mgmt_controller_resume_evt, 8, true },
+	{ 0x002f, "LE PHY Update Complete",
+			mgmt_le_phy_update_complete_evt, 12, true },
 	{ }
 };
 
-- 
2.17.1

