Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E4BC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 14:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA98A223CB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 14:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6Mv9uDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA98A223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeKMAeT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:34:19 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36407 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeKMAeS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 19:34:18 -0500
Received: by mail-oi1-f179.google.com with SMTP id r127-v6so7330331oie.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Nov 2018 06:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e/Ll0jvh3hjxrTnvLE3NNHvRT0UluTdHv/MrTLfe+WY=;
        b=V6Mv9uDNUppjal7XHnUb9Y83CsL1j6ngA50Kq8AW0kJOp5GLe/HzPKoJVRidRc33r4
         sPVhsVupJd5XXAPRGhVf7eRPbxozTeByzNFaAkexeVvPFNMkzPA0NvoYCGkcZe23qi59
         3ofwb5ZUs7Sakztx/LGgT5DXc20OFqdefoENHf1ds4VKc79BUbFxQZ+blkgJqIuI+ZYs
         /x47ZjUV63orlP+bMxCN/U1dvRRe1VdugnPGsl1yN7+T4nR7+iz6CFs/Q7WT8cR1ltSd
         QvQ/na06I3jIian9CDm7brQUXpVCs01PqgkLGc82WYMBWjol9M7Gdiwv/DfSdaPCuIK8
         cLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e/Ll0jvh3hjxrTnvLE3NNHvRT0UluTdHv/MrTLfe+WY=;
        b=sJP33HWlobbVs2IqTg5lXdZaeqKHNtaBe0l13Pt7iVsPEOOUV5aaPNx0g1Gg20CK6b
         alRlY6jmW7XtUnDyo9E4/lR1zwhkGqhK/Gr8wtMkzZ+CBLazUbABKx5cERxDkdFhWdB5
         0iviwE8CN16otqfmc9y5yjctnxTYsJeel+a52Fr+Njrru0zcn2ysuuxhXes0LqwJxTZC
         jNNvMRu8wGvx0oYof4na+Naox/yQIrdBA5yPYmDBZ4xGx4ItK5stgX05gFXE5Mp1ryUL
         1GyFa3tu07JIvFKN/NimiqCig1+hCJRVZusi1ITKXk47Fr4wiokAhj/mCmzdoszPPZq9
         Ozbg==
X-Gm-Message-State: AGRZ1gKcahiFdOasPDCfdUOt6zTAFB3YRdH/H3t/MisVn45fZSr6Pxkd
        1Jwowvrr5WVomj1bTSKJWhAAbloxz/a+OuFJSss=
X-Google-Smtp-Source: AJdET5e02a0bA980/GCI/TdFy2LcqJCAZ7CyCYelejF25dcGHZ65RgrDIEH6pjpJ4mXMXtgqt3kamPXdsHFii0OJwr4=
X-Received: by 2002:aca:32c6:: with SMTP id y189-v6mr586551oiy.153.1542033645183;
 Mon, 12 Nov 2018 06:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20181112013317.5714-1-inga.stotland@intel.com>
 <CABBYNZJLLxNC3BQvyDxzTFLppe25ke=VK_9QtvJsNbCFjnUW2A@mail.gmail.com> <4C0377DF-430B-4A2C-BA6E-CC4B9C6ED9F6@gmail.com>
In-Reply-To: <4C0377DF-430B-4A2C-BA6E-CC4B9C6ED9F6@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Nov 2018 16:40:33 +0200
Message-ID: <CABBYNZ+1RqUJm3c_mQjF0DNDy1GWTKRP-v-66VN1ihEpf6Y3iw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] doc: Initial Bluetooth Mesh API
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Gix, Brian" <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

On Mon, Nov 12, 2018 at 2:58 PM Johan Hedberg <johan.hedberg@gmail.com> wro=
te:
>
> Hi Luiz
>
> > On 12 Nov 2018, at 13.24, Luiz Augusto von Dentz <luiz.dentz@gmail.com>=
 wrote:
> >
> > It seems wrong  to me to have to send your own object as method
> > argument, usually this sort of communication goes as a Signal but it
> > seems the Element interface has no signal to be able to do something
> > like that.
>
> The problem with signals is that they cannot return an error, and I do th=
ink we=E2=80=99d want to have the daemon return an error if it cannot send =
the given message. Also, by default signals are broadcast, and it feels a b=
it hawkish to do unicast destinations for them.

Well unicast signals is not a new thing, though we never used it that
would be possible to do something like that, anyway D-Bus signals are
subscription based which is the reason we haven't consider it to be
problem to emit signal for Value changes in case of GATT attributes,
that said the lack of error result could indeed be a problem but some
of the errors are actually due to the checking object_path is valid?
Other errors Im not sure, Ive assume if there is a response that would
then call MessageReceived, but perhaps we want to validate the
transmission itself, but I though that wasn't possible in BlueZ.

--=20
Luiz Augusto von Dentz
