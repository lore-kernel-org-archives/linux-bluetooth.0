Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC2364
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631251; cv=fail; b=hk2iiY+rmpcNXAllEm2bZrmqMb1ATuuD0+LDgiV4+Nk0Z8QTeYDaDRVgwHufSAnP+SXTe/JhrZx40GyrHjY/ESlS99CYjiSD5ncvLDcfG9YhCMMfixQygm7uq2IKa6Y32A0L9qqdnbYn3HkN3jpHqHZIqlqcY8Ef+JLzD1XGm7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631251; c=relaxed/simple;
	bh=ZCehA0XYUW+GR8Pc2gZ9cuGMkI+a1+tqdyiC9pJ9a+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fyAWVpzH9F0CTtfbsCSV+HhQPb8v5wd1iCc8mo0s1avPQgiR5cB8Fkyy935zn7F1arJ6DHZwphplAmaHgnkKeiE4XkRpdC9FjddzyKcOQwxpDVMRmdRcGWXS4s2QlzlaYwND4+qcmVrC/i3nkT5dhsGlWz4lrXzXSD/S3WRFoQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HUWmnCLk; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HUWmnCLk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6PMHTC7UWPcY2eOLXtQTmZhHYov1CYIMr7oLEZgyna4AJGFqKP5fMGCYWGG42fi4O1W4Qmm/SMTgHroG/INJm9dy9JYsbttD+jh0oLSbW/s7jb8/vfgf8ilujNuGdm5bTC+z9hp5Rr0nq+iVjUzWw41XPZerNejPRcj77fd6mVSCoj9s7vFbWOSv4X1KIWPTvFsG8h8sp9aGJF8EnBPMUDM3v8bnHDhdiWvbdJblS/EcmigbiSShFvpLWHsKOJKljcLGvn95aKQidwt0CMTwx8LxLP1SNhezMQMMkAZxdWCjmVq+5evM+elaYYBqFmMOz8PybUKk1Blb9Vksss+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jirrB8JMdrhescmO/fkkNSCc4xLMaxkhhkJYtyQ2JfQ=;
 b=eV0Yunwtkbj39NNYQWWFALrD8prIM2MqKgt86SHqWqy952FgPpv71XO6afDqH37DF95l9voPkS6EKAjhrml3Roi6Rp/g5G+u6bsOkGkOYOEayr9nxBrMeB0uY+cjlm28GOaltaKuQLlcWETvEui/dPBYVOl1mk88jDyWbUL718KCpaIKZNY+bxYO9K9I1+IiNCWdo6XEx60HbdKC6iK5urJcaB/2suJxmGDOlLlorAKhAa+gQeID5x2KKtdayl3kEBJ8KB6mhZHL6vYcoNQy2kGAlWzlmuQb6yuE+1rtnDfYISE+DDs4bkF2/NWJHvCdvQZgC0w6l86qBbwekrojkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jirrB8JMdrhescmO/fkkNSCc4xLMaxkhhkJYtyQ2JfQ=;
 b=HUWmnCLkCmDuf0boVPEpSOLrzHE9LYvcW8PnSQdg5t7orRj0N0EPNa//lsbygdrE7fF7YNsqEUbRYhmWTr8Iz3I6ID0+5Tf9kGSN9OcWPAwiNTFvTpmLNy7kjzdba/DU0Npu5ZJgMW9fNMVOtjz78CJkg+1qwcH6yikKqYhxkug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6899.eurprd04.prod.outlook.com (2603:10a6:208:183::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 13:07:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 13:07:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: pav@iki.fi
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 2/2] iso-tester: Separate iso_defer_accept into dedicated functions
Date: Thu, 28 Mar 2024 15:07:21 +0200
Message-Id: <20240328130721.15739-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <0b191e2c9773ab6d559bd8d72ae36c509c02999b.camel@iki.fi>
References: <0b191e2c9773ab6d559bd8d72ae36c509c02999b.camel@iki.fi>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0138.eurprd07.prod.outlook.com
 (2603:10a6:802:16::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 98700f76-13be-4657-df76-08dc4f280337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+dz12Eq7ynGRh5S60D9kT65iICGrIKirkRo2cFkIYQEhrUtacfSv49HUEt4AeUATpNv71EEuFM4xivGjB2arb66gaSci5LpWSCXWY6TrlZOmNxw6XTjAzMqa5kaDRLtsVdxat0FPAfC0016kRUnhqTLm502TPRWvzwnrEOH7Yxv23fK1MeEHohHPxjTIeXywwFlHFgjmkrM95BB3rpRxED9pswkRifX7wdy2cj++GjoE0LlQhsRDACpmmgjjDuMgFhpBJywdbW4Yvnqpq4qeLfPkWyAggIw+Y5GgMgD53LR6X+AjgjtvcBcE3W7NitBrTjWfeKU1lTIdCiibyme4Iw6X6LNXPVyY/U2enLw+m2gJHgro18wzut1Rt3OBr2mTvidnpPQZKeb2JqPwszuIXE1CCCsA7WYRhfom+4dYNlEJG3RpX6GTKN9SIQ7yRp3niD63qgpK2xhZAbZpISngt5KS4znmDyeZ3vpgNR9tCvvvF7upMl7WCy+qAmvU35aik0UHFIY3bsYJY89wR+Jz73h9481QEhSnQbCTCvYmajDoFXcr7lAsQqdJwRFrawfCeIPTncMKPifONwD25rGWzwefWN68DlfrX6hXrAqfn+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vW+1KECyo/0qj7ft4rLodddTbG4XKEZUQd/n1rH5skxwXBlegcQsKx+pIkiv?=
 =?us-ascii?Q?vWkpw3wDyM5LOACSIgUfjC9dGhvhuMVKqgjD589zVyv4wl31Z3irGDNqLtZY?=
 =?us-ascii?Q?miBCi678uK5Gcys1kivPSgRNz7EQHygY2PxDYQWWh9AsO+LO8T3THOCG7Q6q?=
 =?us-ascii?Q?OOVSCXDTI4gZkbzoKFvMZ3id/vkbZ+h5gmHA7ehLL9nFSIkJfk/0kGXs8ZIJ?=
 =?us-ascii?Q?SZhJMAkC2TCS2ibGfGdmMCNXY+U5Ed3SQEQS5PzGHoXy8RVvTk4vwbu8a+pf?=
 =?us-ascii?Q?Cqc/4PBG5bLb/B4sQO9ZpaorVAOg8AqmWSXQfiDezoE9bt3GFrvK/1VAJ9sM?=
 =?us-ascii?Q?ur5tclwSYtTJbRdVyUljiCC0EI5rfRLVnVU0X608HdAwH0eE0JiUcuA2z9vg?=
 =?us-ascii?Q?B5g8xn0m5UBRkJt3dx+N/F4GVUuhcqd1vO7PTT0cv4gxiIsXfoYNbWqzzZLv?=
 =?us-ascii?Q?CFCBdL9eXJWpJ1U6cW+gZdSMHqkO3g68tYaeP1SPLVeTY4XvndAVSZK2yOT9?=
 =?us-ascii?Q?isbrtg54gQJW9m5jEOlBYBvZUFjhSViqUOUWEWBcnR/cD02jUuRs/7IzHQtc?=
 =?us-ascii?Q?GJKFv2d+7ROKEr6+WDQTR8xHpoOmmcQ1cjN+lq0YX2yo5wG38va03O6x9g5Q?=
 =?us-ascii?Q?DtjuVlvFLwUPbOqTO4E3vvGuuwfMSQL/6XrMRhDOqiwkS9Bnz7JPjgkVy23r?=
 =?us-ascii?Q?8lBBa3Wl2zX7i5dcPzdSANgDH7b+9E1hY6ly1QRh0ylEU2NwUx+k63sugnja?=
 =?us-ascii?Q?ZIpiEkCEgElfcLyeFt7QDTFKLafu8CStwyDFr4bYzLEzBvsFMJo26aLTT0ON?=
 =?us-ascii?Q?K0OJBKI3wfp0iGPufFRQmO1WtLuVYEVmFBAYkluvZR+9Yu0GFpIPqtI3IipO?=
 =?us-ascii?Q?C2HtPzFVE3qnVbaxfMTUbMdoO4Skj9MIDjvz2tgAVLEtB3plUTnEbOz1DfPt?=
 =?us-ascii?Q?Coby4JeBtUc95mwzy6DT74pNzkBD/PvMV4zeYSoXk/9sGTWQwyEMSEYXT2rY?=
 =?us-ascii?Q?4YcXQRbW5yGinT1uuliGL0ZpW0A5QLBvatwGFiiHKGfqYWSlIeqBDvMkunWl?=
 =?us-ascii?Q?/wpp8S40LGSOIEEDZ5mt4MN97Sukl86I5oSyYopVO+jx5A7731fFHYCA10Gi?=
 =?us-ascii?Q?yOye+Hu61oR2LzuPZRGQfQQqT4R2ZSbZ2wlfyL9p5OhFqZwD0mqmGSYRdPjI?=
 =?us-ascii?Q?l8fEEXQ2AxzWgqqVbQBpVWJIZybMuwob1eMPT0C2gvcjTIn6LCu7H9/I9aU0?=
 =?us-ascii?Q?YIcMpH+taRdgQUXMay0+vi16YCUtkCMZN1b55hWX2GEcij3MIaYMUaRVdMmn?=
 =?us-ascii?Q?Br/LLgep1V29W4uw9a4TtTZDBWOhpaKsv1tKE0twAqu2GB82fNE6JplTisdd?=
 =?us-ascii?Q?gjLhdZFYs7Rv9u/HPraDo/b4cDvWqjOLjfJ5ctL5C6Zpvq35C393imzqzsWj?=
 =?us-ascii?Q?4cf1dk7A2GPnM1LD44x1J8vz6LlU2q/1VIIOxW28zhBeiX2eT7SIXUfTNFE8?=
 =?us-ascii?Q?A0Yv0Dgo2g5CIhKU+jpn4cNTZNp3Y3p1By8TeZ6dhu4dRGGDZqXsvBz1LkyM?=
 =?us-ascii?Q?gA/ZaOfoQKgj0XosIn1EVz9JyEkLlun7x1SROj+D1oS2MMRPHeAXC1wVqsyw?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98700f76-13be-4657-df76-08dc4f280337
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 13:07:25.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E49lOv0fIAygMR619I03pLRRVL4RRAZJISSJlD1Skju7jzHSWYCSPlmFEyaeotjpB2/kQ1WPSnpG7NxrQau3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6899

Hi Luiz, Pauli

> -----Original Message-----
> From: Pauli Virtanen <pav@iki.fi>
> Sent: Wednesday, March 27, 2024 7:48 PM
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>; Iulia Tanasescu
> <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ 2/2] iso-tester: Separate iso_defer_accept into
> dedicated functions
> 
> Hi Luiz & al.,
> 
> ke, 2024-03-27 kello 12:50 -0400, Luiz Augusto von Dentz kirjoitti:
> > On Wed, Mar 27, 2024 at 12:10 PM Iulia Tanasescu
> > <iulia.tanasescu@nxp.com> wrote:
> > >
> > > This separates the iso_defer_accept function into dedicated ones for
> > > unicast/broadcast, since the flow is different for each scenario:
> > > For unicast, POLLOUT is checked on socket before calling read and
> > > adding a G_IO_OUT watch. Checking for POLLOUT is not necessary for
> > > broadcast, since currently this event is never generated on the
> > > child socket. Instead, G_IO_IN is generated after BIG sync is
> > > established and a BIS socket is ready to be accepted.
> >
> > @Pauli Virtanen Is this inline with TX Timestamping though? Or that
> > only cares for POLLERR?
> 
> AFAICS this won't interact with TX timestamping. The timestamping only
> cares about MSG_ERRQUEUE which is not touched here, and also the setup
> here seems to concern what happens before user sends payloads, so
> before there is going to be any timestamps.
> 

