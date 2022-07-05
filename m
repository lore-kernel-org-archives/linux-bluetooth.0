Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 06:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGEGsh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGEGsg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 02:48:36 -0400
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 23:48:36 PDT
Received: from mail.ferris.chat (mail.ferris.chat [172.105.4.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9CCE96
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 23:48:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99F461F248
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 06:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imaskeleton.me;
        s=dkim; t=1657003192; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:  disposition-notification-to;
        bh=QA3rwpnQu9s90PZbyLPjuHn18SJfku/PYY+D0OC6cXM=;
        b=Fo4NriKpajgXdFobVweQdPc9kvFFw/SpM4PSAs661JcYu6FW78jf0I8xY4S0uwyOCf18m5
        hHfJ4DdYkxBaxv8E6eKx36VKcULS8pojrE/Ie9nhReBKTI/NKQx2OlMQaVF3P3Kcbevo3D
        C+uNh1CFgLN/+ZAi+GAwZKXlD60jRH1+hafrNXixFTsnPU1KAfChtxLVdtMdWc2gMX0vnn
        Y/GJetGjzrniKDTmKpWmpCZ3XiT8R5NZThPQfyWjRKPtZw8gzAhvek/trPAbd2q/bXRK4/
        PjSCp/26AaRA6GyGzIBKlpfipg7pGbLeKbdj8HQ074UzECqc1N6DY/DZCo9s4w==
Message-ID: <faa17dab-fbd5-a077-3e08-31b91645154d@imaskeleton.me>
Date:   Tue, 5 Jul 2022 00:39:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
From:   0/0 <zero@imaskeleton.me>
Subject: ASHA Implementation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi there!

I'm deaf with Bluetooth-enabled implants that implement the ASHA 
protocol, for which docs can be found here: 
https://source.android.com/devices/bluetooth/asha, along with an example 
implementation here: 
https://developer.android.com/reference/android/bluetooth/BluetoothHearingAid.

I was wondering if it'd be possible to get this implemented somewhere in 
Linux itself, as it'd be a huge time saver instead of having to hassle 
with many libraries. Right now my only option really is to stream audio 
to an Android/iOS device from Linux, and then to my processors, which 
adds some bad latency and makes it a huge hassle, or to use proprietary 
devices that don't seem to reliably work.

I'm sure I'm definitely not the only person out here who would benefit 
from their processors being automatically picked up.

Thanks!

