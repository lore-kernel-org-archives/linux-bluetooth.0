Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02133EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 11:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjHGLDn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjHGLD2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 07:03:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F08E8
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 04:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTY7VZyOWSPOKd/1qrgGEqmDrD748n4NcvpjGP4Y0Q/HQaT5wgvTYRbJOS7u7Ws1edPtN8zdKjc32xchQoxW0nThLkaiXMbzZ8iNDNkovG6teCWNYUgjHOeFNkZPT+DdtGkJgYLn3E+LvQFgFfT+lUVXHF9Ett8VJNFSeYhwx0IFSfHMemHdRBqbawVBoAtKvqrZDRhwsXuLFElUfOUv6xo7cXxXUI/kI1He0W5hG4ris6VMlokpax1vnL9T33MqUC6U7kEBEeK6AjVq0EcrTihcnVB66cql5koUgR8/9PEc151gXfDX8xr23aUYuNC4+5ztGa21XoyyHUzyiv61yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJN5xEpTPScwahccSgMdLFUcuasc8PgB1NwJx3Dj5dQ=;
 b=YIlrbm3AZ27sMQPSL4iD2xDzK7G988lejxuVWaSh+Ek5jnK8t7FavRJX7iDzobhGUmU7jnq1KvnHDvMiHEdCEs9MKbH6VnGNWYcyx89t8xP7GTcPCs562TD/Mntcy2YL66C5MjlBe8Zj6TIYbwDoadCxk6/7U8qAHJDgbj0ofKSpAZTdQqUkTVAle/vv4pPyeX+wr6Ht/mGQCjn7F1WalFqLw8vCzWvbtNwHStodZebiM7VqkqnsEbP3f8lsRUa7CfIiRfn43NDxWXC3LpVaH2di4Y0Yc+AFnBUPQ2dq3Gw8ie3mtgJAWpC7WL+iC4U1eHsDU2q2dQdHrnyp/mo2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJN5xEpTPScwahccSgMdLFUcuasc8PgB1NwJx3Dj5dQ=;
 b=WNOWOnowon2gZ1kT/WEQejw30TFxeGTbeDW5o7/hkWLdcKcHVggjtnfGejNwX/jAoP/AAO4B10UVSRE2306umSC9hDtrXuHiyUow8inK2MDcZTbJLIg931jFpqgM8TO3e7i0g4amcm6g/YaZSu0vYZmIXCaYe8TrR80/25HDWxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB8028.eurprd04.prod.outlook.com (2603:10a6:10:1e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:02:45 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c%5]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 11:02:45 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v2 0/2] Configure BASE using separate structure
