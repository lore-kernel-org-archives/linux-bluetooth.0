Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0105CDB474
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 18:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjJQSNO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Oct 2023 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjJQSNN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Oct 2023 14:13:13 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 11:13:12 PDT
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net (p3plsmtpa12-05.prod.phx3.secureserver.net [68.178.252.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A02793
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Oct 2023 11:13:12 -0700 (PDT)
Received: from [192.168.0.7] ([136.62.61.27])
        by :SMTPAUTH: with ESMTPSA
        id soWuqmQogm7Z7soWvqvE8J; Tue, 17 Oct 2023 11:10:57 -0700
X-CMAE-Analysis: v=2.4 cv=cotd0X0i c=1 sm=1 tr=0 ts=652ece31
 a=BGXmWvXU9Wd9CvcTTPvfXQ==:117 a=BGXmWvXU9Wd9CvcTTPvfXQ==:17
 a=IkcTkHD0fZMA:10 a=FE-PtrOHSPgalcmjdmkA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-SECURESERVER-ACCT: ethan@braneaudio.com
Message-ID: <b7c90f4c-8868-42ea-86c0-3f9f2b0f27e0@braneaudio.com>
Date:   Tue, 17 Oct 2023 13:10:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     linux-bluetooth@vger.kernel.org
Content-Language: en-US
From:   Ethan White <ethan@braneaudio.com>
Subject: a2dp delay reporting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfApuyMDxtB36rR5FkaGtEueREaXud0KYFX8T2hXv1EmkOxcJ/WfxGCOCI6e9Hl/nL+AEPluFJzzdyN5E/5cCzFL3eKrZ/boALhrqL3HEt3F39taOAzOa
 fHmTUll8mm79GWd/MvYVFUqhlWCDccSfU3iNKo4rX/mj/zEHjYdkJpYuP/Swqw1eTVjhg4ilP4gz2MRwpoW6lDeJwRCSj1DvoDM=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

How do I inform Bluez of my a2dp transport delay?  The media-api 
document shows a Delay property for the MediaTransport1 interface but 
attempts at writing this property yield the following error:

org.freedesktop.DBus.Error.PropertyReadOnly: Property 'Delay' is not 
writable


Reviewing profiles/audio/transport.c a2dp_properties (Bluez 5.70) I find 
that the delay property does not have a set function:

line 846: { "Delay", "q", get_delay_reporting, NULL, 
delay_reporting_exists },


What am I missing here?  How an I supposed to inform the a2dp source of 
my playback delay?  Thanks for any help.

Regards,
Ethan