This is right.

To better explain, I decided to remove the POLLOUT check at broadcast
defer accept because it is unnecessary with the current kernel
implementation (POLLOUT has no part in broadcast receiver setup and
so the decision to accept it should not be done based on this condition).

I am actually working on a kernel update on the broadcast receiver side
that would make use of POLLOUT:

Currently, a broadcast listening socket with defer setup is woken up after
a BIGInfo report is received:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_event.c#n7084

If a Broadcast Source only has PA enabled but does not have an active BIG,
a Sink will be able to synchronize to the PA and receive PA reports, but
no BIGInfo reports will be generated. In this case, the userspace will
never be woken up to enumerate BASE from PA reports.

This can be fixed by allocating the PA sync hcon directly on PA sync
established event, and once the BASE has been extracted from PA reports,
the userspace can be woken up to accept the child socket and get BASE.

However, the userspace needs to be informed if BIGInfo reports are also
generated - I was thinking by generating POLLOUT on child socket. This
will not work with the current BlueZ implementation where deferred setup
is accepted only if POLLOUT is not detected on child socket.

> > Also it would be great to know what are the plans of PW with respect
> > to broadcast, I was thinking something like this:
> >
> > 1. Broadcast Source: Have some dedicated card that can be configured
> > via configuration file or a dedicated app that performs the
> > configuration which can then select what streams shall be broadcasted,
> > since broadcasting things like system audio notifications probably
> > doesn't make much sense.
> > 2. Broadcast Sink: This shall be a little bit easier since we now
> > enumerate the BASE found over the air, so it should work very closely
> > to unicast, but perhaps you may also want to start a scan session
> > while the card selection dialog is open so the user don't need to use
> > yet another app to trigger it, or perhaps this should really be done
> > at Bluetooth system settings that way PW don't show any Broadcast Sink
> > until the user selects it at Bluetooth APP, this way we don't clutter
> > PW interface with unsynchronized Broadcast Sinks. Note that in the
> > future we are going to remove the step of creating a MediaEndpoint for
> > Sinks since they are already configured over the air they shall appear
> > as MediaTransports ready to be Acquired.
> 
> I've been waiting for the BlueZ side of it to settle down a bit. (I
> note the BlueZ broadcast API is not documented, would be great if the
> .rst docs would be updated too in the patches.) It would also be great
> if there is some way to test all this locally, we've merged patches
> from Silviu for broadcast sink, but I have myself only looked that it
> should be OK in theory.
> 
> 
> For Broadcast Source:
> 
> The plan here would be to add first some support that we can create and
> destroy broadcast source MediaEndpoints on the fly, and then wire it up
> to the runtime setting system we have, so user can create and remove
> endpoints without having to restart daemons to reload configs.
> 
> Generally they would appear to user applications in similar way as
> network audio sinks, there's established way how all this goes.
> 
> The fact that it has to be via the same DBus connection as the rest is
> a bit inconvenient, but can be dealt with.
> 
> Ideally the BlueZ DBus API would be such that there could also be a
> dedicated "broadcast" application that can send streams, without
> needing to interact with the sound server, and also allowing a sound
> server to be running its own broadcast sources if any simultaneously.
> 
> 
> For Broadcast Sink:
> 
> We are going to expose whatever we see over the DBus API to the user as
> audio sources, which can be connected where they want to, and will be
> acquired when connected.
> 
> For controlling the scanning of the broadcast streams, and which
> streams are going to be synced to: It feels a bit orthogonal to the job
> of a sound server. We could in principle do it. The BT Controller would
> appear a sound card object, and it would have additional properties
> that would list the available streams, and one poke e.g. with
> Pipewire's command line tools to sync to specific streams.
> 
> This would be inventing an API to do something that might in principle
> also be DBus API in BlueZ.
> 
> I guess a question for both source and sink is whether the sound server
> should do the whole thing, or only be responsible for the routing of
> audio, with things like configuring BASE or selecting which streams to
> sync being an orthogonal DBus API (which could then be controlled by
> the sound server, or by a dedicated app which could then either
> implement its own audio transports or leave it the audio transport part
> to the sound server).
> 
> >
> > > ---
> > >  tools/iso-tester.c | 45 +++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 35 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> > > index 1864b9e9d..60afef301 100644
> > > --- a/tools/iso-tester.c
> > > +++ b/tools/iso-tester.c
> > > @@ -4,7 +4,7 @@
> > >   *  BlueZ - Bluetooth protocol stack for Linux
> > >   *
> > >   *  Copyright (C) 2022  Intel Corporation.
> > > - *  Copyright 2023 NXP
> > > + *  Copyright 2023-2024 NXP
> > >   *
> > >   */
> > >
> > > @@ -489,6 +489,8 @@ struct iso_client_data {
> > >         bool pa_bind;
> > >  };
> > >
> > > +typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io);
> > > +
> > >  static void mgmt_debug(const char *str, void *user_data)
> > >  {
> > >         const char *prefix = user_data;
> > > @@ -2582,11 +2584,10 @@ static void setup_listen(struct test_data *data,
> uint8_t num, GIOFunc func)
> > >         }
> > >  }
> > >
> > > -static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
> > > +static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io)
> > >  {
> > >         int sk;
> > >         char c;
> > > -       struct pollfd pfd;
> > >         const struct iso_client_data *isodata = data->test_data;
> > >         struct sockaddr_iso *addr = NULL;
> > >
> > > @@ -2610,6 +2611,31 @@ static bool iso_defer_accept(struct test_data
> *data, GIOChannel *io)
> > >                 free(addr);
> > >         }
> > >
> > > +       if (read(sk, &c, 1) < 0) {
> > > +               tester_warn("read: %s (%d)", strerror(errno), errno);
> > > +               return false;
> > > +       }
> > > +
> > > +       tester_print("Accept deferred setup");
> > > +
> > > +       data->io_queue = queue_new();
> > > +       if (data->io_queue)
> > > +               queue_push_tail(data->io_queue, io);
> > > +
> > > +       data->io_id[0] = g_io_add_watch(io, G_IO_IN,
> > > +                               iso_accept_cb, NULL);
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *io)
> > > +{
> > > +       int sk;
> > > +       char c;
> > > +       struct pollfd pfd;
> > > +
> > > +       sk = g_io_channel_unix_get_fd(io);
> > > +
> > >         memset(&pfd, 0, sizeof(pfd));
> > >         pfd.fd = sk;
> > >         pfd.events = POLLOUT;
> > > @@ -2632,12 +2658,8 @@ static bool iso_defer_accept(struct test_data
> *data, GIOChannel *io)
> > >         if (data->io_queue)
> > >                 queue_push_tail(data->io_queue, io);
> > >
> > > -       if (isodata->bcast)
> > > -               data->io_id[0] = g_io_add_watch(io, G_IO_IN,
> > > -                                       iso_accept_cb, NULL);
> > > -       else
> > > -               data->io_id[0] = g_io_add_watch(io, G_IO_OUT,
> > > -                                       iso_connect_cb, NULL);
> > > +       data->io_id[0] = g_io_add_watch(io, G_IO_OUT,
> > > +                               iso_connect_cb, NULL);
> > >
> > >         return true;
> > >  }
> > > @@ -2648,6 +2670,9 @@ static gboolean iso_accept_cb(GIOChannel *io,
> GIOCondition cond,
> > >         struct test_data *data = tester_get_data();
> > >         const struct iso_client_data *isodata = data->test_data;
> > >         int sk, new_sk;
> > > +       iso_defer_accept_t iso_accept = isodata->bcast ?
> > > +                                               iso_defer_accept_bcast :
> > > +                                               iso_defer_accept_ucast;
> > >
> > >         data->io_id[0] = 0;
> > >
> > > @@ -2676,7 +2701,7 @@ static gboolean iso_accept_cb(GIOChannel *io,
> GIOCondition cond,
> > >                                 return false;
> > >                 }
> > >
> > > -               if (!iso_defer_accept(data, io)) {
> > > +               if (!iso_accept(data, io)) {
> > >                         tester_warn("Unable to accept deferred setup");
> > >                         tester_test_failed();
> > >                 }
> > > --
> > > 2.39.2
> > >
> >
> >
> 
> --
> Pauli Virtanen

Regards,
Iulia
