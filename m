Return-Path: <SRS0=ihQD=NM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA43C6786F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EA020820
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 08:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JAaXfj6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EA020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeKARK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:10:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61272 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeKARK0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Nov 2018 13:10:26 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181101080825epoutp0310b546497e2f34859c37cea8ac42537b~i8aMTf9Xf3083230832epoutp03r
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Nov 2018 08:08:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181101080825epoutp0310b546497e2f34859c37cea8ac42537b~i8aMTf9Xf3083230832epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541059705;
        bh=l6/aP8C9yFE56MFEyVbwkXc9rsQOynmbUGUQtEML5mw=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=JAaXfj6BYq9EOq2oiEVAv/zgKakLDjLoeex5PJOz0rcxVs67xo+AFxJuV0cbr2ULP
         TtiBUHTZYCau4HRowLqmC8dVsXK6lL2dOb1iL9MJKFkVECMvDYuzZwLeURzAluelBc
         SswIO3W3DLvxs35B2I4zbAbh5P13YdYuI3Dxp7qc=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.194]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20181101080823epcas5p3cd24758a316ac78e694214381f3b43b9~i8aKc4Yny2506225062epcas5p39;
        Thu,  1 Nov 2018 08:08:23 +0000 (GMT)
X-AuditID: b6c32a4a-5a7ff70000000fe5-db-5bdab476f81d
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.89.04069.674BADB5; Thu,  1 Nov 2018 17:08:22 +0900 (KST)
Mime-Version: 1.0
Subject: Kernel interace for LE Set/Read PHY API's
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Anupam Roy <anupam.r@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e@epcms5p4>
Date:   Thu, 01 Nov 2018 16:54:51 +0900
X-CMS-MailID: 20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmpm7ZllvRBsfblS3urLa2mHOtj9mB
        yaNvyypGj8+b5AKYonJsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4CmKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKDI0K9IoTc4tL89L1
        kvNzrQwNDIxMgSoTcjImbvjPXHCSp+L1/zamBsaFXF2MnBwSAiYSvWsfMHUxcnEICexmlNh3
        9CxLFyMHB6+AoMTfHcIgNcICRhL/j61gBrGFBOQkFk9dywZSIiygKXFzYwpImE1AXeLXwx0s
        ILaIgLvEnv23GUFsZgFVic1dk5khVvFKzGh/ygJhS0tsX76VEcIWlbi5+i07jP3+2HyouIhE
        672zUL2CEg9+7mYEWSshICOxbyEfyMUSAs2MEgtWd7BBOBMYJdb/+gnVYC7x7tAxNhCbV8BX
        Yu+si+wgzSxABz1cWAtR4iKx4O4zFog75SW2v53DDFLCDPTW+l36ECWyElNPrWOCKOGT6P39
        hAnmlR3zYGwlia3X57NC2BISfZt3QcU9JI482QYNtUCJjmcHWSYwys9ChO0sJItnISxewMi8
        ilEytaA4Nz212LTAKC+1HDlGNzGCk5eW1w7GZed8DjEKcDAq8fBqSN2KFmJNLCuuzD3EKMHB
        rCTC+9cSKMSbklhZlVqUH19UmpNafIjRFBgCE5mlRJPzgYk1ryTe0NTIzMzA0sDU2MLMUEmc
        d67s3GghgfTEktTs1NSC1CKYPiYOTqkGRjm9uMLJ/+WWvbkt4hFn19u74WXnHpF5qXJf8w/K
        6VSYLWUS1awqT/23x+fzLLP7/d8la3J2SWd/DH7fvtulaQ/X14SbM4/cCa44k/ExaLra5zLf
        PP/OKAH1Cb96Te7qqTbsEzWec3hdySzLao5agU2vw9obtrDs5F3dUqR31NogoXbey9fblFiK
        MxINtZiLihMBxd46SHQDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e
References: <CGME20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e@epcms5p4>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
 Is there is any plan or on-going work to support kernel interface for BT 5.0 PHY based HCI commands - 'LE Set PHY', 'LE Read PHY'?
Actually, we would want to have support for the above, such that PHY parameters can be updated\indicated from user space BlueZ for any particular connection.
As I see, currently there is no kernel interface via which application can change PHY or atleast request controller to change PHY (for a particular connection)

In order to support these via kernel interface, I think following could be possible approaches.
 - via kernel's MGMT interface (I am not sure if this would be ideal approach to set PHY preferrence from user space)
 - via L2CAP socket options (Bluez user space would be able to read\Set Preference for a particular connection handle)
 - via kernel internal logic (Don't expose control to user space and handle Read/Set PHY internally inside kernel. Choose 2M always, irrespective of user's preference.
       But, i am not sure, if this would conflict with different application's requirement for a particular PHY.

Also please suggest if there is any other better way to support these?

Why we would require these support?:  Even though LE Set Default PHY can be used to indicate controller about preferrence/mix of certain PHY's, it will be applied (unless controller denies it based on Connection interval or other requirements)
for all subsequent connections and hence no per connection(application) control over PHY.

Please provide your suggestions/comments on how to go about with these! 
Thank You very much!

BR,
-Anupam Roy