Date:   Mon,  7 Aug 2023 14:02:22 +0300
Message-Id: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBBPR04MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f74bd7-bf90-45ef-1b71-08db9735d3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fw4ofAJi+pdCVN2qW1JrEtTqwrT7gUoHQ5Kydxnjw8zQEqTWzhyflE85tNl5tA9ZjKUmr3uIqLHolrkrBWFjREXkhqCPoxtDmumLebsz3fcLN7+YwfyFfufh5ERgsWJHYVMMzvwBmTmHG8/Aln6deMpqgTTANDexDPnK2Uj6O3P1zTDNGvU9tbSMpAW/DQrN3wNG4BffJrLpZlRNYFGoKl/jc6dhnl6xhjStDygSbKJqzlpKgn9XZYwmK/NX2laDyWKRGpmWOhKEfH45MpKuKqTnlrujaSg2CUgTqdpr6H8nt7n0sKpcfo4YdHsyQ2qLMTjpjJUD1RYIFejq+QI4oYToRFsmvmHusl0Tn6yoyoU6Gu0UL/zcVjAkbhIx4BLxynv7VnZhdDDPFXfLRTd9h6A+z3TBwotKw/rqc6TpBs6Wx+cOmVIB3kMLfPBNVSA9uAHQHc483G53B8PMHME8sOQibMF0yIdafMPK4EL/fTk+Su86JkUFx8swwMxkBxPbOfe/4MD5Re69R/KU6QDgz+avyhZ/0fANlno41xL3VaccvLDjQTuu92dk0iaPLh65uJt0jOZeU5JXbBVWQsynj/W1aMzoWTV6ozMuJEUQfMMJEj3g77aM4QVFRKEkZufg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(8676002)(4744005)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(38350700002)(38100700002)(6486002)(66556008)(66476007)(52116002)(66946007)(6666004)(478600001)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JG6Coz7iCvrXvxIXTCQ8M83/vof+KBqIUcRjALsvjf/iJb9CVsfrJcwcqZ0?=
 =?us-ascii?Q?xPSS1feJ0Dd9NWTyWrx6ELx8QwOqT8BGrsAmGbGA8tdNKoAFDkfdleewvjKB?=
 =?us-ascii?Q?H5pFzl8jxEfkhe3rhAaqyKMskRta1WSPsXMllaYdlTqN45okqw3D8mpmuNt3?=
 =?us-ascii?Q?K1NJ1L8veflqWpeIe7vidXqk1qTEJQ0GJX00g9+oYJAefkqkc4RNaxBxje4C?=
 =?us-ascii?Q?tCNIi5eMSsG0aH3Z064MFI8d9sz7B6SXY+eZTZbB69u7GLzN0AgqelgDeFLn?=
 =?us-ascii?Q?EPZ93s3I6YPfhlSZPe/yhhu8gZarTQqYO8g6Vysp2GTYi35xgXHu6fWp4qJv?=
 =?us-ascii?Q?JPe8z9sr6lshtixwnNidD6hQfiIBa/Zri2x21O8LAnfNt+rBKTxDgz6DJFAl?=
 =?us-ascii?Q?4xv6Rp4xJC9XpLlEJEX325f0HtzAwtEKKNKAw83fQJET8HsCh0+mtpueun8K?=
 =?us-ascii?Q?H7VUmviaEVUtBwAnJcwXpyLmNdjvBERzWLYl9RuWPYDpZR1sln9ZI8hliLe/?=
 =?us-ascii?Q?eXqtFvAO6z2x7JAPGUzMc1JTCJINlM9LccnaLDRyaWQ//o4RsYAidPYJQ5aY?=
 =?us-ascii?Q?JxkpEPvcz09uVsn5l0iaBz0YO0cmrkFpNfFRNdiy90ksu9fotAWXhCZEkxq7?=
 =?us-ascii?Q?OLOQgkrC8AzUsFWZALS4/eggFquzpD03cykFaBw9nL6SIEKW7SVAooUizq9Q?=
 =?us-ascii?Q?fqYB4+qPQaLGc2qfwQgkugLi4ad92zxWjWEwAGHoElHAUlH0uJLcDdUCOjFe?=
 =?us-ascii?Q?Jj4J9/6zcYpCqxm89DqjNeEKxAXOVmGIESiNGoMyYtMfh57Ff9k3qSqZDd7W?=
 =?us-ascii?Q?qZDO21z/ORiWS93JevfrB4BR3hHG30+IVsqUK7BF9VMB3Xhy5Biw2xQI8UDv?=
 =?us-ascii?Q?yVpHqbTCgp9SDTnSqCaLnyHCbItaA5O3AGP8rkNhRsfTxqHD1q4GLRhBS8wx?=
 =?us-ascii?Q?MpxvYcreSzZM/pB84H9awFTf1LFwvVJ+Sa+C4gv/G3Vk2xL/k7xUWN+KUg/p?=
 =?us-ascii?Q?ZZV1OHg0Aqbc/ACD2pFvBpQT0DmsZbbTNLIK7WtOpSi9XCQZNjSt2FzgkeqN?=
 =?us-ascii?Q?p4Ap4YaP0zKeUbEu0W9mRSgMmhasBQZECu2cmInxvL6yeE/Z2J1GVKImTgz7?=
 =?us-ascii?Q?BRWJTodtNxRTHuX8gPd1xYWBgUH16x1uZ/Elqh5OBop7c8DLUW+rCe4+rXcv?=
 =?us-ascii?Q?kpT0domGr+srDtKV38bn4fZ7CgB6sYiCCA7FWv30AJddnqOHRAbB+moz8l+y?=
 =?us-ascii?Q?ZAQHPOiY/HTg0YkWkDPVToYAFbWffuEG4LRVRq+W4VPu35uE/S3zdgTTS5yH?=
 =?us-ascii?Q?Cq5B+cjRBvWOdSHdovBXWCUQ6AkuS1R9PTMuuLu4suX0EQ/81nppIcfhxMJc?=
 =?us-ascii?Q?NA1y29RQF1c50R72LjGCGH7j5li46ktLbzP4x96lxVWiX3tEdKO+N62WtVVa?=
 =?us-ascii?Q?8HDXMiawSvsVhPyfuulC5Uts2MDWx2jDcdKkd7CVOsQU8sC8cveVxoTodJBF?=
 =?us-ascii?Q?QWvFOs8EDPgdURbltkngIhrjlTRB4KjXCWrxqvQeW2nC2o4l4rNDhw1ZMqt+?=
 =?us-ascii?Q?RLsvHuEAu+KPfUu2RU7pU5SMIgpOP9HLq3DQjNH0Y3Tcemn4X7sI7iXKqcBR?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f74bd7-bf90-45ef-1b71-08db9735d3f4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:02:45.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZfcpFBwwSGcWZuogAeMMD4B78aB4VtQqI+ua+xtqoYMJcfAIMObVdujzpSDjQD6oVfmMI3mX3UDSLgX55Ootshqvk8E0NFOsk5EXb4EgP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8028
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use preset configuration in capabilities.
Configure BASE using separate structure.

Claudia Draghicescu (2):
  client/player: Use preset configuration in capabilities. Configure
    BASE using separate structure
  bap: Use the BASE structure received from upper layer

 client/player.c      | 24 +++++++++++++++++-------
 profiles/audio/bap.c | 13 ++++++++++---
 2 files changed, 27 insertions(+), 10 deletions(-)


base-commit: 80107630396d3d3a3984c599e0cb9b015be0499c
-- 
2.34.1

