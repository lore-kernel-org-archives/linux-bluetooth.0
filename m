Return-Path: <SRS0=IUpk=4A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C8C352A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 10:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D90A206D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 10:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uy03HPfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgBLKhH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:37:07 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:42928 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLKhG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Feb 2020 05:37:06 -0500
Received: by mail-vs1-f45.google.com with SMTP id b79so811231vsd.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2020 02:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SoA7AEf5bmw85UWXzZ+k/ae3lNpgl5yFbyqoRAnSr4E=;
        b=uy03HPfAxICb/CJODJIaJAQ8il+zj11rCc0JDHIpjo4d6xFIiRi28yw1uUUK747FO0
         MACN0VfaBarvRkU/axD+TCE7fxN0W8RRSf9C0PCsxjl5yrI4uWXnaNloM+ZlLkqs7vAQ
         pTiIbX3mXes18U79ExgCpc108p4LEVf3QLBgyy83aaW4iGG3pvr+iBu0a7NBn6sz5mCs
         dM87nfW9dXTsf6aVJUdEB7apq4WANgmvSu+9CHRot2YwokTFHHapJJPOhte+JsmZEODU
         oTH4KTPqgUq5coDPhXcS71x1dzSEE5WJdQVTS+R7jxfHOCWj/kbzuG4aMvEW7srTHL3U
         PrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SoA7AEf5bmw85UWXzZ+k/ae3lNpgl5yFbyqoRAnSr4E=;
        b=BdoTga5xMtbErYjPvpkB88roDJChmdR8BMsuJkDDM6c16+VR3hhW3kqpYB63bqAh+d
         qyDWSxQ6a7LZnhH/WkBBk1sUcf7zQn6SO2skYu8GAj+hQt7tV2kHGIdt+0yhFbZkmyvM
         943fFjHOgBzAUUnOiNHAzNjc/5oUtw/VVOGVXC/dwnuT+MVnEJ/cfE7omiOgWEdd/tzQ
         hDJVKOI1oFgvGPnOonGb/N6nkABaWxk4yGPoe3Q3WCUYGyZqSVT19qCmSGfKeV2as+EZ
         MEKwPhW6Nk/4EsaaTgsXamD52ELqcu0fWcFyy7vHyVJRT1uH2TFAI1CTcKvgTvzvxSnz
         2KRg==
X-Gm-Message-State: APjAAAWUU98avIJtyteqxpxVjBIA3EH8aZHACSFci9uz4Fb5PBfCFtCV
        SZ3QNCTu8bJdxe216E/zrRxOb3gRKfQ5HHy/IJ8r4Ue3
X-Google-Smtp-Source: APXvYqxLzVziiLL2emarhOUhguE7Uw6SFjtFHKYRx5dD2+c+kbqPeK5ceBzfWrpGQcACJgqYY6uK0vh6p23qmBwtlso=
X-Received: by 2002:a67:ed93:: with SMTP id d19mr11984142vsp.60.1581503825328;
 Wed, 12 Feb 2020 02:37:05 -0800 (PST)
MIME-Version: 1.0
From:   Marcin Kozlowski <marcinguy@gmail.com>
Date:   Wed, 12 Feb 2020 11:36:54 +0100
Message-ID: <CAP6wrbWGcAh2yjwWQZvjjVReH3gMFLK9yPbp20QvqBDAdZSBgw@mail.gmail.com>
Subject: GAP ACL L2CAP Data Packets fragmentation over HCI in Android Bluetooth
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi list,

Hope is ok to ask here. Can somebody give some insight when this can
happen: https://android.googlesource.com/platform/system/bt/+/3cb7149d8fed2d7d77ceaa95bf845224c4db3baf/hci/src/packet_fragmenter.cc#220

Tried sending fragmented GAP ACL L2CAP packets via HCI, but I cannot
imagine how this condition (in packet_fragmenter.cc#220) can be met:

https://stackoverflow.com/questions/60116790/sending-gap-acl-l2cap-data-packets

Anybody knows? Can shed some more light on this?

Thanks,
