Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064B4BA84
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sX38sz2r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfOPMDT8z6SSoTM5+hBOhrablrIoG0S+n8kMO4DDIGIkx87cSrsnWKs7eTZptCcnL3us8qRc7+nyCdSGinQjoVIKGbPhuox0Zz5BeBlKufHUddOMKuWcbeMNQqGcXdJG7tCp3ULGYrcYkr3dFStG6v2dJhakYONYxuJxIuQ24QRIrh/f124CdjXiC9uLOhTxIF5YbyP7SHt4yDkdaXY8D+AxzDsyDfLl3vbrrA9zlCMwN0nK9XMLpm+aiAKjpmIreNiukCdCuC/JvgLQpu1IOKG6R0NvkNUYsQk5BmoXa7QL3gvgfYqC66nnSQ8+5YK+7nBzUfLWzQzzVH849OOC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoOEDv+ug4JNIFA+grF7dkph0PWujyp8X9piLnWdXoA=;
 b=ldsYJ7AQ8Mrmz+YX3xo+BRAGORpzqsrf3kfQJ4Lk44SmyDhaSbpBo7WzRQtMejK3jOs3P/+g56Hflu2egO/feeOm7Szq866zKTwq/qoxhewkR2t6GoVJAjSvn0adbT5gLH/wf2/DDpmT671GJvOFkSy3PI5Kphd0l/rEBLyosPwZ8UZFlA+zLB9AfZ5nsml5XyzirtsSrvFYQ44tBSpAUjBPK17y1qxbQGC23jeGQv27qhJTVho9Y/4E1frxPJLcnTX6Fl8hZJ4SlyF6j6lyXRVK1gITYNaSBuG+46HT9B6BX6FsRLFcSEO2INJt7v6VZiXaaOHTTrCwbyApokkI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoOEDv+ug4JNIFA+grF7dkph0PWujyp8X9piLnWdXoA=;
 b=sX38sz2ryqIQvF28kIMAJFjqQXB/6IcAnGrMH0c0DbSeOnniCCUvI/bGCuQndrRlsda/NXpe1iN+G7Gduc0HwiAZZIWywEeOLPusZUg1cZhtoMYXis2FqDT3aO3GcCJzvEMBftz8uLIb0KLVY+WIdLmU69qA3RDKGQkNv6Ms1sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6863.eurprd04.prod.outlook.com (2603:10a6:803:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 16:11:04 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:11:04 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v4 0/3] Add support for multiple BISes
