Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24511C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 20:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07532083B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 20:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CICI+TRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGUYZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 16:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUYZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 16:24:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D5DC05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 13:24:23 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r25so6416553oij.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPDSoIGlKBnhD0hfymMJ0hDYHcPFSakSRoe2LcTL95Y=;
        b=CICI+TRnz0BuQ2i1EXESJxvkZV/80/USa8XEMxsKA5rfBDsVDZbBsiFa2tWF10K5MO
         pE6itEiwbOoAuq3ZKOynnvq7ZGL4tJfH4CvgnpfWrGbPpHQYaHEF68FSn6JaE3Od5hYT
         ROgudw0HWcYS+Fn6SW6cBLZPGhwTFoiUWifiPa413+OQ3td9QHu7y8U7gdl3Jr/b2Hcq
         TbjwyN9UUxcV07/7jgK+1X+/D1bU01wwEsJBYqHOyajlJbFqikBI2ReCgy7Ob+nrfmAY
         4cm1kR3+owyJ4opH8FmE5vroLt5Evl95oYZi36aKqKBla6BV6NXjUXB0/cg8BAALTsbM
         1S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPDSoIGlKBnhD0hfymMJ0hDYHcPFSakSRoe2LcTL95Y=;
        b=Y0+L6oMbyfZyzwQskeWrWhr8nJ7qFiaxdrkOH79U6moB53zpqrgvk68+nN8J99tMlL
         U8/xAoWq/jH5MA1268niJgelzMPeHv8A5+P5l5ZLtq3KvojIpVjPA8Gj0YjhDs8z7lfT
         IUGPe4+0ROXayeB6aVRpNhrLJO4kbSSDc81qdAt4zc8YUalKdWzL0AFXSWQy1PbahDiU
         02uo1yJoPljmJMlxnrSKMcErI7kV/lrbU7keVc/ImRjgS8QVOYiBZurCsrumqG/QTWU1
         Oc/wOyRCrOs1/tkGejsMMQ/GEmaxU6g0fRTBZdF61IqeppiiYzlJ5FBeEUY/Xt8fVhrG
         PATA==
X-Gm-Message-State: AGi0PubfZl41LvMuKyjdnrELp2a9js+fnOi13Bq4nHNgyPDhGMdwF6Z6
        EwMFM04FHPcyuy1Mnd3j+J1npbVu7Zti7OmjP+g=
X-Google-Smtp-Source: APiQypIaW1Yqhnnc1koD56SDvPvrMXA9J5qSfFQwBN1nt0pZQJV1nUf2l4zux2QwZ5rmne4AfNGpXMAPJrBFq233yZ0=
X-Received: by 2002:aca:acd0:: with SMTP id v199mr7676876oie.82.1588883062735;
 Thu, 07 May 2020 13:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <1588847119436.26848@mentor.com>
In-Reply-To: <1588847119436.26848@mentor.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 May 2020 13:24:11 -0700
Message-ID: <CABBYNZ+a3Br71ExTi1XUa7UnDry2dNBaomz-+z7sVtVH_5toCQ@mail.gmail.com>
Subject: Re: Incorrect advertise flags in bluetooth beacon using BlueZ
To:     "Karim, Hafiz Abdul" <HafizAbdul_Karim@mentor.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hafiz Abdul,


On Thu, May 7, 2020 at 3:36 AM Karim, Hafiz Abdul
<HafizAbdul_Karim@mentor.com> wrote:
>
>
> Using nRF Connect android application, I'm getting incorrect advertise flags in bluetooth beacon using BlueZ
> I have tried on two bluez versions i.e 5.48 and 5.52.
>
> I have set ControllerMode to "le" in main.conf. Using bluetootctl, when I turn on the advertisement using command "advertise on", I get 0x02 advertisement flag. Which means "BR/EDR Not Supported" (Bit 2) is not set.
> Now, if i restart the bluetooth service, and turn on the advertisement again, I get 0x06 advertisement flags.

Are you saying we are not updating the service once main.conf has
changed? We don't do that automatically if that is what you are
referring to, also if you want to advertise as a beacon/broadcaster
and not as peripheral thean us you should use advertise broadcast.

