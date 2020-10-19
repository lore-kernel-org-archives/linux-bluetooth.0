Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC2C433E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F552225A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 10:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWLmaHrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgJSKIi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgJSKIi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 06:08:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C9BC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 03:08:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t25so13023462ejd.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eO+sfU9p3a6wYac7KK6fViGM9QTWAk8ORNW0ihu4jdA=;
        b=sWLmaHrBOxbdpmClMLIOhQvLSOf0UasVVLXfPMvf/UOZgJydiiESxgkYyZAounnfha
         DJPgQPEg8OLcUAH3Tpc6glvlyT42PjY6aWOXJ77/U0NBEzseLq9y/QtLYEmu9+fRo67Q
         auu7HluS/VUBeWaYIFVub5U3IaicD7b8KAptqRRSetQ7mbe2aaKFHAArSokyMC7rHg61
         tONrTAV5FPsrp4qpp4gzLOuK4/2ujKUSY4L1J7vtxdbYbttyV2gbbQlM7rl27NJVO8yy
         6ZFtZoIOA7D5RqOjqTKlJvhf2hFtmhxYwCIy2HduAlQ5lgc9s80aQhvcmS22r73CGBch
         BBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eO+sfU9p3a6wYac7KK6fViGM9QTWAk8ORNW0ihu4jdA=;
        b=XTSAKsZo29lpKyhQ3iA717QW3kW8PUgvK7whcQaNLzQnUCP2hGC6cDVwfaFT5sEA7g
         qoRfb8hk1QNTftNK3Edy8ZCvck2Ej7SpwYf+vOxap0KrZHFOm731oGCTR+t/Nh+0bIDf
         pkEIc7Q78XkbldyOgPypEv42KyasIxpEOm40Dyyd+c3A/M4lioVtQsMckyOdRhT3k9ba
         XQxp7GXZf8odbQDocfhBN1kdRbl9b9CfSR5TbszCdLyXE9I8aIeHFnoE0gEigEEk7LwH
         +WU62VqYByv8T/i05n1F6BIxmQZFoi9GRC8Q4Wg5uNbpYYvgK/XRLD7OMJ+zc5hUNY7g
         YRGw==
X-Gm-Message-State: AOAM531/AMTSwUkU2yltIkN5leJz0OxQu3Oi8hLaAiLJVwKxAxGBcBCX
        AlxBxUF0oUQWA532jYWUNzxYtdKlHtU7prlJD/EFt8JQT+1h
X-Google-Smtp-Source: ABdhPJxuDw8kPdJZD10+kpWpsm3oMYIl67jvnJcGwvSl0rwRAZIzCLQt6fsDC3cc5gzvu44URzM2ovrHAaFPJngFyK0=
X-Received: by 2002:a17:906:6dc6:: with SMTP id j6mr17413776ejt.354.1603102115322;
 Mon, 19 Oct 2020 03:08:35 -0700 (PDT)
MIME-Version: 1.0
From:   Marek Czerski <ma.czerski@gmail.com>
Date:   Mon, 19 Oct 2020 12:08:24 +0200
Message-ID: <CAOOgLvqcSoaM7hgdzUA+JK0qgHfjhKKcLS2ScWNvsEiEj4xkoQ@mail.gmail.com>
Subject: avrcp: possible race condition during connection establishment
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

I was looking into, so called, absolute volume control that was
introduced in AVRCP v1.4. What I want to achieve is to send audio from
android smartphone to linux based device running bluez and make the
volume control on the smartphone side to control the volume on the
device. So the device is the a2dp sink + avrcp CT/TG and the phone is
a2dp source + avrcp CT/TG.

I assume that if all is working correctly then on the dbus the Volume
property of the org.bluez.MediaTransport1 will be changed by the
volume control of the phone and changes made to this property from the
device would propagate to the phone volume slider.

This is not happening and what I believe is the cause is that
AVRCP_EVENT_VOLUME_CHANGED event registration request sent from the
phone is rejected by the bluez. I can see that on the wireshark snoop
from the device's bluetooth adapter. And on wireshark I see that
AVRCP_EVENT_VOLUME_CHANGED event registration is sent by the phone
before bluez initializes session->supported_events variable (not
really sure about that). I think that this rejection makes the phone
to not send SetAbsoluteVolume commands to the device on volume change.

To test my theory i changed the session_init_control function in the
profiles/audio/avrcp.c to call first target_init and then
controller_init. This caused  the AVRCP_EVENT_VOLUME_CHANGED event not
been rejected and the volume control from the phone works as expected.

After reading AVRCP specification I did not find any reason for the CT
on the phone side not to send event registration immediately after the
AVCTP connection establishment. So I believe that bluez should not
reject event registration in this case.

Best Regards,
Marek Czerski
