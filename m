Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E831C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 19:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLOTt6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 14:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLOTtu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 14:49:50 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5E254365
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 11:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIApATYlwzIKfZppmNvz7ioo+FHqNH80Fc4yRxJEPUFJqig6M5Q4M+2xga6KTHr1N3k8kuhLWKdlxY9W5+vvkN2ySm2sB4HvJPAVxclTng/41TPCjXGTmXqIUne6bvAJlpeHKie/QifnALfzlagt+oReLamM5dtYFvBK4MFAVT1w7d4Ho3O+skZlXhkyLocV8kMjr6LQUc4xoYCOh9MQzh2cWXRCpdBGtTwXDFK2ODCQ3mnIgoZ3/wm6bmEAAsFxTdd7KZjJuDGVEKuwwJ7REsAcoFg7aMeT47tvwo2X0FnLZzBvXQ4lYQAlt9hY9iWi8EKTfMtcqtyAs6fD1IlTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrLE3+h1yRHE3tim4oNCb4GJX+JTDPy2VFhczqMipv8=;
 b=TBqeV1cgHpqX0D0mKW61qPoHpoGEzMitCMKL3OfS/48yCKUhj58DchbeiaR1BvpMhV9w7J1jbYcQE616HgJBZ51kV5M7fTP4uMuzZq3KV71YuQ+gc4DVU3klM9ElcigyLrWlzkh2KNgl4J0/zuQd6Q2Z8aN5TgrQU2GpDmQOzXI8c6QGUg5ZU/w6g5kAUmO4YcQeN99SCtjtYG+OzZwTZm16H2Ek0CkmPZ2D9Ws5KPr6YNOrAl5+AL7xGBrfSugysqg0mL/GSiRvIv88x32QEcEVsUNlWHjvQ6xM8s0aLCXoUBCBX0wrnF3znBE1pSnFOp02NRjhqUoU8hAQb39GmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=systech.com; dmarc=pass action=none header.from=systech.com;
 dkim=pass header.d=systech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=systech.com;
