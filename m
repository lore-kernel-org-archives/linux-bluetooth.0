Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jul 2022 20:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiGGU3w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiGGU3v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jul 2022 16:29:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831D18359
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jul 2022 13:29:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e12so33064249lfr.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jul 2022 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdZJ/yhMGlSlA8iHn3Uhn3zlOQ94GKVsXmFUHo4Ri3A=;
        b=SbfnQXTf2i8vBS/r86z6z6+ptUQo5EjkMDHf6r/sFef27fpjYUSE2zapXyEcwhiyzO
         iZpD7rpwnJj/o5zhxFRaj4bYMir9/kw0otvV4kXNfAcwRLFMBGVBPEr822B6GwAzo0xN
         NNOijPoQx0xf4rEdHM0yKNtxYLybWNIXI4sLXznUUfPIBW87U/5DfPZF/0AXgrUmQDf7
         8CETyShPYTsYlViu/PFhmRcYG8dx+ozeRtiPY7c1vbZcBINGDPJnNsDwaLiMyiDvT5CW
         U0/ZjPeKkaXOtxA2vpBNXcjyiVRGem2dtPFzSY63igSdzS/D77OtzqYaCqpqme/HG8B5
         DbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdZJ/yhMGlSlA8iHn3Uhn3zlOQ94GKVsXmFUHo4Ri3A=;
        b=4bvC1f2Vlk/OqAMietz4R7ac+ENrvV5qeiMaEKBAjsbqmoolXyCa3pyPMrHcmSBcIq
         W7eowQ+/mqnpoZjs3mjsfB82rk/1VGiSwXQfdNcF/gM4v3VPQrq8/Y4S4mjvhWcVcCTO
         QwBTffzLltjzrUcrCPVDuNbWYRGeyEywMd+Im0ZTLDRfgIzbQpa827q4PGCoMHwE7SAP
         +n/SlxXIgpJmJpGc/SzVUJBoFZ8BgLjXbKMxdjDqTosRmnJda9LC8Hq5RqU0TD70dGvI
         X/0MQBd8flKYp2aw3I+a1hrVmb2hx9BFR0fT2JidcK15SGw6wzq0b1XJ05h7eEZaVMxR
         2Wcw==
X-Gm-Message-State: AJIora8yuGiiuKQt01K7TCHXwbVkh5dtb5AMi4E5eBrU2/ag0AmArPY5
        etFC+4UL1M9ANjB0+Vz26tPFW9Mj/R1F6sSYMISD0wmz
X-Google-Smtp-Source: AGRyM1ucYkM1Q/g9M8EopVWMIlzxiQtEn7qCzgHd5O8RBf0NtJ/LmnakmuazF1nik6JAG6N2Jt4nDwQXLSAcxs1xFYQ=
X-Received: by 2002:a05:6512:3b9f:b0:483:9ecc:6740 with SMTP id
 g31-20020a0565123b9f00b004839ecc6740mr10969554lfv.57.1657225788719; Thu, 07
 Jul 2022 13:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755B252BAE811BDFE22E3F7FE809@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <SJ0PR13MB5755BDD8A189504972CCAF8DFE809@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB5755BDD8A189504972CCAF8DFE809@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 Jul 2022 13:29:37 -0700
Message-ID: <CABBYNZ+1+z++f-uDJ+AHpF1swwVBigqRe4jUTL55GUa0o1tfvg@mail.gmail.com>
Subject: Re: [BUG] Extended Scan Hangs
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Wed, Jul 6, 2022 at 3:56 PM John Klug <John.Klug@multitech.com> wrote:
>
> I was running btmon through pcat to avoid running out of space on the device.  I think this was causing packets to be cut off midstream at the end.
>
> Here is the btmon output when turning scan off:
>
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x0010
>             Props: 0x0010
>               Use legacy advertising PDUs
>             Data status: Complete
>           Legacy PDU Type: ADV_NONCONN_IND (0x0010)
>           Address type: Random (0x01)
>           Address: 06:62:7D:C6:64:48 (Non-Resolvable)
>           Primary PHY: LE 1M
>           Secondary PHY: No packets
>           SID: no ADI field (0xff)
>           TX power: 127 dBm
>           RSSI: -68 dBm (0xbc)
>           Periodic advertising interval: 0.00 msec (0x0000)
>           Direct address type: Public (0x00)
>           Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>           Data length: 0x1f
>         1e ff 06 00 01 09 20 02 74 f5 eb a3 76 9d e7 b5  ...... .t...v...
>         11 e6 85 a0 41 ca 09 4d 27 f1 f6 dc a5 5f bc     ....A..M'...._.
>         Company: Microsoft (6)
>           Data: 0109200274f5eba3769de7b511e685a041ca094d27f1f6dca55fbc
> @ MGMT Command: Stop Discovery (0x0024) plen 1                                                                                                           {0x0001} [hci0] 159.216816
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Command Complete (0x0001) plen 4                                                                                                           {0x0001} [hci0] 159.220056
>       Stop Discovery (0x0024) plen 1
>         Status: Rejected (0x0b)
>         Address type: 0x06
>           LE Public
>           LE Random

Looks like a bug in the kernel since it is rejecting the stop
discovery, have you checked if there are any fixes for it later on?
