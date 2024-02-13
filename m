Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F823754
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820934; cv=fail; b=UyxFsRQ2y2jVkZ8tyT4Io53C+jS3EX7XsQIvwz1UQ52SmAN//CuwSWOsp61KSN6F41qmNKcV21dv8W+j8+Cs8ilk1SgUwpaXU5i6zOGjD3qGZxnNfhhNn3kKneLtx9m1XCq74BnT2mkJoRgqMhqoDCKZhHapBE12xe/e21ORz3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820934; c=relaxed/simple;
	bh=K5Zj3lutr8JAHfVqEgaish9FcxhT2eyc0W3DyjGawy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbOsPCMtrGMi0bZJlctWFxD+/FZ6uDT/VxI0aaL6zH+lQaY3BoTjjdOadGWpU9P3WjYKIOsOnkQ1YiGeuNoe/uJiEwsHGJXX16mtUcFYymT0xUbhrTIthTEojuAKLhgHv8TLBfA141OHzKKgo1KLBDBvHzLqbcMBUunlFLXILvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GjIWhyLF; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GjIWhyLF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nvsiyvn/5FG27gyTiaxnLsQYStbbwq1ImVzmCxUhPNPSd8I8lEZp/lyJzR//pVXvPDFw0fLjitF+zZA3uoxMqtm+/ZQnmN1SqvKuO0Ypu3F8oK9MeGvWoKsqO+ppS1t9l1uau5c53H4tys0/d1xs4aeJx+OW199kqL8ZpJ4lUtMTRqcf2tpqvznOagzNLdgehmzhBJYhhY7DV2TPjxvjKISKQX8JyXsiTu1tZwZS3t6/HitwVAXHKYUxBkbj5PaqHliJlbWU5smicWUv1NKlqrmzqrNVilBA4bzt5zhQ8temOBuD0PFp9RN6N3gRXRI1zgkaax7TOk5S0ALEMbk3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGAwibqTzHOQSu8Uo/7W2607UffUCI2q8d9EvEHUX1k=;
 b=c5vYXy/D1Q1UDhpTugwB5He0EnypB8xPu8qZE9GOMbXzN1uPtIZkElkxxckL31dkNsGa3t+0hzh3GN9iOF98QrYsrvRwQcTvj3bWFzEW7jbSjCAjz72B5LWESMGWqnMMyAeU059Flg8U9u5a6VIlWIgNVFs5QikXtwgPx/tAzWnsf9xpk14e+0E7nSjkVeJdnIHHH2FfOz+arrUoqime3sNyUzIOH9Dn+yY390wzMAYlqfhH/yQkOBjNAWFyuIIKKdlF13hY+lIgvRNCM7VSf7k1LoVXJg8305cB/ubj7LrIppXUDj6IcOvoZfwVeul6HP7/JL+LMZFjrxiJnC8yJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGAwibqTzHOQSu8Uo/7W2607UffUCI2q8d9EvEHUX1k=;
 b=GjIWhyLFx3g/9PzZ+VrhmJN8oyP0cP9PVyT3m9191RAHsFbiAaMAgx/LGgyVD5G9HdxwQhjXxngwueutvT9PjJpGQvjSRyGKz4wPDnDD3UEA6ly6l3mFLN0xzs+TNrMcWl75qJxksSLNwUOBw9SPD8cPuIChHWwDvmQ0hibff6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8941.eurprd04.prod.outlook.com (2603:10a6:102:20c::12)
 by VE1PR04MB7344.eurprd04.prod.outlook.com (2603:10a6:800:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 10:42:08 +0000
Received: from PAXPR04MB8941.eurprd04.prod.outlook.com
 ([fe80::5a22:2321:79a2:9856]) by PAXPR04MB8941.eurprd04.prod.outlook.com
 ([fe80::5a22:2321:79a2:9856%3]) with mapi id 15.20.7270.024; Tue, 13 Feb 2024
 10:42:08 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ v2 5/6] bap: Do PA Sync for each BAP Broadcast source discovered
