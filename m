Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FEBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 19:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKITND (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiKITNB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 14:13:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E95240BC
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 11:12:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1959609wma.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 11:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgvysWE2zj8Wvl7SDX+PnlJIdSv6aFmqIWg6JBOupCs=;
        b=BpR33m5j07xelTHGmo11GZSZ6XfsmNQr+TcbaewDkbeReRtqGKg3k8OkUt7PtGYTks
         J2ANdwgw0coUzcBQ+0xSBxwWCupgMTLal4Js0AgAEeCZCjLh9oIxX31I1zHa/gPLrf+9
         JsXSWav7DfOLNx8caKYpBUk+uhWurxIp0bV+zyIjyQo+P9bCrc0A1ATq1iJ2hcX2PqWY
         kY8uor7EDNwdY2mNCUPoFNlgM8+9jyNIjwCPmnZywXMTuBYWr0Sl4D5p7jphikXCiQyh
         TzuqQSjN6F73/dGbztvG5CL76YERmdsZ3D5kDGfs43O8aFpVK/l1fa/5X73bLDvWvAF3
         iaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgvysWE2zj8Wvl7SDX+PnlJIdSv6aFmqIWg6JBOupCs=;
        b=7Ck0fdfWwkbSPAL2dDUxhTXWvvEkAaX2MCU5rlu4RC7ALEZeUkA4zi7j93oeG7wfdw
         XggqqKLHt1rSDsdStybIwoX2J4zFtpfx69Fz7pDcwoyJEQ+AQ5pfJAZjvHhNExkEDP3T
         xCs8VFD94uQj3b3pwHma0XhCxkQ4XTSuFrhRFW7xoCbD4W+wG15A3PJ4wq8bQQ3+xJs5
         yBBCheCjuVbE9kYmJUNJwRF5tY+QosTqV41tLOyvOjK1+hW/EQUJnfI+sN5dyyDyoqx4
         iGbyZK+pHpMWXSkXaNzZebwT/QdSJWbEv01tDy1z+hJGXszdmLkw2023IBAWTK4NcgBy
         0t8w==
X-Gm-Message-State: ANoB5pmc9Rd02J/AghlbrX+0LZcHz8YM89XywX29eCfOvrgBxig0+y6t
        y5jnSw53FWfSdxIKU/E7FJI=
X-Google-Smtp-Source: AA0mqf68kU0DW/muGgsDNMcvGxeVHaLxtYuq5FB79fkr6IayjUL2hl0YHVYcPqKccu/K9CP7VUc76w==
X-Received: by 2002:a05:600c:4a11:b0:3cf:b128:39ad with SMTP id c17-20020a05600c4a1100b003cfb12839admr9769878wmp.127.1668021177136;
        Wed, 09 Nov 2022 11:12:57 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id q10-20020adff94a000000b0022e035a4e93sm13614897wrr.87.2022.11.09.11.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 11:12:56 -0800 (PST)
Message-ID: <76cd4547-a68d-9d52-1d87-8299e29406ff@gmail.com>
Date:   Wed, 9 Nov 2022 20:12:52 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
From:   Swyter <swyterzone@gmail.com>
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
To:     luiz.dentz@gmail.com
References: <CABBYNZKWc13qGDOyhPZ9wZcTaK+Wg0LUycsKX58w7wEjTaGS=A@mail.gmail.com>
Content-Language: en-US
Cc:     Jack <ostroffjh@users.sourceforge.net>,
        linux-bluetooth@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Hans de Goede <hdegoede@redhat.com>, swyterzone@gmail.com
In-Reply-To: <CABBYNZKWc13qGDOyhPZ9wZcTaK+Wg0LUycsKX58w7wEjTaGS=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>> Correct hci_set_event_mask_page_2_sync() event mask
>> git bisect good 0feb8af0275d196a29e321bedc15319673923cb6
>> # bad: [1172c59f451f524a14bac5e7b047781883dfe441] Bluetooth: btusb:
>> Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
>> git bisect bad 1172c59f451f524a14bac5e7b047781883dfe441
>> # bad: [766ae2422b4312a73510ebee9266bc23b466fbbb] Bluetooth: hci_sync:
>> Check LMP feature bit instead of quirk
>> git bisect bad 766ae2422b4312a73510ebee9266bc23b466fbbb
>> # first bad commit: [766ae2422b4312a73510ebee9266bc23b466fbbb]
>> Bluetooth: hci_sync: Check LMP feature bit instead of quirk
>>
>> And 766ae2422b4312a73510ebee9266bc23b466fbbb does make sense as a
>> likely culprit.
> 
> Looks like we will need to reintroduce the quirk then since it appears
> the LMP feature bit is probably set in those controllers but the
> command doesn't work.

It is. I already mentioned it in the Bugzilla thread and that's
what the patch series I submitted the other day fixes:

> Bluetooth: btusb: Fix Chinese CSR dongles again by re-adding ERR_DATA_REPORTING quirk
> https://patchwork.kernel.org/project/bluetooth/patch/20221029202454.25651-1-swyterzone@gmail.com/

Hans de Goede gave it a Reviewed-by, but it has been ignored even since.

Keep in mind that I'm an occasional contributor and I can barely use a mailing list,
but this goes back to the patch that Zijun Hu sent back in July and I was pinged.


I took a look back then, it looked suspect, but I imagined you guys knew what you were
doing. Fast-forward three months and the code arrives at most mainstream distros.

Every single cheap Bluetooth dongle on Earth broke again. Just like that.

https://bugzilla.kernel.org/show_bug.cgi?id=60824#c242

I just came across this thread archive by pure chance, this isn't very user friendly.
Please CC me if you talk about this, I'm not subscribed to any list.
