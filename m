Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE54C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 08:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FE42087C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 08:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="txncYtFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfBYIzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:55:09 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:51935 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBYIzI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 03:55:08 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190225085506epoutp038afe70b3c7b5822092afc524dec05e4d~Gj4E5eBUV2152921529epoutp03X
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Feb 2019 08:55:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190225085506epoutp038afe70b3c7b5822092afc524dec05e4d~Gj4E5eBUV2152921529epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551084906;
        bh=R35P+l4W6VQ+N5WrmPSx7K605VB4Qhg1edkSUjEyugQ=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=txncYtFLwe8T1hv5RvyBU2F0uH78awBES0kzDMkaybLmOZSHDhJkFSNqeTlkPtBIp
         UIUSYzBI/PlrnGQeQ1f1WM+cPGZzJeQOJuRjiE9BRWhdM8YG0WxPElfom8xWi4w8Ps
         fTvHFALpVfhI+ADKvW82cjwfJ2JcIyvqsYrQakM0=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.197]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190225085505epcas5p221bafd91efe8e74251b484a302d9eba0~Gj4DQNDiP2174721747epcas5p2N;
        Mon, 25 Feb 2019 08:55:05 +0000 (GMT)
X-AuditID: b6c32a4b-4afff70000001028-5c-5c73ad624173
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.F2.04136.26DA37C5; Mon, 25 Feb 2019 17:54:58 +0900 (KST)
Mime-Version: 1.0
Subject: Query regarding BLE Mesh provisioning
Reply-To: a.rai@samsung.com
From:   Atul Kumar Rai <a.rai@samsung.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Anupam Roy <anupam.r@samsung.com>,
        Maneesh Jain <maneesh.jain@samsung.com>,
        SACHIN DEV SHARMA <sachin.dev@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190225082813epcms5p8052825469b7459d632a2a1aa6508192a@epcms5p8>
Date:   Mon, 25 Feb 2019 13:58:13 +0530
X-CMS-MailID: 20190225082813epcms5p8052825469b7459d632a2a1aa6508192a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmpm7S2uIYg9bXYhZ3VltbzLnWx2xx
        9tk9VotbN/pZHFg8+rasYvT4vEkugCkqxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMHaI+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQ
        qECvODG3uDQvXS85P9fK0MDAyBSoMiEn4+P3HqaCfcwVH3azNDC+ZOpi5OSQEDCROPvhJpgt
        JLCbUWL/Yd4uRg4OXgFBib87hEHCwgJ6Em9mHmaEKJGWOLSnixUiriUx6U4fC4jNJqAhcWpx
        P9gYEQF3iT37b4PVMwvUSLSd2sQKsYpXYkb7UxYIW1pi+/KtjBC2qMTN1W/ZYez3x+ZDxUUk
        Wu+dZYawBSUe/NwNFZeRONr9GmgXF5DdzSix9sU9FghnCqPElxOf2CCqzCWmre0D6+AV8JWY
        cPsA2CQWAVWJ7j0PoJ53kXg9+SHUpdoSyxa+ZgZ5nllAU2L9Ln2IElmJqafWMUGU8En0/n7C
        BPPMjnkwtrzE6ra/rDAP3P7VC3W0h8TX7lY2SMAFSnyb0cE6gVF+FiJ4ZyFZPAth8QJG5lWM
        kqkFxbnpqcWmBcZ5qeXIUbqJEZzStLx3MG4653OIUYCDUYmH98S/ohgh1sSy4srcQ4wSHMxK
        IrxT5xbHCPGmJFZWpRblxxeV5qQWH2I0BQbBRGYp0eR8YLrNK4k3NDUyMzOwNDA1tjAzVBLn
        nSs7N1pIID2xJDU7NbUgtQimj4mDU6qBUUXMRuRz8yJr/rRHPx82Ln7Sd3tHj3jwgzO7Gz1C
        Ug0PN2pWqfZN3Z+x7tHdo9+5p6l4/T7eUDDh8Yz80FSrpNNuZwz1tNwfiz5jkRF2+WaqvGCz
        zf6nXV+//DtXcZRHKTuvnvNIis7H1m/b7X6tV7swU8Skp0y79ddcpoZeo/ArHMcCbx9RUmIp
        zkg01GIuKk4EAHRbotV/AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190225082813epcms5p8052825469b7459d632a2a1aa6508192a
References: <CGME20190225082813epcms5p8052825469b7459d632a2a1aa6508192a@epcms5p8>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

We are looking to enable BLE Mesh in our setup.
But it seems currently only PB-ADV based mesh node role is supported by blu=
etooth-meshd,while meshctl only supports PB-GATT based mesh provisioner.
Could you please let us know, by when mesh provisioner role support will be=
 available in bluetooth-meshd.
Also please guide me on, =22how to provision bluetooth-meshd based node=22 =
currently.

- Regards,
Atul Kumar Rai
=C2=A0
