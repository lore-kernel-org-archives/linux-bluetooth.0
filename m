Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B1BC0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37742189E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc36IrPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfGCQDe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:03:34 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43519 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCQDe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 12:03:34 -0400
Received: by mail-ot1-f41.google.com with SMTP id q10so2879718otk.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDFGkL7VjsuAcgmtrlZJY21ER8SsIoV81ls3l3HqYDU=;
        b=cc36IrPcBioXYqPXBqie3kDWrlgXkMraIaWb5xUoEjpEMrPWHDzaqEJ4AvAKc3EqE9
         eWrGZgvhs3FKZt320H9+vJxUFDo4Pn0TIjhbOj8//xei+AT/j49N7svAysKtPzYYv08E
         kdealVfhOnMXV77YvTRGAIfRkkabZ0qWHUwDGU867iDDZ432ZciJhs6VTKajVjWzf3tR
         gyGfy6OWT+enmENz6BMdbPqDjkijofpPnoBAxKSIZ+Jf9kC0sZWIEGudBFSje5tnP6dm
         RrrHINaNOyIYwFZp8BKtD5NkTXrIth5aLXWFuFArJMon9D3iGmOOTw7kRmsW149eFZTn
         NAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDFGkL7VjsuAcgmtrlZJY21ER8SsIoV81ls3l3HqYDU=;
        b=g1B+cm66Vx+GDYa0p+SvdTAfr311Wmb7mhlorKYupgPzRSuHcy5K/BF4aLx/iyJ5qS
         GWtpdFaWN+tyNLcmcALIuJk/O6czYECGpviKCvQjOZK1gFLdTG7GBB0MOGVQ9DsMbH8v
         fH240BAfpz4LGoeKkMs0YxRamZl54+8Crn3CuoxdDmANgtuhbPI+NuQEfCgiIXGmXTf7
         2gxHA4WnqlmMTLSQBiBVM/Je9r8177IaD94zB3lwk+0E7kUWWX6WfKgh+2PYIqsGqBKu
         rrvJ7Iq6grFB5Cqn7Uszye8pkg1F73hdGI5oATJLzCxl8ucw2W92sIHGsFtVJ9jZEefV
         L0gg==
X-Gm-Message-State: APjAAAWqR3qB//cPI+oU+gI0dYh4PR6QRpfvNTnNWnGDjwx1w6SD4Af5
        B/mJXcmYKkVQXgC4PDUV4EbJtyR0+Ks9hu8DdYYkDxxJQe8=
X-Google-Smtp-Source: APXvYqw/ytKqdXoxPEum/pG+up7xFu0+StnAEc8WanupyMap3DWpUtwg/8GG5HluceO2esgu4DOBxG21BBMkYTFsTF8=
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr28625359ota.79.1562169812897;
 Wed, 03 Jul 2019 09:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAK_dC=N+YvA1mH5XJDO-P3CV38NbK6UiLrBQe9na-AT8yraVAA@mail.gmail.com>
 <CABBYNZKf5=Kvi21Q=HH8f2KLo0qCTe1U=DeY2QfEGi46m-5x3w@mail.gmail.com> <CAK_dC=OsbyNdFtC6tqhPy1nh6KB6A6BF5u0nEi9obUhLJ5FW8A@mail.gmail.com>
In-Reply-To: <CAK_dC=OsbyNdFtC6tqhPy1nh6KB6A6BF5u0nEi9obUhLJ5FW8A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jul 2019 19:03:20 +0300
Message-ID: <CABBYNZJO9z2jfJoSn7awJttVUqxUNxpcvJ_yPb-7s_CQq0RBFg@mail.gmail.com>
Subject: Re: PTS test case (GATT/SR/UNS/BI-01-C) fails with Bluez 5.50
To:     Edward Fung <jjsheepman@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Edward,

On Wed, Jul 3, 2019 at 6:35 PM Edward Fung <jjsheepman@gmail.com> wrote:
>
> Hello Luiz,
>
> Yes, this is the same test with 3 different errors reported by the
> PTS. The HCI commands for each error code are included as below.
> Thanks!
>
> Test case : GATT/SR/UNS/BI-01-C started
> - Running test case with ATT bearer setup over BR/EDR.
> - BR/EDR Connection setup successfully.
> - BR Security not initiated due to TSPX_security_enabled value.
> - Sending an ATT request with an unsupported opcode.
> - Received data 0116-0102-01
> - Invalid request handle received. Expected=0x0000 Received =0x201.
> - Connection terminated successfully.
>      -Final Verdict: FAIL
> GATT/SR/UNS/BI-01-C finished
>
> > ACL data: handle 12 flags 0x02 dlen 24
>     L2CAP(d): cid 0x0040 len 20 [psm 31]
>       ATT: Prepare Write req (0x16)
>         attr handle 0x0201, value offset 0x0403
>         part attr value  0x05 0x06 0x07 0x08 0x09 0x0a 0x0b 0x0c 0x0d
> 0x0e 0x0f 0x10 0x11 0x12 0x13
> < ACL data: handle 12 flags 0x00 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 31]
>       ATT: Error (0x01)
>         Error: Invalid handle (1)
>         Prepare Write req (0x16) on handle 0x0201

