Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EB375F88
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533138; cv=fail; b=h/wAVUjvMjmClu4nFQz5b/YYngKSiKrh6JJNZeFgekvSbxteQpG1RKaddn+b8BxQ3dKRLrnj9hxq4TUPsWFzSo5MumApVLW844WYTvh5hPpMuvhvk+XpYFRyC/nmMOQ2CLubJyjjeI2LI3ekKh9CfwN8lgzDAN23ynfcg3iGmD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533138; c=relaxed/simple;
	bh=xTeT4Sr0wy7sEOyx7fCp1wGzk27CpM0TFpUdwKoazI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEDWehbiU7L45pE/9iCNjkOtudUpk/Ox84GhqoZdKz6gOqfJ1H6LyRulWVkGcxDZUTpZUoG1fgbsCq0gITVbr/LxOz/+zCkePctFbBa108jBuQqz0n3wy8a9jNiXMjeMNCHGX2m4SYsWW8sHV8s915KvKXaFwFlGmY7YH2v2yrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=kLZQ1Ycz; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="kLZQ1Ycz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMZvK+iqZsf3i3nOY+DaYpifaBMzA9PSZcsfAhd1a5acBgqN45mrYwjdwHrW2WcA6moVT5ez3k+HGZrz0zyG+Iw0e4GC2CsYEfRTokY2AejDSMdbuZFFitj4l5O/VkowLwG1M9puu6nYK/O8aOeLLnAfo9a/xRT/C4U5b6X24Y3Q8eUDMDLKgjuyHvNbhcdHFNFNOpECpc6AwHJC3me4OsaxFI/74BHnWHBCSvzz/NBHlMwz56mOhfsLDTcsFeN5N8CWkqk7n2umeJpFgOvW/r4LxO/2NGEnmUeD5rLvXHHTm+xy1YsAnaS/zNjEK4/9LAE+qi3NAypgEDgEKpHspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g92EN5hTeeXuv1HDncIx/L9X76hdBcee7bXYo4u72KU=;
 b=UQXoAI9oXryiAcmeg6SJBDC8UsqBFO07ewlaPHurosqgdZsVL8tWKeqk1eUb4qWE8EDxtJfp8GJy3JIjuEuaVgX3aUst1Pc2SYtevfpzrvR/Wih8W4mSC6/ak2v62x/LEytXdFf4mtchCMgVBWEZK2rsh/9gpWU/2VfHJU2mDd56FqglPVcAWWHeUOipQMdPlrqtr+6epTPl1A4DSMNntphyTGWdEnFqqQMWrZ+QuW+HDoS6LmjmYIfLYz2a5x9v+qI7phuVu4KO1En/wEoVqr+qDUzqK4q64so1VzK2J8zKe+h+RR3RJIWSieSdMNOSxFa0Wz0PioGemLYHtHvGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=intel.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g92EN5hTeeXuv1HDncIx/L9X76hdBcee7bXYo4u72KU=;
 b=kLZQ1YczKljdTn0FXPU7MCXIkKHjRqnS27LQlr05R55vhpOErs8lKdXmYnX481nbVZ5wh3Jqao6ssp4LtvccqKoouqih6a1ghWpzZ4ZQf6CluSMGlDImxsbw+b3Aws+wf8/NrsNIUwWZeWSJX5ZVEVugaLrn4QnuV9W4HJlBs7I=
