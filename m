Return-Path: <SRS0=v5pE=ZW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A445DC432C0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB02075A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 18:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjAutFLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3Swn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:52:43 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:46150 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3Swm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Nov 2019 13:52:42 -0500
Received: by mail-io1-f50.google.com with SMTP id i11so35742607iol.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Nov 2019 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4MJFIfzrzlkMFkbPkTZe2S4JsJL0B15h4NuZDBKvGrg=;
        b=hjAutFLT2G9A6nCWHmUWs3iMt8IV58ZvHoyPPdmC6XpmHyH/hbaXALbRGGru1+jPXZ
         d6tBUTmQl0zDKsMi4A11jcmFO2umlQ6xqIVRn6pXqt3AEWnJw+rU57sn9rD3RU6njv3b
         RvArhJinzdjVUn4AsiXcnPTXNvMN+yn+VNJ9G7vnQgE9/lIvEEjmo+wotM9HGpSvAESd
         HEp5nwQPegNGUoLSqoFH8oeSy5DXNW0jkehjLYe7sQBasr610sJNX4T+9CTg9KVZ9/ie
         wdR35xtPvYJgdB296wo5nnmvFT1x0oK7AergXwjJ6eHaAWxxr2+DGhYYXAEA7WnX6cPD
         jb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4MJFIfzrzlkMFkbPkTZe2S4JsJL0B15h4NuZDBKvGrg=;
        b=WSI0IQRk1mBJG2puDMe7CmgFZfLDS74MQU6zbRH5RoDL7zb9lcrKeboP1E6h9D1OLM
         sjFVgdUJkDLY//4CWq6O79lDTJcSFQulgMvlbee68REd7vHpL7MWaltWwrNryz9MQQa8
         tBEmTI2sLrqIvFF1LUO/WYRoDyrzlFEQHWV9+1trf+K37sJobfX1LTjMg2qhXhLNldW3
         tK2L5zrQu6NtWK8z++ylofnE3x+gXGw9ziETDYu2mj6vZkNVfMPVizC6U+6vI9UR1l6Z
         hxW4RfNa7rqCggZdYrgsK4gcRk4027REEZussoeEu/NUvi51fKrRBb8nMwHgTZBOILGH
         4X+g==
X-Gm-Message-State: APjAAAVu2W40IQaEGhab359OFFSpMC8w9yH/jNO/rXj1hoz91NRfmi3a
        0RpJcJd3FAv5El0YPx5kwWEaii8l+/a6DofL/3887VsT
X-Google-Smtp-Source: APXvYqxyQcZxrFP5GnGOYsFp92m3ytoJCzZ+aYzVHKf8FZ+pGgk89fQVVX3QsvDtUJHmGLPfixPhteW9l+nT4kcA2hk=
X-Received: by 2002:a6b:f701:: with SMTP id k1mr52348174iog.260.1575139961842;
 Sat, 30 Nov 2019 10:52:41 -0800 (PST)
MIME-Version: 1.0
References: <CADqM=-wgFoxbnuBb1XwSyueg=cTCN=9tCrSDxRp-Pq8HnLo-zQ@mail.gmail.com>
In-Reply-To: <CADqM=-wgFoxbnuBb1XwSyueg=cTCN=9tCrSDxRp-Pq8HnLo-zQ@mail.gmail.com>
From:   Abhi Arora <engr.abhiarora@gmail.com>
Date:   Sun, 1 Dec 2019 00:22:30 +0530
Message-ID: <CADqM=-wzCdi9gq0tBCkUVSbj0j6J4qgyPmt8Hjf9iWBBJ2TZYw@mail.gmail.com>
Subject: Re: Using Bluez as Peripheral and connect to multiple Central simultaneously.
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Is it right platform for this question?

"Hello,
I got to know that BLE v4.1 supports peripherals being connected to
multiple central simultaneously (I know there could be some limit on
the number of connections). I want to know if it doable in BlueZ and
if it requires some support from the BLE Chipset/IC, please specify
the HCI commands to look for it in the datasheet of the chipset.

If it supports, is it stable in the current Bluez stack?

I also want to advertise (being peripheral) while connected to other central.

Please help."

On Thu, Nov 28, 2019 at 11:58 PM Abhi Arora <engr.abhiarora@gmail.com> wrote:
>
> Hello,
> I got to know that BLE v4.1 supports peripherals being connected to
> multiple central simultaneously (I know there could be some limit on
> the number of connections). I want to know if it doable in BlueZ and
> if it requires some support from the BLE Chipset/IC, please specify
> the HCI commands to look for it in the datasheet of the chipset.
>
> If it supports, is it stable in the current Bluez stack?
>
> I also want to advertise (being peripheral) while connected to other central.
>
> Please help.
