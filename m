Return-Path: <SRS0=wWzP=ZA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D21C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Nov 2019 02:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1327E21882
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Nov 2019 02:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c+wvsAg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfKHCE2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:04:28 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:40872 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHCE2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Nov 2019 21:04:28 -0500
Received: by mail-qk1-f182.google.com with SMTP id z16so3925010qkg.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2019 18:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2gJXdS8n/Z4E33qZju6i0lJ1SLBNFhBSOGRO1i9g/KU=;
        b=c+wvsAg5bI7hJ2u+3LvTH3zo6rku0GyRI3XuPtzkt/cyOyNBU+uzmbyXM4FkTqaeG1
         0TeSMmywi6lrUWd3CrOHrpMXJL3XGaEAaDEZo//oEU9tPrdS1k8KVUyLZd5P29clZ9Se
         3K//CfGEyq856um3ZmsRf3qPficyQe2GHlndo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2gJXdS8n/Z4E33qZju6i0lJ1SLBNFhBSOGRO1i9g/KU=;
        b=R1IH1kYkrNZor7NFb2IfTDIooBiL3zii3HcAAv6foisbuLOqrvIsr2ihYKob+JR720
         yK3mb0E3vhvnTQPmrG6no68nmpEYAWBhCGQRxWMBvuEzZJmulSPOmlLoJ9O8d+/5xJmK
         iyk5ZaHNnYLNOJ7u4qrSnje2cmEW5qaSUKkqsIMBfC5O3V3lMnQX5Yw7uBkyqRVfWCr9
         bt1BnRAOGoa67VgjMXT39byeCsQKgi18Sj+vd+bK+eQddXXHDfkO7rvBuCF5utdRPoW/
         ExmC/d5ZNbRNc0XKSDpJoJnTNRirLyMw7JOK57jDx8Ire8n0oD87NtPvFjxEbH/vr+8G
         4LLw==
X-Gm-Message-State: APjAAAX0J23JWNjhDucAI1xGxanZxUfzGVMbUObpEElW/x4r9mU+9/jo
        /nIn7JEp9LGVymgl8ELmsASqt/ogGw5iRWQyxuRWSQ==
X-Google-Smtp-Source: APXvYqwAc9bL4cjkHgy48fK84OmvPZAH95bXWdygOImMO0ZJN1zE489UBydJPMduNUuSCERiX4tsqxEV7hf+hjjdlK4=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr6302911qkg.331.1573178665583;
 Thu, 07 Nov 2019 18:04:25 -0800 (PST)
MIME-Version: 1.0
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 7 Nov 2019 18:04:14 -0800
Message-ID: <CANFp7mVOh5KPYPPnbGO_YnV-mBGTV3gYgWcPNSMq+=aBzBM00Q@mail.gmail.com>
Subject: RFC: Managing devices around system suspend in bluez
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Yoni Shavit <yshavit@chromium.org>, alainmichaud@google.com
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On ChromeOS, we are currently trying to design how bluez should behave
during system suspend. This is motivated by the fact that bluetooth
can be a noisy source of wakeups on a system and historically has been
noisy on ChromeOS.

Here are some problems we've seen:
- If the system suspends while discovery is active, advertisements
will continue arriving on the host and will wake the system
- Pairing a LE keyboard/mouse and disconnecting it (via link loss)
results in a passive scan of all advertisements (and these will wake
the host)

To resolve this, we propose adding a SuspendImminent and SuspendDone
dbus api to inform bluez that suspend is about to occur and the system
has resumed.
(These names are based off the ChromeOS Power Manager's existing
design: https://chromium.googlesource.com/chromiumos/platform2/+/master/power_manager/docs/suspend_resume.md)

In the suspend imminent handler, we would do the following in order:
* Pause any discovery
* Set an event filter for all paired devices capable of waking the
system (anything that creates uhid or uinput virtual devices)
* Disconnect all connected devices (with a soft disconnect)
* Enable background scan with whitelist of devices that should be able
to wake the system (** see below for comments about IRK resolution)

In the suspend done handler, we would do the following in order:
* Clear the event filter
* Enable background scan with non-suspend logic (** see below for
comments about IRK resolution)
* Unpause discovery (if it was running before suspend)

We expect this will result in the following:
* Classic: A paired device can wake the host if it's in the event filter
* LE: A paired device can wake the host if it's in the whitelist and
it sends an advertisement (undirected if in the whitelist, directed if
targeting our host; i.e. filter_policy = 0x1 or 0x3)

Do you think the actions taken in the suspend handlers are sufficient?
Any concerns or things to look out for?

Thanks
Abhishek

IRK Resolution:
With this design, we have some problems with IRK resolution on BT
version < 4.2. Devices supporting BT Privacy 1.2 may start using
resolvable private addresses for both initiator and destination.
Without address resolution in the controller, we have to set the
filter policy to 0 (allow all) so that we can do address resolution on
the host.
Implementing these privacy features are outside the scope of this RFC
so we will disallow wake up from suspend for these devices (set filter
policy to accept only whitelist and directed). Once bluez supports
Privacy 1.2, wakeup from these devices will work on controllers with
BT version >= 4.2.
