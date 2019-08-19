Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D06C3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A25A20644
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Rdur5d3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfHSNiK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:38:10 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:30610 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbfHSNiJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 09:38:09 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JDYcHZ026238
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 09:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=mW7tY1YIYGcnxGhEB6HXrcrT8vomw4phmC10tGmZY58=;
 b=Rdur5d3yvwYyDrjhKJyeBbBD9NcbvlMv3mi3Jf4R7sLyTLwx71KksZprmuWLtvEovs8Z
 sp2IZDFpcOIp5YEZ4K2YjaS2reHJHQgUj9UcEDxvqZpsl5wAg/GkEH3orgk0h9/LYsJO
 Ft1Zg1Fw85SNdaXfdfGW5/zmpZw9+grEC3PJxeIdDBGZyIEqa0XTJV/TZ044tsEGpYMe
 eComWDBL1iXTVl4r/YqbJeND+IOPclshLx1TxnkoQgm+9GyDQtSEzZUHZjA2NNdKTLaS
 MEHb3qqAlJIdK7zNybgAG0Ab5taq5ne7H7c/ieTRDutCykYaSbbmbFUAEIzDh+SEI3+S cw== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2ueanvxyfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 09:38:08 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JDbnR3118992
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 09:38:07 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2ufufk1cdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 09:38:06 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="410156939"
From:   <Mario.Limonciello@dell.com>
To:     <ckellner@redhat.com>, <linux-bluetooth@vger.kernel.org>
Subject: RE: BT advertising packets and s2idle issue
Thread-Topic: BT advertising packets and s2idle issue
Thread-Index: AQHVRhqgVGNmeV2XRUeiYVQj/t6U86bwL+ZQgBJp84A=
Date:   Mon, 19 Aug 2019 13:37:37 +0000
Message-ID: <3d106f2c49514f4db2d418d8b7ad8b3e@AUSX13MPC101.AMER.DELL.COM>
References: <87sgqoewqv.fsf@kellner.me>
 <ccb1c793a9094d3d9cac1c63b695d5e5@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <ccb1c793a9094d3d9cac1c63b695d5e5@AUSX13MPC105.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-07T20:43:15.5083913Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190155
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190155
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> -----Original Message-----
> From: Limonciello, Mario
> Sent: Wednesday, August 7, 2019 3:43 PM
> To: 'Christian Kellner'; linux-bluetooth@vger.kernel.org
> Subject: RE: BT advertising packets and s2idle issue
>=20
> > -----Original Message-----
> > From: Christian Kellner <ckellner@redhat.com>
> > Sent: Monday, July 29, 2019 9:33 AM
> > To: linux-bluetooth@vger.kernel.org
> > Cc: Limonciello, Mario
> > Subject: BT advertising packets and s2idle issue
> >
> >
> > [EXTERNAL EMAIL]
> >
> >
> > Hi all,
> >
> > I have been wondering what to do about the bug that advertising packet
> > will wake systems from s2idle when a device was previously paired with
> > the HCI_AUTO_CONN_ALWAYS flag (kernel bug #200039[1]). I was thinking o=
f
> > creating a patch for bluez that would create a "delay lock"[2] and
> > de-register any such device from the kernel before entering s2idle, but
> > I wanted to check first if that is the best approach.
> > In comment #27 it is suggested that using a "LE Privacy v1.2" feature
> > could fix the issue as well. Is there some more information about this
> > available somewhere?  II can help out with development and testing as I
> > have an affected system myself.
> >
> > Cheers,
> > CK
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D200039
> > [2] https://www.freedesktop.org/wiki/Software/systemd/inhibit/
> >
> > --
> > Dr. Christian J. Kellner
> > Desktop Hardware Enablement
> > Red Hat
>=20
> If I'm not mistaken, even unpaired LE devices can cause the wakeup.  Any =
device
> with an advertisement report will cause the wakeup.  So de-registering al=
l devices
> from kernel before entering s2idle wouldn't solve the problem.
>=20
> My opinion is there should be a dedicated kernel freeze handler that does=
 the
> following:
> 1) If LE Privacy 1.2 "in use", handle regular suspend/resume flow
> 2) If LE Privacy 1.1in use, power off the radio in freeze, power back on =
in resume.
>=20
> For now, since LE privacy 1.2 not yet enabled, this would at least help w=
ith this
> situation as reported.
>=20
> Of course this will mean BT devices can't wake the system anymore if s2i,=
 so
> maybe
> the behavior  should be put behind a module parameter or sysfs file.
>=20
> BLE devices are so prevalent though; I find it a hard time imagining anyo=
ne wants
> it
> the way it exists today.

Another approach to this may be to submit a revert to the kernel for this c=
ommit:
https://github.com/torvalds/linux/commit/a0085f2510e8976614ad8f766b209448b3=
85492f
until LE privacy support is in place.

This seems a regression to me that the system wakes up from any BLE traffic=
 after that commit.