Received: from BYAPR20MB2664.namprd20.prod.outlook.com (2603:10b6:a03:fd::26)
 by MN0PR20MB4644.namprd20.prod.outlook.com (2603:10b6:208:377::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 19:49:45 +0000
Received: from BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::3189:3512:b958:e9f6]) by BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::3189:3512:b958:e9f6%7]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 19:49:44 +0000
Message-ID: <a5d13cfe-dece-7fb1-f2c2-447112d2cb99@systech.com>
Date:   Thu, 15 Dec 2022 11:49:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Jay Foster <jay.foster@systech.com>
Subject: Need Help Understanding HCI Disconnect Completion Events
Organization: Systech Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To BYAPR20MB2664.namprd20.prod.outlook.com
 (2603:10b6:a03:fd::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2664:EE_|MN0PR20MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4bc009-9d01-4a43-44ad-08daded58381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/e+usJA7NkwEOAqMu5JH1p0aiAOmY5MhlXyTQQ8T78Z9lR9wVT50dlqOKEbQkzYh+oWyT/t6tfGUZD+Qjr6wf6fYwVusqdYuqC5+MSL14KgcWS/XL+UvyxtwZCuYunYIMiz2gKq6qcKGS5gFOnANjzmw28yaIt/NfWkUHwQ6luug6APbCxBGvcjwRLnMwssCKdzduR3bE7b9kaFAValqecVRAkroWP/XLorIESpOcMWIxAEYrtdmlVqLqd9itMcIYpP3aRxs+w/sV1d6z/yc7/9pH5d1/q5TWItTEG8NVbfHwzw21EmfjRiNwWbxnwEMk6XB1Yv06ZwJpnAKsa2OjkvsIFO65LsiYJeZpmnufdnXJ9sPPKPzTOxwMNjn6A0f7gORV/8LlTTtRYzVoaWdu0dfOwPabIpM/znOqDetgnWh+rMcxDAkHelBwFH3Cc1sh2hoiUI7qfs73t6/I9mIDyAUZNcTIEKDXgpcgeFTay19x6DanzHaYbS5X5/EMJfofwjsKc+6SE0Kw13gaWQ9hUU3YQBY60+6lLU+hU5G4a9BxF0hcZuGpCjoQ2iL4NdLCMba4w1e61qYtbgwneB3xfONo3rUJiOGeUTDDXxXuRY8VkAVDd38hfsX6I/fmKkrwb8YMHvNCK+0K2yTzPYa8gtCHQavM8CW2vxmWEL2tCkXM2UvxUZOlCILn9rUciCH5I6XENPgrqHilJXZNYGKQ7lXUWepdVsXp2IbNzozwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2664.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39830400003)(136003)(396003)(366004)(451199015)(36756003)(31686004)(38100700002)(8676002)(2906002)(66476007)(66556008)(66946007)(44832011)(5660300002)(83380400001)(31696002)(86362001)(8936002)(478600001)(6486002)(6916009)(316002)(36916002)(41300700001)(2616005)(26005)(6506007)(6512007)(186003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXAwbTV5VmVzQXh6R0xNeXlrZFVEVjI1WE5Va0F3a1Y0VUlvRkdiVlNCalNk?=
 =?utf-8?B?ZXFpUzJ6OFg4dGh0R2FTT0l1ZkNTZkNKcjhqM0U0VHFac0h5aUJwM0hYK1hh?=
 =?utf-8?B?TFdaaEYwT2RHbXdZcGJFWDNNYndwOVR5V29aendyZnZlMWc0U2JmUEo3QlVv?=
 =?utf-8?B?ZUlzNjJVcTFUZHNGWmVRSHNuN0JDUjEyVEhzZ1M0UzBjWDVrbmJncmpmUVhz?=
 =?utf-8?B?OFVjdTVjQVdqcHA1VXZSTlIxVk1zM3ZkR21SQnpna1FCWGRiUjZvSVNmNFhk?=
 =?utf-8?B?SVhaSUZ1Y3FsSTh4WTkxWERaVi90Z1BtcGVJdjZldmpPakxtNTdUMVVpdkRZ?=
 =?utf-8?B?bTNXMmE4MlJub1BaOFNUVmFrOUdyd092TXFBL0oxQkp3Mlo1dFhxOTFLSEdh?=
 =?utf-8?B?SWM2ek1iYU5YUWE1MndtZXJGZ1VvUGllSG95a3YxRExuWFRqTGlDRzY2amMy?=
 =?utf-8?B?REc3Sk9RTUppdmRiQUZOaHNBbmRmTzNQblBVazQxY0VtajJMYVoxNm5ER1E2?=
 =?utf-8?B?OVBxaVJxUHR1MzlxdXU1R3YxdVFyblUvaXlwQUt1cUo2MGZHK0ZBdHJGQ25r?=
 =?utf-8?B?VnJLc1MrNGlGaGE3SGkwakVpUitWS1NCeUl5SDJUdlF1L2NYL3V6ZGZhZ0x2?=
 =?utf-8?B?ZytoLzQ5WWFDYWVUVkczYkxXUTk0MCtlaG1PZ05SenlqOVlCZHNPdnNCOEcy?=
 =?utf-8?B?ZVVRNHFOSHg1MTJoNTRET0dhUnhWcUFZd3VwaU9TOENtWGI3eC9uOEVURHpx?=
 =?utf-8?B?ZklRc0NaM0JtOU0weGNEdDB2cmdDVnhUUnBuY0RSaUttdU90VVBGUGNtVVpF?=
 =?utf-8?B?MTBYVVpMSEpnWUtqdm1rcnRUemhNZXpneVdjY2tQTkdVVjF6bTI1SDRuZVRw?=
 =?utf-8?B?NkxNVm42cWFZZy9MQzFIaTB0RGc3V3VFVm96U1hNOGMxR3Q5TlloeGE2MG5H?=
 =?utf-8?B?dGw4MnpSb1JxdUlKM3BaZmlCMFE3d3lDUFBkMGd5dElQQTZWMHo0MFg0TkxM?=
 =?utf-8?B?NjBrYWRBakF1WmdPeVlaakMzSW44S2hscFBmeC85MURvak84WERDcFBkVzZn?=
 =?utf-8?B?V0IwNGdma29mWmxKNDVUVlRrNzE4NGlxOXkrWWNNaEdwZTBBL0pFRS81ekQx?=
 =?utf-8?B?MUk0ZkNNM1V4M29RaHA2NEsycDU2anZRaXFNZVhxclF5TmJGM2YzU0UxVjh0?=
 =?utf-8?B?MkZOS1htMjExUHVjcXd3Ukk2M25PODVYc041bEpiZHozQkJnYytjSHNvNmNn?=
 =?utf-8?B?RVJYZVZKMHJPWndSOC9tU2tFZEhhZy9SU2NkUHdybnMwTjFONVJXRm1tZmZi?=
 =?utf-8?B?SmtxbGFxdGJmeFZKWEdoWU1VUDFZaTRJQlRwREhLWTQrVTJKWFZuelVDR2Vl?=
 =?utf-8?B?YVNWOTdPRVA1eGpwYTh1QVhQV0N0K2NveE1VdFFxUEt5RGV2WGkrUXJoSCtE?=
 =?utf-8?B?NjBEbGp3TVhCbEo0QWpwSDlLSXJ3SG5IMFZTdHNKMmRRaEk4di9CZTE3ZE1G?=
 =?utf-8?B?MEJSL0RhLzVudUdQVnBhRERtTC91RnFVK0FFUkVrK2Y3WUxlK29DMldkUTAz?=
 =?utf-8?B?R0FHVlByUGZ4SGNPUVhlSUF4OHFkUWRTcFhOZjdSa3hEa2NpZnMycmg0ZDBl?=
 =?utf-8?B?M1F4eWFRb1MxUUJLU2phSUdUcUlFYUpJNnBNSENBUmQzQUtya0I1ZkNxdmZn?=
 =?utf-8?B?WmFXNHZlMS8wTHpEVk9QbWhsSFNCRWlOTk5iWWMrbWg4czdKN2NtLzYvTFQz?=
 =?utf-8?B?NndUalNsUjFSZmZLTG1qNW9BbHdWZ3kwNlJGWGdRNWp3eTlVbFJQa1JpbzBj?=
 =?utf-8?B?NHJyaElaY01YNC84OEQ2Qmgzbkk4K1FDSUwvODdiNCswb1pIeWU0TWE3N2ln?=
 =?utf-8?B?Nk9mYmdHT1h0dzZ2R1g0eU0yM3h0OHFzWEJVbkFnU2xZMDRyOXVPakl3RjRI?=
 =?utf-8?B?Nk11U0lRZ0RrRnRVNWIwdkhkc1RWcWxDU1JVd2czaXBDcU1aZkVrNU9wRTZ0?=
 =?utf-8?B?NmZTeURHRmptbzduZU9pQ0t6ZlU1WFYycjJSMFI0dmw0UTVncHBQeUNVNXox?=
 =?utf-8?B?dkh4T0k2d3ZNSCsxeTVUMlZSYXlnSmpyei9vb0c4bEU4VE1YQWx4TnVJd2R5?=
 =?utf-8?Q?BhslgRziOzM4F3AxFUSAYqhCy?=
X-OriginatorOrg: systech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4bc009-9d01-4a43-44ad-08daded58381
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2664.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 19:49:44.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 47224f68-59f8-42cf-9b0c-62ae261b2df6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLhjiq7f/GKm0zTx+cJX8THNt/3/+vy5n+4Te7hrxqiU1A14c9/+pn68oHCUTboPrPQ/+WT5++2kdAYKmL8/jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4644
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A customer using my company's product is experiencing Bluetooth 
disconnects using a PAN networking application.  The btmon capture on 
the NAP role side sees a disconnect completion event with reason = 
timeout coming from the adapter (RTL8821CU).  The capture shows a 
sequence like:

185.515624 receive HCI_EVT (Rcvd Number of Completed Packets)
195.512404 send HCI ACL Packet, BNEP protocol, TLSv1.2 data
195.512519 send HCI ACL Packet, BNEP protocol, TLSv1.2 Encrypted Alert
196.321628 send HCI ACL Packet, BNEP protocol, TCP Retransmission of 
Encrypted Alert
197.456727 send HCI ACL Packet, BNEP protocol, TCP RST,ACK
206.716499 receive HCI_EVT (Rcvd Disconnect Complete, Reason: Connection 
Timeout (0x08)

The disconnect completion event arrives about 20 seconds after the last 
frame received from the adapter.  It appears that the other side of the 
connection stops responding, or the local side stops receiving the 
responses, right after time 185.515624.

Is the disconnect completion event generated by the adapter (adapter FW)?
Is the disconnect completion event in response to something sent by the 
other side of the connection (PANU role)?
What types of things would cause a disconnect completion event to be 
received by the HCI driver?

The very next frame in the capture is at time 206.747045 and is an 
HCI_EVT received from the adapter (Rcvd Connect Request).  This is the 
PANU role side immediately reconnecting.  This seems to indicate to me 
that the other side knows about the disconnect right away.

I have had no success thus far reproducing this myself.  I am looking 
for better understanding of the disconnect completion event with timeout 
to guide me in assessing causes.

Jay

