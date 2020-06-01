Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB8DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 13:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403FD2074B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 13:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cz9v73vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFANHH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:07:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46515 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725847AbgFANHG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 09:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591016824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0laGd52IgFbrpwcJizDebr/s17cCzX73jyqDIb0EbtM=;
        b=cz9v73vF/SFG6rRZmCdP0/JgSdExBz9T5VvFFwcDqokkjzJoPNwPQdY9Tru9UfSl96M3mL
        z4dmhAjXVeILN/YNs9uhrim3npn0WcciKrl5bN4K9pk1d9cP43QIk4gl4cSch7dFYSNJtn
        bggTG7u+B7q2QTPCi1X7N/ULTxHpkh0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-IMln4vssNCe-hNHo3r7Jjg-1; Mon, 01 Jun 2020 09:06:59 -0400
X-MC-Unique: IMln4vssNCe-hNHo3r7Jjg-1
Received: by mail-ej1-f71.google.com with SMTP id qo26so2892981ejb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2020 06:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0laGd52IgFbrpwcJizDebr/s17cCzX73jyqDIb0EbtM=;
        b=J53CFpNuYPc9YWz6YjkXbYxcCic9shPHXR12+BtynNXnSwle4CVk94cvozqHrtlu79
         wWI04hrfK5QwCVaErzP1cLnM+FRdRETWitCtBD+CcjQ2SgofpImByLI46nEKH1OHZpPw
         xQ4cbHZHgtzRRRhgSoj4u9t+9DW1TKd2AGelv0kTzvUh1770bkkSHlClu+6gj2ie0gTe
         3c+JInKLTwJft+f3ndBi+ZB61YjCE6om96GXbK9gqjhSDeRazeBy0wg7PjGTDjADMiv8
         Hvz1Ngfzp6rtfAQoYkq0wFL+9wobnYMCTIb/MwgFkxVBh5WvldP6P4GFF4D870cCIgzq
         NGlA==
X-Gm-Message-State: AOAM533P+FW278BwAsZMXDXpzE8lmXDqAFKpYHfRxfZImaV252XjssZh
        MKe8onKsVwrSCenKSghZRoCnYTxrCABZ48Y5uhogrAGQyX+bOthF8j7zCUkzQ54CMLfuzUciLh0
        Gq/sFxyI84++E9IdA1Zt71u4OwpYW
X-Received: by 2002:a17:906:cecf:: with SMTP id si15mr18553510ejb.164.1591016818292;
        Mon, 01 Jun 2020 06:06:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVtsaSd4VK6OCHrih11juUluAa2cOpsGvmDGgm+5kn0iUOv2TFnbwBMWBpB1+HRjDKA03oKQ==
X-Received: by 2002:a17:906:cecf:: with SMTP id si15mr18553493ejb.164.1591016818057;
        Mon, 01 Jun 2020 06:06:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id b15sm16633630edk.90.2020.06.01.06.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 06:06:57 -0700 (PDT)
Subject: Re: Bluetooth part of RTL8723BS
To:     Tobias Baumann <017623705678@o2online.de>,
        linux-bluetooth@vger.kernel.org
Cc:     alistair@alistair23.me, Larry.Finger@lwfinger.net,
        jwboyer@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <fb9c3d0e-813e-90f6-2492-c7eaaf0b490d@o2online.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <230c11ab-0c1a-f7c0-8b0c-c59ee4c5c49f@redhat.com>
Date:   Mon, 1 Jun 2020 15:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <fb9c3d0e-813e-90f6-2492-c7eaaf0b490d@o2online.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tobias,

On 6/1/20 8:18 AM, Tobias Baumann wrote:
> REF: Linux Firmware commit e6b9001e91110c654573b8f8e2db6155d10d3b57 <https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/rtl_bt?id=e6b9001e91110c654573b8f8e2db6155d10d3b57>
> 
> REF: rtl_bt: Add firmware and configuration files for the Bluetooth part of RTL8723BS
> 
> 
> Hello Community
> 
> Hardware :
>   M8S ARM S812 RTL8723BS
> ODIS Wintab8 Intel Atom RTL8723BS
> 
> 
> I'm working together with Martin (xdarklight) to get the new kernel working for older Android Tv boxes with ARM chipset (Amlogic s802 - Amlogic S812; Ubuntu , Debian ).
> 
> After Martin has successfully integrated the patch for SDIO controller . I got my internal Wlan Adapter (RTL8723BS) working.
> 
> We are now also activating the Bluetooth part. But we encountered the problem with the config file.  Hans was nice enough to extract the RTL8723BS firmware file from the Realtek driver file.
> 
> As Hans has already written there are almost no differences in the tablet area with config file, I can only confirm this after looking at different driver files (Realtek bluetooth UART).
> 
> I found only 4 ACPI ID : once the already mentioned OBDA:8723 which is the default version ,one for ACER tablet OBDA:0623 and the BESTbuy ( Chuwi Hi10 ? ) OBDA:0242 ; in the driver version of 2015/2016 there were still 2 config files available(standart and ACER) in the version 2017 only ONE so that also the Default, ACER and BESTbuy use the same config files.
> 
> I myself and Martin are currently using the two files from the firmware repro successfully.
> 
> !! So I ask you to remove the ACPI ID from the file and rename the file to RTL8723b_config.bin ; furthermore I ask you to set the reference when loading the RTL8723BS Blueooth driver to the RTL8723b_firmware.bin so that it corresponds to the standard file name. !!!!

We cannot simply remove the ACPI-id from the filename the driver is looking for,
if we do that then existing installs with the current linux-firmware version which
has the rtl8723bs_config-OBDA8723.bin file will stop working as they now try to
load the non existing rtl8723bs_config.bin file.

If you believe that having a single config file will work for all device-tree based
platforms, then you can modify the bluetooth driver to load rtl8723bs_config.bin in
the device-tree case.

The linux-firmware installation bits allow adding links at installation time,
so for the linux-firmware side you can then have the installation create a symlink
by adding the symlink info to the WHENCE file in the linux-firmware repository, see
some of the existing "Link:" entries already present in that file.

Regards,

Hans

