Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643DFC7112F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3439420879
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 12:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1vObMwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfAUMMj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:12:39 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44860 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfAUMMj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 07:12:39 -0500
Received: by mail-oi1-f180.google.com with SMTP id m6so14329168oig.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 04:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFBpcXoHyK7V1mVULRj5oR/tQiF0lKhqgyzpdQ3WB3Y=;
        b=e1vObMwQ5/VDr5jGvxwot5Kg46lRjY1Td6HUn1/eJCZTUlititMLr3FFQy4v22GGSE
         7C4liDzcdQBOeUSQDRg0hZwnvvDayh41T+sCK+SzmSdQtAU5o1gopv1GRMX8soeQyfa3
         Mxc8Ipg+PRddSJmE9KnHC7Scv9TDTi007wVfg9tmH4ISLVbEbkmljiI/MlCDg6UOV3dR
         FKExpZjPheheRFoaGUoaWIoYJ8P+U4ln5cyrdcTP8JNZrZ/3fb6lD+T4lX0VSDZF9m4X
         RY10ltQuo8u00jw6DE/4DnyzcTjLQh9KrikC0iPN9jU4//QHhBYfWy1T9n1NagavCaoO
         glHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFBpcXoHyK7V1mVULRj5oR/tQiF0lKhqgyzpdQ3WB3Y=;
        b=aoIxyXyAt/7Mt64CXCT39SqeZHtoD7vm0QAakthvXeI38iqiUDSjAv6QgtG0/F21SJ
         KUNru8Wwwfp3b6TKqm3MYfJPGKmU1gFO90tdmy5ZPE20AjFcvhphQY7T5TFXi7/mSjqw
         FCPZhhro7NwUkovKMF20blNTcnWXNfUoA1Uo8n+OUZSLEfsObAJMF09zhQ9uXetqUmIH
         ZzuRoExOlxGiPi/6ItLoHwMA0A49eDDfPsKNbjNlC4VRUinN6dTbP8k0oFNUFNjyCWBG
         fLPHMORw1zbE/e5A7v+5JaAkcuUZOJf3UfRlSw6SBz2Pp4gK15pkIF4L+cjKICnWn/Ow
         lUow==
X-Gm-Message-State: AJcUukcWx9yHShH7dsLUWU2I5l/+ZEG8jROYJ7rFNZwcvSOjwznYJ/Ph
        qDoh9s7fONAr8UyRkKUWEiP/Xl9YM6fwdpJlui4=
X-Google-Smtp-Source: ALg8bN7ZTcZXlO8WuPIHVTR8ZEtZlyvmEgL5D0UZFwEigSIaO+nCRNuji6h6z1gKl0RXCXOqWQ83dN3wWRtTEIai4RM=
X-Received: by 2002:a05:6808:97:: with SMTP id s23mr5226265oic.251.1548072757791;
 Mon, 21 Jan 2019 04:12:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+T8qpa+qHK7O6zr+a7CUysPzzR4jce7peCCcuOVN4J9TP6teQ@mail.gmail.com>
In-Reply-To: <CA+T8qpa+qHK7O6zr+a7CUysPzzR4jce7peCCcuOVN4J9TP6teQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Jan 2019 14:12:25 +0200
Message-ID: <CABBYNZKGS=AcqtgfFffLBWZX6pxOHmkpnXgW4ddr4hO58a_pHQ@mail.gmail.com>
Subject: Re: BlueZ 5.50: Browsing local GATT table
To:     Youssif Saeed <youssif.am.saeed@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Youssif,

On Mon, Jan 21, 2019 at 1:05 PM Youssif Saeed
<youssif.am.saeed@gmail.com> wrote:
>
> Hi
>
> Is there a tool/utility for browsing the local GATT table. I have so
> far used "bluetoothctl info" as follows:-
>
> [bluetooth]menu gatt
> [bluetooth]register-service 0xFFFF
> [bluetooth]register-characteristic 0xAAAA read,write
> [bluetooth]register-application
> [bluetooth]back
> [bluetooth]info
> Controller 00:16:A4:09:31:11 (public)
> Name: linuxvm
> Alias: linuxvm
> Class: 0x000c0000
> Powered: yes
> Discoverable: no
> Pairable: yes
> UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> UUID: Unknown                   (0000ffff-0000-1000-8000-00805f9b34fb)
> UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> Modalias: usb:v1D6Bp0246d0532
> Discovering: no
>
> However, this does not show the list of characteristics/descriptors
> and their handles which is what I am after.
>
> I am using BlueZ 5.50 on an Ubuntu machine running Linux 4.15.0-43-generic.

I guess you would be after the registered local attributes, command
info doesn't print that only the UUID of the services, we could have
then as part of list-attributes perhaps but it would only show the
attributes register by that instance of bluetoothctl nothing else. As
for the handles that is currently not exposed to the application, do
you require them perhaps to restore them in the same location?

-- 
Luiz Augusto von Dentz
