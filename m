Return-Path: <SRS0=rkTY=PG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFABC43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 07:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F94C2070D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 07:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeL2HfX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:35:23 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45672 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeL2HfX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Dec 2018 02:35:23 -0500
Received: from [172.20.12.43] (unknown [213.61.67.157])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8A116CF358;
        Sat, 29 Dec 2018 08:43:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Bluetooth ECDH selftest failed (endianness issue?)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEQQxWzdBy9JOC7+oQTBJ35Gov1CDk17fy+XH=jha8MuT9fy9Q@mail.gmail.com>
Date:   Sat, 29 Dec 2018 08:35:21 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <49999069-238D-4FBE-8F38-3762788A67C1@holtmann.org>
References: <CAEQQxWzdBy9JOC7+oQTBJ35Gov1CDk17fy+XH=jha8MuT9fy9Q@mail.gmail.com>
To:     Andrey Batyiev <batyiev@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

> I'm trying to pair my MIPS based router with a phone (using bluez),
> without success.
> I have turned on debugging features of bluetooth kernel module and I
> got this in dmesg:
> 
> [  234.481526] Bluetooth: Core ver 2.22
> [  234.485231] Bluetooth: Starting self testing
> [  234.525375] Bluetooth: ECDH sample 1 failed
> [  234.529728] Bluetooth: Finished self testing
> 
> Also, I checked hcidump, and it seems that SMP "Pairing confirm"
> command got rejected by the phone with an error ("Reason: Unspecified
> Reason (0x08)").
> As far as I understand, ECDH computation is involved in a pairing process.

I think that our ECDH code was endian safe, but then it got changed at some point to use standard crypto and maybe something went wrong there. Can just provide the btmon -w trace.log for the SMP pairing so that I can have a look at the binary trace.

Regards

Marcel

