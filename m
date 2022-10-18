Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 14:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJROyL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJROyI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 10:54:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2052.outbound.protection.outlook.com [40.92.99.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1527DD994B
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 07:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrZnPVW4Xu4NM6o+iwEWGgpAYd2ZVKWwtawZ/EnQbB1MrH0m8bEtzRiKcT305CNjKSIdULsD2KA+leR66ZAjEkCPP+5uIZdWIOTnJsJMjQMllLKparOmHdne1FDiHySIKB6RhRkxskIDq/Z4iWTW5O7Ndkb847gZ35ta6j0NPRPTtqqA/QdFqZJap4W0YwUMufL1R1yf9YAlHDBcB87hV8PuIZFLXF8rbaBTGGwiQ+wNlPmummfkh2Xe5ltJeGIIqddWsP5xx7aNC3l04xPSMcpSq32yKQfpR8dIVZpNDHEIo7N5uzmdIEFXKmezuTAaLh1R/iBQfwfeZ+NXEQAOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdSd7zzJ6pkpK3E6DWhfHiArABhMybiggr4A4466+m8=;
 b=cK3qopHdHDsyt9v2vE1qS9OOCiVXBs0EgDoD2KNpOvz5BU+8U5FY1ddZi8totNRoT2NGq0Lfl7NFNz1BLbGuH2C+dWR+r2NQ0LHPzvhJnWieXb6pL+63P3oViNFyCPgH0VsNTKmF+MnM/pA0Gf10/T9pcGg4TapvuVTl/zJS0KH65kyCRVUbB+2+vVvB6SvZrYWP/+FlHTDIfogQGLu88D2dElM1WZZhzHGSpVsHgmlfbbinrP42qio5tH7MKmFxVr+iRwgXHLmi3tO5o8kibdPIP4wVkqsbMwBGaDQoTEuIFKx0IOK/AuYHSA2F7SHX9EGb6fePgBE7JmomSmcE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdSd7zzJ6pkpK3E6DWhfHiArABhMybiggr4A4466+m8=;
 b=l7q3mPoEb+ty8v00U2U2/H+GDkdTO/YOcMdChWXjVoCmUS+3KiGaVEmpkX2grx0SmAHtkCcuD1LdRyAcs0QXr1Y+mHoMZH2QspVsAcI8s6fjYXVrIK0egFJ68PKz0h8jkRAPJ50/6Qb4O8cczqyqKC68VeNc5jipgDzWkYgzryLaAjqCqgiP0CJL55wK8r+BVLtFamWSOQpkBWL4CATfIRNAHrCxUsoIyxodrjIE6QjEKH6G1za4acYB9EZh/rLcsh21s0O/drSTTYr3yVMpNdu7mPpyafwv6ZGQ7BWA64fmuDjlYvrAy6M64Rf8mtWekB6GmXvr6X8e1NI59IJlvw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB2271.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Tue, 18 Oct
 2022 14:54:05 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4de9:f94b:b58f:948f]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4de9:f94b:b58f:948f%6]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 14:54:05 +0000
