Return-Path: <SRS0=DBgY=PZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F11C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jan 2019 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A232C2054F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jan 2019 12:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Dtsfnree"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfAQMOe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:14:34 -0500
Received: from aer-iport-2.cisco.com ([173.38.203.52]:18597 "EHLO
        aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQMOe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jan 2019 07:14:34 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2019 07:14:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2937; q=dns/txt; s=iport;
  t=1547727274; x=1548936874;
  h=to:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=y+Non+sKIL0Ry9W79/7/svPvKHE/ONWQ3rh5ZOC1NhU=;
  b=DtsfnreeRsNB6zhedgpVVJz+dqOAMatc/jwQJd2NZNZpPLR+aLJhrQTy
   yng+upqMQYLJDzykLQ88TAcWt3wsFC0bBw1wfSOPhKwK43yVq+qqF422D
   mG4sakC1VSaDKITKCzlScG7oxyYdwtPGSSRQDHXNWNNG/bvS3rbNuGC2x
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ClAABDbkBc/xbLJq1jHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBVAQBAQsBgVqBXjOEKIh5pSKBZw2HZDcGDQEDAQECAQECbSiFdA8BBXY?=
 =?us-ascii?q?CJgJfDQgBAYJTS4ICqnCBL4VDg2SBDYELi0uBf4E4gj2EfAESAQODJYJXAol?=
 =?us-ascii?q?cmDQJkg0GGIogh2uHIJNugVwiZXFwFYMogiYXgQABAo0cPgOJJYI+AQE?=
X-IronPort-AV: E=Sophos;i="5.56,488,1539648000"; 
   d="scan'208";a="9499733"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 12:04:46 +0000
Received: from [10.47.79.134] ([10.47.79.134])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id x0HC4k9g029713
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jan 2019 12:04:46 GMT
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
From:   =?UTF-8?Q?Per_Waag=c3=b8?= <pwaago@cisco.com>
Subject: Disconnection of signaling channel after AVDTP close
Message-ID: <e66fded8-91ee-6cb9-11be-162dd5c436aa@cisco.com>
Date:   Thu, 17 Jan 2019 13:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.134, [10.47.79.134]
X-Outbound-Node: aer-core-1.cisco.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We have a product that implements an A2DP sink running bluez 5.50. I'm 
try to qualify this product with the Bluetooth SIG using the Profile 
Tuning Suite (PTS), but I am having trouble passing a test that verifies 
reported delay value (A2DP/SNK/SYN/BV-01-C).

In that test, PTS configures an AVDTP stream and verifies the delay 
report, then opens the stream, streams some data and closes the stream. 
This is repeated. The problem seems to be that after the stream is 
closed, bluez immediately also closes the L2CAP signaling channel.

I have pasted the problematic sequence from btmon at the bottom of this 
email, the problem is the last L2CAP Disconnection request.

This was introduced with commit 7ece89b0b6 between version 5.47 and 
5.48. Before that, there was always a one second delay before the 
signaling channel was disconnected,
which was enough for PTS to configure a new stream.

What was the rationale for always disconnecting immediately? Could there 
be circumstances where it would make sense to keep the signaling channel 
open a bit longer? Is there any other way we can force the channel to 
stay open?

Best regards,
Per Waagø

--
 > ACL Data RX: Handle 12 flags 0x02 dlen 7                #329 [hci0] 
48.732441
       Channel: 64 len 3 [PSM 25 mode 0] {chan 0}
       AVDTP: Close (0x08) Command (0x00) type 0x00 label 2 nosp 0
         ACP SEID: 1
< ACL Data TX: Handle 12 flags 0x00 dlen 6                #330 [hci0] 
48.732775
       Channel: 64 len 2 [PSM 25 mode 0] {chan 0}
       AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 2 nosp 0
 > ACL Data RX: Handle 12 flags 0x02 dlen 310              #331 [hci0] 
48.736692
 > ACL Data RX: Handle 12 flags 0x01 dlen 337              #332 [hci0] 
48.771536
       Channel: 65 len 643 [PSM 25 mode 0] {chan 1}
 > ACL Data RX: Handle 12 flags 0x02 dlen 12               #333 [hci0] 
48.771963
       L2CAP: Disconnection Request (0x06) ident 30 len 4
         Destination CID: 65
         Source CID: 65
< ACL Data TX: Handle 12 flags 0x00 dlen 12               #334 [hci0] 
48.772019
       L2CAP: Disconnection Response (0x07) ident 30 len 4
         Destination CID: 65
         Source CID: 65
< ACL Data TX: Handle 12 flags 0x00 dlen 12               #335 [hci0] 
48.772960
       L2CAP: Disconnection Request (0x06) ident 4 len 4
         Destination CID: 64
         Source CID: 64
 > HCI Event: Number of Completed Packets (0x13) plen 5    #336 [hci0] 
48.778131
         Num handles: 1
         Handle: 12
         Count: 2
 > HCI Event: Number of Completed Packets (0x13) plen 5    #337 [hci0] 
48.953264
         Num handles: 1
         Handle: 12
         Count: 1
 > HCI Event: Disconnect Complete (0x05) plen 4            #338 [hci0] 
50.167143
         Status: Success (0x00)
         Handle: 12
         Reason: Remote Device Terminated due to Power Off (0x15)

