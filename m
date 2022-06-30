Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E5AC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 07:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiF3HaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiF3HaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 03:30:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2078.outbound.protection.outlook.com [40.92.90.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2C61C928
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 00:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehTiuzvfzFiPgL+U96sMg45iDp622K7urRozZ7Z/dyMKs0LC4EiOT3RUZmEb5Su35kbcLtzj98ugI7Y/uHChNXalSlxx3sXoh8Yfov5KEEjR6x6ozB5ZmCqdDQ6QunpoGNlNknrBnQYEX3INo4d8HgCZHLwRSsDRZ2yJBR30tbfsxfrZ3WI+9zI6KMOPxqp+iggOToxQs1QPR+FIoQLzORqPSoPBUplvrJ2dv3QVK2Dfki/FO0WHtKdGlqkTCB9YLce3Yp8/sIZcJUoUQNMX/AY5i64XcsPK8+wOQQlqkz0TqLBXMBbnHQwIOYBfSRwF5i0OzRnFwKIl9hd2TCHiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCKUqf2L9wv/hywt5Dxzp5XKEgEAdLX+VXSKZoBlupQ=;
 b=iXyojJKu/K6l/Nzk4zhiTxBpELIIcHXCbQB6+NJ1dVz2W1MdsACvZ54m6iWMDIdZqm5TzqDxd2R3KyNPNKLALFIo0M1TiSpMr6xNkVmD2+zXNJZkTKRmG0PIXgiBHie3JBI6xupc0mXz71sA/g7YAINeGnl+s6HYOyHHqHt/2jTis9tYM1telZYgez0AggKlTwLQWmacqZHspk+A1DuVvtIQBV6VrL1VqrF8FufSk4uJetZnqGWjRn3D/TGq+UuxRfVkNDng6tU6l4btPRVqVUjpnd4LNT3WK5cEUq8YA/z9iaq1+gYHI5F212sjYeAfA0ogjELqGCgkldV95o+iJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCKUqf2L9wv/hywt5Dxzp5XKEgEAdLX+VXSKZoBlupQ=;
 b=Zso/+2uz3wy5q8FY6lwyCMD/KKz6a6gIAWajp5vb1Izi1Nk2mcIU1UydlXshAw36PPA6O7n6U8r+fAoMzF66ulFE9vxTSrYZdEkkFtuEML/NCU5zGwZ7ls8unHeDjJpxt16ipmQGkemUXxdntadp55x2i3OiCHerUvaBvBPV4RLyxtpaPXaKfVkcRX8pWcSOKF+TsmPzkyWf1NHbvTxfYjz5k7iH/BniOabWKPceEqDNfnU2vfLhtuhbajgzmLxnWicJSw19qrE7WGI8B37l/5ERUR2CReNS9bwQo7lJDevYaxb1KUOBodNVhSVz9ujw9Xp+TVH877VEmxtIPAa7cw==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by VI1PR09MB4238.eurprd09.prod.outlook.com (2603:10a6:800:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 07:30:18 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::a854:d1b9:4cc2:f422]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::a854:d1b9:4cc2:f422%3]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 07:30:18 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ 0/1] mesh: Use correct net_id in ctl_received
