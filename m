Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D51C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 12:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4902223BC7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 12:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgLIM7U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 07:59:20 -0500
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:51960 "EHLO
        7.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbgLIM7U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 07:59:20 -0500
X-Greylist: delayed 4601 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 07:59:20 EST
Received: from player694.ha.ovh.net (unknown [10.109.146.1])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 72EFD26FB85
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Dec 2020 12:41:58 +0100 (CET)
Received: from labapart.com (host-88-217-174-125.customer.m-online.net [88.217.174.125])
        (Authenticated sender: olivier@labapart.com)
        by player694.ha.ovh.net (Postfix) with ESMTPSA id 207A118EA271D
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Dec 2020 11:41:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R002bf34f9ec-c039-4b29-a749-55ee3851e5a8,
                    1AC18DC7F9FA5926FE91FF6DADBB0C28C81C5654) smtp.auth=olivier@labapart.com
X-OVh-ClientIp: 88.217.174.125
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Olivier MARTIN <olivier@labapart.com>
Subject: Accessing RSSI during BLE connection through Bluez DBUS API
Message-ID: <aa77c035-d2aa-f227-bfcd-358b5f063b21@labapart.com>
Date:   Wed, 9 Dec 2020 12:41:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Ovh-Tracer-Id: 13260286153969069644
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudejkedgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertddtfeejnecuhfhrohhmpefqlhhivhhivghrucfoteftvffkpfcuoeholhhivhhivghrsehlrggsrghprghrthdrtghomheqnecuggftrfgrthhtvghrnhephedtjefgtdfhhfegtedvffeutedtjedtleduheehhfegleduheffieegiefflefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkeekrddvudejrddujeegrdduvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpeholhhivhhivghrsehlrggsrghprghrthdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Bluez members,

I was looking a accessing RSSI during a BLE connection using Bluez DBUS API.

As mentioned in the documentation 
(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/device-api.txt#n230), 
RSSI is only exposed during inquiry or advertising.
I confirmed that trying to access it while in connection does not work.

I managed to access it while in connection using the Bluetooth 
Management API 
(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt) 
but I need root access.

So my question, would it be possible to extend Bluez DBUS API to expose 
RSSI during BLE connection? Or is there any limitation?
If there is no limitation, I do not mind to give a try extending bluez 
to add this support.

Thanks,
Olivier

