Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6215218A
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975433; cv=fail; b=WqRwTVSQSV9lmpMGjtB8412F+FfzYrCkq2l5lJ22hPnA5mjgepc6B+cIhNP+IGL+4fDgBiHvgRKlEbts4NoSMdKHD9O0/yaz9xQFrsTWTlg1mGqgekIDw9qkytDfwF6f9MKKy2oJ380OrDZ2rZXfuyHBCyzh2yIZGGnFHD8RC7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975433; c=relaxed/simple;
	bh=WG4NDkzC4zxtIds3+c9r3caMRCEKSP7Uv63w3iTu0/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yc9TJGUC5vJ6mhjOJdvQ7Y/bnus6pJp9TcY7Z2NcFc4FsMNgzHXlLuTTXKFFoDN3YPgGiUBa2GKZkIvkBi89BmaTx/CE99s3MpwzSfRyRxZNkDD3mUfnSA46dRRMqJ5X6nmUJkRuiq9wtRL/LiFP96uIRj+50BcIM1envaAu2Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IOJslFZN; arc=fail smtp.client-ip=40.107.7.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IOJslFZN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuZ21X2FSBvCv8wEuNrxdAOZY6g8SjdyX5hyTWLBURJhoPqVHkRFHNvVgzi+W9yo9rja/3JsY9Nzg8NDAt+4VptirHF6oS5bjC+al8vg1olo3/qbHYu/d20iejCqa6R081hGg8GpeFz6zA/OleaDwOzTKHSYyRGkJaT9Zn44NOXCm6wFfnVX+tNQ7J2w7jR3UDYBUv9/P1W1MrtMeh307Xd5FtkV0s2sBWYaW3OQt+enLKlMcEdEPnuZAaTqOqfRJiJa5dLzgx6dnqIghIiiKpmuU523xxqGgw1oxLkTMVcBANPoYwQANXUsOXHYItu7l28xa1K5lvRKZ4B7u9eXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkmOwvWbFFJoIFyA3TiOAMAQBeaYS9UwrlaywyTeYMY=;
 b=cWRnZpvQYOWO4mZ+KOi5CAN7cNw9MBC2U/1LqsDTzfLhnsWgTTZVxT0rd1FWotNTCPeWafb4mDt5s7p/+Va55SDyT+Jiw/5Kp6wJNDxVlAuWMtoeA2mVO7KbSc6KVb3+PSOg6UJ8A3t8xW3++PVVkQIZw2ohSh+bSyw+HfhEFCjGMnrilvojbV5Bfp7h+m6286OM171Oh1VPVEt+I3UnGT5W/7qjUDjgGCEP/HfogIHOyFxooQ8I0gRUuNok/9aGsIPIjcWs4vKrkbIVHSisshOeIs9M8G+RA/wUYa1Zgg8bjZHjznz2D52FASBKetzCSSN02ATiTzYnt8G4uRroAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkmOwvWbFFJoIFyA3TiOAMAQBeaYS9UwrlaywyTeYMY=;
 b=IOJslFZN7r+MX5KWCYRacxshfAk1RaNwW/xews7VBO5HECAxI8pymmovAHXyfl2lISZu33dO68ikfYYQAf1IS85+WJzvDDMoHm36Qqqa6lzt1qTz3GJSWjT3ukA2Ray9DDk3hC5k71oFbULoQJOM6ATgJAaSsSXu3C4M9apws3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 13:10:28 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 13:10:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH RFC,BlueZ] doc: Add initial MediaSetup rst
