Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C7C83000
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096C0206C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 14:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCOd1/VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgD1Oh7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:37:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726868AbgD1Oh7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 10:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588084677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wWcgfxBQPCOubSMBYwNbBlHyf+/b+HUAXLwiPseogw=;
        b=OCOd1/VT9bKoNYKOqLWp7Z1+Nabn3myQTUJyuqFd6oz0+d9rm+LKFsLrODA28XBcKrRl6Y
        V8EM9B4jSSnBX5nVG/B5UNB/YnY6NbbWapDLjixVzFfa0z99AbrpUIWVquB80vO72wdunu
        KW2+wXHhU2weBn6awt2jfibsQ2J5kxI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-MxZDBNFRMlGBotfHE_Tpwg-1; Tue, 28 Apr 2020 10:37:55 -0400
X-MC-Unique: MxZDBNFRMlGBotfHE_Tpwg-1
Received: by mail-wm1-f71.google.com with SMTP id d134so1257567wmd.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 07:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2wWcgfxBQPCOubSMBYwNbBlHyf+/b+HUAXLwiPseogw=;
        b=TaRdfQrFwxOgEkeVCOvvxbueEDc5ZTYC4QSGQHcaMQOaH4I10Y8F8dfsVyBlFKRtqc
         J62y8XNGR4Qyvl5AqxUpkvBx+G6cboYwekJLKgxLi1uYOiSJY2Q/JVnD6+R+EPlLIrTw
         HLyay3phr2jcLu2Wv2IXbUjKfeCXHtOD6c5ZxfwcAnkDJM9zHDx8vbfEy23sTaV3n8Pj
         lUzbGVpv3qk9w9tn7ziOahYoq3F97R0mSrlk0OWOXD/TUzb3EuKIYXzJJPmXlNw1IF9e
         YWUuPO2jir7nQApZOnlyXSUvtBXNgSQQulzJcyHPg5s9VvTcAoDAibKCi/CHdgT8Bhq/
         xdFw==
X-Gm-Message-State: AGi0PuaT3etmq6eNTBPi5On82IhM8qT5O+RG8chdH92gClELXPbRM0Rg
        pKQLp8ke7xW3i38UZ4LtKF4hkl4+m4n69bTeb9bkA0JxCWDAkaGh7OPdQ0Kg3SQTJuZ6Qr1pCTA
        q18iZcFA49i6Ex6tgn+M2V91rUvoC
X-Received: by 2002:adf:e450:: with SMTP id t16mr36103482wrm.301.1588084674430;
        Tue, 28 Apr 2020 07:37:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJvko8yesIRqMiDpUVNHSXLnE4DZQKgTIDYgk/QUubqpFFWQNEmV+xxtOMoIu1gw07kinjp0Q==
X-Received: by 2002:adf:e450:: with SMTP id t16mr36103465wrm.301.1588084674234;
        Tue, 28 Apr 2020 07:37:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p190sm3623306wmp.38.2020.04.28.07.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:37:53 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: btbcm: Do not free IRQ on close if we did not
 request it
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20200427145414.121700-1-hdegoede@redhat.com>
 <F764A836-9722-4192-AEB8-551DE080F175@holtmann.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aeba5b72-3d66-7822-8b09-54cf35a6e2de@redhat.com>
Date:   Tue, 28 Apr 2020 16:37:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <F764A836-9722-4192-AEB8-551DE080F175@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 4/28/20 11:39 AM, Marcel Holtmann wrote:
> Hi Hans,
> 
>> When the patch-ram is missing the hci_bcm code does not request the
>> IRQ, in this case we should not try to free it from bcm_close()
>>
>> This fixes the following WARN statements + backtraces:
>> [  332.670662] WARNING: CPU: 3 PID: 4743 at kernel/irq/devres.c:143 devm_free_irq+0x45/0x50
>> [  332.670882] Trying to free already-free IRQ 44
>> [  332.670891] WARNING: CPU: 3 PID: 4743 at kernel/irq/manage.c:1718 free_irq+0x1f4/0x390
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> drivers/bluetooth/hci_bcm.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> the patch doesn’t apply cleanly against bluetooth-next tree. Can you send a revised one. Thanks.

So I looked into rebasing the patch and it did not apply because
another (almost identical) fix for the issue has already landed
in bluetooth-next:

d5d0c62437c0 ("Bluetooth: hci_bcm: fix freeing not-requested IRQ")

So my version of this fix (this patch) can be dropped.

It would be good if this straight forward fix can be send to Linus
for one of the upcoming 5.7-rc# releases.

Regards,

Hans