Date: Tue, 13 Feb 2024 12:42:05 +0200
Message-Id: <20240213104205.16361-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CABBYNZKv6pwOdVG0i0pZ09cin7B2Nn8TwndZt_yozMa84UEgXQ@mail.gmail.com>
References: <CABBYNZKv6pwOdVG0i0pZ09cin7B2Nn8TwndZt_yozMa84UEgXQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0142.eurprd04.prod.outlook.com
 (2603:10a6:208:55::47) To PAXPR04MB8941.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8941:EE_|VE1PR04MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: b53cb62a-c267-4647-8656-08dc2c806cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UdHUgXinc1hzBY5N6F1H/cR6ClZG6pgy320strhGQ468eGvENRG8w9LYoush9rFYLfzQgu2v9ko7AynVygQnYVzzEdRD67dlrcLeuRgsbBv9NCo/Z02w6qkG2+qir0j/1GeFJkSDkfCwNxgfQuHtwHfJo6Gd6KugMqPJgdJwiIKqYtlLsbTsSmbAGpe335Ldjk9H6KGm9lZhNcngGeHt8tuARrmegYE79h423KbeD9RoVo0lXA5mx5Cb3JWsfamrLBzpdWuHG7GkrBTqameGGxBnSNiffNGbybfBsn0BDuPJZAvfrh2spt2qjGdxmGKhLYOQtOU8HcmRJyv7c1WAj+RciSWkrxk4IajlavInoIrvG6a4s+nDxjbeTuZ7PEE0tZFGbV5AizGR388fNG21CWpUzEpZhuwW9ZfrjvO4s9CFOj5GcjhO7fABiB3K+iaVT99p9DXbmXFnr0GG/l42cqXdxikf77AlvU9JVyaZQjd2qGulQWJLC2cLb1c2ph05CAapqO93MiLxULKoeG962PPQ9WT90QNXtQB+sV36Z7omGyBleuoJcXQ2Nyk3z/M0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(6512007)(6486002)(6506007)(36756003)(44832011)(2906002)(30864003)(5660300002)(86362001)(66946007)(66556008)(38100700002)(478600001)(53546011)(26005)(316002)(6666004)(83380400001)(66476007)(4326008)(1076003)(8676002)(8936002)(6916009)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JdirIXLkCeCps6HfjT8IuKcPSEXH6Gn61azQNbPoCO1lrlEMk0hjtt9J8I/c?=
 =?us-ascii?Q?rFQZ2p9jtFKbt6WUD8hsqEkFItyhIhat0FrkqTmCpI4uCpE1uPV3z5dQiJt8?=
 =?us-ascii?Q?OBPagdFk4iU3tivf0bNI21u4lHGStvihLz1EBtg9IwcrA9DgAs/EKCV4284J?=
 =?us-ascii?Q?ZlPXTHEhVhlXLQEi5XWH0n+qOA1rezf+UfYen/OauUcjxsySqWFU2G7CkjhS?=
 =?us-ascii?Q?kolYPG7KMGUQylTQ4hffii86TelFBOwAydWQB0gJMNOmup4IqFKeTjc8Qxwh?=
 =?us-ascii?Q?/XHH6cCDeOJVQTciwdtKSS5YddNORLypCq5gr0ARQGrjuQwR0ATYbnMfTxeO?=
 =?us-ascii?Q?jaC65sthEJXYUbaQXyR1TJkHWo/CpHV85Kj6okg4YP+0urTtERb0pJQZXX/A?=
 =?us-ascii?Q?7oHktkrMs+AM5LIQKJgPlWVmvW94TaewwwqX5OHKqFTBU85X8iOUAn5dfaOV?=
 =?us-ascii?Q?96Ro9ay0+QFfE2/MCpolMkVLEwbcPKZGpITt1Xtx/V/X00LROHIZ/Ue5T5y6?=
 =?us-ascii?Q?wgIuzRBPc+y8rksGsYpY6tW1c8tZyWhycSB2540//KtSEa+n78z5G2517NRJ?=
 =?us-ascii?Q?AIC1+JfKx6JIdIRDc7uzSBdCL1CjHy1Myqvbkgul0K65KFQtjzmfdA1PHtc/?=
 =?us-ascii?Q?l3KWRGGEilNzscqczPHkTXvOHqCJWBI3DTVCTLsvzmCstbyIbsjkGEHfpl00?=
 =?us-ascii?Q?3t1udaPVLM1AE0rTEhf8DKvUBC87r0OFpJWagl45BPRmDS02AzBT9pHbo78n?=
 =?us-ascii?Q?aCBmX7Eafnt8cDJEj5TnKSjZ5JjoAMUT2sqN4LSJjBKXOh2GhS85nDaD00O/?=
 =?us-ascii?Q?7yzGkycgLrt+aTcIJRp231XBJuT+CDuUriFivpvI5abs5naXBelHUEqqzydX?=
 =?us-ascii?Q?8thAoao6VxjjoHVl7VAkc7FOgqCQO74UenITMxCo5A65spZ6a/y3sRtUZfeS?=
 =?us-ascii?Q?4Dd9MBZt6JRSAh8zzDf3Kl5PO0M0D/e5MhYpyFjzrgJi1v+UiE4axJzNnQ0T?=
 =?us-ascii?Q?Q5Cu3TCZCW6Le36IVxUYYpNL4IY4Ayw+c7a3L863EtaGUnLtAPuGGkwdWH95?=
 =?us-ascii?Q?QKpDfjHVs01469Fgm3bqhAgsH08/vcc1fQPredIJ99MVAYK5zhb3zWNtMKnT?=
 =?us-ascii?Q?KVqTsOjPGV5v/qhlLOfRnt11Q1jEDmKjvZFwhQQFXp6sWvb4SFZpyZWoFXg/?=
 =?us-ascii?Q?bpiwFG3dC13fPbzpmhzz7AKkjcmoXtcAzCy924QetZHpDf2cGAbFap7scVhh?=
 =?us-ascii?Q?EHZ5hnVjs4IQAsWQ7A7R0MBp7L+YjPUKXWueQ8v9SuB8U7+nqUJ9x/xkwNkT?=
 =?us-ascii?Q?RiJ/CGrixpWzrLh9TMHCIh+zb4jtLfs5GM/4n17FBVzJM9M/ur+NuT5/RIqm?=
 =?us-ascii?Q?aZggbF6mOMaPo+taXF13FQs/LVJoBaJdd7NOnOpjsGAjwUyzb52gjepC0LuE?=
 =?us-ascii?Q?a5Jw1O+/HU9eO+vh7/1XphFu3mnzc7yqUiYkjYM7Uf5VIvir1z8eR1EyHU/P?=
 =?us-ascii?Q?baiNAr8rT3h97thlcLxfWJva18wxdvRhBiu8F/nQ3IhQzKdKVlSu4As60A+P?=
 =?us-ascii?Q?skullC/p3a5dq6yYTNSw4QqqnaDT55L0UnkARCqoNnkHPut4Sv09XMG2OVEy?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53cb62a-c267-4647-8656-08dc2c806cfc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:42:07.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNsjZeCVzO5O7E5SEo1HzdGAwOOF+aUI3HTouCrxQz18UGyvziL/Z7KN6I9VuPFRmkhX7U8iriUMI/dz4AtlF0swV39A1pA7VdqPhhTeKJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7344

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, February 13, 2024 12:08 AM
> To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ v2 5/6] bap: Do PA Sync for each BAP
> Broadcast source discovered
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
> 
> 
> Hi Andrei,
> 
> On Fri, Feb 9, 2024 at 11:46 AM Andrei Istodorescu
> <andrei.istodorescu@nxp.com> wrote:
> >
> > After discovering a BAP Broadcast Source do a short PA sync first to
> > learn the BASE. After discovering the BASE check how many BISes are
> > matching the sink capabilities and create endpoints for them. Allow
> > user to configure one endpoint using "SetConfiguration" causing BIG
> > synchronization to the corresponding BIS; also this results in
> > creating a stream and the corresponding transport.
> > ---
> >  profiles/audio/bap.c | 308
> > +++++++++++++------------------------------
> >  1 file changed, 95 insertions(+), 213 deletions(-)
> >
> > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c index
> > 88c93127bea0..61fb124b62c2 100644
> > --- a/profiles/audio/bap.c
> > +++ b/profiles/audio/bap.c
> > @@ -422,113 +422,6 @@ static int parse_array(DBusMessageIter *iter,
> struct iovec *iov)
> >         return 0;
> >  }
> >
> > -static bool parse_base(void *data, size_t len, util_debug_func_t func,
> > -               uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
> > -               struct bt_bap_codec *codec, struct iovec **caps,
> > -               struct iovec **meta)
> > -{
> > -       struct iovec iov = {
> > -               .iov_base = data,
> > -               .iov_len = len,
> > -       };
> > -
> > -       uint8_t capsLen, metaLen;
> > -       struct iovec cc;
> > -       struct iovec metadata;
> > -
> > -       if (presDelay) {
> > -               if (!util_iov_pull_le24(&iov, presDelay))
> > -                       return false;
> > -               util_debug(func, NULL, "PresentationDelay %d", *presDelay);
> > -       }
> > -
> > -       if (numSubgroups) {
> > -               if (!util_iov_pull_u8(&iov, numSubgroups))
> > -                       return false;
> > -               util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
> > -       }
> > -
> > -       if (numBis) {
> > -               if (!util_iov_pull_u8(&iov, numBis))
> > -                       return false;
> > -               util_debug(func, NULL, "NumBis %d", *numBis);
> > -       }
> > -
> > -       if (codec) {
> > -               codec = util_iov_pull_mem(&iov, sizeof(*codec));
> > -               if (!codec)
> > -                       return false;
> > -               util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
> > -                               "Codec", codec->id, codec->cid, codec->vid);
> > -       }
> > -
> > -       if (!util_iov_pull_u8(&iov, &capsLen))
> > -               return false;
> > -       util_debug(func, NULL, "CC Len %d", capsLen);
> > -
> > -       if (!capsLen)
> > -               return false;
> > -
> > -       cc.iov_len = capsLen;
> > -       cc.iov_base = util_iov_pull_mem(&iov, capsLen);
> > -       if (!cc.iov_base)
> > -               return false;
> > -
> > -       if (caps) {
> > -               if (*caps)
> > -                       util_iov_free(*caps, 1);
> > -
> > -               *caps = util_iov_dup(&cc, 1);
> > -       }
> > -
> > -       for (int i = 0; capsLen > 1; i++) {
> > -               struct bt_ltv *ltv = util_iov_pull_mem(&cc, sizeof(*ltv));
> > -               uint8_t *caps;
> > -
> > -               if (!ltv) {
> > -                       util_debug(func, NULL, "Unable to parse %s",
> > -                                                               "Capabilities");
> > -                       return false;
> > -               }
> > -
> > -               util_debug(func, NULL, "%s #%u: len %u type %u",
> > -                                       "CC", i, ltv->len, ltv->type);
> > -
> > -               caps = util_iov_pull_mem(&cc, ltv->len - 1);
> > -               if (!caps) {
> > -                       util_debug(func, NULL, "Unable to parse %s",
> > -                                                               "CC");
> > -                       return false;
> > -               }
> > -               util_hexdump(' ', caps, ltv->len - 1, func, NULL);
> > -
> > -               capsLen -= (ltv->len + 1);
> > -       }
> > -
> > -       if (!util_iov_pull_u8(&iov, &metaLen))
> > -               return false;
> > -       util_debug(func, NULL, "Metadata Len %d", metaLen);
> > -
> > -       if (!metaLen)
> > -               return false;
> > -
> > -       metadata.iov_len = metaLen;
> > -       metadata.iov_base = util_iov_pull_mem(&iov, metaLen);
> > -       if (!metadata.iov_base)
> > -               return false;
> > -
> > -       if (meta) {
> > -               if (*meta)
> > -                       util_iov_free(*meta, 1);
> > -
> > -               *meta = util_iov_dup(&metadata, 1);
> > -       }
> > -
> > -       util_hexdump(' ', metadata.iov_base, metaLen, func, NULL);
> > -
> > -       return true;
> > -}
> > -
> >  static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
> >                                 struct bt_bap_io_qos *qos)  { @@
> > -948,12 +841,36 @@ static DBusMessage
> > *set_configuration(DBusConnection *conn, DBusMessage *msg,
> >
> >         setup = setup_new(ep);
> >
> > +       /* For BAP Broadcast Sink QOS comes from the kernel and it should be
> set
> > +        * in the setup before taking user's new values.
> > +        */
> > +       if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
> > +               GError *gerr = NULL;
> > +               struct bt_iso_qos qos;
> > +
> > +               bt_io_get(ep->data->listen_io, &gerr,
> > +                               BT_IO_OPT_QOS, &qos,
> > +                               BT_IO_OPT_INVALID);
> > +               bt_bap_bcast_qos_iso_to_bap(&setup->qos, &qos);
> > +       }
> > +
> >         if (setup_parse_configuration(setup, &props) < 0) {
> >                 DBG("Unable to parse configuration");
> >                 setup_free(setup);
> >                 return btd_error_invalid_args(msg);
> >         }
> >
> > +       /* For BAP Broadcast Sink, the capabilities and metadata are coming
> > +        * from the source's BIS, which are present in the remote PAC
> > +        */
> > +       if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
> > +               util_iov_free(setup->caps, 1);
> > +               setup->caps = util_iov_dup(bt_bap_pac_get_data(ep->rpac), 1);
> > +               util_iov_free(setup->metadata, 1);
> > +               setup->metadata = util_iov_dup(
> > +                               bt_bap_pac_get_metadata(ep->rpac), 1);
> > +       }
> > +
> >         setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep-
> >rpac,
> >                                                 &setup->qos,
> > setup->caps);
> >
> > @@ -977,95 +894,27 @@ static DBusMessage
> *set_configuration(DBusConnection *conn, DBusMessage *msg,
> >                 break;
> >         case BT_BAP_STREAM_TYPE_BCAST:
> >                 /* No message sent over the air for broadcast */
> > -               if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
> > -                       setup->msg = dbus_message_ref(msg);
> > -               else {
> > +               if (bt_bap_pac_get_type(ep->lpac) ==
> > + BT_BAP_BCAST_SOURCE)
> >                         setup->base = bt_bap_stream_get_base(setup->stream);
> > -                       setup->id = 0;
> >                 }
> > +               setup->id = 0;
> >
> >                 if (ep->data->service)
> >                         service_set_connecting(ep->data->service);
> >
> >                 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> > -       }
> >
> >         return NULL;
> >  }
> >
> > -static void update_bcast_qos(struct bt_iso_qos *qos,
> > -                       struct bt_bap_qos *bap_qos)
> > -{
> > -       bap_qos->bcast.big = qos->bcast.big;
> > -       bap_qos->bcast.bis = qos->bcast.bis;
> > -       bap_qos->bcast.sync_factor = qos->bcast.sync_factor;
> > -       bap_qos->bcast.packing = qos->bcast.packing;
> > -       bap_qos->bcast.framing = qos->bcast.framing;
> > -       bap_qos->bcast.encryption = qos->bcast.encryption;
> > -       bap_qos->bcast.options = qos->bcast.options;
> > -       bap_qos->bcast.skip = qos->bcast.skip;
> > -       bap_qos->bcast.sync_timeout = qos->bcast.sync_timeout;
> > -       bap_qos->bcast.sync_cte_type = qos->bcast.sync_cte_type;
> > -       bap_qos->bcast.mse = qos->bcast.mse;
> > -       bap_qos->bcast.timeout = qos->bcast.timeout;
> > -       bap_qos->bcast.io_qos.interval = qos->bcast.in.interval;
> > -       bap_qos->bcast.io_qos.latency = qos->bcast.in.latency;
> > -       bap_qos->bcast.io_qos.phy = qos->bcast.in.phy;
> > -       bap_qos->bcast.io_qos.sdu = qos->bcast.in.sdu;
> > -       bap_qos->bcast.io_qos.rtn = qos->bcast.in.rtn;
> > -       if (!bap_qos->bcast.bcode)
> > -               bap_qos->bcast.bcode = new0(struct iovec, 1);
> > -       util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
> > -                                               sizeof(qos->bcast.bcode));
> > -}
> > -
> >  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void
> > *user_data)  {
> >         struct bap_setup *setup = user_data;
> > -       struct bap_ep *ep = setup->ep;
> > -       struct bap_data *data = ep->data;
> > -       struct bt_iso_qos qos;
> > -       struct bt_iso_base base;
> > -       char address[18];
> >         int fd;
> > -       struct iovec *base_io;
> > -       uint32_t presDelay;
> > -       uint8_t numSubgroups;
> > -       uint8_t numBis;
> > -       struct bt_bap_codec codec;
> >
> > -       bt_io_get(io, &err,
> > -                       BT_IO_OPT_DEST, address,
> > -                       BT_IO_OPT_QOS, &qos,
> > -                       BT_IO_OPT_BASE, &base,
> > -                       BT_IO_OPT_INVALID);
> > -       if (err) {
> > -               error("%s", err->message);
> > -               g_error_free(err);
> > -               goto drop;
> > -       }
> > -
> > -       g_io_channel_ref(io);
> > -       btd_service_connecting_complete(data->service, 0);
> > -       DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
> > -                                       address, qos.bcast.big, qos.bcast.bis);
> > -
> > -       update_bcast_qos(&qos, &setup->qos);
> > -
> > -       base_io = new0(struct iovec, 1);
> > -       util_iov_memcpy(base_io, base.base, base.base_len);
> > -
> > -       parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
> > -                       &presDelay, &numSubgroups, &numBis,
> > -                       &codec, &setup->caps, &setup->metadata);
> > -
> > -       /* Update pac with BASE information */
> > -       bt_bap_update_bcast_source(ep->rpac, &codec, setup->caps,
> > -                                       setup->metadata);
> > -       setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
> > -                                       setup->caps, NULL, NULL);
> > -
> > -       bt_bap_stream_set_user_data(setup->stream, ep->path);
> > +       /* listen channel is not needed anymore */
> > +       g_io_channel_unref(setup->io);
> > +       setup->io = NULL;
> >
> >         fd = g_io_channel_unix_get_fd(io);
> >
> > @@ -1074,26 +923,43 @@ static void iso_bcast_confirm_cb(GIOChannel
> *io, GError *err, void *user_data)
> >                 g_io_channel_set_close_on_unref(io, FALSE);
> >                 return;
> >         }
> > -
> > -
> > -       return;
> > -
> > -drop:
> > -       g_io_channel_shutdown(io, TRUE, NULL);
> > -
> >  }
> >
> >  static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
> > {
> >         GError *err = NULL;
> > +       struct bap_data *data = user_data;
> > +       struct bt_iso_base base;
> > +       struct bt_bap_base base_s;
> > +       struct bt_iso_qos qos;
> >
> > -       if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
> > -                               user_data, NULL, &err, BT_IO_OPT_INVALID)) {
> > -               error("bt_io_bcast_accept: %s", err->message);
> > +       btd_service_connecting_complete(data->service, 0);
> 
> We shall only mark it as connected when a stream is set up, before that the
> device shall be considered temporary so we only keep the devices the user is
> interested in.

Agree, I will fix it.

> 
> > +       bt_io_get(io, &err,
> > +                       BT_IO_OPT_BASE, &base,
> > +                       BT_IO_OPT_QOS, &qos,
> > +                       BT_IO_OPT_INVALID);
> > +       if (err) {
> > +               error("%s", err->message);
> >                 g_error_free(err);
> >                 g_io_channel_shutdown(io, TRUE, NULL);
> > +               return;
> >         }
> >
> > +       /* The PA Sync channel becomes the new listen_io.
> > +        * It will be later used to listen for a BIS io.
> > +        */
> > +       g_io_channel_unref(data->listen_io);
> > +       data->listen_io = io;
> > +       g_io_channel_ref(io);
> > +
> > +       /* Analyze received BASE data and create remote media endpoints for
> each
> > +        * matching BIS
> > +        */
> > +       base_s.subgroups = queue_new();
> > +       bt_bap_parse_base(data->bap, base.base, base.base_len,
> bap_debug,
> > +                       &base_s);
> > +       queue_foreach(base_s.subgroups, bt_bap_parse_bis, NULL);
> >  }
> >
> >  static bool match_data_bap_data(const void *data, const void
> > *match_data) @@ -1934,12 +1800,11 @@ static void setup_listen_io(struct
> bap_data *data, struct bt_bap_stream *stream,
> >         data->listen_io = io;
> >  }
> >
> > -static void setup_listen_io_broadcast(struct bap_data *data,
> > +static void setup_accept_io_broadcast(struct bap_data *data,
> >                                         struct bap_setup *setup,
> >                                         struct bt_bap_stream *stream,
> >                                         struct bt_iso_qos *qos)  {
> > -       GIOChannel *io;
> >         GError *err = NULL;
> >         struct sockaddr_iso_bc iso_bc_addr;
> >
> > @@ -1951,29 +1816,26 @@ static void setup_listen_io_broadcast(struct
> > bap_data *data,
> >
> >         DBG("stream %p", stream);
> >
> > -       /* If IO already set skip creating it again */
> > -       if (bt_bap_stream_get_io(stream) || data->listen_io)
> > -               return;
> > +       /* Send back to the kernel the updated QOS */
> > +       if (!bt_io_set(data->listen_io, &err,
> > +                       BT_IO_OPT_QOS, qos,
> > +                       BT_IO_OPT_INVALID)) {
> > +               error("bt_io_set: %s", err->message);
> > +               g_error_free(err);
> > +       }
> >
> > -       io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, setup, NULL, &err,
> > -                       BT_IO_OPT_SOURCE_BDADDR,
> > -                       btd_adapter_get_address(data->adapter),
> > -                       BT_IO_OPT_DEST_BDADDR,
> > -                       device_get_address(data->device),
> > -                       BT_IO_OPT_DEST_TYPE,
> > -                       btd_device_get_bdaddr_type(data->device),
> > -                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> > -                       BT_IO_OPT_QOS, &qos->bcast,
> > -                       BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
> > -                       BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
> > -                       BT_IO_OPT_INVALID);
> > -       if (!io) {
> > -               error("%s", err->message);
> > +       if (!bt_io_bcast_accept(data->listen_io,
> > +                       iso_bcast_confirm_cb,
> > +                       setup, NULL, &err,
> > +                       BT_IO_OPT_ISO_BC_NUM_BIS,
> > +                       iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
> > +                       iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
> > +               error("bt_io_bcast_accept: %s", err->message);
> >                 g_error_free(err);
> >         }
> > -       setup->io = io;
> > -       data->listen_io = io;
> >
> > +       setup->io = data->listen_io;
> > +       data->listen_io = NULL;
> >  }
> >  static void setup_create_ucast_io(struct bap_data *data,
> >                                         struct bap_setup *setup, @@
> > -2037,7 +1899,7 @@ done:
> >         if (bt_bap_pac_get_type(setup->ep->lpac) ==
> BT_BAP_BCAST_SOURCE)
> >                 setup_connect_io_broadcast(data, setup, stream, &iso_qos);
> >         else
> > -               setup_listen_io_broadcast(data, setup, stream, &iso_qos);
> > +               setup_accept_io_broadcast(data, setup, stream,
> > + &iso_qos);
> >  }
> >
> >  static void setup_create_io(struct bap_data *data, struct bap_setup
> > *setup, @@ -2422,6 +2284,7 @@ static int bap_bcast_probe(struct
> btd_service *service)
> >         struct btd_gatt_database *database =
> btd_adapter_get_database(adapter);
> >         struct bap_data *data = btd_service_get_user_data(service);
> >         char addr[18];
> > +       GError *err = NULL;
> >
> >         ba2str(device_get_address(device), addr);
> >
> > @@ -2465,7 +2328,26 @@ static int bap_bcast_probe(struct btd_service
> > *service)
> >
> >         bt_bap_set_user_data(data->bap, service);
> >
> > -       bt_bap_new_bcast_source(data->bap, device_get_path(device));
> > +       /* TODO: Check that there is no other PA Sync in progress already.
> > +        * If there is another PA Sync controller procedure in progress this
> > +        * one will fail.
> > +        */
> > +       DBG("Create PA sync with this source");
> > +       data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data,
> > +                       NULL, &err,
> > +                       BT_IO_OPT_SOURCE_BDADDR,
> > +                       btd_adapter_get_address(data->adapter),
> > +                       BT_IO_OPT_DEST_BDADDR,
> > +                       device_get_address(data->device),
> > +                       BT_IO_OPT_DEST_TYPE,
> > +                       btd_device_get_bdaddr_type(data->device),
> > +                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> > +                       BT_IO_OPT_INVALID);
> > +       if (!data->listen_io) {
> > +               error("%s", err->message);
> > +               g_error_free(err);
> > +       }
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.40.1
> 
> Doesn't seem to work:
> 
> bluetoothd[37]: profiles/audio/bap.c:bap_bcast_probe() Create PA sync
> with this source
> bluetoothd[37]: src/service.c:change_state() 0x89f540: device
> 0F:3A:2B:0B:92:1A profile bcaa state changed: unavailable -> disconnected (0)
> bluetoothd[37]: src/device.c:device_set_flags() flags 4 [CHG] Controller
> 00:AA:01:01:00:03 Discovering: yes [NEW] Device 0F:3A:2B:0B:92:1A 0F-3A-
> 2B-0B-92-1A
> hci0 type 6 discovering off
> bluetoothd[37]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x0013
> [bluetooth]# scan bluetoothd[37]: src/adapter.c:discovering_callback()
> hci0 type 6 discovering 0 method 0
> bluetoothd[37]: src/adapter.c:trigger_start_discovery()
> bluetoothd[37]: src/adapter.c:cancel_passive_scanning()
> bluetoothd[37]: src/service.c:change_state() 0x89f540: device
> 0F:3A:2B:0B:92:1A profile bcaa state changed: disconnected -> connected (0)
> hci0 0F:3A:2B:0B:92:1A type LE Random connected eir_len 0
> bluetoothd[37]: BASE len 0
> 
> > HCI Event: LE Meta Event (0x3e) plen 39
> #1128 [hci3] 16:51:03.376695
>       LE Periodic Advertising Report (0x0f)
>         Sync handle: 1
>         TX power: 127 dbm (0x7f)
>         RSSI: not available (0x7f)
>         CTE Type: No Constant Tone Extension (0xff)
>         Data status: Incomplete, more data to come
>         Data length: 0x1f
>         25 16 51 18 e0 99 89 01 01 06 00 00 00 00 10 02  %.Q.............
>         01 03 02 02 01 03 04 28 00 05 03 03 00 00 00     .......(.......
> > HCI Event: LE Meta Event (0x3e) plen 15
> #1129 [hci3] 16:51:03.376698
>       LE Periodic Advertising Report (0x0f)
>         Sync handle: 1
>         TX power: 127 dbm (0x7f)
>         RSSI: not available (0x7f)
>         CTE Type: No Constant Tone Extension (0xff)
>         Data status: Complete
>         Data length: 0x07
>         00 00 00 00 00 00 00                             .......
> > HCI Event: LE Meta Event (0x3e) plen 20
> #1130 [hci3] 16:51:03.376701
>       LE Broadcast Isochronous Group Info Advertising Report (0x22)
>         Sync Handle: 0x0001
>         Number BIS: 1
>         NSE: 1
>         ISO Interval: 10.00 msec (0x0008)
>         BN: 1
>         PTO: 1
>         IRC: 1
>         Maximum PDU: 40
>         SDU Interval: 10000 us (0x002710)
>         Maximum SDU: 40
>         PHY: LE 2M (0x02)
>         Framing: Unframed (0x00)
>         Encryption: 0x00
> 
> Sounds like it is a kernel problem since it seems to not be passing the BASE
> back to usespace, or perhaps it is something with BT_IO_OPT_BASE, we may
> be missing a test for BT_ISO_BASE in iso-tester so we can check that it is
> reading it properly as it seem we only do set via setsockopt but we don't
> have any instance of reading it with getsockopt.

Indeed, there is a limitation in kernel when you have the BASE split in multiple PA reports. 
Real controllers have the length set to 255 and emulator to 31.
If PA chunk exceeds this length kernel overwrites the BASE in the socket with the last report chunk.
We also noticed that when the chunk received is greater than these sizes, the emulator does not handle PA data correctly.
We will submit a patch for each of these issues.

> 
> --
> Luiz Augusto von Dentz



Regards,
Andrei
