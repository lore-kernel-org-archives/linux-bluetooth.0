Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D3FC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5C720885
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 09:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OyNeeJfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgK0JLp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Nov 2020 04:11:45 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:16904 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgK0JLo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Nov 2020 04:11:44 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201127091141epoutp049f14931387ead4500cdec97a0cf1652a~LUmior4wo2982529825epoutp04P
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2020 09:11:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201127091141epoutp049f14931387ead4500cdec97a0cf1652a~LUmior4wo2982529825epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606468301;
        bh=/jYo/SjQrZ8O8R+bunraAoL5kNrkkbCZjlUbY6DIYjo=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=OyNeeJfd8QekrvuiRRhRKvDTVMP5UNyoVQfsi4Waqkp0UoGeM91WxtHGr5GxtsCxr
         fBXQJIvTExDG1d2OjqHp+pSAqY8q1wQP58TKa/0HBFUWo+qIwIq/EvfMMy48N4E/6T
         599zu+UBdXwcmSqrY2UO1NW9zFnzoFiWOk+fNwSU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201127091140epcas5p350a550877fac3b1b162f59c95e8d686b~LUmhkGiSM2702827028epcas5p37
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2020 09:11:40 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-12-5fc0c2cc8a3c
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.2E.15682.CC2C0CF5; Fri, 27 Nov 2020 18:11:40 +0900 (KST)
Mime-Version: 1.0
Subject: Support for LE Set/Read PHY APIs
Reply-To: ayush.garg@samsung.com
Sender: Ayush Garg <ayush.garg@samsung.com>
From:   Ayush Garg <ayush.garg@samsung.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201127090950epcms5p2af83accad82795ea00e1d1535e46327f@epcms5p2>
Date:   Fri, 27 Nov 2020 14:39:50 +0530
X-CMS-MailID: 20201127090950epcms5p2af83accad82795ea00e1d1535e46327f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmpu6ZQwfiDb6sEbSYc62P2YHR4/Mm
        uQDGKC6blNSczLLUIn27BK6M5eeuMBfsZ65omjWDsYHxOVMXIyeHhICJxJwzKxlBbCGB3YwS
        izYbdTFycPAKCEr83SEMEhYW0JTYermRDaJEQWLez92sEHFtiUdvpoONYQOqef3xC5gtIuAu
        sWf/bUaI8bwSM9qfskDY0hLbl2+FiotK3Fz9lh3Gfn9sPlRcRKL13llmCFtQ4sHP3VBxKYk5
        bXtZIexmRonuCUkQdg+jRMvVWgjbXOJ/91uwel4BX4kPS7+CzWERUJU4+3E/1A0uEg96X4D9
        wiwgL7H97RxmkHeZge5fv0sfokRWYuqpdUwQJXwSvb+fMMG8smMejK0isWFVJzvMaR+PLYQ6
        2UPi468tzJCgCpRYPOkg2wRGuVmIAJ2FZPEshMULGJlXMUqmFhTnpqcWmxYY5qWW6xUn5haX
        5qXrJefnbmIEx7OW5w7Guw8+6B1iZOJgPMQowcGsJMLrLrw3Xog3JbGyKrUoP76oNCe1+BCj
        NAeLkjiv0o8zcUIC6YklqdmpqQWpRTBZJg5OqQYmloOK1lvm/lSe3qsQJL9a5dHrdH+pPP9Z
        P+f36234p3C6edHd+ZGT5Tit3xxkXR5yfvrnfu/7L3oiTVTXKwVJHit3fX/6Tuaxnc0ejzTq
        /grd8hPNMFJapblF16/tnKFZuZ3PPUmJk/HHuEsl6xPPpDs6sImWHLqUdXHxVc3ysoX8qkU6
        sbc/PzNLjZerrp/d9zV9zqLamgstPqc29L0y4z+7W+vQ54MHG8S/in0RNfi5yrb5Y12rX5K4
        oUXplZ2C0at7fix5t3of71G+OxN/RSTsXXT5T8jF74pPUpfHLYzlWr2ynPvSiV92X51P/vyU
        fsV2T+u5mXOfHnNfkStq8uLCzYu3Gr/u/SW7yDt9vRJLcUaioRZzUXEiAGC687xWAwAA
X-CMS-RootMailID: 20201127090950epcms5p2af83accad82795ea00e1d1535e46327f
References: <CGME20201127090950epcms5p2af83accad82795ea00e1d1535e46327f@epcms5p2>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
It seems that at present, there is no implementation of BT5.0 PHY based HCI commands - 'LE Set PHY' and 'LE READ PHY' to request controller to change connection specific PHY settings (2M PHY, coded PHY etc).
Could you please tell if there is any plan or ongoing work to support the same.
If not, Kindly suggest some flow on how can an application request the controller to set or read phy settings via kernel interface.

BR,
Ayush Garg
