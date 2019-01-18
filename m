Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44104C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 09:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C1E2086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 09:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfARJn5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:43:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44336 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfARJn5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 04:43:57 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 85143CF2C3;
        Fri, 18 Jan 2019 10:51:42 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Bluetooth ECDH selftest failed (endianness issue?)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEQQxWxpi7FR=RDT1cLMDBUUGzHSfSrgngHL7dCK5V1eJOOu3Q@mail.gmail.com>
Date:   Fri, 18 Jan 2019 10:43:55 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <82ABD3A9-290C-4291-A84D-C4C2DE62CD17@holtmann.org>
References: <CAEQQxWzdBy9JOC7+oQTBJ35Gov1CDk17fy+XH=jha8MuT9fy9Q@mail.gmail.com>
 <49999069-238D-4FBE-8F38-3762788A67C1@holtmann.org>
 <CAEQQxWxAvZBX8simb7gNu6ob_0gGXzTEQuOybiP5MTV8dq5sEg@mail.gmail.com>
 <CAEQQxWxpi7FR=RDT1cLMDBUUGzHSfSrgngHL7dCK5V1eJOOu3Q@mail.gmail.com>
To:     Andrey Batyiev <batyiev@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

>> On Sat, Dec 29, 2018 at 9:35 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>> I think that our ECDH code was endian safe, but then it got changed at some point to use standard crypto and maybe something went wrong there. Can just provide the btmon -w trace.log for the SMP pairing so that I can have a look at the binary trace.
> 
> I found out that if I change "swap_digits" method in
> "net/bluetooth/ecdh_helper.c" to
> 
> static inline void swap_digits(u64 *in, u64 *out, unsigned int ndigits)
> {
> int i;
> 
> for (i = 0; i < ndigits; i++)
>        out[i] = in[ndigits - 1 - i];
> }
> 
> then BLE pairing on big-endian become operational. I'm not sure what
> proper fix should be: is it a problem with crypto API usage or a
> problem with crypto itself?

if the kernel ECC and ECDH crypto already swaps for us, then we don’t need to do it again. So all the swap_digits most likely can be removed from net/bluetooth/.

Regards

Marcel