> Here is my main.conf
>
> [General]# Default adaper name
> # Defaults to 'BlueZ X.YZ'
> #Name = BlueZ# Default device class. Only the major and minor device class bits are
> # considered. Defaults to '0x000000'.
> Class = 0x000100# How long to stay in discoverable mode before going back to non-discoverable
> # The value is in seconds. Default is 180, i.e. 3 minutes.
> # 0 = disable timer, i.e. stay discoverable forever
> DiscoverableTimeout = 0# How long to stay in pairable mode before going back to non-discoverable
> # The value is in seconds. Default is 0.
> # 0 = disable timer, i.e. stay pairable forever
> #PairableTimeout = 0# Automatic connection for bonded devices driven by platform/user events.
> # If a platform plugin uses this mechanism, automatic connections will be
> # enabled during the interval defined below. Initially, this feature
> # intends to be used to establish connections to ATT channels. Default is 60.
> #AutoConnectTimeout = 60# Use vendor id source (assigner), vendor, product and version information for
> # DID profile support. The values are separated by ":" and assigner, VID, PID
> # and version.
> # Possible vendor id source values: bluetooth, usb (defaults to usb)
> #DeviceID = bluetooth:1234:5678:abcd# Do reverse service discovery for previously unknown devices that connect to
> # us. This option is really only needed for qualification since the BITE tester
> # doesn't like us doing reverse SDP for some test cases (though there could in
> # theory be other useful purposes for this too). Defaults to 'true'.
> #ReverseServiceDiscovery = true# Enable name resolving after inquiry. Set it to 'false' if you don't need
> # remote devices name and want shorter discovery cycle. Defaults to 'true'.
> #NameResolving = true# Enable runtime persistency of debug link keys. Default is false which
> # makes debug link keys valid only for the duration of the connection
> # that they were created for.
> #DebugKeys = false# Restricts all controllers to the specified transport. Default value
> # is "dual", i.e. both BR/EDR and LE enabled (when supported by the HW).
> # Possible values: "dual", "bredr", "le"
> ControllerMode = le# Enables Multi Profile Specification support. This allows to specify if
> # system supports only Multiple Profiles Single Device (MPSD) configuration
> # or both Multiple Profiles Single Device (MPSD) and Multiple Profiles Multiple
> # Devices (MPMD) configurations.
> # Possible values: "off", "single", "multiple"
> #MultiProfile = off# Permanently enables the Fast Connectable setting for adapters that
> # support it. When enabled other devices can connect faster to us,
> # however the tradeoff is increased power consumptions. This feature
> # will fully work only on kernel version 4.1 and newer. Defaults to
> # 'false'.
> #FastConnectable = false[Policy]# The ReconnectUUIDs defines the set of remote services that should try
> # to be reconnected to in case of a link loss (link supervision
> # timeout). The policy plugin should contain a sane set of values by
> # default, but this list can be overridden here. By setting the list to
> # empty the reconnection feature gets disabled.
> #ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb, 0000111f-0000-1000-8000-00805f9b34fb, 0000110a-0000-1000-8000-00805f9b34fb# ReconnectAttempts define the number of attempts to reconnect after a link
> # lost. Setting the value to 0 disables reconnecting feature.
> #ReconnectAttempts=7# ReconnectIntervals define the set of intervals in seconds to use in between
> # attempts.
> # If the number of attempts defined in ReconnectAttempts is bigger than the
> # set of intervals the last interval is repeated until the last attempt.
> #ReconnectIntervals=1, 2, 4, 8, 16, 32, 64# AutoEnable defines option to enable all controllers when they are found.
> # This includes adapters present on start as well as adapters that are plugged
> # in later on. Defaults to 'false'.
> AutoEnable=true
>
>
> And bluetooth.service
>
>
> [Unit]
> Description=Bluetooth service
> Documentation=man:bluetoothd(8)
> ConditionPathIsDirectory=/sys/class/bluetooth[Service]
> Type=dbus
> BusName=org.bluez
> ExecStart=/usr/libexec/bluetooth/bluetoothd -d -n --configfile /etc/bluetooth/main.conf
> NotifyAccess=main
> #WatchdogSec=10
> #Restart=on-failure
> CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> LimitNPROC=1
> ProtectHome=true
> ProtectSystem=full[Install]
> WantedBy=bluetooth.target
> Alias=dbus-org.bluez.service
>
> Any guidance/pointers?
>
>
> Thanks,
> Abdul Karim
>
>
>
>
>
>


-- 
Luiz Augusto von Dentz