Date: Fri, 21 Jun 2024 16:10:26 +0300
Message-Id: <20240621131026.5814-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZJh1Maz1ZyG7+N-Xux7c3hbx_YqEinCO_z=tMvpRxU+dA@mail.gmail.com>
References: <CABBYNZJh1Maz1ZyG7+N-Xux7c3hbx_YqEinCO_z=tMvpRxU+dA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::18) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|AS8PR04MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9378e7-0d11-4b0e-3a65-08dc91f38545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XkAwwD0B4Lpl6/mBPZtzAGVOEx2Yl1MJDgtvWdPczUA8D+Nzz2LgmDo8sezL?=
 =?us-ascii?Q?A4X9Jc/mYsEytIlimlTrB5grDnTwSvJgvbGu9D5kmMZz+NzDMcQhE5DBUnbe?=
 =?us-ascii?Q?mUfmS8NRyxhWUklWmxtgbK6A6PHoweNAggkctuhyEUokef72Ywwvm9Gtf32W?=
 =?us-ascii?Q?jQiAX6BJsQ1e8m7Rx5PHIXEFu8NGMH1Nh1j87nZZCeFCFiqXBsutiSj/wwhk?=
 =?us-ascii?Q?gmL+lPhxSQDvhDhUIV1v+qKNJswOrxB4f7w+0c79bqX9QZN4FrimULIynNcL?=
 =?us-ascii?Q?2zwOLCTXxHDkpZHuIddUVX1QtYy+buUnZvMJG1kROCQ+LjedBHIRgepGWftG?=
 =?us-ascii?Q?a/bJWcE2JI/JaHz7FqzTkahdeR2KEoID8Y7bbUWDUxzo0iBWO0QJ9wcOWS9f?=
 =?us-ascii?Q?EykDWU/BniN2YP2slwr1IKP/zBWFre9++v0WBrduKBqmF0QnqBdzQmcdYT8U?=
 =?us-ascii?Q?d08LfzNfSWrLGnsTHfjnQ4VyzqNB5/tfF/j6GqYRaYV+vTyzB1uioZ/e1etd?=
 =?us-ascii?Q?NmYlcZR7WUuWTBGYU81mmyEE9YhX5rEtGPiLgyIdbzs8rm7aXb6ACfusteNk?=
 =?us-ascii?Q?eZwcQR8AYoHPCP+W48jBEd2RVyZnP/ZSQqR7xGAIxT5phuKzBSIFvHESIQwg?=
 =?us-ascii?Q?CzOl+4HrXtRgw5pxtlmHOJ/lpQkyJfLcp6FKZ5Sj/4ha+DWRduPXo+r5axaW?=
 =?us-ascii?Q?1M6AKT3k7yqiz2M/JAxXRjN0TajInHIm/Pd4uzy4UFWET5DwB4fAOhvS2GNc?=
 =?us-ascii?Q?gm9/OObsGE5q/vHA/QtWwh6ErbQGHQ/Fpy79qEd3jYdALKny7DHT0qCikJY8?=
 =?us-ascii?Q?ClOJP0X/IlNh0UTMA1rv4OmVWWoHQmIo9Gup0PUmomOzf99LjJE0LYYTxKhj?=
 =?us-ascii?Q?ystlii5Jys7aXEzplptcEWHO8fPFe8sgsuiqAdTOQ5GRa82QYessYasv9/xA?=
 =?us-ascii?Q?aUK8vokAAhCao9xhg5Tfsd3CsHnbKdisOjN5z4j39Dp0o9YH6Kq6nCVxW9JS?=
 =?us-ascii?Q?imD3YIIWlTwgHgYo6mCtzUIIuw88RZnw+QeerFz0PcKyONJu21i+MZj1nPAc?=
 =?us-ascii?Q?iCWBOX8YYT3ZGaT7a0F6yEKq8JriggFBwTNoyCdGmdXam/vfCA5tTzGgF5ER?=
 =?us-ascii?Q?FPqUGAkBxWUaKM9dZ4apjbsX7bZ/L21KEz/Ocza4ZTZ4aGpE0Dsu7+MbntUF?=
 =?us-ascii?Q?gYqnA/sIRcoBWQoWiXM7M+lUG7idwUWqOvLgs8G/isywoWycJat5GgJ/SahK?=
 =?us-ascii?Q?6nT5aYFEzVJ7+dPdCVMP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmh7pJf2urTt+paDxsKGjF3DHSktkNscr09uWrapVr/7tkjqfz0TR+7H/UEq?=
 =?us-ascii?Q?3e6grX+crvcub1shcssfBRAmESXGEdBxHvxR+kvTVV477DXfdNObxTrt0Y2l?=
 =?us-ascii?Q?uWzRVFlkud2c3oEyIa+uAHcesv1hv7TNwX+onzpZbrKO4q3fIRipYBv6EwYy?=
 =?us-ascii?Q?BFve51wo2hoVz9F3d7QKHqz7P+mbgvhNvOxnQdJ3Ansq0t1V5F4YSzOqA0fC?=
 =?us-ascii?Q?vHrHX/dm0fylW2WtcXK3/NS+KaCQbmRQU2F5uzg+SUl9Wpoce+J3hjEktdI+?=
 =?us-ascii?Q?p1DIg6DemrJAFBer6Di7GjKbI5/CCRY5gz2DoiBL+R6t4CRWuPBsE7rZDK7S?=
 =?us-ascii?Q?Z/3HvHQrBasuZXgReAKL8Cj3L+Q6zCovO4KCqCE+tTUD2DmLX6z7ji2StDuG?=
 =?us-ascii?Q?TZnIeTkfkKnniR0rxoBbAYQewPgH+UO0qt1ZgC2Qyf+2JXiAVQ1fWnld62be?=
 =?us-ascii?Q?HQP/XxPUjzHFSHwbINxht6c+2/20q/gZBcDGngqaHLd2DFgLkH+ZuichyCUT?=
 =?us-ascii?Q?v3g7psVdJVSDULSdDhPGKYi+A6XJFeMm7kMJwHfbatAH4aUPJqwD7IcHi+b6?=
 =?us-ascii?Q?pl2RCxZC7e0iDj5aNByA8R5Y8CgQL/UReu1WeypNl5yv8lQQVPIe6QmbCxCH?=
 =?us-ascii?Q?H/Ei+Xsh2IP1LMuUoZiqumZzk7vr9vEnh9t7DtDwFDBcT4gzgXf9I9I+Ugj+?=
 =?us-ascii?Q?lj02WY2MZXExw7AegjPuK+ei6SIlUPgwK4RcxPjmW7Ey1FTQ135Q5THuGdUC?=
 =?us-ascii?Q?Q4NUGaSzqOdrukXwbqGDNsbR965SAGwkwOYvUgCRACZotSV7h5jxu1WWovK+?=
 =?us-ascii?Q?/WC2RHdPpzABGbDBLhNl5fFiFofGxnPvcmcrFpnaQ+Yx/Az46JLM4hjfhfO3?=
 =?us-ascii?Q?u9b3OjMP3Ed3Sd5vG80CJoD1FTdo4E68IJtPla0JYJrwoNGs2Gc9A/zb/M6G?=
 =?us-ascii?Q?Y93DJVEHj+A4aczhWym9tfKajoMnXsqFbJ07HC4i+W2PXbnc9CrER76f0GD4?=
 =?us-ascii?Q?0OeGZ06vDXPKDTrAwLtETe7s9g3kewLYQ19WTG866PgzDA2oRQf1oH1DN75/?=
 =?us-ascii?Q?CAe2OJVaVknD3/NJNew/GsNPSOe986b3VXkQPlI869pdZ42WR4S2hsKtiFeO?=
 =?us-ascii?Q?OJgjniA2m7LUaYpCmplGVaDmjUV/8P3lGafDJtHa4vYJiiQ87VCeyA3IX4Gd?=
 =?us-ascii?Q?sBGOoCKmBS6OiyPGbth4zH7E12NImw8hCCcefZhaUtbRS4Sarhlj27DZ40fd?=
 =?us-ascii?Q?LXNhMQtvJb600/hRaFP0gkjkmB3Caw78sxMXciT0AcZMtTIqboUerYVw98N6?=
 =?us-ascii?Q?+lOP0m2uJeppqFZYY+EKp4uXE24VU1zVpVmNEv37aKkxjyaBVgV8fs02MZGw?=
 =?us-ascii?Q?aWV2CJ0AsOyBLA4aD+kTeCgv2ansMAVFjgq8X6VRTU3ItUZ+4cLK16GNWVZf?=
 =?us-ascii?Q?v8qVLWnv2mQLS500Q5KVGicjs93UMvHo1lObyhSVQN1HiY9och4uHYhEiXct?=
 =?us-ascii?Q?6vTNQdVfXKaTemL9/CoT+f1gRennITGa094dr3e8K6VxC7Gka48IINUkW5Rc?=
 =?us-ascii?Q?eiq24rKlG4rOEwBE56bZ+boMvxTNO+FghIcDwbZNQaE1Yzfaaoeaz5AJRk+k?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9378e7-0d11-4b0e-3a65-08dc91f38545
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 13:10:27.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMN1BHkqPJOj6F7bKGeJSv7GNDY2+2m0UgQkv0pkvUDz+jeK0U3y/hReIJvmLamLCISjm5SCnvf0QB/4wqAf8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, June 19, 2024 5:53 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>; Andrei
> Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH RFC,BlueZ] doc: Add initial MediaSetup rst
> 
> Hi Iulia,
> 
> On Wed, Jun 19, 2024 at 7:35 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > This proposes a new D-Bus API to be used by the BAP Broadcast
> > Assistant role.
> >
> > The BAP Broadcast Assistant is a Master device that can have multiple
> > connections with BAP Scan Delegators. The Broadcast Assistant has the
> > UI to start scanning, enumerate Broadacast Sources, allow the user to
> > select a desired Source and send the stream information to one of the
> > peers. If the selected stream is encrypted and the peer requires a
> > Broadcast Code to decrypt the stream, the user should issue a command to
> send the code.
> >
> > A new D-Bus API is necessary to allow the BAP Broadcast Assistant
> > implementation in BlueZ to communicate with a top level UI process.
> >
> > The Broadcast Assistant in BlueZ should register a D-Bus object for
> > each scanned BIS that matches the Audio capabilities of a peer. Each
> > object should be linked with the stream and the peer device that
> > matches the stream capabilities.
> >
> > The top level process should detect these objects and display the
> > information to the user. The user can issue commands to select an
> > object or to provide the Broadcast Code for an object.
> >
> > More information on the proposed design can be found here:
> > https://gith/
> >
> ub.com%2Forgs%2Fbluez%2Fdiscussions%2F822&data=05%7C02%7Ciulia.tana
> ses
> >
> cu%40nxp.com%7Cc4b5189ccea94198202d08dc906f805b%7C686ea1d3bc2b
> 4c6fa92c
> >
> d99c5c301635%7C0%7C0%7C638544055766136877%7CUnknown%7CTWFp
> bGZsb3d8eyJW
> >
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%
> >
> 7C%7C&sdata=w8yqp2HZQqouwJTFALZVB9Z32st0a3GTKm3w1TcHg10%3D&res
> erved=0
> > ---
> >  Makefile.am                  |  6 ++---
> >  doc/org.bluez.MediaSetup.rst | 45
> > ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+), 3 deletions(-)  create mode 100644
> > doc/org.bluez.MediaSetup.rst
> >
> > diff --git a/Makefile.am b/Makefile.am index 0ae721111..217e7d2e4
> > 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -362,7 +362,7 @@ man_MANS += doc/org.bluez.Adapter.5
> > doc/org.bluez.Device.5 \  man_MANS += doc/org.bluez.Media.5
> doc/org.bluez.MediaControl.5 \
> >                 doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
> >                 doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
> > -               doc/org.bluez.MediaTransport.5
> > +               doc/org.bluez.MediaTransport.5
> > + doc/org.bluez.MediaSetup.5
> >  man_MANS += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
> >                 doc/org.bluez.GattService.5 \
> >                 doc/org.bluez.GattCharacteristic.5 \ @@ -395,7 +395,7
> > @@ manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> > manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
> >                 doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
> >                 doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
> > -               doc/org.bluez.MediaTransport.5
> > +               doc/org.bluez.MediaTransport.5
> > + doc/org.bluez.MediaSetup.5
> >  manual_pages += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
> >                 doc/org.bluez.GattService.5 \
> >                 doc/org.bluez.GattCharacteristic.5 \ @@ -475,7 +475,7
> > @@ EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
> > EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
> >                 doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
> >                 doc/org.bluez.MediaItem.rst doc/org.bluez.MediaEndpoint.rst \
> > -               doc/org.bluez.MediaTransport.rst
> > +               doc/org.bluez.MediaTransport.rst
> > + doc/org.bluez.MediaSetup.rst
> >
> >  EXTRA_DIST += doc/org.bluez.GattManager.rst doc/org.bluez.GattProfile.rst\
> >                 doc/org.bluez.GattService.rst \ diff --git
> > a/doc/org.bluez.MediaSetup.rst b/doc/org.bluez.MediaSetup.rst new file
> > mode 100644 index 000000000..7463d7cfb
> > --- /dev/null
> > +++ b/doc/org.bluez.MediaSetup.rst
> > @@ -0,0 +1,45 @@
> > +=======================
> > +org.bluez.MediaSetup
> > +=======================
> 
> Let's use MediaAssistant as name:
> https://github.c/
> om%2Forgs%2Fbluez%2Fdiscussions%2F822%23discussioncomment-
> 9818645&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7Cc4b5189ccea941
> 98202d08dc906f805b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C638544055766147461%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C
> &sdata=jHOPPf1bg8SpRg4N3AP33ozX51GGUslWid9JObkRzFw%3D&reserved=
> 0
> 
> > +
> > +-------------------------------------------
> > +BlueZ D-Bus MediaSetup API documentation
> > +-------------------------------------------
> > +
> > +:Version: BlueZ
> > +:Date: June 2024
> > +:Manual section: 5
> > +:Manual group: Linux System Administration
> > +
> > +Interface
> > +=========
> > +
> > +:Service:      org.bluez
> > +:Interface:    org.bluez.MediaSetup1
> > +:Object path:
> > +/org/bluez/{hci0,hci1,...}/src_XX_XX_XX_XX_XX_XX/dev_YY_YY_YY_YY_YY_Y
> > +Y/bisZ
> > +
> > +Methods
> > +-------
> > +
> > +void Select()
> > +````````````````````````````````````````````````````````
> 
> How about using Push as the method name here?
> 
> > +
> > +       Send stream information to the remote device.
> > +
> > +void SetBcode(array{byte} broadcast_code)
> > +`````````````````````````````````````````````````````````
> > +
> > +       Send Broadcast_Code to the remote device.
> 
> Hmm, I wonder if it wouldn't be better to just have a dictionary that you can
> pass to the Push method.

So you're suggesting instead of having a separate method for setting the
Broadcast_Code, we can provide it through the Push method if the stream
is encrypted? I think this can work, but we will need another MediaAssistant
property to indicate stream information, maybe a "QoS" property like
MediaTransport is implementing.

So when calling Push from bluetoothctl, we can read the QoS property and
if the stream is encrypted, we can display a prompt for the user to enter
the Broadcast_Code.

> 
> > +Properties
> > +----------
> > +
> > +string State [readonly]
> > +```````````````````````
> > +
> > +       Indicates the state of the setup. Possible values are:
> > +
> > +       :"idle": setup created
> > +       :"pending": setup selected
> > +       :"requesting": remote device requires Broadcast_Code
> > +       :"active": remote device started receiving stream
> 
> We might want to add a property that refers to the MediaTransport object, that
> way the application can tell what is the BIS configuration from the transport and
> we don't need to duplicate them here. The lifetime of MediaAssistant shall be
> the same as the MediaTransport object it refers to, so if the transport is
> removed/free so is its MediaAssistant object, we may want to document this
> though because the Device object could persist if they are not temporary but the
> MediaTransport objects for broadcasters are normally considered temporary as
> they are not paired/bonded.

I think most use cases do not require a Broadcast Assistant to enumerate
MediaTransports, so I don't think the objects can be linked:
https://github.com/orgs/bluez/discussions/822#discussioncomment-9839217

But even if MediaTransports and MediaAssistants would coexist on a Broadcast
Assistant, they refer to different things: MediaTransports refer to streams
that the local device is trying to receive, while MediaAssistants refer to
streams that peer Scan Delegators are trying to receive.

As I see it, the "State" of a MediaAssistant allows the user to know the
stream state on the peer: For example, if the user calls the "Push" method on
a MediaAssistant, the BASS Client in BlueZ adds the stream information on the
peer, and then the BASS Client receives a notification that the peer
successfully acquired the stream, then the MediaAssistant goes to "active"
state.
> 
> > \ No newline at end of file
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia
