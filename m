Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA5C3F2D7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399F622B48
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 12:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f0qnsr6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgCBMy3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:54:29 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:40457 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbgCBMy3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 07:54:29 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200302125423epoutp043dfa0ed1f723205d666a778bc7a2b2e6~4fd6QEutc2993929939epoutp04t
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2020 12:54:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200302125423epoutp043dfa0ed1f723205d666a778bc7a2b2e6~4fd6QEutc2993929939epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583153663;
        bh=yc2Jy54D36WaqiistaUeieTfIgy8H5fccjt9Y75F0KA=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=f0qnsr6vO2MeA0yE+ux9EybId4780vx2xKO4wDbFyahol5TDa9BU62YjlU9vbf6Wj
         m4pp7Y4BYzuDSX9k2mtTwN9bFywWTsvUSSzGYN200qgBEGDfKPNVOM6vGihP4V07xi
         B6ZQNvNUtGtBtJ0j+q6BwlImaA+ZxCFGNSpji48I=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200302125423epcas5p3d000a22b07c08e0b5b19db948df2dc1e~4fd50FxKN2313223132epcas5p3w;
        Mon,  2 Mar 2020 12:54:23 +0000 (GMT)
X-AuditID: b6c32a4b-32dff70000014cad-5b-5e5d01ff7bb9
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.85.19629.FF10D5E5; Mon,  2 Mar 2020 21:54:23 +0900 (KST)
Mime-Version: 1.0
Subject: Regarding OOB authentication method & action for Mesh provisioner
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Semun Lee <semun.lee@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        Nitin Jhanwar <nitin.j@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
Date:   Mon, 02 Mar 2020 18:23:44 +0530
X-CMS-MailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7bCmlu5/xtg4g/PbhS2WfP/IZjHnWh+z
        xbZ17cwWxzY9ZXJg8ejbsorR4/MmuQCmKC6blNSczLLUIn27BK6MmzsmMxUcY684s2oXewPj
        JLYuRk4OCQETiZvHrrJ3MXJxCAnsZpS43/qKuYuRg4NXQFDi7w5hkBphAS+J+zf6WUBsIQE5
        icVT17KBlAgLaErc3JgCEmYTUJf49XAHWImIgLvEnv23GUFsZoFCidWL1jFDrOKVmNH+lAXC
        lpbYvnwrI4QtKnFz9Vt2GPv9sflQcRGJ1ntnoXoFJR783M0I07t1wVNmkJMlBLoZJV7vWM8E
        4UxhlPh48S0TRJW5xP/ut2AdvAK+EvOuLgKLswioSrzpXwI1yUXi+KPbLBCXyktsfzsH7Hdm
        oMfW79KHKJGVmHpqHRNECZ9E7+8nTDDP7JgHYytJbL0+nxXClpDo27wLKu4h8fXELmi4BUqs
        +NfGPoFRfhYidGchWTwLYfECRuZVjJKpBcW56anFpgXGeanlesWJucWleel6yfm5mxjBKUHL
        ewfjpnM+hxgFOBiVeHh/MMTGCbEmlhVX5h5ilOBgVhLh9eWMjhPiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOO4n1aoyQQHpiSWp2ampBahFMlomDU6qB0dNR+Y5ky6SnnrsCpj488qxQb2M770fv
        5T2Zh5p8TweLZ1gkCS9MvPg+//stoWvn7xZ+WJf74PyreANpmSfeG+YWsLBHbmz+tmLycSXp
        WQEPbyp90D93aaFIuejpJ2XX1GolHiZK+5+3XD/3LP/iPzvfHei4u2mm5Wce1hNaXwNLRJxv
        77hUHaDEUpyRaKjFXFScCAA/1h6MBQMAAA==
X-CMS-RootMailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
References: <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,
  Regarding remote node provisioning, currently, it seems 'meshd' is choosing Provisioning method & actions internally, based on remote node's capabilities.
  
  - Choosing Method :-  /* Parse OOB Options, prefer static, then out, then in */
  - Choosing Action:-  Based on high bit set in the action octet:  u16_high_bit(l_get_be16(data + 6)), in case of OUT OOB or  u16_high_bit(l_get_be16(data + 9)) in case of IN OOB

Is the above preference for choosing Authentication Method, based on some pre-defined security level? If yes, can such security levels can be made available to application for configuration?

Also, I would like to know, whether there is any plan to Request external provisioning Agent to choose Provisioning method & specific action?
The reason being, some *application* may be interested in a particular Security level & Authentication action, depending on its own I/O capabilities.
 

BR,
-Anupam Roy

BR,
-Anupam Roy
