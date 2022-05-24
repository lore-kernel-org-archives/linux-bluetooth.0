Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0019C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 22:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiEXWB5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 18:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbiEXWB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 18:01:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA678506FC
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 15:01:54 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1ntcbA-0005jx-Az; Wed, 25 May 2022 00:01:52 +0200
Message-ID: <f5730712-1967-9d1b-3e04-9fcb6b4a3070@pengutronix.de>
Date:   Wed, 25 May 2022 00:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH-stable] Bluetooth: hci_conn: Fix hci_connect_le_sync
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220520183713.2641513-1-luiz.dentz@gmail.com>
 <148a9f76-0784-1d17-22cd-80343895aa37@pengutronix.de>
 <9e5b51ae-5089-dc91-57cb-52b0d76249d8@pengutronix.de>
 <CABBYNZ+DNOvguwKXie+1NVJ6xQjOYQiUCroBcBNEyUuKjt2+_Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZ+DNOvguwKXie+1NVJ6xQjOYQiUCroBcBNEyUuKjt2+_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

On 24.05.22 20:08, Luiz Augusto von Dentz wrote:
> On Tue, May 24, 2022 at 8:55 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> On 24.05.22 16:48, Ahmad Fatoum wrote:
>> I see now that this fix doesn't build for v5.17 because hci_conn_failed
>> was only introduced in v5.18. Can the hci_conn.c hunk be safely dropped?
> 
> Are you talking about:
> 
>         if (status) {
> -               hci_le_conn_failed(conn, status);
> +               hci_conn_failed(conn, status);
>                 goto unlock;
>         }
> 
> You just need to replace hci_conn_failed with hci_le_conn_failed or
> well in the code above the end result is the same since it is not
> supposed to cleanup in the event handler.

Yes, that cleanup in le_conn_complete_evt() needs to be removed.
I am talking about the other hunk in hci_conn.c:

  -    if (!conn)
  +    /* Check if connection is still pending */
  +    if (conn != hci_lookup_le_connect(hdev))
               goto done;
 
   -    hci_le_conn_failed(conn, err);
   +    hci_conn_failed(conn, err);
 
    done:
        hci_dev_unlock(hdev);


Can this be dropped for v5.17?

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