Weird does the prepare don't require to return the handle on the
error? The spec don't seem to mention that.

> > ACL data: handle 12 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 31]
>       ATT: Read By Group resp (0x11)
>         attr handle 0x0001, end group handle 0x0007
>         value 0x00 0x18
>         attr handle 0x0010, end group handle 0x0015
>         value 0x01 0x18
> < ACL data: handle 12 flags 0x00 dlen 11
>     L2CAP(d): cid 0x0040 len 7 [psm 31]
>       ATT: Read By Group req (0x10)
>         start 0x0016, end 0xffff
>         type-uuid 0x2800
> Test case : GATT/SR/UNS/BI-01-C started
> - Running test case with ATT bearer setup over BR/EDR.
> - BR/EDR Connection setup successfully.
> - BR Security not initiated due to TSPX_security_enabled value.
> - Sending an ATT request with an unsupported opcode.
> - Received data 010E-0000-01
> - Invalid Error Code received. Expected=0x06 Received =0x1.
> - Connection terminated successfully.
>      -Final Verdict: FAIL
> GATT/SR/UNS/BI-01-C finished
>
> > ACL data: handle 12 flags 0x02 dlen 19
>     L2CAP(d): cid 0x0040 len 15 [psm 31]
>       ATT: Read Multi req (0x0e)
>         Handles
>         handle 0x0201
>         handle 0x0403
>         handle 0x0605
>         handle 0x0807
>         handle 0x0a09
>         handle 0x0c0b
>         handle 0x0e0d
> < ACL data: handle 12 flags 0x00 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 31]
>       ATT: Error (0x01)
>         Error: Invalid handle (1)
>         Read Multi req (0x0e) on handle 0x0000

Here I think we do have to set the handle and we are not doing it,
this is probably an error on our side but invalidate the first error
since there we would be doing exactly what this failure is suggesting.

> > ACL data: handle 12 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 31]
>       ATT: Read By Group resp (0x11)
>         attr handle 0x0001, end group handle 0x0007
>         value 0x00 0x18
>         attr handle 0x0010, end group handle 0x0015
>         value 0x01 0x18
> < ACL data: handle 12 flags 0x00 dlen 11
>     L2CAP(d): cid 0x0040 len 7 [psm 31]
>       ATT: Read By Group req (0x10)
>         start 0x0016, end 0xffff
>         type-uuid 0x2800
>
> Test case : GATT/SR/UNS/BI-01-C started
> - Running test case with ATT bearer setup over BR/EDR.
> - BR/EDR Connection setup successfully.
> - BR Security not initiated due to TSPX_security_enabled value.
> - Sending an ATT request with an unsupported opcode.
> - Received data 010C-0000-04
> - Invalid Error Code received. Expected=0x06 Received =0x4.
> - Connection terminated successfully.
>      -Final Verdict: FAIL
> GATT/SR/UNS/BI-01-C finished
> > ACL data: handle 11 flags 0x02 dlen 22
>     L2CAP(d): cid 0x0040 len 18 [psm 31]
>       ATT: Read Blob req (0x0c)
>         handle 0x0201 offset 0x0403
> < ACL data: handle 11 flags 0x00 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 31]
>       ATT: Error (0x01)
>         Error: Invalid PDU (4)
>         Read Blob req (0x0c) on handle 0x0000

And here as well, we should be setting the handle as in the first
occurrence, but it is saying we should return request not supported
instead?

> > ACL data: handle 11 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 31]
>       ATT: Read By Group resp (0x11)
>         attr handle 0x0001, end group handle 0x0007
>         value 0x00 0x18
>         attr handle 0x0010, end group handle 0x0015
>         value 0x01 0x18
> < ACL data: handle 11 flags 0x00 dlen 11
>     L2CAP(d): cid 0x0040 len 7 [psm 31]
>       ATT: Read By Group req (0x10)
>         start 0x0016, end 0xffff
>         type-uuid 0x2800




--
Luiz Augusto von Dentz
