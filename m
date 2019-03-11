Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C4AC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 18:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E349920643
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhAy/Fna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfCKS1o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:27:44 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:39702 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKS1o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 14:27:44 -0400
Received: by mail-wm1-f42.google.com with SMTP id t124so121322wma.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2019 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bl7aw/oUm/PPOXKsj2a/wyaDaO4lzWzQVnA7cADCFgI=;
        b=vhAy/Fnakcf5RdOUIq+aboaCoFKt5CKdaWUdqy4zLALX2GoZCKNejMI2y1ZssR2H7G
         1D62uAkTNnoDZLTECjsX+noOPBn05jgt6xqQWQfVvXfhj9Y/2Zjnc+XytrnkRcjfdiKM
         HojIp5zvHdj/a+5EPwwKQTddTw6VEL2D0RrBpiS+LqgYnl3wEqiBvEgqAruADsbYhm13
         6WLTXLBjeFHWAswJKSo6yiDmkfk0GIe2qRDlCu6kl/1B0DLJ9xQowq5sV+/IUAm4KRn6
         PjzFHuCnYf5MWCjC8q/ydkeelCEz3lwSQz18dDlZ1j+j1sfFPOoRt1L6qcqh06wduLLI
         /afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=bl7aw/oUm/PPOXKsj2a/wyaDaO4lzWzQVnA7cADCFgI=;
        b=TQiAYcsnoxvyoLSsEb6HXZPNR4uknpaO9D8WIP+ZCrquHcKBF04Um5enU81YKVTdN8
         9ItwFcDPTVTHd8Hdc1tIfEn5+HYtPEX9NIqEAF39/QDDyOxDxDXreBVY5GMuvnm1swkm
         DWgXPecncD7P/HHqp6FF9m8J6WjYukDTijpn5E7kpY4OMz1rNFhDB/E5Mbb8yn6BEwK9
         U0j+Jc+gyTt5wjaJtalG6y6f1yXaJr7cJtiydVmAW2OA+LIBeJonipE0bRFGG9HDhh79
         l0FHBH3NBnZNw7cjaldk/0C1x5uqkWBs8zh4CX4q1Mbhu/mySIbVjjXuphcogfavtAbe
         1VSA==
X-Gm-Message-State: APjAAAV9wOGdGxqqB2qMhYG99PY8/YUE2LJM6sG2yiCCAJdzf5touYbb
        cvMlx7UzHma1u7itnXraGltD5ekI
X-Google-Smtp-Source: APXvYqwrRTlqEKurlJLRPtdRSgyfvfQXVeLtl9H8prh/XE7oO5KL7O9E8OTkRdJmvHmwK7KVzTtovw==
X-Received: by 2002:a1c:c109:: with SMTP id r9mr42211wmf.36.1552328861534;
        Mon, 11 Mar 2019 11:27:41 -0700 (PDT)
Received: from [10.200.101.254] ([137.204.150.11])
        by smtp.gmail.com with ESMTPSA id o5sm12642132wrv.70.2019.03.11.11.27.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 11:27:40 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
From:   Sergio Callegari <sergio.callegari@gmail.com>
Subject: Issues with rfcomm: rfcomm_bind: Address already in use (98)
Message-ID: <b371cdcc-dc09-4041-536c-04f60883097d@gmail.com>
Date:   Mon, 11 Mar 2019 19:27:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

writing with reference to an issue with bluez 5 and rfcomm found in recen=
t linux=20
distributions (seen on ubuntu 18.04, 18.10 and fedora >=3D 27).

Libreoffice uses rfcomm to let a mobile phone using a dedicated applicati=
on work=20
as a remote and as a pointer for presentations.

This has worked fine until slightly more than 1 year ago, then it has bro=
ken.

Starting libreoffice impress shuld activate an rfcomm listener for incomi=
ng=20
bluetooth connections from the app running on the mobile phone.=C2=A0 How=
ever, it=20
does not succeed and an entry is created in the system logs (visible with=
=20
journalctl). For instance

bluetoothd[1470]: RFCOMM server failed for LibreOffice Impress Remote:=20
rfcomm_bind: Address already in use (98).

- libreoffice started supporting bluez 5 a few years ago, and I have=20
successfully used the remote with bluez 5 (e.g. i ubuntu 17.x)

- libreoffice developers indicate that nothing has changed on their side =
and I=20
have confirmed that older versions of Libreoffice have the same issue on =
recent=20
distributions.=C2=A0 For this reason, the libreoffice developers are relu=
ctant to=20
looking into the bug, and tend to think that the problem may be in a regr=
ession=20
or a change of behavior in bluez or in the way in which recent distributi=
ons=20
deploy bluez breaking their application.

- distributions appear similarly inactive on the bug until one can actual=
ly=20
point at something proving that the issue is on their side.

Unfortunately, the message on the system logs is not detailed enough for =
me to=20
try to understand where the issue may lay.

I am thus asking for advice on how to try identifying whether the problem=
 is in=20
a the bluetooth kernel code, in the bluetoothd daemon code, in the bluez =
dbus=20
api, in libreoffice or in the way distributions package and configure blu=
ez, so=20
that I can address a bug report to the appropriate developers.

Thanks,

Sergio


