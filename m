Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DCEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Feb 2022 23:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiBYXZi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiBYXZg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Feb 2022 18:25:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB918BA7D
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 15:25:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3E3AIcuo3xccYkfxMEaa0gw3Un9F0NqPKoga27knG+QoWCv4j3ej9xMVly+TiB0PfKMWoKHlIXm+SVJO/kYaB3Y3tT3DfCpy9Giq+Kt8qbjXhWrG3LmHBbky0nv4cgQVFSTktfZ6b+wKaTm/SNQeh8AAOoDIlKWm3+sfh8Ms3fHTVokqE4HAhN+wGvYkhNGkWuNIA1LY1esFIuzXCiYh6ppzmlr+S1Jnt/RPAIzIIFIXApDG6U44Lfoty+bYVQGToreeJ/2GivKIvaZLOVGLt12m9ek6mbIVL2spO2UcyDCkOr9B56MZWeuUusdYAyYWilZJa4w4b0Ke5N3PclEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XfrvQUnekKpBc/4sZRH47E9adpJDc42UypsZpuAT7k=;
 b=FGgZk3BgXiU1GD4gGREEg04s9GZcGlFrINc7QQ4hvdA5MZiPHcDGA/Kojydzy7Ap9rJB2ulV+OWySyOWdxI/pREuTRl+p5wkzC7ktSzj/N0GaKjVZCpO2NwFfgObZjh7FYsJSQG2HaxWbgOAYhxZ16hKX3zQ4QV4J7BAK6F936Px1pfamYKywP35+VryNHOMwgeqPSlC9znlqQGFKjqpqtU9Bj/bE6MAwNjwqcHnMVOYDu4SQM8p/TAnOXhoMWS2mKSf2WHJtLPMNDO7HGDl+132qz/ngha9nqais4uUG0exKjnS2iqJF51Pbh12vqcqXHDG9r1uZ2jPd0h1vPmqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=systech.com; dmarc=pass action=none header.from=systech.com;
 dkim=pass header.d=systech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=systech.com;
