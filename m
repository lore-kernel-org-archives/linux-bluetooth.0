Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4AC7619A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Apr 2023 12:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDOMBz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Apr 2023 08:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDOMBy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Apr 2023 08:01:54 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5FE559E
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Apr 2023 05:01:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A87115C0291;
        Sat, 15 Apr 2023 08:01:48 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Sat, 15 Apr 2023 08:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681560108; x=1681646508; bh=aB/73pdluWbwF4vxX0QpwG48rF9552YJ5ch
        aGnLRWyM=; b=DRHNwyWEFfO9rqezVAYt7jMksUqjQQShnm7ZjYOT3yRI9ZBOnV0
        AaY0+Mp29m6F75gNBrZfM2aIqJl42OlTftQtSn55Gvfl26Zj832Luy8QR9vFHzak
        Esidb3STR6+uJaVJ5LnYSYU/HTumZUL75yCrWlyg8Lf1PHhwb6IkFaaaHQaD8rmQ
        iY+Mf+IVCh3s2FjIYe/jRs7A5WBgeTqrKH7I3CzkMAvEnZ+WH2iGdm87ApjqNLhG
        2hikis23W8JXaQbz1h7vq6d3iilnNktVKA65m/NQIbGM+3rn8VIqGlPyiKlCjdn+
        eMWLLGFBuxGBLuEPXfSRDF1IusXsUdb/SXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681560108; x=1681646508; bh=aB/73pdluWbwF4vxX0QpwG48rF9552YJ5ch
        aGnLRWyM=; b=Bc3OzphAw4kvjfxjPZRM5CyusG2l7M0X1759GvyhoC6pJRlD2u9
        MZrvs2iOpA5tMlyP+GQJ1iQeWz2HGdhfXYudpTC+VCOmXF+IB/wuW3ptj9MFveIV
        TJ/wt+uP5iKJ4X9KSX1f1W04OD0K0o62HzoGoeX1U7Eg2S9c627NMn6hd9rfHqqV
        3oSiG9QRl+CP7cp5KRHyvwxFt8n0eWRg2f9AH/1BG4gpcVlPi0l5+/40SIc64ts9
        W+si0L/BO56y0gvogtHqGbvdHxCQ4CdajuKKX+qD2j7wF1CxRmiytes7pjBNG4Ly
        t5KF6gYN/uVYws/fzYeBINQyyDs+IMLBgAA==
X-ME-Sender: <xms:LJI6ZCCEqQcBqsv00fCAaSpMLMPk5sOw3vIG319PdlXAgI46LvOT-w>
    <xme:LJI6ZMgdWGXI5CXPS8EAsLXWK7RYb9sg9zRCo5d5r_BjalDdjEdjpPl_pv9p_tjA6
    CN4_FHc_JoQa_7D3kU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdev
    hhhrihhsthhophhhvghrucfunhhofihhihhllhdfuceotghhrhhisheskhhouggvheegrd
    hnvghtqeenucggtffrrghtthgvrhhnpeevffevfffgjeegieejteehheevtdeugfevudeu
    tedvteeuffdvffdtudeuueffieenucffohhmrghinheplhhoshhnohdrtghopdhmrghrtg
    drihhnfhhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheptghhrhhisheskhhouggvheegrdhnvght
X-ME-Proxy: <xmx:LJI6ZFm2Bi0ijO0LkWNoPS0HRa5iUuo34wFj9M8gIwUFjzPhv5ZxwQ>
    <xmx:LJI6ZAwGn8A8UGAHj2EbsMj_sDyzCqjeoIasDKpw2sA8o8GTJH5Vgw>
    <xmx:LJI6ZHQfeBqz5AKHkxBE9cvrNt1gUv8oHk2R7Yis9aC4_3krm86uZw>
    <xmx:LJI6ZCcnlFkS136mHmsgrcQOq1VoqNsdOgixToiuM95oVtxoX1ZzFg>
Feedback-ID: i01794759:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E9CF136A0073; Sat, 15 Apr 2023 08:01:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <06d8f66e-1a35-4f7e-8e35-00595c424542@app.fastmail.com>
In-Reply-To: <CACk7upyYLmiS9GMJVatjDz52Z4MEPRVAoHi_tSchHWjQfqo2sA@mail.gmail.com>
References: <CACk7upyDgd8kCY+8j+RMJz35GXrF=bwRzDNH76Oh8q4nB8i0KQ@mail.gmail.com>
 <126c5bce-6496-4744-9101-6a61f0fff106@app.fastmail.com>
 <CACk7upyYLmiS9GMJVatjDz52Z4MEPRVAoHi_tSchHWjQfqo2sA@mail.gmail.com>
Date:   Sat, 15 Apr 2023 05:01:26 -0700
From:   "Christopher Snowhill" <chris@kode54.net>
To:     "Raul Cheleguini" <raul.cheleguini@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        "Marcel Holtmann" <marcel@holtmann.org>, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com
Subject: Re: unexpected SMP command errors with controller ATS2851
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Apr 13, 2023, at 6:54 AM, Raul Cheleguini wrote:
> On Fri, Mar 31, 2023 at 2:50=E2=80=AFAM Christopher Snowhill <chris@ko=
de54.net> wrote:
>>
>> Would some pcapng logs be useful? It appears this device flags some c=
ommands as supported, while indicating their entire feature sets are not=
 supported in the local supported features bitfields. Or that's as near =
as I can guess.
>>
>> First is captured from a generic driver that works, the latter is cap=
tured from Linux 6.2.9. Included in the working capture is the beginning=
 of an exchange with my Sony headphones. The latter stops logging after =
the first failed command.
>>
>> https://f.losno.co/bluetooth_ats2851.pcapng.zst
>> https://f.losno.co/bluetooth_ats2851_broken.pcapng.zst
>
> Hi Christopher,
>
> Thank you for sharing the pcap files. Based on your comments from anot=
her
> thread regarding this adapter, I suggest that you apply the following =
patches:
>
> [PATCH] Bluetooth: Improve support for Actions Semi ATS2851 based devi=
ces
> https://marc.info/?l=3Dlinux-bluetooth&m=3D167846197021176&w=3D2
>
> [PATCH] Bluetooth: Add new quirk for broken set random RPA timeout for=
 ATS...
> https://marc.info/?l=3Dlinux-bluetooth&m=3D167957918920723&w=3D2
>
> [PATCH] Bluetooth: Add new quirk for broken extended create connection=
 for...
> https://marc.info/?l=3Dlinux-bluetooth&m=3D167957998621276&w=3D2
>
> You would end up in the situation mentioned in this thread, and you co=
uld
> resume your tests from there. I haven't had the time to experiment wit=
h SMP yet,
> so any assistance would be greatly appreciated.

The above PCAP files from Linux were logged with those three patches alr=
eady applied. It did not help my situation. And any further feedback on =
this device will not be coming from me, as I already returned it and bou=
ght a supported Realtek device instead.
