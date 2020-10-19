Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC85C433E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C85A2177B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1x53QSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgJSOQO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJSOQO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 10:16:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4786C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 07:16:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dt13so14096187ejb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRlq7MRSCFQ/vR/TXV3EeifLVws1XMkB6CnguS9s3cs=;
        b=J1x53QSAN9bhf1N39QLSGd+zoEd1zZVdG7dVBLyKLUar4X7v0q48W6Gj0uOJ1PHHZL
         RLmUalYI50RWyv3M+FkgkOlnuJ+N4N4IgjV1mDv2BPLw4239Vjkydi6Dk9wSh89IYbHF
         AAb+UNrM5QEL9aVxUDw6HSLGPN9ixCClZMEPUTE0WHSQ4SUnNfIWzmLeso0AEyh18G9p
         OyV9YmoaWMyUVQn4p9XGltW1YIFncBXp8qFWleSYLaBUEsTDZOowqObK57nbW1T0IjV/
         DMFyZfwK8c9OfpSrn1nnuK1tbvD8CZhDHZbHwj5yPujUYwAW9h44s8gHSsbvsuo/XZGe
         AUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRlq7MRSCFQ/vR/TXV3EeifLVws1XMkB6CnguS9s3cs=;
        b=YHiB0VQke0bGWhMmsLYzl2aLrrzJmUAhRP54AFYnR7jsx3HQAjN9mhvZTimVg/8hup
         Sc4NhIMm7yt/nEAW/VqpybPgjgoKWnzXJmbyscBuEevA2aIcmkDeETvJeM2oncOfV1Dv
         YKC7YSWEXLlhZCq6hq3LQqPn2llg2B/K48rO7KhZvwWPfXrLDh9OCmqHWnTwzQQo4Q8m
         b3bL9CAV/Rv11Ax+AnUvch5NitQTSNckxuk50xyWtjEYQcmTbFOWIIt8IhmKysm4nz7z
         ISVwTuQVfkfdWuoU2QIkWyBSCW8TdNzJFkzvbtm+gXoILlqwH/ia5g+tB9bSJa8QuX7d
         94Ew==
X-Gm-Message-State: AOAM533rx+e1AO9pGBICI0ej3iAOuZzcuA34i422ROTU7sV0usDeoou7
        Vwz9EzMhto+4tbumMQFGYSibVaI2PZGXSg==
X-Google-Smtp-Source: ABdhPJz6+hU/boDphNQOFvG3P5f0tklnBthF2rJULAc4zs+j+5JauRW6oui5gKAbVQRd+VChpRSLlg==
X-Received: by 2002:a17:907:435e:: with SMTP id oc22mr60357ejb.485.1603116972381;
        Mon, 19 Oct 2020 07:16:12 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id e4sm5705870eds.50.2020.10.19.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:16:11 -0700 (PDT)
From:   Marijn Suijten <marijns95@gmail.com>
To:     ma.czerski@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: avrcp: possible race condition during connection establishment
Date:   Mon, 19 Oct 2020 16:16:08 +0200
Message-Id: <20201019141608.401899-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAOOgLvqcSoaM7hgdzUA+JK0qgHfjhKKcLS2ScWNvsEiEj4xkoQ@mail.gmail.com>
References: <CAOOgLvqcSoaM7hgdzUA+JK0qgHfjhKKcLS2ScWNvsEiEj4xkoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek,

> Hi all,
>
> I was looking into, so called, absolute volume control that was
> introduced in AVRCP v1.4. What I want to achieve is to send audio from
> android smartphone to linux based device running bluez and make the
> volume control on the smartphone side to control the volume on the
> device. So the device is the a2dp sink + avrcp CT/TG and the phone is
> a2dp source + avrcp CT/TG.
>
> I assume that if all is working correctly then on the dbus the Volume
> property of the org.bluez.MediaTransport1 will be changed by the
> volume control of the phone and changes made to this property from the
> device would propagate to the phone volume slider.
>
> This is not happening and what I believe is the cause is that
> AVRCP_EVENT_VOLUME_CHANGED event registration request sent from the
> phone is rejected by the bluez. I can see that on the wireshark snoop
> from the device's bluetooth adapter. And on wireshark I see that
> AVRCP_EVENT_VOLUME_CHANGED event registration is sent by the phone
> before bluez initializes session->supported_events variable (not
> really sure about that). I think that this rejection makes the phone
> to not send SetAbsoluteVolume commands to the device on volume change.

I looked into the same issue earlier this year, see
20200118194841.439036-1-marijns95@gmail.com [1].  The gist of it is that BlueZ
bases supported_events solely on the remote AVRCP controller version, which
Android sets to 1.3 when it is a media source [2].  This version is not
relevant in your use-case because the Android phone is the AVRCP target while
blueZ is the controller.

It was decided in that mail thread to split supported_events in two; one based
on the external controller version (when BlueZ operates as target it'll
validate incoming notification registrations) and the other based on what BlueZ
currently supports as controller.

The second check might not be all too relevant and is already covered by the
switch-case; perhaps it makes more sense to base this check on the external
target version, and again validate whether we expect to receive that particular
notification registration?

Both checks together implicitly validate what BlueZ supports locally in its
role of controller or target, as remote_{target,controller}_supported_events
(anticipated names of the new members replacing supported_events) will only be
set to events that BlueZ is able to emit.

Unfortunately my ramblings in that mail shadowed an important question: how to
determine in avrcp_handle_register_notification whether BlueZ is running as
controller or target?  set_volume in transport.c derives this from
transport->source_watch but there seems to be no easy access to the
accompanying transport in avrcp_handle_register_notification.  With this
question answered I'll be able to update and resubmit the original patch.

> To test my theory i changed the session_init_control function in the
> profiles/audio/avrcp.c to call first target_init and then
> controller_init. This caused  the AVRCP_EVENT_VOLUME_CHANGED event not
> been rejected and the volume control from the phone works as expected.
>
> After reading AVRCP specification I did not find any reason for the CT
> on the phone side not to send event registration immediately after the
> AVCTP connection establishment. So I believe that bluez should not
> reject event registration in this case.
>
> Best Regards,
> Marek Czerski

Best regards,
Marijn Suijten

[1]: https://marc.info/?l=linux-bluetooth&m=157937699001093
[2]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r4/bta/av/bta_av_main.cc#761
