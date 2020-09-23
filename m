Return-Path: <SRS0=ZvEB=DA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F037C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 15:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54552223E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 15:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dtw11gvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWPvQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:51:16 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14011 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPvP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Sep 2020 11:51:15 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 11:51:14 EDT
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200923154313epoutp032baef8564e332642821b2630e4387adf~3dA1Yi-Fh1017210172epoutp03Y
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2020 15:43:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200923154313epoutp032baef8564e332642821b2630e4387adf~3dA1Yi-Fh1017210172epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600875793;
        bh=o8TmnvCqFo7wT77dhVK6ICzeRgA1HKhWHsU1u3ETDE4=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=dtw11gvRUuWxA+VSN7YWNp+s9vOJGAurjFY0k6SWootNREkeY648bJSSw4x2d1FF7
         Izc0UEWx536PQvRNRxqCKtnydi/W4HVD4huHy6G27eVQAf6AGokCzv4ImVmyJFv/uU
         QFHc7FGzmBjzl8lWey/S7cO+cfj5VX/0xphoMCXA=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200923154312epcas5p28897ec0808a760890b1d78c6076ea447~3dA0TX_2T1222812228epcas5p2C;
        Wed, 23 Sep 2020 15:43:12 +0000 (GMT)
X-AuditID: b6c32a4b-2f3ff7000000255f-63-5f6b6d0fe8ee
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.CA.09567.F0D6B6F5; Thu, 24 Sep 2020 00:43:11 +0900 (KST)
Mime-Version: 1.0
Subject: Regarding 'unicast notification' by GATT server
Reply-To: anupam.r@samsung.com
Sender: Anupam Roy <anupam.r@samsung.com>
From:   Anupam Roy <anupam.r@samsung.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Nitin Jhanwar <nitin.j@samsung.com>,
        AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200923143412epcms5p2103ec8f62fc97334f46d92f36490e61f@epcms5p2>
Date:   Wed, 23 Sep 2020 20:04:12 +0530
X-CMS-MailID: 20200923143412epcms5p2103ec8f62fc97334f46d92f36490e61f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCmui5/bna8QftpC4t3XdPZLOZc62O2
        2LaundmB2aNvyypGj8+b5AKYorhsUlJzMstSi/TtErgyFsxZx1RwmL3iyNUHjA2My9m7GDk5
        JARMJA5OeM8MYgsJ7GaUWHgwrIuRg4NXQFDi7w5hkLCwgIXE/DerWSFK5CQWT13LBlIiLKAp
        cXNjCkiYTUBd4tfDHSwgtoiAu8Se/bcZQUqYBSIk7m3OhVjEKzGj/SkLhC0tsX35VkYIW1Ti
        5uq37DD2+2PzoeIiEq33zjJD2IISD37uZoTp3brgKVCcC8juZpR4vWM9E4QzhVHi48W3TBBV
        5hL/u9+CdfAK+Er863kIZrMIqEqcP7MeqsZF4uPVs2B/MQtoSyxb+JoZ4mhNifW79CFKZCWm
        nlrHBFHCJ9H7+wkTzDM75sHYShJbr89nhbAlJPo274KKe0gsOA7RKyQQKPHt1RTmCYzysxCB
        OwvJ4lkIixcwMq9ilEwtKM5NTy02LTDOSy3XK07MLS7NS9dLzs/dxAhOAlreOxgfPfigd4iR
        iYPxEKMEB7OSCO8Ntex4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxKP87ECQmkJ5akZqemFqQW
        wWSZODilGpjMvFz8pyzS6fTPSdIXcn/Z3phv2VcYu/BP0LrSTw2X9F5wKUzqEZmauXGyWv5R
        Eft5FtFud2bUz3h5b931Q0b5CsWBaqsEqv2Zso4pBc2e/CxT+LjDh5UV4fYfbuzq26pjWHgz
        f/mXwNYOyV3fb6xVny7/9sWjLQoHT01y2OW/wPdZ97zln3nSU6peP/eJrs94dX29aPM1q+8N
        6pPc9KMz/E9dM1dhcr50lu3p7WNnY3a1ynmJ/rb/tPvfwpus5w42rCyc8M3po2Nmndpp86aF
        cYdOJFd7sk1YUH22z0SD4eSjt6tzvzbM77E9oW32IpOZk/kD3yGtipmixlMWrnjaqXVxvcbU
        /I8c/Hxf9hQosRRnJBpqMRcVJwIA9b2xzXEDAAA=
X-CMS-RootMailID: 20200923143122epcms5p8e33d120d02df9dedb5b905426664b899
References: <CGME20200923143122epcms5p8e33d120d02df9dedb5b905426664b899@epcms5p2>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
=C2=A0Presently=C2=A0I=C2=A0am=C2=A0checking=C2=A0notification=C2=A0for=C2=
=A0multiple=C2=A0GATT=C2=A0clients,=C2=A0connected=C2=A0to=C2=A0my=C2=A0loc=
al=C2=A0GATT=C2=A0server=C2=A0(using=C2=A0'AcquireNotify')=0D=0AIt=C2=A0see=
ms,=C2=A0notifications=C2=A0are=C2=A0multicasted=C2=A0to=C2=A0all=C2=A0conn=
ected=C2=A0remote=C2=A0GATT=C2=A0clients,=C2=A0which=C2=A0have=C2=A0CCCD=C2=
=A0enabled=C2=A0at=C2=A0any=C2=A0given=C2=A0time=0D=0A=C2=A0=0D=0AIf=C2=A0B=
luez's=C2=A0DBUS=C2=A0client=C2=A0wants=C2=A0to=C2=A0do=C2=A0selective/unic=
ast=C2=A0notifcation,=C2=A0is=C2=A0there=C2=A0any=C2=A0way=C2=A0to=C2=A0ach=
ieve=C2=A0this=C2=A0via=C2=A0'Acquirenotify'?=0D=0AAny=C2=A0insights=C2=A0o=
n=C2=A0this=C2=A0will=C2=A0be=C2=A0really=C2=A0helpful=C2=A0for=C2=A0me,=C2=
=A0or=C2=A0please=C2=A0let=C2=A0me=C2=A0know=C2=A0if=C2=A0i=C2=A0am=C2=A0mi=
ssing=C2=A0something.=C2=A0Thank=C2=A0you=0D=0A=C2=A0=0D=0ABR,=0D=0A-Anupam=
=C2=A0Roy=0D=0A=C2=A0
