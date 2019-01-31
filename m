Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF0DC169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF4C218EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtaTA1zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfAaRDT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:03:19 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38824 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfAaRDT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 12:03:19 -0500
Received: by mail-oi1-f173.google.com with SMTP id a77so3333449oii.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2MuGqSPcFz8/+xEDbMlsc1GVbcxyzJaN4/39dsLg50=;
        b=QtaTA1zLeIflvAo3jPYoGbBq1ziYLbpUaZ9OZNaAjLDEpdo0xlGEN/xQzt/JXO1W4L
         HGxW6sfiDxJycaz54D1yUUmWMfV0tOe2odZHGj7OqCeQk2oSqntG1VCNNm+mvp8HIYsv
         mM//H3C4q17SsY4c+foWdnYR4pKjhLGofVcsYLnbWSPzJmWBaBzmY/TQ31/j7tHCvfb9
         VBn4bGJ2o8dRtQKKMOWMCrP1HznkxwT5gzRHEZHWSu/U9QVV/UPu89u+71Oauha3bpE0
         kWp27ynm0NHw7ndNb+SWfMQdbdWFYRI+fhvsoLQKqNUV28khdfhCS8KXQixMYrqSoH1k
         SbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2MuGqSPcFz8/+xEDbMlsc1GVbcxyzJaN4/39dsLg50=;
        b=loqMbInE+YMRyId16Hdt+n6PumpL3Xcr3MK793A4wOlxKtk9qlQMuxcCb+7+YgR1P5
         aUge7t5mDtinQttnRisK9d5bBIUzW56ioqZrVYFpZIxRdMXAEw0Paj+OgiX3Rs0OA8Yp
         Oh0tBIDyvBT5T46QCrRbAW+M9kV+pfM5yF5LeJ9MyM/YiEzli54syJgzIHxpRdEg30Th
         UN7fUQFegXKtC2uMqyNL7O5MKo5X7zPxs54LDjmI/qKa3lQEqFmuxBZdDkyTsf/d4+Ip
         P/XbAt7XXUR8z7luYoWtFdqWgx43GW1O2XYIf30sL6cwDWZ2PlGcflrLHVQd1yftWGse
         zHaA==
X-Gm-Message-State: AJcUukdg1FjpsVqPr+kj0hi+DRQFUG82nZKfyUpB9HMAxwun1ElnT3XN
        7btvdbWKv6pXEnMsqDisBlj2It0+uRkhcJgqw1M=
X-Google-Smtp-Source: AHgI3Ian9c7nlL0R38Cp4mQDRBmD61riUdnFRjesazuUqKS5sgZ1OB75ccsvBFADo6KRpfFi+MBNJfq1jYbHVseKL5k=
X-Received: by 2002:aca:47c6:: with SMTP id u189mr16269153oia.250.1548954197836;
 Thu, 31 Jan 2019 09:03:17 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6scUuK1K+zLjyQA12HtY9nNdR=Q8MeuruC2GKvaJPH0knA@mail.gmail.com>
In-Reply-To: <CAO1O6scUuK1K+zLjyQA12HtY9nNdR=Q8MeuruC2GKvaJPH0knA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 31 Jan 2019 19:03:07 +0200
Message-ID: <CABBYNZJ8hqJph3DgFBdTPBpD5eqSvMHCsrwvNZx3z5v9Fbu3Vg@mail.gmail.com>
Subject: Re: Flag for specifying write type to WriteValue in gatt-api.
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

On Thu, Jan 31, 2019 at 6:19 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
>
> Hi,
>
> I was looking through the quite lengthy discussion at
> https://github.com/WebBluetoothCG/web-bluetooth/issues/238 on the
> issue that in Web-Bluetooth, only a single "write value" API is
> available, causing Web-Bluetooth to decide on its own if Write With
> Response or Write Without Response should be used, in case both are
> supported by the characteristic.
>
> But in the Bluetooth spec about Write Without Response:
>
> "This sub-procedure is used to write a Characteristic Value to a
> server when the client knows the Characteristic Value Handle and the
> client does not need an acknowledgement that the write was
> successfully performed."
>
> Basically, it says it's up to the client/application to decide if an
> acknowledgement is needed or not, and hence it's the app that should
> decide if Write With or Without Response should be used. The "client"
> can't mean a bluetooth stack here since it can of course not know if
> an acknowledgement is needed or not.

There is a property indicating if write without response is supported
though, but you are right regarding that not excluding regular write
so at that point the client would have a choice whether to use it or
not.

> I noticed that according to gatt-api.txt, BlueZ has the same
> limitation in the WriteValue method, in that the stack chooses the
> write type "arbitrarily" if both write types are supported (or really
> the Write With Response is chosen, which might cause unwanted
> latency). Therefore I suggest that an option should be added to the
> WriteValue method, for example "write-without-response" (bool) to
> force Write Without Response.

It gets a bit trickier if the attribute is in fact a control point in
which case perhaps only write-without-response really works, anyway
control points are better off using AcquireWrite.

> Note how iOS has a write type parameter to the write method, and
> Android has a write type property you set before you execute the
> write.
>
> I see that it might be possible to achieve the same result with
> AcquireWrite -> write to socket -> release but that wouldn't be a good
> solution for bluetooth stacks built on top of BlueZ that would like to
> differentiate between the two write types (such as Web-Bluetooth)
> since AcquireWrite can fail, for example if two apps write the value
> at the same time (I guess the lock is exclusive?). It also seems like
> unnecessary overhead to open and close sockets.

AcquireWrite is to be used when the app needs exclusive access, like
control points such as those commonly used for things like DFU, I
don't think that is your intent here (or is it?) so I guess adding an
option for WriteValue is probably better. Note though that obviously
one cannot use such a flag with things like e.g. offset as that is not
supported which makes the API a little trickier to use but I guess
that ok given that setting flags is optional.

-- 
Luiz Augusto von Dentz