Message-ID: <TY3P286MB261149FEFA5DE82238E21FEA98289@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 18 Oct 2022 22:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To:     wiagn233@outlook.com
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
References: <TY3P286MB2611921D86D83105FC85ABE0984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v3] Bluetooth: btusb: Add more device IDs for WCN6855
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <TY3P286MB2611921D86D83105FC85ABE0984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [P9NHsMoYaPTWejLXeIP8C5NAsgpFou34]
X-ClientProxiedBy: TYAPR01CA0022.jpnprd01.prod.outlook.com (2603:1096:404::34)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <79479742-08b2-943f-698b-5ceda5606936@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2271:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e94a5b-5d9f-4e46-5724-08dab1189a16
X-MS-Exchange-SLBlob-MailProps: QG/aTLqFmehJW7/1jPuZIlwfLRUlWWCFdramB76hXGV+zigqexbcZKDx+Ant2jHuGoBgq4dl5CtesDMXDpq/TpecIeDzNP2lZUNk2sxSM+iB3QeCM/yYXRKt1pv3kJlqz0GzjZ4uBzHCgokoenGuqCtKEmCy5gDvFJxDPkqwv/jnUOmZGPRakXb5i6o4CeEaFm88OVQcLsY/yOCGVUSBrce1FGrfJaqG+c9zuNsQr4nnvvjmFA8QL3Ruc4mjjWbOGDV2SP4rFMrbhIklIw9Yw+Xcd05RVSAuoWUkWfAMbwGQoBguNJxlLLCen7Y4W1tKONhjbghNc+sgKcXOoD4mZsiOELtQQIYIsKSF7w2r2I8IKIuu4VWWHsJv2f4KNsJKyVLoJ3EKLY+5gHwXtK8vIqy7tVyTgszGSzidpLGkqdSRATajRcYQNEaq4tFSTBY5KFeqjzApJgN00uOXDH0CS7aWZIHEfNjtV7zKLNq/ErlDyw3ZFZvp8f4GWM5dBCBmAMtQTxtl7Ang4HkWCoss52ByIVB/i6zLXwpRFdowxwBEBgpMnAyLipvC/NcqOqNoM+t2ne+pp1+q77Q1IcO9Sps9s1c8pm8jCb7AF6QFXmwphZJGHiGYlgHR72mwYmR3RpwGhIbXGZaP8wgdiBaHbrc+EfDU2su2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7yqwWd0B6kLQcsAhJ+vyiBCmwyFZTGHVI8kA2Q88pkq9lpfUC8SHONCaB7V2OlC8qZ+zal9zp9bbglc8bGX32YZcnAQKqev4MmME+kTka3Shj3+Ns/FK3j4Gu+Iq/viGx5gXRtqhOlJXvl2Ob+X83VOMwa1fS/Jv1UlQVmibIJhmKl/w7uPQQ1TwmFgHey/3tACEvIeqUfUs9jJOQAqy37O5gu8vZNgUDKuHtUr8Sd7JeBJdSF25fzT8Wov/DAR2fR/H3ImjVld/Eq3Ni/GBelnoXrL5M1zhBtcB87N1f83A+76ZEUgOQSEfULtY+1GZideHoVGo/6BYFSzJT40bbhL1CJle6OfKUIj2c4C7+l3TZaQdFyRMUDiIGf9jHBCEW/OrPH4WxvADwW16k2vR7jUQ7FQENLPQK3383uJgcdR/W/FLPyYm+pVjHsaU2PV4nxmug+yEKfc3E4Pkk1CI6gttdh7oa2KaDxfVz01Z6nCiVxUwX8+ZSWTp7CtuMF0ScFXKgotupcSIYUTuEkD++ZlARuTS83OarnNuG+lvghtgukANEBD3A08pW3X4+0pC1Zto0VKpUG9VcFljp9tYu2Bvfe2GignKIoMOmOQHv95K175CEuU2xkLNSylEibkw15vOeqErOHPpZ77Dq4TI/AGT/Z5pL2H25EtadSyqT1GGVPBU6Y3YAmhYLhWejazJTn8RG7z4sEvP1LK5mtwwq08brqned5rr8Wq1lY40gE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3BTMkdXTmRmVERWTjNvNkNxNitxc1dHdWdXMUFkUXR5SmRlaGJmdTB4dXNP?=
 =?utf-8?B?d0NTRjUrSWNlang3bU9nK0J4Qm9GbndrMVFsREJoYXpCak50d0FNMVdHaDFp?=
 =?utf-8?B?bmNDTWlnaTZZbUdCeU1ObE5oRk5KRU9NSlI3WlpQQmlTNktzaWdXU3dnemtX?=
 =?utf-8?B?NENMeFRkNlNXdzBHRUluVDRsQnAvZ0hoVUc0SnNlL2wyaEk2bkZZcGhvZGZo?=
 =?utf-8?B?TmtmNU9yQUs0bE5DT3E0bnU5Z2JVSW5QUkFxQlVlbDFKRVRQL29OblJCU3VB?=
 =?utf-8?B?TDRiVEJZUklTbUluNW1vckdLbzg4ME9valNacVAvZmFDamY3N1RHMnRsQURp?=
 =?utf-8?B?enlha2ZITGdkQnZFN0VZKzVkOHNzOW9LZlJtMXR1MHNnUGh2Z0tPZDBXS3BC?=
 =?utf-8?B?Z0pHMEltUWhzTm52U0xPM2JDOXdtazNFMU5GdTdrVFlNVWF2YVFpdWs1UzR4?=
 =?utf-8?B?WkkzeWRuZ2Fsekhtbi95aWk0ZTZJRkc0aVV2bUVzdlNKMG5DZDM4SXVIcUZl?=
 =?utf-8?B?NkM5M2g1RUU4QUh4RUVhNGcvZ0FySjJORkJEdEw4NEU5eCtxQWplYkhSUEdF?=
 =?utf-8?B?ZVYzZDI1N2w3ZS9pVW1BMzJCOW9UNVhUbWtlcGJRNGZHU0FYUGpwc0ZqbVBR?=
 =?utf-8?B?REErZmJHUHFpelFHWDZOUFZsS1AwSDJyakdOYTQ1RjVuQjVBeE53YjEydmFN?=
 =?utf-8?B?TzB3NEMwcXU5aFd4WTlMd1NCaWlCZ1BOMU1DSE1TUzRRVkR2bVBKbXNYS1Ur?=
 =?utf-8?B?NG5JQ3A4K0pmb2E2d3hwUmRwZGxZdC9TbUhTQXNlU1FsTE4xTmUvb2NkWURz?=
 =?utf-8?B?cTJUVng5bWpqNnd5VWg2VWJHelkxMS9SODFaRjRLWnFnMGFKZkRTNEIrZjRZ?=
 =?utf-8?B?MnFuOCtlUTFYQWhVR2xSKzVTdDdDa3dZRGZBSWxpcnpnbWFsMklXNSs1aS81?=
 =?utf-8?B?ZnNiSlE0bW9raCtDNUJsTi85alVWMHdTaVJQYkJRREZPK1hhUGFYU0FlNGhn?=
 =?utf-8?B?TTNGV0ZYUEpoN1NtbG1qV3RDRDlCNTdnRTMzQVFuSHRmOXpOT3JSM1hwei9C?=
 =?utf-8?B?WU10S0h1dmFzUk84Zk94R0FtSzJ5UkVVdU1VYzlaNmF1UU5KcllRTkgrMGxR?=
 =?utf-8?B?SU9DdnRrWEZoQkNzeE5kdjUyZzV4Y0R4NWdIUFQzVlJiZUhtY3FZQWNlQy91?=
 =?utf-8?B?U2F6dGwrSDh1cGsySUZxT2w4cHBCNkE4QVI3WVVPa3RPaWNkZlJuZittZlpa?=
 =?utf-8?B?ZnI0bTk5dzlOb3dITDZQa1Y1Y1daRzlDZ0lEdFZnaW5CeHk5ZEdLUWlUdmgy?=
 =?utf-8?B?ZjNRMEpKN3RLYmRNRm8vWEkwSlRYVXI2Znhxai9UNTRpdzV5OS9SL3VrbjVD?=
 =?utf-8?B?OVdsTTJRT0l4U2xMck96dnA0amZJMHkzUXdhVitsSnV2QVM5Tzl6anZVN2Fn?=
 =?utf-8?B?MU5xQ1dFWWdOamN3Y1JYYU53eFdiRkU5ZGdOclZleUVReGdxWEZDNTFiUWln?=
 =?utf-8?B?R1J6bTNId01zZmY0MU4yZG94TTJ0ZDZyeHNqSHdvTlBWelQzaTYzNEo0Ykhz?=
 =?utf-8?B?QysrRDZHVEY2TnpFNW5RNDIrbnM5Nnk2UFlNNGZTcVkwSVhDLzlVbHJkN3F6?=
 =?utf-8?B?dFFrWVovU0tESWtFWnE1Qm9vQ091SWZtMjlhdDhSK3JkRzVRNnRxZlJ2dVBs?=
 =?utf-8?B?QmJnNUVPSUVFTmlhVTl2c0s3TnBFbmpncU81Uzl4QlNBZU5nQVE1cU9nPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e94a5b-5d9f-4e46-5724-08dab1189a16
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 14:54:05.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2271
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I've seen this patch has been archived on patchwork list.

So I think its time to ping for review/test.

Shengyu

