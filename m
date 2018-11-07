Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4347EC0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F920818
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 18:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrcY2Suu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9F920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeKHEM1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:12:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41917 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeKHEM1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 23:12:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so12233053lfj.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 10:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKMGN0MJVUd8wrHy5GttiWdJKlPaEMrb98pEgkryghI=;
        b=CrcY2SuugiL0UAZ/GvZDLhkfNFpzmFNi89OcnfWpGeA7X7wfEqJVzBOsPb2Ypbl7nk
         G3l9A4KLbg9+NycyLmvXCVb8E5qmiqPvFjTO3S/TLEIAbGruv5+qrCJxe76pJ+ni/KFZ
         lD3YFaRO7gOx8letFUFBxTTSzYr916jMtaQfxaAtEl6tVBlgr7VM2ueVuJOqPDGwewZl
         hRubodtMT79O87G+r9Zw46phAPATq4ERL352ydoQho94YeL61vzwMnYuyyl19EbDtY/7
         3nuXdizyKQBhjw0qtn1obCz4gb9QBIZ4HZnfcde+XOkk/49tKGCPtGDpALgndEg5pktu
         9yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKMGN0MJVUd8wrHy5GttiWdJKlPaEMrb98pEgkryghI=;
        b=tDm6KkJushvJDLs+3+ibPcr5nxBLGqC0n/qITU3Idt+bvmtDmDkY0PVUeFXEkKZ33H
         Kiwmgyj1p6cPmIs//JxNe8JOdTKTyh0vMNMRkbd++Bz/ZBhU1PCn4GU6e9s5ItZVBswz
         feWer8jE334sAOIG+i6IJQFobDOACUfM08vlOnPKy6F6kXWUFbt9l02GwrAJEjbV5aRG
         +jDEpEiPgFe/5rlXzm3wNKYux9WnAb2ZUCZmcDdEPc1bgxKzMb4HsWH1tNqti+stTTVX
         PyfurTUEFZzb81nDbFHUCr5tcXMKJsqfWVnbvKHa+RnMG8wO74D8EQib/U7Ga10Y8Das
         Jgjw==
X-Gm-Message-State: AGRZ1gKfR0hUrNq5K38KwF9O4i4FjRtF8rvMvoKn1x7oSzTUck1uJhWa
        Z0799FxkiBobeR0QQOkvTNNRYMnD8VnNB1r5plM=
X-Google-Smtp-Source: AJdET5dl04HgSbZeEw4iSin1D+630FUNrxKMIN87qzgM8H2gv6n9G+yeV4P5nz7upXmaN65jMZp0jNdWCj3eFGJRQU0=
X-Received: by 2002:a19:d145:: with SMTP id i66mr816565lfg.97.1541616048493;
 Wed, 07 Nov 2018 10:40:48 -0800 (PST)
MIME-Version: 1.0
References: <1540907764-26294-1-git-send-email-chethan.tumkur.narayan@intel.com>
 <CAMH2TCoG80TCheJqPhu3vxQAvgALnSh8g=jbw_QFM9BOTBq1XA@mail.gmail.com>
 <20181107014427.GA1121@dtor-ws> <CD6DE466-5E73-473C-8943-684FBAEF337E@holtmann.org>
In-Reply-To: <CD6DE466-5E73-473C-8943-684FBAEF337E@holtmann.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 7 Nov 2018 10:40:36 -0800
Message-ID: <CAKdAkRTfBV67=KGmimsc6obeHcjgo63UpG=Jn+C=NFDQ2cNE=A@mail.gmail.com>
Subject: Re: [Patch v1] Bluetooth: Add Rfkill driver for Intel Bluetooth controller
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     chethantn@gmail.com, chethan.tumkur.narayan@intel.com,
        linux-bluetooth@vger.kernel.org, amit.k.bag@intel.com,
        raghuram.hegde@intel.com, sukumar.ghorai@intel.com,
        rajatja@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Nov 6, 2018 at 11:28 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Dmitry,
>
> >> We are planning to further implement the followings, kindly please
> >> provide your suggestions.
> >> 1. To handle more than 1 Intel BT controller connected to platform,
> >> will keep list of the objects in "static const struct acpi_device_id
> >> intel_bt_rfkill_acpi_match[] ". And keep a list of "struct
> >> intel_bt_rfkill_dev" for each of the acpi object.
> >> 2.  With this implementation from user space RF kill for the device
> >> object is achieved, however need to map the rfkill object with the
> >> corresponding "hdev" so that on error from the controller kernel can
> >> do the reset through this RF Kill driver.
> >
> > I am confused, why you model a generic chip reset functionality via
> > RFKill subsystem. As far as I understand, the issue is that you want to
> > be able to reset the chip when it gets confused and not actually disable
> > the chip/stop it from emitting RF signals.
> >
> > I believe this functionality should be contained in the driver and you
> > simply need to come with a way to tie the adapter instance with data in
> > ACPI, probably based on physical USB connection.
>
> it is impossible to do that in the driver since what the GPIO is doing is to push the USB device off the bus. So you actually see an USB disconnect and a new re-enumeration when it comes back. Meaning the driver knows nothing during that time.

The driver would know that it is in the middle of resetting the
device. The fact that the device disappears from the bus is not a big
deal. You just need to make sure you finish the reset task running
before finishing teardown of the device in disconnect method.

> This is a classic soft RFKILL switch like we have seen in the early Thinkpads.

It is not RFkill as, as far as I understand, it does not guarantee
that it actually blocks the transmitter. It really is a reset line and
its purpose is to unwedge the chip, not keep it in the off state. I do
not think there is a reason to export this as RFkill switch to
userspace and then build infrastructure to recognize that this is
special kind of RFkill switch that can be used to work around issues
in the controller. Have the driver assert and deassert it to kick
itself off the bus, the USB hotplug will take care of the rest.

Thanks.

-- 
Dmitry
