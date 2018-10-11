Return-Path: <SRS0=Gi1c=MX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F64C677FF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Oct 2018 16:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA2D2087D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Oct 2018 16:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYGuVGw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA2D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbeJLARd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:17:33 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:39312 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeJLARc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Oct 2018 20:17:32 -0400
Received: by mail-oi1-f169.google.com with SMTP id y81-v6so7605818oia.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Oct 2018 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g5TQwmGNFpQSAbcYJj5cRS5fhz+2GrAqkm6iBSUH2CM=;
        b=kYGuVGw80L8crlAyz6cWzrBTIQuZf9T07/2iNX1/V9Xi5Fi1i9tOI20BJxkfMFY4Yq
         7kvMJQak4hoO+R9AUd8KwZViKGsQ4EiTUTmaAC5hnx46hcdEoCYr6J50/RUiRpTQa0W/
         IPitPnl9WVm5Q0qz2zsg3FS05Vnl0AK3NXxT4eHlUPTYXrc9FttV4eBZM4dbEJdeZQ3L
         eAtI+R4IPkOpd9mpPubL1isM1O/f08fKZifmzI+4m6DMqoOlCfhZkvXCY9Lb6mSFuEze
         Nf/Xo6qw8Gm365tbi1+sIs6BFolqh5YlPXV0KKZftq7who9DpczVUe4+oGklNkdUI6iw
         Pymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g5TQwmGNFpQSAbcYJj5cRS5fhz+2GrAqkm6iBSUH2CM=;
        b=iZC99tgY0EsYeXApZ4GAPlJ4HRDF3MEB8b3nVqjLmn7/PLL7Lb2Sh8jVNdHw+NpKG4
         PVIoXvZA0Ws9jKStxXedvYAPPsnOy4j6PvZXJVk+a9B0xouMg/DMeyjsEujFLg5hpCbe
         P6CwpZ8pcFublvWz1b06M2xLkqPGK25bzTr5U4wyBZTv+jicomK3t4PhH8BFD/wIg+FL
         T3VBVs7JwiabHzGd8l/4elyFgmlaDuSzwslvQRAqRlxBgv/bpbRAXwo6im6rfNE5lhrd
         cDpcJ0Z50M1wHlA63kfjhmM+fUfO06QvTNfcCo71XzHBk3eQh0ls7uvpHbMFMZSmDhCD
         lJnw==
X-Gm-Message-State: ABuFfojci4khC7RYfueSuv8Uhu6fuMw6HOhv+Ul/Y4f1jKb7o13Uwxck
        kVPU91wDC66rz0Yq6x/8FXM/U3SgaJZhmbjzNJ8=
X-Google-Smtp-Source: ACcGV63aYpwgHRvwp+LukrvAQIMv26K79iJgkmUFtnidbuPJbysvQXpAqAcNy/D5ki9wgjGS1/uVYgjJhZCfveP6DLQ=
X-Received: by 2002:aca:6b45:: with SMTP id g66-v6mr1376227oic.273.1539276569683;
 Thu, 11 Oct 2018 09:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <da781fd16860492a9b4d28334a593b77@fronius.com>
In-Reply-To: <da781fd16860492a9b4d28334a593b77@fronius.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Oct 2018 19:49:17 +0300
Message-ID: <CABBYNZKWhK5NKQqpgXqTAFcaBkVM=CrSLtuxzD=MPyw6p-es7A@mail.gmail.com>
Subject: Re: Bluetooth: Is it possible to operate Bluez concurrent in central
 and peripheral role?
To:     Eisenkolb.Thomas@fronius.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thomas,
On Thu, Oct 11, 2018 at 10:18 AM Eisenkolb Thomas
<Eisenkolb.Thomas@fronius.com> wrote:
>
> Hello,
>
> I am working with blueZ 5.50 on a linux embedded device with kernel 4.14.
>
> Now I have to implement a use case where the linux embedded device commun=
icates as a central device with a few sensors through Bluetooth LE characte=
ristics and at the same time it should advertise some data and accept at le=
ast one incoming connection from a Smartphone as a peripheral device for ma=
intenance cases.
>
> I haven't found any information about blueZ is supporting both LE roles a=
t the same time.
> I have already tried it now for 2 days to get this use case to work and I=
 found a few limitations for which I didn't find any solution.
>
> I was not able to advertise any data while my device had an active connec=
tion to a peripheral device.
> Also while the Smartphone is connected to my embedded device(peripheral),=
 I don't receive any advertised Data from any sensor and I cannot connect t=
o any sensor.
>
> The Bluetooth Hardware Module which I am using on the embedded Linux Syst=
em supports Bluetooth 4.2. From the Bluetooth Standard I have found that co=
ncurrent use of both Bluetooth Low Energy Roles should be supported since B=
luetooth 4.1.
>
> Is it possible from blueZ Stack side to implement this use-case?

BlueZ should work as dual roles already, if it doesn't there could
bugs or the controller preventing commands to work properly.

> If yes, can you give me some hints what I have to consider to get this ca=
se working?

Do you have HCI logs of the problem(s)?

> If no, have you got a timeline when it will be supported or is this no pl=
anned to implement in near future?

Most of upstream effort is on mesh and updates to include 5.0
features, but dual-role is something that we might consider high
priority if that is not working properly.

>
> Thanks for your answer,
> Thomas
>
>


--=20
Luiz Augusto von Dentz
