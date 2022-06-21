Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13008C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiFUTNp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFUTNo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:13:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE83B13E09
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:13:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so23983390lfg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7eBesiERH0JVmkcMi1fBa7JsyR5GPtjmf/w4neP6a4=;
        b=CzeEYkzD2YW1onhb2PHWD5qY08xBS8trahyBdD20NntMb7Q1BoTHomUSHMvQVd8JBG
         Siid2uB44zsl+4qZrNiieF4xYfsSlEtEVFwGIQZiVOsxXuTa5EHRsnA/1zBLKb45u+93
         DKzpaF2l4JgKIG4DdxC8/WUolqvM5A8AeuyFN6C9tplNfOuq/8UFwhbTw18TVCYiOOec
         SbSMBoylRa6parKId2tcexZKjY6t8F2YKa487dQ4AZ8IXDZm8pAFayRNULVFn/duGI5M
         2nLznro+g/VfECf8vq3Q+gOF47Ud7om27mexOwoLc0MLRaqEjh1tISXjJlbr/EKJSZpM
         u3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7eBesiERH0JVmkcMi1fBa7JsyR5GPtjmf/w4neP6a4=;
        b=scyi1EJM8tOOrLfmBLIAIGrgZieyWCtws49sT9t7LeoaXpFKwXj+8vfFfX/WBTxnnb
         eA4WRu5RM1BAldFmgnsZUFILgj2oIWDLBTWU8EE8LJ525YbKrsYHSwb3u1DbcSbTWD7z
         wYrA0dTjQnsJiu2tV0YpzobqcAUbgscJhAfd0fdWLBQvt4A93gn4WaPODOF9/j7G7Dwy
         hp7xn25XOobSjJ+8RsU1XFlsdjTzRqzyyBhV8etTxmetBVKvhA1cZOGg/sL/4YM9ZhFA
         9T0NYz/e6pnkMH6Mmtl8P0UHv47CsJWdkxMQjmMWEeDFO2TBq+XHn4WvmbKvZAAol9fK
         8qCQ==
X-Gm-Message-State: AJIora/IsNoQz2v8UStnwrJ7HXaOmJ3lsAwI6xWgljRDRtG5hf/vrNIK
        I3WYJBs+vWkqaGIhbDtkJSyWZrTv9srPLgzmo80=
X-Google-Smtp-Source: AGRyM1tItkMlRTPwlpgk15FAVpzAuujfFH55pE9kTxKvacCQIE8tO/QjeptDbBgsJyiQ5foRACSRqj8F0k3+AC/E8nM=
X-Received: by 2002:a05:6512:2204:b0:479:7c21:bff8 with SMTP id
 h4-20020a056512220400b004797c21bff8mr17702261lfu.251.1655838822102; Tue, 21
 Jun 2022 12:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755580E109362B165C9688FFEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB5755580E109362B165C9688FFEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jun 2022 12:13:30 -0700
Message-ID: <CABBYNZL_C5cb0OPQqw07JiFEeYEYL8aJDhUArE6KaUzXqfCOYg@mail.gmail.com>
Subject: Re: [BUG] Use of gatttool causes scan to stop (permanently?)
To:     John Klug <John.Klug@multitech.com>
Cc:     "linux-bluetooth@vger.kernel.org Bluez Kernel" 
        <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Tue, Jun 21, 2022 at 12:00 PM John Klug <John.Klug@multitech.com> wrote:
>
> I am using 5.4.199 currently with bluez 5.64 on an arm 32.  The same problem occurs in earlier versions and kernels.
>
> In bluetoothctl after the issue occurs the "show" command always says:
>     Discovering: yes
>
> And no scan data follows, even though we have many devices.
>
> I have tried turning on duplicate data with bluetoothctl.
>
> I see (manually typed in):
>   [bluetooth]# scan on
>   SetDiscoveryFilter success
>   [bluetooth]# scan off
>   Failed to stop discovery: org.bluez.Error.InProgress
>   [bluetooth]# scan on
>   Failed to start discovery: org.bluez.Error.InProgress
>   [bluetooth]# scan off
>   Failed to stop discovery: org.bluez.Error.InProgress
>   [bluetooth]# scan on
>   Failed to start discovery: org.bluez.Error.InProgress
>   [bluetooth]# scan off
>   Failed to stop discovery: org.bluez.Error.InProgress
>   Failed to start discovery: org.freedesktop.DBus.Error.NoReply
>
> gatttool can still connect and retrieve data.
>
> btmon shows no activty except from gatttool, and none from scan
>
> Here is a snippet of debug from bluetoothd:
>
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> agent.c:agent_disconnect() Agent :1.1113 disconnected
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> agent.c:remove_default_agent() Default agent cleared
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:set_mode() sending set mode command for index 0
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> agent.c:agent_destroy() agent :1.1113
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> agent.c:agent_unref() 0x13285c8: ref=3D0
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:discovery_disconnect() owner :1.1113
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:discovery_remove() owner :1.1113
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:discovery_free() 0x1321050
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:update_discovery_filter()
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:discovery_filter_to_mgmt_cp()
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:trigger_start_discovery()
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:cancel_passive_scanning()
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:start_discovery_timeout()
>     Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/src/=
> adapter.c:start_discovery_timeout() adapter->current_discovery_filter
>
> Do you have any suggestions for further research into this problem?

Don't use gatttool, which has been deprecated, instead use
bluetoothctl (menu gatt) for GATT operations.

> John Klug



-- 
Luiz Augusto von Dentz
