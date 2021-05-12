Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91876C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 01:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B076192F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 01:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhELBlW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 21:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhELBlO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 21:41:14 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1777C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 18:36:15 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id j19so4455095vkj.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 18:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GpdyqVa3B+lxuTT8brBcevVG4wUtcG19Sl0+92ZTw8E=;
        b=EbKlFpMXixN3PkW8eDkvOunk/HoqEpex4O2Lmeut3qK6PsTdYN22Y0sf14zOI4pN2V
         TfTvZrqIcqPr6ye4O9+j7Gm3v1kjNv6WfJuV6aa02/YCBBSKQN39AQ1A1jjICxujdSmK
         3JmlrmjV/DIJqqighTOYsIOhUq0jIANIRbK8V3D8MQizZrmmCgXEr3T++R43pVM3/Ona
         ibgz+sXGAc71idUJQ99ir73Sgl5ZURHHj83K23mvB13+WGV0ilJ8of2qZHRd7dOhtQl9
         b1lZLxzLQQ0/nxWeQ89PwFc3eJmLAK9p37x5q5Sj8seAQV7KbXpaCm/kpfhAWR8IuUuX
         enrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GpdyqVa3B+lxuTT8brBcevVG4wUtcG19Sl0+92ZTw8E=;
        b=WhYbpJsKBAFPz4RyXyI35hN0Kr9rA1iVcfz/Ox+fOPRMy8ET/F/rl6Wq3didLLrZ8h
         xKTpTdgL6miD1WLBWsQyB7c/uTZy7g6VQ40MPAXJmYYwh+PSalucEbywBDHV65e2qkLb
         qj2ANTv6uK8gBOQOoyBd68x7aw2T8XITL91fkfbRI991jKaAzn2iKNN6pfCJiPUsVkx1
         5YCWa1xVEXFZCYUKZbdN0CvCWGlFaEz4ru91X4h6uFHuxaRFj4koGzxSJIR1KpUEIEdd
         NM1RrvFsj27WNvOLH7NRzAqcCAnvSWMr/JFL0O2Xyx4mTOzN5fGCuaANS1zFYzbw0vv2
         MVzw==
X-Gm-Message-State: AOAM5339+1cHsUj7ooy7Im9oZauZjh07nTduiA8mT1GagJYPEqcGcDbc
        2aWTdBLp/wuHsleey32d4p0GSjEUU/NVXKL8Z7CgYQk44Z8=
X-Google-Smtp-Source: ABdhPJzag1amPQDlsEaSpqcb9pw/uffWurSOGRl0w27xgMMdY+WoSwuhLl/MguoOc6pKwRaq9cI/gvDryAt6mwWHdZA=
X-Received: by 2002:a1f:9d90:: with SMTP id g138mr26081383vke.2.1620783374378;
 Tue, 11 May 2021 18:36:14 -0700 (PDT)
MIME-Version: 1.0
From:   Patrick Doyle <wpdster@gmail.com>
Date:   Tue, 11 May 2021 21:35:48 -0400
Message-ID: <CAF_dkJD9+0ZXRi6e+9Bsjwo7069zg9fHH4RhaYQf+w-LjNpRwg@mail.gmail.com>
Subject: Help understanding BLE Advertising and Scan Response packets...
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm confused by how Bluez assigns data the to BLE and Scan Response
packets.  In src/advertising.c, in the refresh_legacy_adv() function,
I see the following:


adv_data = generate_adv_data(client, &flags, &adv_data_len);
..
scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);

Looking in generate_adv_data() and generate_scan_rsp(), I see that
they both end with:

return bt_ad_generate(client->data, len);

So, then I look at bt_ad_generate() in src/shared/ad.c and I see code
much like the following:

serialize_service_uuids(ad->service_uuids, adv_data, &pos);
serialize_solicit_uuids(ad->solicit_uuids, adv_data, &pos);
serialize_manuf_data(ad->manufacturer_data, adv_data, &pos);
serialize_service_data(ad->service_data, adv_data, &pos);
serialize_name(ad->name, adv_data, &pos);
serialize_appearance(ad->appearance, adv_data, &pos);
serialize_data(ad->data, adv_data, &pos);

return adv_data;

From inspecting the code, it seems to me that Bluez stuffs the same
data in both the advertising_data packet, and in the scan_repsonse
packet.  This is especially confusing to me because, examining the
packets on the air with a BLE sniffer, that is NOT what I see... but I
can't figure why not.

On a somewhat related note, I have constructed my D-Bus object with
its org.bluez.LEAdvertisement1 interface to specify the data I want in
my BLE peripheral advertising packet, and I overflowed the size of the
advertising_data packet.  I would like to figure out how to indicate
to Bluez that I would like the "service_data" portion of my
advertisement to go into the scan_response packet instead of the
advertising_data packet.  Any tips on how to do that?

Thanks

--wpd
