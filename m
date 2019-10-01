Return-Path: <SRS0=34D5=X2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D40ECE58A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB0421783
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 17:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=einfach.org header.i=@einfach.org header.b="PxM7j3sB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfJARAw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:00:52 -0400
Received: from postler.einfach.org ([5.9.2.179]:41322 "EHLO
        postler.einfach.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbfJAQkg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Oct 2019 12:40:36 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Oct 2019 12:40:35 EDT
Received: from [192.168.5.9] (unknown [83.55.205.201])
        by postler.einfach.org (Postfix) with ESMTPSA id 6132A2412
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2019 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=einfach.org; s=mail;
        t=1569947545; bh=2lPPnnu4rQ8ZkqTNX6rAz4Cfq7L0JZIDcGIdRcCJAyk=;
        h=To:From:Subject:Date;
        b=PxM7j3sBUtmFCB/3MKjv7JuVfJqUEh/G5s9w3zg3YQNYH9wVCNbuPcNCDRqInsCBm
         g3bJur2ay/y8JjEmWkGAoPyDYzwC+4kYQWxDzL02yWePjaE6cavKud464/7+b2u+DC
         MRvaACqegjjrTrGtSN/Y1Oqmv5PeJhahG1kFcgtM=
To:     linux-bluetooth@vger.kernel.org
From:   Bruno Randolf <br1@einfach.org>
Subject: bluetoothd: Please don't filter UUIDs
Openpgp: preference=signencrypt
Autocrypt: addr=br1@einfach.org; prefer-encrypt=mutual; keydata=
 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
 kcSK3qeB7qKuAXopxt5uEFNOKZeKF/UQlKrr
Message-ID: <a04053d3-6165-5dfa-932c-5a93d2bd1358@einfach.org>
Date:   Tue, 1 Oct 2019 17:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11 (postler.einfach.org [0.0.0.0]); Tue, 01 Oct 2019 16:32:25 +0000 (UTC)
X-Virus-Scanned: clamav-milter 0.98.7 at bced1da0f74a
X-Virus-Status: Clean
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello All,

I am a developer using bluez via D-Bus to access GATT services and
characteristics [1] and I would like to argue that bluez should not
filter UUIDs of characteristics it handles by internal plugins.

I recently came across this with the battery service (BAS). Our BLE
device exports it, I can read it on Android, iOS and from other devices,
but reading it from Linux is impossible. The UUID doesn't even show up
in the list of characteristics! It took me a while to figure out, that
it is filtered out and that you are supposed to read it via a different
API on D-Bus [2].

It surely makes sense to provide this more generic API, but I'd argue
that all services and characteristics should be available via the normal
GATT-based API using org.bluez.GattCharacteristic1 as well.

One of my clients, for example, uses Linux/bluez as an interface for
Server-based reading and writing of GATT characteristics of several
managed devices. So I can read all those UUIDs, but why not the battery
level? What happens when Bluez learns other GATT services, will their
characteristics then also disappear? I think there is a strong argument
for maintaining a generic API for GATT reading/writing characteristics
independently.

I made the following change to the bluetoothd code to get access again
to all UUIDs, and I would like you to consider to include it upstream to
enable us to access all characteristics via the normal GATT API:

--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2006,9 +2006,6 @@ static void export_service(struct
gatt_db_attribute *attr, void *user_data)
        struct btd_gatt_client *client = user_data;
        struct service *service;

-       if (gatt_db_service_get_claimed(attr))
-               return;
-
        service = service_create(attr, client);
        if (!service)
                return;

Thank you,
bruno


[1] I published parts of that as an open source library:
https://github.com/infsoft-locaware/blzlib

[2]
https://stackoverflow.com/questions/49078659/check-battery-level-of-connected-bluetooth-device-on-linux


