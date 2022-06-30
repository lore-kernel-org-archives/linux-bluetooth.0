Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2581C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 07:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiF3Hah (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiF3Hag (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 03:30:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2025.outbound.protection.outlook.com [40.92.90.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF631C928
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 00:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZKApD9/+U63HDfwn0oadpOK2bV+wdkFCYl169A6WoXqZolgV2930/hndZE5qGV/UfZESz0KUe5wt6s3atUn7gUOcV5VUS3/bSTi4sFElz/urxv1SEwFXDQz6jsLKzN0naWQKzZ2oEai9U1SGrRL4N7SZXkijaFWIp01pFtpwkFPt6HBs5HZpznNm6BWn3um+TrPj+Kdn+InGUD6mHBVDljjrnhcVPez+J4xxYAEaifa7momNRI6LdBpvNmlP5vvnPTLQAgWWQNA+Vc0iEUw0Yzw43HJgnK7T0+JISpGtG2Jpa2Ft4fhHXxCGba6uKYLwIIeWV/mgomgl63ReT41bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9l2x6iNzwxrKvaY7rqNsjt/pw5D+s+cfYK5WHfIwNc=;
 b=PsUEBj71HZpvM0hwRgE3ZdEdNM5ld0WjFXQ2m9/7RDm7btjq8X4l6s91kix7z8hxvxh783b392QyBeg1krkmsNE09JtJ8vZ7U0x1tP0+YREDdPlVu+iUEK8xtC4PgnZFchj88J/LyTvxH7hzOcFepbq78yC9k18PTsb28RB0s4xGO6RiTiZtaRGRYBpY1SgXMyhP61ic29HlYS2rdU4AnBGxTEOQOp60ZnJJ28yRxKwE3kK0CpOOl4pF/YZIeeU8bOfnJBi79N+Vrn9ubb3dglLQuGZLR04obyJG6UOT+A6IkoO1f3BIp+QN9ALAY1QNUtEqokR8fPeEzVe/53JvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9l2x6iNzwxrKvaY7rqNsjt/pw5D+s+cfYK5WHfIwNc=;
 b=uinikouhsu5J0H8q7JQWthNx1i372c9Fta55B8ydZPjUco3nesJRrcyygnRGL+OkCDYPumbC9UmzVPCsTFHYmf3Q9r1dPxEYpOU3SjM7b4YqshEhvheLAFcYkZklKdi0j3SDIL4Ty7W5E+wWfl9o/2BwEsUwEezVIa9kfPWA0Dbf884Lk2ad465bc764pFqO4QRMtiLYp+hOOC/Gd1sgdb60BAdmYTn2FMhxe+WHeFVoO1z/Fozw4BNruTcAPimR+sZIEToNGOSOIBQv8Leov2QNUDjpiz4AVJMNbEI1TFXIx9hIpqCxN93gf9ia11QgqUYEmcSQn9ORyAKzVGkmMQ==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by VI1PR09MB4238.eurprd09.prod.outlook.com (2603:10a6:800:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 07:30:33 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::a854:d1b9:4cc2:f422]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::a854:d1b9:4cc2:f422%3]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 07:30:33 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ 1/1] mesh: Use correct net_id for received CTL messages
Date:   Thu, 30 Jun 2022 09:29:19 +0200
Message-ID: <VI1PR09MB423902850B3FAEAAC0190EE3E3BA9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220630072919.20890-1-isak.westin@hotmail.com>
References: <20220630072919.20890-1-isak.westin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4pFwMcXKPvwRfkHrSPJgwRO0kHlxpNia]
X-ClientProxiedBy: ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::20) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220630072919.20890-2-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d68a0618-4858-4cf7-310e-08da5a6a6ace
X-MS-Exchange-SLBlob-MailProps: +LiGfBxqLEthM4Yqklomr3cO6U+d/w6UAVjkhstBczaOHDHlAMUj6/KCsdOP7DYriMOd5V/TvTmrqNgr5w70Xuh5xs+XF6GL3h2T8M3FVp8n4TnSI6XvAAx5bmy39ZOW51NuHqHAQCaTaYaD2ugB7JBpg+EmmSRD8LfgkTvbDWk448gsY3cOKWmP5m3TYGDs4mmMf+ZevBX32AVOWH8qZHJ94zzqC3nHToSc265au6eW9CUi6qfxSu8mcVDYfzAlXN5K8Nn9b7JxIidtUIojdekGO+Pg1N3tE1srpv12KxYSCmw/0DF2gm9u9OA1WQUQ1pL1efaoga+DcIzbq8qYoIXDB37TCYEWS4GqWCmOgmwVLueOaYOuNtEjyNFYdhZAtOnR3OvqdcFbbm1GiO7/7+StN8kjzXDReF4SgDzLzxtpeUABQyc7GQb4aOE7w1sdWqbZHq8sXm48UQN+k7AAwCaU8XRaKUZ1wTYopotA38/QNp/zihCkr0phKM5QVKC8OcduDdFpLQjHvM/ek4JC82slwldAvPfTUfCx+dTZKF+9KK61w0q87zNcuKMWq0++g+LDlQDc8Imvo5hbsq3ANkeO3o0HuzQLFegZgtZ2hC9obtDR/B+27wEn/rrhNbnw3dyVAvN+erxUyioiKf85Juq6UbceQyowVriyj4FmXpSOm0/CVKRAQ8bshlq6EEkx8g5Gjd88qIVY2VJPTkie1ZImXojGUHNiEqthrcNXP4y1dVBpyvP1WkWe2jbgiGjR7dfL1NHAJmWYIF2TxIrbqAeZLRuK+BN/
X-MS-TrafficTypeDiagnostic: VI1PR09MB4238:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfQR6+gAJS8L2ah+k/ryamJszzkaDMOIw7zhvGftpao+cGE1Rm5as4krnuozfmjeqqJ5X/7SSU3kM5ezkQvLTv6CMkYYi8UY3I3toEViiQgQzI2MqdS2iWNYn26HQIgIxlJxOAes82Gua6N753B7fbdbpGXS/Un7lRfzw2iGDi4IdoNART/PUV48d870hWW8f2J4BPNkYFZdzIW8P/e3Nvbise5IpgFw9UBbwAVwCZYn/WwP50ZgW3Ln/r0ypBD6+O2+ybBQSvvRuAj+Y1u0TqzecBunEshG97sZUA2oPOHWQOVfPMU/PPYvYG8btRYncMkancBsLryOAwer++Fmd2UpT4Mk4X3mpNaCOtOFzus7cghWk5HUlwfM7IHQ2Y6B6d5P6TrqDQssUt+/YS4ZmCALDlLTmbh3W5p5BS6jDsrvoIUqYIYP5H5l7gZBUFmBO2zQ7btaxAJmdc6PJxB1mHy9YO6Pv3XHdDE0sSTwKvI35JQTkZHGgMAGeopb1gZJtXDM2+eKzsieBmxQENCnvvHfdOucGnirMBj0r6GU4aYi9MrBrSgbMMeLPprnQlqGpu3ZMu1qc1lIYSeBARzwV5zuFL51hxsj6Uz4El3Pk7sCuvP/ie/pebDYot0vc3xbNjgsRTMvUFwZnKhfvOuBqA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hyTh9hJyIfNLTjv9AtfmfZ0A8jtn1jx53ZB1u/jx/OXlaVnfpUP825F0X1nC?=
 =?us-ascii?Q?ei89kH081HL48rm4FWNX/Hciqdtlv9zKfdY9IQtmyF6Uxm14MWwQCaf9H0Q7?=
 =?us-ascii?Q?owaVopGAvh2nzGeKPHEppujugKfM81G6RWsAmyexLbziGMMoyROAk+cAQUcL?=
 =?us-ascii?Q?4v/pmR7eFlp2LyGc5h9qZDmdvgB/Tg0zDUimN0BcEu4hSC9Us8rGPghT2kbZ?=
 =?us-ascii?Q?lRXaQFNjFBLCQGKP2NZe7qRvQ06y/WTeeFMOn8cMU2yNrgAWpOBsYNOIC2cz?=
 =?us-ascii?Q?ZhRczK8FOLLchEoF08egYWUvMjjDHyh5kv711ccvmMH0DIprBMi6XILwffU9?=
 =?us-ascii?Q?oRGqaWMA26ezzBR38ZPMhEOVypseuDbt2xTRmtPzRDJEEu24krV1TpNNRYGV?=
 =?us-ascii?Q?18M7VTzQxStY3/+J4cHhMllsdPNMByPTc9HKtwF56P3k+gWjITvk1ENvzmar?=
 =?us-ascii?Q?4zTcBYzWhWwRu+eSMu5IsDk5T+0CpmjVv1TAQHs7iN2KaeLbp8tAw0Wr0+ux?=
 =?us-ascii?Q?n4W2CUZnhlozpQSbk6tHFl6AZ1j1Hes8VlO1BCPA3/qkh7n57NoojT5T97xR?=
 =?us-ascii?Q?Nb+aIF+n0AV0W65s+CSmsd9JOqhwnHK+kZjSnL0+QUA/CkDic3byn3JW7YBl?=
 =?us-ascii?Q?SUaBCiF81Kl2bhCvFqAdb2yxZiBn2RQX7caDWiZYKr+HBxTdz+u7W9Vv6dQL?=
 =?us-ascii?Q?fahRvWiMWoJFzyOaPppw41k52nE+DBMYD/sV6/phaXbOK8VsKbtOjeHd+ywS?=
 =?us-ascii?Q?alA+fS+hwANNdh3FNq45088Kz6lr/6KxuEukOaZi11JUzBRToDUdE313ccBF?=
 =?us-ascii?Q?4Lyog2Ps+jJUE6PLYVGges6Y9LMi39UGEvNmUBz3JjAyk33bqvh6zDwyFm3O?=
 =?us-ascii?Q?nQ/bFWnb7ka5k5QwiNqbyBItn7C/8hmsyobE79qo53clFMT8mcwwJ+4IeUfZ?=
 =?us-ascii?Q?wYWX9I2wmeqyqwbFBiFqzoQUxMGsdFD5l7gUxvCRNEZNciFvOrL0IBueFdD0?=
 =?us-ascii?Q?oM/5Bl0Kjr+zUShBAYoHIjUC/qyFlFmOISPGMBmG6Fo9gsn/8pkeNqmCdrJn?=
 =?us-ascii?Q?/cik3vyWG7pObFgE95OLC/F5ggweM00HilDUCF7FsATpz5yoUPiNWEcCHm9q?=
 =?us-ascii?Q?2wLpFNf7s8dmoelQg/c2+UeJOvdU/9Ph5rPILB237FRHErJUUez0b0OK/M6j?=
 =?us-ascii?Q?0jT/+UBM6inBpZJrY2idRx1qFLuIC7bEUsRYxro05anex4nydNoKSCc2mdoR?=
 =?us-ascii?Q?OYEI/Dv+kMgge/EicG6XcLJKIZn9GxHIjDCVZf9GDA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d68a0618-4858-4cf7-310e-08da5a6a6ace
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 07:30:33.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4238
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For received CTL mesh messages, the wrong network ID variable was
passed to ctl_received. This patch changes to the correct variable.

Also, changed type of net_key_id argument in ctl_received function
to be consistent wich the whole call chain.
---
 mesh/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 8ff3ef32e..e8e6d3a61 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2028,7 +2028,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	return false;
 }
 
-static bool ctl_received(struct mesh_net *net, uint16_t net_key_id,
+static bool ctl_received(struct mesh_net *net, uint32_t net_key_id,
 						uint32_t iv_index, uint8_t ttl,
 						uint32_t seq,
 						uint16_t src, uint16_t dst,
@@ -2347,7 +2347,7 @@ static enum _relay_advice packet_received(void *user_data,
 							net_seqZero,
 							l_get_be32(msg + 3));
 			} else {
-				ctl_received(net, key_aid, iv_index, net_ttl,
+				ctl_received(net, net_key_id, iv_index, net_ttl,
 						net_seq, net_src, net_dst,
 						net_opcode, rssi, msg,
 								app_msg_len);
-- 
2.20.1