Received: from BYAPR20MB2664.namprd20.prod.outlook.com (2603:10b6:a03:fd::26)
 by MN2PR20MB2701.namprd20.prod.outlook.com (2603:10b6:208:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 23:24:55 +0000
Received: from BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::b094:5bbf:41e:4e2c]) by BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::b094:5bbf:41e:4e2c%4]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 23:24:55 +0000
Message-ID: <659f7c4f-f4d3-31d8-45f0-282570d0b12a@systech.com>
Date:   Fri, 25 Feb 2022 15:24:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Jay Foster <jay@systech.com>
From:   Jay Foster <jay.foster@systech.com>
Subject: Missing Network1 Interface
Organization: Systech Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To BYAPR20MB2664.namprd20.prod.outlook.com
 (2603:10b6:a03:fd::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd01dd0-d1be-4727-5998-08d9f8b6080a
X-MS-TrafficTypeDiagnostic: MN2PR20MB2701:EE_
X-Microsoft-Antispam-PRVS: <MN2PR20MB27016DD9F032222635E11091933E9@MN2PR20MB2701.namprd20.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TprYX6Ks1+jcmzDzqKFTgfWhHaDk30Taon+PKbkXJyaG6ZPBbLFHPjai2Di2emiitgU3oUrUYBlLMBoUkSmFtwDtXYsQG+9S+3g0XxIfg6LUOaER2Y8hgzcqQJvGHw8KBRVZuX1XkakkSJ/3TAp5VWWOfvXmix8ytcdvDN+T8VUeO9PDRFwnheDCEaoMb210YUJRXzn2eQiw0tiRqZYbpxWw5HEmcOi+KGR4R0wNxTiT4z3wm4IfZ7bxMSCgJWWYB88RHf1mC1zUCcc65KUdljPJFhSsEbIP27GG2MKPa12Nqh3zfgYv1+dhxzO/JfkcZmFQUw6rEQvzW9OxCXlLsYuOFFylmW1FvhD4lKjYKDe0ZzTUncKgP8F9AISPX+qoMMSpuysIb8hjgSBGCjNCC+7z5+5SFRZWGCNR1eU2GJQscplfZPkrobQZeL1PisjLZn54P0sc8LAyw81hUaZyfeqsUaoyDsATdnUGCEy7iUp38hIzG5Y3Qr2R+v1W3HRndnD3645R1EYQY6zaeCiixQbjZXp1Ddjp3kmX9BJkS2zONPDHbDFwNXrITVkEQcxyJoKAELWf2b1L2YxF4NekEZGzlINhKFQ7xPLmaDlSRRVsgE1PIvXLOLW7/Jmwk1ZnSXX2WgNRXG/Z1GTD+K+H0W5fFHezvH8ZCp1i2k1Go0KnNk6haCmfOk1S+Y3vH18y2W1NWetMd/jq649S34nEpliFrE1gNyx+ETVIXF3Y0/XCtzX/BKBDpmL7PIZEvn4gJSk1+UC/xwKzZVTOVE2SkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2664.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(39830400003)(346002)(376002)(396003)(136003)(6666004)(31696002)(8936002)(2616005)(107886003)(4744005)(5660300002)(6506007)(6916009)(6512007)(44832011)(86362001)(316002)(7116003)(66946007)(66476007)(52116002)(66556008)(4326008)(8676002)(508600001)(6486002)(36756003)(36916002)(31686004)(38350700002)(38100700002)(26005)(186003)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9KY2M0U05wbS9Sbkl4UGZVVVhlK1g1cUpxRjZkSkRIaFRiRWVUNTIydHlX?=
 =?utf-8?B?NmJYc01hdUhjNHplQW1FWWRhc0FHYTVIU3RhWlNQV2JLRVJ6MDVJTUltQkJM?=
 =?utf-8?B?NmtxNXNNZm1QTFBEcjFJZUp0R1ZIQjFGSE1qaXh4UE9zVmVVSVNHdDZJdzZJ?=
 =?utf-8?B?eTl0cXR6WGJXL3cvOTQxYWxONUNFYndyUjhienRDV2txQWRXVTN6WWtxMmdv?=
 =?utf-8?B?YjhsRDVxQ1FNbDhiUGExM3NBUjJFNHFXWFd0NGdtNHdiUXZFQllUbjFMN0Qz?=
 =?utf-8?B?LzlaS1pQcWV4QXB6b0RxRG9MR01QdFc4aksrNjkwSW9GNytFRTZzekx3V2Qx?=
 =?utf-8?B?eExhTm4rRlgxbVhzMDNldG1yRGFTdDN5NWw4OXl4Z0M5aDdudUtTSWFqTlU0?=
 =?utf-8?B?TWtQbmx5aC9qQzZ5QStjMnF3eEZjZ1VaNWVCdDl5bTRIUkExczVaZ1o1d2hS?=
 =?utf-8?B?N2ZKd3dmODZReEJWVVRsNG0xMUpudnpHbGhzSTlvWHE3cDZhZUpsTGFyQTZF?=
 =?utf-8?B?ZHdEdTJnTHVKSlVyUjcwSi9QeTNuTEpsWGdJZ09wSjhJQ1pVc2MybW4vN29r?=
 =?utf-8?B?U29ycHRjN2J2Z3FGWDNlTW45OENqS1RMdnFJdG5JNUlUcU0yTXdTYlZKZDlP?=
 =?utf-8?B?TlRvZEhNbmZEYnltU3pUVXdLaERaakRsbnpDL04wejdSVmxNMk9hbG4vNGMv?=
 =?utf-8?B?dkRHYTQ2R2NWZ1R3dkN0UGZIZ2ZNZ25YeHpqM1dXZFJRbldtR2FoS3VLMzYr?=
 =?utf-8?B?L2RtVmpJcllJdGp1VVd5QWxtZDd0Kzg5S0xEQkp2aHcrWURGK1ArMFA3VnRR?=
 =?utf-8?B?ZXlNcW9QbHphenRKU3podEMveXA4Yk9FRmN2MXFsaUk2TWE4aU4vajFDeTZY?=
 =?utf-8?B?RVMrcW90N3Jxb0R2WHMxSHVZSjFoZ1pTRk94Wm1MVHNOemg5RFNmc1pIZ3Rm?=
 =?utf-8?B?MlNsVk40WFltNkxJUWVyeWdtNVJKVkFlUjdMQmlOTXZYRU5IaEsxTTNrZlZw?=
 =?utf-8?B?SEZaSGx4SEJSVThhRi9oeTlqcVVkRnU3anplaHBFMTJ5SnpvVHpxU0hIN29a?=
 =?utf-8?B?dlp1YXZJSjQya05YdEpKb2s1TG5HVDJZek9rdDM1dEx5YkFEZ3RtVVJoVWxE?=
 =?utf-8?B?bi9UUUhReDRKVGd5bFhjemxDYk4wdlpMQWxnRXF6cnR4Q240YU5SRk4yQXNv?=
 =?utf-8?B?R1g4OHN2emVpcFRiTlg0OUIvYm1HbEptbmh6elBkdEJ4NXZzWktvcHJoUW5j?=
 =?utf-8?B?cm1QZHRET2FLZytkdUFhaVpVdEFSQW45VUxlNEEvbmt6aDR6SFU1Unovdkc4?=
 =?utf-8?B?VUpWdm5TVlpGMTQwZTNjczUyRk1keHRnYXFBcCtTV2hXcSt3Z1BXWjdpQW1F?=
 =?utf-8?B?WXpkUTBrem1lcmI2QllPZ2dtemxiTmkzdXFiSlFTUzdwdWYvVUV0N2Z1bUN5?=
 =?utf-8?B?bzBRTHlDNmU1ekIxZWhraVZNMm1EbDJ0cHc4bmlrcEE2NUlkekN3MGRlNGdD?=
 =?utf-8?B?cmdZdzRvWGxmaXdQMzRWM1FWQnhSbDVuS2dsZk5WeTJPbUF0am4zR2ttQzRZ?=
 =?utf-8?B?UVhkT1J6emY4K1k5dWZEOEFoLzhlNXRLNkVPaXBpREdnYkVkeDNaYnhGVVdu?=
 =?utf-8?B?R0xObDFScDVTWVY5V3hBdFdGYnBQeWI3TmFDa1NITjlaWm1YendsQjM3cjN5?=
 =?utf-8?B?dGtRV25VUkNWQTkyblova0dqYjNnTG5YOXFiaE9BMExDaGhRU3NHdWtDMjdB?=
 =?utf-8?B?R2N0S09lVEtCSStKVlc5TENxOU41N2lKdHFvVXk3czhWKytUZHZxZ09vR3pW?=
 =?utf-8?B?QUNGYWtQbTNOK1UwSzcxT1hmV2tKblMwZHZ0ZU15SFpFZGRJc1NnYlBjQ3p0?=
 =?utf-8?B?c0pIN0FXaG4reWswaFltVjF5dnVuRzNacWNWM0NCV2pWZ3grZmg0YjVNUEcr?=
 =?utf-8?B?TGhtUUREamorZk5OWmRGRFNmOW14UDhmbVJuZlFXd0FaUDJLMFlJMWxoeUFz?=
 =?utf-8?B?Qk1jdlRyanpadWJKajRFRURiMkU3SERkeEtZdDVybitrWms4NTE5WnpuLzQ0?=
 =?utf-8?B?bU9kQmlwUERlNEs3TlcwLzNyMFowQUtneW0waU9kRUxETnVMUjh3OW1RM2ZS?=
 =?utf-8?B?c3dsSkp1NkhnNTNyWmhoa054ZU92c1JabEJrNDRraUdIODVOV3JhZm95SHNR?=
 =?utf-8?Q?cN7dmGv+zUsdSxebvVuIagE=3D?=
X-OriginatorOrg: systech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd01dd0-d1be-4727-5998-08d9f8b6080a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2664.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 23:24:55.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 47224f68-59f8-42cf-9b0c-62ae261b2df6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91vB4akdnTr+oS2l5uE/1qpRqcj9TfotDgrLwvERIPjEV4AY261aE212U0fPDqR+UXIkQjQQo3F34qCFxTy1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB2701
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have an application that has been in use for many years.  Recently I 
have added support for a different Bluetooth adapter (RTL8821CU using 
the btrtl linux driver).  Mostly, things work as expected.

One application is PAN networking, where the adapter can be in the NAP 
role or PANU role.  When the new adapter is configured in the NAP role, 
the PANU system cannot connect.  Using DBus introspection, I can see 
that the device to which the PANU is trying to connect is missing it's 
org.bluez.Network1 interface.  My application uses the Connect method of 
this interface to connect to the NAP role system.

What would cause a device to lose (not report) it's Network1 interface?
I have tried several different versions of BlueZ (5.19 through 5.63) 
with the same results.

Jay
