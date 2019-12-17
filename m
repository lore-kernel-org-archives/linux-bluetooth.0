Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7075FC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 12:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3374B206A5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 12:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="krm15xqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLQM7j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:59:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:48109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLQM7j (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 07:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576587567;
        bh=2HkFeiZwUwI8dkycGVvfX0tWo0t5jmvhNrEkAT95D7Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=krm15xqHsYEogj2zU9x5pN7IGkkGJbURAuJw0ZIvbB3AwSXilaZqdhuSIUU7GWClA
         AYD4yfJlYtcE4MSmyY8ju1eQPzmWvHQfVCPTsPjI2HT28NZx7jBLcbDcfMoMQFLVZx
         UhQwQ8gzsTwTBEqRF7wrXQb7b9lTRUE21eN/of5s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.176] ([37.4.249.154]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hVB-1id3aI2Qa1-004lVV; Tue, 17
 Dec 2019 13:59:27 +0100
Subject: Re: [PATCH V4 01/10] bluetooth: hci_bcm: Fix RTS handling during
 startup
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
 <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
 <61789264-a4c2-ac85-9d74-d186213ec70a@gmx.net>
 <20191216132509.ofqcdpwxsd7324ql@core.my.home>
 <6f05f4d8-fa84-ae81-ac4f-00ab12fabeea@gmx.net>
Message-ID: <5bbda434-d0e4-7162-8634-9900a4fa9148@gmx.net>
Date:   Tue, 17 Dec 2019 13:59:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6f05f4d8-fa84-ae81-ac4f-00ab12fabeea@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:J/+nhngNsiRpXFva8LhRKZOD3EwX4sty6zgKpJk4HznZvWttOsm
 pg38SqOn6JvtHccgD/eEeBbTZpIaPNZP3x87zozi6Z9ONPXxncLRdf9XhnI5pwAUM0Mb0Wc
 z9IFVNHrh5tI4v3dWmQr8AO1q79vn9dtdIfPtRfjniT33D1HCqZ/guQgdTPFnToxvzmNXv7
 WBfGdfYM0rgoeBW+l719A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qKCYXvb1phE=:6j6FxufvYMfhGTAmdw6I4H
 0KpswJSIboPCVLdJzdz3YKdXLdu1a5diSG0iqFDH8VqmJnAt50BAcFZDtCtk3NMp8u828IZuo
 xqtpeLbTXCnDLCPo1RerRzmV8UxMvdOEl3HiEEu5geuGSzBEMh9wfTihO+5iZOuEu2MpwK8JE
 1WKTBhQ64wpvoQ8+hwzAvovwnOh8yv2N8X9TO9WP2olCnBw9FC9vL1T+7QYfB2RRjsx/pG8A5
 qtCwgOkiFwkgBQPjFc11nIVK3juEMS/s6N16UlHTQSjlhEVhoGpO+t2emauIDVEEpR8nE1Aoh
 s5Jd1+bd7nsCJacbBpQKyO11rLU9dAwjV2KWkAWiHZoa/fc9T27UQzXyoDLKblV4PYZh62d03
 lyP7ok5Ry6ZMyQYHyVz8JNUDuHGC88vwYrdV57JVLTWlfhviwF2BI6/RQky+CPgiZegRQRTRW
 nVsUKizHSWx0NsiqSdgTg5IilDxMSB6A2fmG/jCLyilAJk1+x4SP52tDmBuD3bSHHq5RldPWj
 Gu2NkKJ6+tmENI3r6WK7jDEjXvIY/tihG3I15XcOzALDQ7RaTwtOk1XXYYn898ltR0fSNhFcT
 5UyCI4e9ZedcZHv3by2cJR2TIgmNEHFdi/oJAO5l6qQLITYlPbl6/tUwSdTO4XBA50Q571R8x
 dpt0IBldQ0NXF8OzxpBsTPlydNrLJyjBB0xDDg6qkG3pXkLMLpLrOq0hi6dyzuSGbXm4FpCO3
 tEt74TL/3JwWdimfYHmjus/EbAYb0FM/abip0zT4SQh+b3eBFuHPtWc0pKYgOXEa9wp4j5PyF
 4yqiQ9F/ftzcl0ghzxxaSamYT4+lLr6O4rGqoe5+Q9xePBKGqtdveLeoor1/Xbqjw6MdNy1po
 gvFpb6pr0Nr+cvvK876r/mC26aSIhHpmN8uNSpgJ2Ad8F/wPI1s/jhA68U/Y61xBw3gdvu5G+
 80PLhnUakDZ9X73QfBuuTjvZQfBgg7Vtpp2VrKWTO2OpZQr8P50OS1f4xdeQm1B4LRPEB21Rw
 jJnA2ivOlrF2B/M28yIRr/8F/PFbuRiaMkyY/ikJs8gLLW7H/ZNHzpJi02HrRbVq3sJW9/obG
 jWq0GSWoRbzJfGvwA75RfDNJEfriBlcViruHqMTBzrYyJUcSc9T7rN4ejSGfbYGqKVILzqUSJ
 Ya6MfWzQ1hcxsKeAvjw6444cljAR1DDF2SipO8qSFSINnPlX5N87uBX8vAJxcakNkncReRXQS
 Ct0ZqFxIjqFXU0ULu9O+VTHZpkNxKW0DJMDUTiSzsYu8HnSBLwVwfT79BYpA=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ondrej,

Am 16.12.19 um 19:28 schrieb Stefan Wahren:
> Hi Ondrej,
>
> Am 16.12.19 um 14:25 schrieb Ond=C5=99ej Jirman:
>>
>> Meanwhile i will play with modifications of original patch on the
>> Raspberry Pi 4 and come back to you.

could you please test this patch [2] on top of current bluetooth-next?

This is the solution in case we don't find the cause of this issue. I
don't prefer this one, because this is next stuff and we need to revert
the offending patch for Linux 5.5.

[2] - https://gist.github.com/lategoodbye/3d39e4b07d401f07fa9f9c2f11e1f17d

>
> Thanks
> Stefan
>
> [1] -
> http://www.sparklan.com/p2-products-detail.php?PKey=3D4984FVukjcpylzifQi=
M-TGFE-IKXD--BCwf4P15KfrU&AP6256
>