Date: Wed, 10 Jan 2024 18:10:57 +0200
Message-Id: <20240110161100.106191-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::12) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc46c8c-7f83-4d1e-ce18-08dc11f6befb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ei8+P69qpAtwuiLzigOE0TxDgG/79uc7Te4VaS6m7MaNQf6bsb8yOsptpc975SQyvqry8kZmBzXOb2rPZpKNVkLHqut1chnOCkI11qWw8Qpw9NQVHsclcKp4s0PmuFsTrjcL7ie2oaCdZBNPsXSjrPByZHsS3NHKKGHlCqz40mZdOn1tKPh0exKS6KTuL5E8k2XJD9J1M7zps2mF+Rix4uYg2C1g4kwdRumCFkhunKjl7NrPdkTzlbwSAC6DMCdJmtEGGDCKyN4rYQddf9NJBVKiu72k3KS8HHIM9rCteJuDBtJex+13qV9LJLV3D5WS16Hz5R+qN4tvljNM9PHRe0et7QzkTVuzrlixtRjHTbw9bA0pJKoV0JCfVZ8VoUjHjcoYhFt+4lBTIulD/FmEh7lbGwSW2/xdy1fOfm5mnn0HtZ2bv1bPZGHE4JemRUtdCajeMuRby69cZOUWXFfoedOcDceAaNKM3834oxxRasUpnt7hc5rTRMwEM7jevP5qSTQPW71bYI6b+YD739oICsTTdP7unMR7Wgc4nzSnsyKkjSIlBqm5TnPa0gg0xZLH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(36756003)(8676002)(4326008)(83380400001)(38100700002)(2616005)(1076003)(26005)(6512007)(66556008)(6666004)(6506007)(6916009)(6486002)(66476007)(66946007)(316002)(478600001)(41300700001)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nIZb2h0459ZcZBic1rR7dwCMEBQDLhkWB0+/spUKlwlRtFzNFC6PV4mUc3l?=
 =?us-ascii?Q?W8eTdSHcJixvZvO4WbGlgUYVDEXI/KVSPCYM48ZHcFq7igmZlekYpMPSNFyQ?=
 =?us-ascii?Q?1UdiXGAXziUFTyD0wq2pYLiQSYkRuGZMSsuuJhORFGP3ZBt10JTgsvgWbHIA?=
 =?us-ascii?Q?YUPnjrWKWtPJ9dKHMf23CU3tAeqSPd4JNivKvImbgioTs8pHIaGqUpEJ5NCL?=
 =?us-ascii?Q?4gTzad2h5PZKK7D6AJdl0SCbRhElilNUDBQIWkpWMFX7BIuOc920H/AabjFd?=
 =?us-ascii?Q?j+r+o9lVY9fLAK3URAl04LyQjxpjWwyl/iBfmc/Ow4FT9oEUXYIOUiTsVXUy?=
 =?us-ascii?Q?XLJ0Qz7KmCpugIJ4KTLqABLw/4jitkzjWykr/9UBoaAxWwuZ+dMeA5EDzSYk?=
 =?us-ascii?Q?MkgxpFj012NbCfN054u1nzAaBDJfkGvRte+/zMilD37X1mObeGF45wIiIm7p?=
 =?us-ascii?Q?hJlFuzx0GFIt6J7zwAaeWc3/SGzkKUyAQk5K6TNqHi7+ILkQ2xb2/pb1zwg8?=
 =?us-ascii?Q?S7tpnqRY4Y4hsETgmmyXnuWKBK+qFXOXMFCFxYsl2yUvu2wAFMGZTQP/hVzl?=
 =?us-ascii?Q?J9GFjrOONJ0hEtQ6QegtkY8MJl+ZYiB4KwxSi0ZiF83BHX7fitllbk8la/Da?=
 =?us-ascii?Q?CElf4r5Ro1kVqU7OuPz+3ihCHy4k1tW3w/cWiFEn2jWcQkGtK53N9oyO+19B?=
 =?us-ascii?Q?lGqrG0KJvKr1Ybu+kdIRTbysFy3B6K3850XzF3+Tkc+peIlshuumkoRD96eY?=
 =?us-ascii?Q?pmD41m92ApuRPLXttdu8KoCW7ktTXhqUlKPiX4nGMG/sAs2fULfW8FccUKpL?=
 =?us-ascii?Q?+bRhpqgRJ/KhHu1xm7+C3XN8XrvB7rDOTxl54m0Nb19493XEOXS7cJ+PRHjx?=
 =?us-ascii?Q?Go+iPZExJbyquKh21zOoqo7qog5w+IYPl9f3iYuJfS/g2RPqoajD2KDRiurr?=
 =?us-ascii?Q?ucNi25NeUFSIV2FgyPptVaWPqcp5Kb1WFtc9wTNp/i+p8gfxXd1wmdYT68v0?=
 =?us-ascii?Q?w6pGTJFYWhcPf7+TaxJmKwtrpZO/eQAKW8d2+9gn0VX7ozoe+BtvN9xPiMOX?=
 =?us-ascii?Q?zsdYfeimqqxEJ7tnm8KVuufICv8Upwcdt0nlDU+cBCMXojt0I+A1eXiT4A7z?=
 =?us-ascii?Q?kn2R75WjPS3M4YWqZG4+vJ4x9omRZbZCHVGtswx0sBF+RwsRZI1sAnMFGSmc?=
 =?us-ascii?Q?yyEm5yuNNV/AvH1q3qMpbtN3MhQvvVUg1lSaI2iQvToBBiGNM00O0JmhAgLc?=
 =?us-ascii?Q?uG2+ZhApGJxscMBxVkgDZCTRzw6UYlN5UUVqYCaBJZWD0dp6PfFcoFZftlFr?=
 =?us-ascii?Q?QdCGruXL3YYtVsRqIA0nS58UbrkwS67dmGIC/ExQVuKgSaQbPYzZuvt7lu7N?=
 =?us-ascii?Q?oKB3B/2iYfyJNXNR8OHmjFKNp6kMdwEFEiaaqq0QSt0bcB2WFlOUFKdARwud?=
 =?us-ascii?Q?lIrKO3PZ0zsp0Xsoqxm9ypSAnELU7nSnaF2yx+aOnzSKyoRVhEt3jAmjfVC/?=
 =?us-ascii?Q?ZgU1rIs+uAcvwqOwg0rlwFwnBi1GzwIZMb27KTXGsLnkGn5XyNi5uEDRX1yk?=
 =?us-ascii?Q?iFT8Bq/Rc1bm0YAUZoRYSZERsGRMq2fsBDxe+PPMFlkwo8aRznOrc2/lmjHl?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc46c8c-7f83-4d1e-ce18-08dc11f6befb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:11:04.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joNKrOgLBbPGWll0Jfx7sjE+frl6KVGXSH4Zr0X6wczw30c90DuostGvQknDfWnppTQ2IMgypEiD8h4HcPcKV7bkXo5+YWq+qNRYN5pegIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6863

This patch adds support for broadcasting multiple BIes and broadcast
source BASE generation in Bluez.
To start a broadcast source:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
configure multiple BISes with endpoint.config command on each
newly created endpoint
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 24_2_1
endpoint.config /org/bluez/hci0/pac_bcast1 /local/endpoint/ep0 16_2_1
each endpoint.config command will create a new transport for that BIS

Use transport.acquired command on each created transport
to start the source
transport.acquire /org/bluez/hci0/pac_bcast0/fd0 
transport.acquire /org/bluez/hci0/pac_bcast1/fd1

Use transport.send command to send data on each BIS

To sink to a source on a broadcast sink:
endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
Use the scan command to scan for broadcast sources
When a broadcast source is found will automatically read
the BASE of the source.
For each BIS that meats the sink requirements will create an endpoint
Endpoint /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast0 
Endpoint /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast1

To sink with one BIS use the
 endpoint.config /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast0
/local/endpoint/ep0 preset

Silviu Florian Barbulescu (3):
  client/player.c: Remove hardcoded base and QoS for broadcast and use
    presets instead. Remove BIG, BIS, and context from the register
    endpoint command for Broadcast. Add Location and Metadata support
    for endpoint config for broadcast source.
  bap.c: Add support for multiple BISes. Update broadcast to support the
    new setup structure. Change broadcast code from iovec struct to byte
    array. Add adapter property for broadcast endpoint. Make broadcast
    sink to select broadcast source BISes based on pac broadcast sink
    properties.
  client/player.c:Adjust the SDU size based on the number of locations
    for broadcast BISes

 client/player.c            | 309 ++++++++----
 profiles/audio/bap.c       | 850 ++++++++++++++++++++++++--------
 profiles/audio/transport.c |  25 +-
 src/shared/bap.c           | 958 +++++++++++++++++++++++++++++++++++--
 src/shared/bap.h           |  42 +-
 5 files changed, 1847 insertions(+), 337 deletions(-)


base-commit: c85546cba715afee020e61bd0a44499e618d0371
-- 
2.39.2

