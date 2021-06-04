Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520F4C4743D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 19:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3550B611ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFDTO2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 15:14:28 -0400
Received: from rcloudmail.hostconnection.net ([38.96.19.98]:6319 "EHLO
        rcloudmail.hostconnection.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbhFDTO1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 15:14:27 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 15:14:27 EDT
X-SmarterMail-Authenticated-As: jay.foster@systech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=systech.com; s=key;
        h=Content-Language:Content-Transfer-Encoding:Content-Type
          :MIME-Version:User-Agent:Date:Message-ID:Organization:Subject
          :From:To:Reply-To:Received;
        bh=XOkaV3Qaw4EYN+kfoiLYvyq3LsuSf+AMK0UsYBAjq3E=;
        b=XwvbSaCPFYKvWu1UC7NCsjH/kL0bb0DEv8g1OWCur8RE0A5ktFM/u1zYJDzsVoeQn
          ACHDCVESlcs2R4YOf2gaK8HX+ucd0iTrMPsT4ZHiC4cOaDMhQzHFkjLrENjUmbO8a
          swFzBKxTxe1KzD3FoabyZSWC7/e38xsI4wy4BlHUI=
Received: from [172.16.4.182] (wsip-70-167-11-34.sd.sd.cox.net [70.167.11.34]) by rcloudmail.hostconnection.net with SMTP
        (version=Tls12
        cipher=Aes256 bits=256);
   Fri, 4 Jun 2021 12:07:02 -0700
Reply-To: jay@systech.com
To:     linux-bluetooth@vger.kernel.org
From:   Jay Foster <jay@systech.com>
Subject: Bluez Socket File Descriptor Leak
Organization: Systech Corporation
Message-ID: <749228e2-4d49-83ef-06f0-2db0532beb93@systech.com>
Date:   Fri, 4 Jun 2021 12:06:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Exim-Id: 749228e2-4d49-83ef-06f0-2db0532beb93
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am experiencing an odd problem with PAN networking.  I have PAN 
networking setup in NAP role.  Another machine makes a BNEP connection 
and performs network activity, then disconnects the BNEP connection.  
This repeats periodically.  This works just fine, except after a while, 
the BNEP connection fails with the following in the log.

May  4 13:08:02 (none) daemon.debug bluetoothd[1373]: 
profiles/network/server.c:confirm_event() BNEP: incoming connect from 
B8:27:EB:E5:35:9B
May  4 13:08:03 (none) daemon.err bluetoothd[1373]: Can't add bnep0 to 
the bridge br1: Too many open files(24)

ls /proc/`pidof bluetoothd`/fd shows about 1000 open file descriptors 
(sockets mostly).  This looks like some kind of resource (file 
descriptor) leak.

Has anyone experienced this before?  I don't know if it is in the 
bluetoothd application or one if the libraries (glib2, dbus) it links 
with.  Happens with bluez 5.19 and 5.52.

Jay

