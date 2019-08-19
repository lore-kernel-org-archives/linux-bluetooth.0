Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB7C3A5A1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 13:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0256B2064A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 13:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7U9KaOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfHSN6Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:58:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40542 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfHSN6X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 09:58:23 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so4440667ios.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2yK2NEcejpNMZgLFI4b9UPr2wkdggEi8MWE9K/djPC8=;
        b=r7U9KaOSxN7sjCli/Yi+ax+ayvENKLL1aiXta2mc6kCN0WlvC+gqNhtHMwpKlvKLXi
         dllckoy8Ek7PHsJ7PwGF6NX8WVMsUlsbJZu/ODxv1fQQlEIsHyHdlIK0Cwcdg8H+A57Q
         W7ldEE9pbDG3ne3vHRYdNYSmGa9Yk2s7jHSQVy7l9bp/HBO2UVrb0g/b/Iu2jAigRLHy
         cNqjdZv54tC4PK+n+J0LhSnNqDQefmuhMeAE3U0UooUirGnFX52QPXkSmK+GwgfNoZbR
         pHQvri9k+lKEYl2SSAGFxGuTlGHrW7EWeKTtlzainGmUVMcfJzvnp+eM0L27Eyf3ipav
         Id2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=2yK2NEcejpNMZgLFI4b9UPr2wkdggEi8MWE9K/djPC8=;
        b=SQVOoJ1xdLEM/F0cN0u5MAGLJAnQ/lpFCiErr3oQ3zzFLrARvMbjd+4Ggwt/7E5UNp
         QkLFSnY9CR65PhPVbMQuY35RO0uOJGyoktbKUG9I7j2h1tftIn9VKdiPlOyEana2+39/
         reAWEkSVRDFPVkBAqiCqUy/y4iO0lAvu3pmLEbVBa9CD/bDD5T46vDeEXI+EucLW1D8B
         H9dgAY7226yxpW/mh8HVF8SntMwj176KnIkJgch2GqWZFVBx+YN/leShP8RSJ32v4wYg
         pWCCQZFIp7CQyZIfgJZYTCHdYIrCniC0m/p6MFdmJxa6kHMjju9jZa5lj64zpu+ZHKT1
         /BGg==
X-Gm-Message-State: APjAAAVzkbMoASNtrsVpmuHI/4YieihTUyi0TgaWi+xAUGVQoySUQPfj
        6P3KGTBgcjRAshig/4+5neI=
X-Google-Smtp-Source: APXvYqzv45JrZTgVPSWK1uuN1K/OJ+0AzVd5WDsy3QJLdqtYqZP1kx6rhfR35DT/h4FKigw1FBWmJg==
X-Received: by 2002:a5e:9747:: with SMTP id h7mr10744936ioq.299.1566223101735;
        Mon, 19 Aug 2019 06:58:21 -0700 (PDT)
Received: from [10.1.1.187] ([8.39.228.178])
        by smtp.gmail.com with ESMTPSA id e12sm33079682iob.66.2019.08.19.06.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 06:58:20 -0700 (PDT)
Reply-To: csonsino@gmail.com
Subject: Re: [PATCH 1/1] bluetooth: validate BLE connection interval updates
To:     Andreas Kemnade <andreas@kemnade.info>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Sasha Levin <sashal@kernel.org>
References: <f9176553-d4d5-c2e0-ecd7-937cac0d8098@gmail.com>
 <138296C5-49FA-475D-9618-FC8D241B8823@holtmann.org>
 <20190815104419.161177fa@kemnade.info>
From:   Carey Sonsino <csonsino@gmail.com>
Message-ID: <0cda8242-304e-a073-90d8-63e656e3600c@gmail.com>
Date:   Mon, 19 Aug 2019 07:58:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815104419.161177fa@kemnade.info>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This seems like the exact "downside" situation that I described in the 
patch writeup.

I would still claim that as a Linux system administrator, I should have 
control over my system.  If I am operating in a low power environment, I 
do not want to allow a remote device to apply a setting which causes me 
to use more power without any say in the matter.

The connection min/max interval settings are configuration options that 
control how my bluetooth device operates.  Why are these down in debugfs 
anyway?  I think that a much more appropriate fix would be to migrate 
some of the BLE configuration options to sysconfdir (some place like 
/etc/bluetooth/ble.conf).  That would also help in the persistence of 
these configuration settings, which is kind of a pain with the debugfs 
mechanism that gets wiped out and recreated on bootup.