Received: from AS9PR07CA0009.eurprd07.prod.outlook.com (2603:10a6:20b:46c::9)
 by PAXPR03MB7968.eurprd03.prod.outlook.com (2603:10a6:102:21b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 10:18:50 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:46c:cafe::30) by AS9PR07CA0009.outlook.office365.com
 (2603:10a6:20b:46c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 10:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 10:18:49 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 3 Mar
 2026 11:18:48 +0100
From: Christian Eggers <ceggers@arri.de>
To: Luiz Von Dentz <luiz.von.dentz@intel.com>
CC: <linux-bluetooth@vger.kernel.org>, <frederic.danis@collabora.com>
Subject: Re: [PATCH BlueZ v2 00/15] doc/qualification: Updates for TCRL pkg101
Date: Tue, 3 Mar 2026 11:18:48 +0100
Message-ID: <2207166.9o76ZdvQCi@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <177248280755.467971.14039615652305364969.git-patchwork-notify@kernel.org>
References: <20260302134540.25540-1-ceggers@arri.de>
 <177248280755.467971.14039615652305364969.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|PAXPR03MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec475b5-8044-4f7a-9c49-08de790e42e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	Rx2qzHcAsi4Twi3InZ8DYm7gD+89lOSIAn69mvV9Yj64dixWfz4g7fJOaE2UXK3RGtdQO7Jviut3Alc2R0/PeJk96rf7p2itqZr8sYCc/XlnsgY41sPur4XnH/PaP+9Cty5ic74/FtptSP4WU8WyuXC5A+ss8CPdiT+UUbx3qgIyY9pjzQVZDuEdbT5K4QY+jZgnkfaEsBuPBX85pvxGZhsAEKqkc6WZGgA6+tx1X/oAzG6pOkcrpOTO9uhgyoTHBQ6Mb2IPHg6po+hQTgCS1/F7mPhKjdS2lQgG7RfHjo0H2rfR9UVMo2wGCCmYjawZrFfnZSOCqDKMvGIIqcdP0aEz1jTBVXPnbgp4zOAdYlD6E+d5YuNUYI7l4yg6aW834/uSqJc/odhYyoaKbcMv4lMGUS0Ej+YK9T0v1ReNVQcpxIWBQ0y3Ons6VY+cDDcafKWh7ZcFclT+7STmmr/b3a6Q8m84A34SWes06UK2fiE/2YqyzYwXEfDptPqNpj2/XN+6QT/rP/mXT9g+Niin9j2uLOhSsScFmn/qUmCcjCh9qi+hSwn2q1y0Xu1Qml2T5zyT1PVGqt9Qbanl5Rkjhms6TrgaIt/II+iSUOGzfhifMcyvL9pC6YIi0lic8PyC029SzSyUMT1c7Puj/N9e18zZDkRhwGrLWvwtLxfojZ/WD7UiBwmyha/taXKUi7RXFIL5U7eqvMa9VbnBJcy18hqp8E3rYuzYw4z0lPsdAdJBpAMTg30qRhJ4aKBftV8CQ2tKgQZV40ccwnc2cnlwnzWq1lojVBujmt5oriyiFbZeQuuhBByP3+M+PXcvBEzz/gFb2h44LfYu5iJGteLReQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FhWC6ic7Ir0AFEY2t21yhbnVBHTKovyQNttk2W4TybhhA/gHxV6JkRYIw8v81liNpQqAJBHjqdR6oKYtRSTX38vMeEwP/XBlxl3NYzF/MX5NVuVxm2+m+XcY6RTlx9/VfzcL7ixxmY7auNrGr0Zd7SVihbMcStSrCQ2RWnujl+AdNANslu35mRciunQMwcYwjLbALm6DnaaY0K6EO3xgX+oa51Y8w75cyhj+1ZPrdWvCtIfANCY2KnE3zdTLAn/CGlWnGq8BL/xDAJlHs4MbRhx7dKpjugJXgW+FGhKiui0k7V4IE+voxKdUuSHTQ+ateG+6/RZMzcbgh85mFNboHRrWJv1fF0qAFBcM509G/hstKIcvx4Nl8BbWDJl/7WGUxs+q09kS7Tx8PU1KmSARvabupRNatnOovMgHEebFCv+mz3nJWxKuyN5EKmFGOZi0
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:18:49.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec475b5-8044-4f7a-9c49-08de790e42e3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7968

Hi Luiz,

it looks like v1 of this series has been applied to master (instead of v2).

regards,
Christian

On Monday, 2 March 2026, 21:20:07 CET, patchwork-bot+bluetooth@kernel.org wrote:
> Hello:
> 
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> 
> On Mon, 2 Mar 2026 14:30:28 +0100 you wrote:
> > I am working on a qualification of Linux/BlueZ for "LE / peripheral only".
> > Due to updates on the SIG's ICS/TCMT/TCRL, some ICS options and tests
> > have been added.
> > 
> > As I am not able to perform all the tests as Frederic did, these patches
> > bring the documentation into a slightly inconsistent state (as I tested
> > with a newer TCRL/ICS/PTS version, but only updated the test docs for
> > the testcases I actually ran).
> > 
> > [...]
> 
> Here is the summary with links:
>   - [BlueZ,v2,01/15] doc/qualification: gap-pics: add footnote for TSPC_GAP_21_9 feature
>     (no matching commit)
>   - [BlueZ,v2,02/15] doc/qualification: gap-pts: fix GAP/SEC/CSIGN/* tests
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4da5d644b884
>   - [BlueZ,v2,03/15] doc/qualification: gap-pts: fix GAP/SEC/SEM/BV-24-C test
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=737b2e6b1067
>   - [BlueZ,v2,04/15] doc/qualification: sm-pics: update capabilities in table 7b
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=68b03755160d
>   - [BlueZ,v2,05/15] doc/qualification: sm-pts: fix SM/PER/PKE/BI-03-C and BV-02-C tests
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61424fa2886f
>   - [BlueZ,v2,06/15] doc/qualification: sm-pts: fix SM/PER/SCPK/BI-03-C test
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=160e9bdf20ae
>   - [BlueZ,v2,07/15] doc/qualification: sm-pts: add description for M/PER/PIS/BV-0[1-2]-C
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=682fff74cd2a
>   - [BlueZ,v2,08/15] doc/qualification: sm-pts: add description for SM/PER/KDU/BI-04-C test
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=19b050c73b60
>   - [BlueZ,v2,09/15] doc/qualification: gatt-pts: add description for GATT/SR/GAW/BI-39-C
>     (no matching commit)
>   - [BlueZ,v2,10/15] doc/qualification: gatt-pts: update description for GATT/SR/GAN/BV-01-C
>     (no matching commit)
>   - [BlueZ,v2,11/15] doc/qualification: gatt-pts: add description for GATT/SR/GAN/BV-03-C
>     (no matching commit)
>   - [BlueZ,v2,12/15] doc/qualification: gatt-pts: update description for GATT/SR/GAI/BV-01-C
>     (no matching commit)
>   - [BlueZ,v2,13/15] doc/qualification: gatt-pts: add description for GATT/SR/GAI/BV-02-C
>     (no matching commit)
>   - [BlueZ,v2,14/15] doc/qualification: l2cap-pts: remove redundant test documentation
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a2186d6926f
>   - [BlueZ,v2,15/15] doc/qualification: l2cap-pts: add descriptions for LE CFC tests
>     (no matching commit)
> 
> You are awesome, thank you!
> 