Date:   Thu, 30 Jun 2022 09:29:18 +0200
Message-ID: <VI1PR09MB42395E20CFD614E52F3BC496E3BA9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tc0ePv2jqw30u3cZDwqm3l/Mpe9Y+vDs]
X-ClientProxiedBy: ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::20) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220630072919.20890-1-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae178e4a-878f-4d09-503b-08da5a6a61bc
X-MS-Exchange-SLBlob-MailProps: q+fD6XS3/UIsx7KfB5fXwSmCBUPcX8iFB7BfKLRV/94aIsfvKs7IJy1zTFrUSwAKmvBcFqwYUETqMCk9eEdPhcN7pqTYy8wwUY60WUuitcWFEpnqu4f6ItvifjY2TiF9qoNpaaVQtkChy2qt17z7P01FJRzVhxTGz2R1PHJOQ5AmWDD8dNtIIuv/YC+q5akn3RPv0wR1yZEYK4nVgv+xjLZaWx+XTvNuX6g42aqTZzIABzqax4vRDxB6YDcl85FlF43d8QwjEY74s/Nor6Xhc7nDErao/kAJvSrFrTJOjlV4xwiuS8GBkJGZwFE+fSJ0HloU4DBEti/kWfR1il9N9c3uT7YseKhdfm1mD18r+LsF9h584HVAcBnVzMpNqzSjBZUSwmh6b3zYUncR0u+8CddC06KMzJc4gTt17myKHy7kn+cOpj9mcOK5wKElpwB5OUtNtcTvKDMJOFl+ZKkr8uHoO4WNHqCyKHotalOboEQqajIhZBcgR7JrXPerAz8yQVYeK9vFIj9vd/Z+PKdJfJcjVPSunnv5MEUQH/HEDKzkooBMAoYV/jQviFAfIprRbIcLMpyvt2ymwwtILU9ZCIsNRgcidonhQRIVr1XlFPk8JzpWVy7ZUL9q0FeJ7EZqXYUEMQ3oO2qMpdsGsp53YFwK0yDWPM9hVlGP8INsr0FU0Ire0msBqZ+8+tva+Xt2jSzbBjLWKOaO8zKVvxe6Iw==
X-MS-TrafficTypeDiagnostic: VI1PR09MB4238:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpy10D+BuAOyDRIuhnoLYQHk+/PLL+1Y5Ie8RMbzTWhjjjcoWQpOxxCij7xKXGtHoQxBK3RWznqQ+2uMLwovZNLPYILYY21z1Q6xdMar3nYqxVcA+OuCdVXV6tKM7i5gBWxuNVz1Cbc0GJ5X7DNqkO4AbrIjrK7c6qqiWz8O2E16iW9BDII1pTiG7hLjtBu3IEXIiBnZ5akFvXTHcrA78U8X/IDSlk+rpqjosg5arbJ2cll7q/SJSCD7prc3zdTKIPm442ZcsnLVV3scE4XfLcTJyu5G5pbu48PHimdI9E8k3ONbqkcbxy2tu59SLv9mXMhT5TaDVCKlDiWuVFyKWD/TSKE2b96qELQabw3YsPTP5qZy2ozgS9uteSetTDnPZGPafjLvF0XaitpLOp5OzKvb4AFnvHOtQhyF9J8V+Kfs+E0ZUpHyQdlT1KV62LttOMVQahRt5+uMoh1s0K0lveWcFFiK6+Ymjq7i5lnHDJU5hXYgMdsk80StAg81lsiDA4bJlj91sC6ZMzRqO+CTyPLeyFL/d6ukcnw3rKhtd/oQhOinUHeeVchpc9lNTKZmhfUr6aTnTXLAgR0oEguQUoHFciNBLzYqUcNY4L1kaG+dkp+th5nc/9WJnr+VgyVRVMHhmCDT31DLUP7EivrPUA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X93qyVZDVu/T3Gr938wBsE3Y64Ja1CynTD+eWEdpUaNbeagcA5Et31cgRd0T?=
 =?us-ascii?Q?RM5AXNjGzmcz7E1Ul/USfJHMHkT4WXB27l2uD9jf9b0T6Vr7iNWB1Czr7iFR?=
 =?us-ascii?Q?C5poUTi2FRaG5MSL4d6t/da02S3SqiV7OeGiVMWKWsPNsfLtjfnUcuIyY9/k?=
 =?us-ascii?Q?8a4YJ0KzHgQSEc9OTwt5V+xHVX2YsmIwl6LaYQ0U4bLDLCQepfyASu7VFlN9?=
 =?us-ascii?Q?dMhqzLpv7YSfxZo04Z0IR047lHSkI7Rgi4La4jur/sR4/0N+kElPtOG36mz2?=
 =?us-ascii?Q?b4V9BvL0dU9Kw4d4mhRrARb9eNW3FBKWjCpIEvkO1DGMgY9p0lpow2B4Bb9d?=
 =?us-ascii?Q?Ywo8heL9Dndrb2riBylGxYIZCQz9kEW10P6zlvA8QnY26rv9rP7SmYX8y05I?=
 =?us-ascii?Q?MLtrRYbcTv+x33OP8crs2guu8w/klRyGSDxtV3idkVR6dTNqU2w+cRASZGce?=
 =?us-ascii?Q?0OoPPigB4+EgzX2ay5o1Jr4Y6dEZLc9iN3SmegUUVe36LvSxaQV47pBKwWeU?=
 =?us-ascii?Q?lvl3GhCpH6C5mvXya3N5MVUHDCQpAQMNDwgQTbfOeRKixfwU1egEFK29x1rq?=
 =?us-ascii?Q?tCcOH41wZVwSPML0oBk4m3INQxKgXrxK8kEF3yrUGLx20rYXeHV/U7aYcD7M?=
 =?us-ascii?Q?QgMPxj3Fk88oy1GwknXCZrBYwWPpryJx4pHdBAHlu8svzcdPAqoHBajVFTAG?=
 =?us-ascii?Q?CTYXiii8FB9czWfpWKAlKmFrLhScU/BcWI8FYZPdK2JkcsAc3GaJOJX0YgkZ?=
 =?us-ascii?Q?kNmzyzFGhTYEzfzP7kb1+nCBh1uGAlo+PbFfUotZNkVjsJbTiG0UVoiyPfxS?=
 =?us-ascii?Q?DlzJ60PsTZiEg+I1VcYkRuTOUFapRTckD2cDsoE+pK1yRJf2kganBt9RNpGI?=
 =?us-ascii?Q?OWFsZCvhNos5/HVjefYncIMtnUDEyGt71Ely+qXRHe/Ux3DeUI+LVI85jIEH?=
 =?us-ascii?Q?KYZSXJrHfNSEJxi7TVCzFbPqeneF0DhXlreIzZwF6ASZ9gjvSKVH+r4K5BD5?=
 =?us-ascii?Q?qjKG5+kdop8HJQPc1BHckiQwda3kL61BwX+RWmBc/93pXdp6DY+vWhsb/6CN?=
 =?us-ascii?Q?Sj2w4Sj9LrUO8vcTE4yyBeWxtr9WgNwcDVfH0h221nTxlMlVtdhBABpWFsqu?=
 =?us-ascii?Q?HqARVYfSBDzcAgq4DN3TPzZgYvxglAIhDTp6tOqUZKZ6zy0qkm1AqOW/TAd3?=
 =?us-ascii?Q?TO8hrppjoawoavMTkVOiCBEP1qiYmVxZNH3clBmvln7x23WltWebf6clKIjx?=
 =?us-ascii?Q?N4ifC9spMgemPNz8R7d8qvIQHFYtG0e73YOZ1JQosg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae178e4a-878f-4d09-503b-08da5a6a61bc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 07:30:18.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4238
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I had an issue that the mesh-daemon local node never responded to friend
requests from a low-power node. After some debugging, I found that the
net_key_id passed to the ctl_received function was always uninitialized.
It seems like the wrong variable was passed to the function.

Following patch changes to the correct variable. I tried it with these
changes and I can create a friendship with the mesh-daemon again.

Isak Westin (0):
  mesh: Use correct net_id for received CTL messages

 mesh/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