A quicker fix would be to simply set the default connection min interval 
and connection max interval values to the full range (6, 3200).  I 
*think* that this could be done by simply updating the values in 
hci_core.c, the hci_alloc_dev() function:

     hdev->le_conn_min_interval = 0x0018;
     hdev->le_conn_max_interval = 0x0028;

would become:

     hdev->le_conn_min_interval = 0x0006;
     hdev->le_conn_max_interval = 0x0c80;

This should allow all devices to negotiate whatever connection interval 
they want by default.  If I'm running on a device with debugfs (which I 
happen to be most of the time), then I can still override these defaults 
to control my system.

Please let me know if you would like me to do any further work towards 
resolving this issue.  I'd be happy to test and submit a patch that 
changes the default connection min/max interval values- I could probably 
get that done in the next day or two.  If you would like me to 
investigate migrating configuration settings to /etc then I'd be happy 
to do that as well, but it might take a bit more effort and time.

Regards,

Carey


On 8/15/19 2:44 AM, Andreas Kemnade wrote:
> On Sat, 6 Jul 2019 15:34:34 +0200
> Marcel Holtmann <marcel@holtmann.org> wrote:
>
>> Hi Carey,
>>
>>> Problem: The Linux bluetooth stack yields complete control over the BLE
>>> connection interval to the remote device.
>>>
>>> The Linux bluetooth stack provides access to the BLE connection interval
>>> min and max values through /sys/kernel/debug/bluetooth/hci0/
>>> conn_min_interval and /sys/kernel/debug/bluetooth/hci0/conn_max_interval.
>>> These values are used for initial BLE connections, but the remote device
>>> has the ability to request a connection parameter update. In the event
>>> that the remote side requests to change the connection interval, the Linux
>>> kernel currently only validates that the desired value is within the
>>> acceptable range in the bluetooth specification (6 - 3200, corresponding to
>>> 7.5ms - 4000ms). There is currently no validation that the desired value
>>> requested by the remote device is within the min/max limits specified in
>>> the conn_min_interval/conn_max_interval configurations. This essentially
>>> leads to Linux yielding complete control over the connection interval to
>>> the remote device.
>>>
>>> The proposed patch adds a verification step to the connection parameter
>>> update mechanism, ensuring that the desired value is within the min/max
>>> bounds of the current connection. If the desired value is outside of the
>>> current connection min/max values, then the connection parameter update
>>> request is rejected and the negative response is returned to the remote
>>> device. Recall that the initial connection is established using the local
>>> conn_min_interval/conn_max_interval values, so this allows the Linux
>>> administrator to retain control over the BLE connection interval.
>>>
>>> The one downside that I see is that the current default Linux values for
>>> conn_min_interval and conn_max_interval typically correspond to 30ms and
>>> 50ms respectively. If this change were accepted, then it is feasible that
>>> some devices would no longer be able to negotiate to their desired
>>> connection interval values. This might be remedied by setting the default
>>> Linux conn_min_interval and conn_max_interval values to the widest
>>> supported range (6 - 3200 / 7.5ms - 4000ms). This could lead to the same
>>> behavior as the current implementation, where the remote device could
>>> request to change the connection interval value to any value that is
>>> permitted by the bluetooth specification, and Linux would accept the
>>> desired value.
>>>
>>> Signed-off-by: Carey Sonsino <csonsino@gmail.com>
>> patch has been applied to bluetooth-next tree.
>>
> There are devices which require low connection intervals for usable operation,
> e.g. BLE smartcard readers. having 30ms instead of 7.5ms means speed four times
> lower.
>
> Other devices might want to set the connection interval  to high values to save
> power.
>
> So if the device is not allowed to set the connection interval to such values,
> how should the driver sitting on top of the gatt dbus interface of bluetoothd
> set such things?
>
> The debugfs nodes are not necessarily available in distro kernels. Anything
> sitting on top of gatt dbus interface does not have access to the connection handle
> and cannot call hci_le_conn_update() to set things to nice values.
>
> Using l2cap sockets instead of the dbus gatt interface is also not a viable altenative
> because it interferes with bluetoothd.
>
> So IMHO this patch causes regressions and should be reverted.
>
> Sorry for stepping out this late.
>
> Regards,
> Andreas


