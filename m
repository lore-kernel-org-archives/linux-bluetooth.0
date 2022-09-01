Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7FFECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 10:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiIAKn2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiIAKnR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 06:43:17 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17313DB04F
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 03:43:15 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8A6BA100006;
        Thu,  1 Sep 2022 10:43:11 +0000 (UTC)
Message-ID: <e62a374b72b54f2e49059d5266f7fafe06b18abb.camel@hadess.net>
Subject: Re: [PATCH BlueZ v4 2/6] adapter: Implement PowerState property
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Thu, 01 Sep 2022 12:43:05 +0200
In-Reply-To: <CABBYNZ+aqTbSR-=R7CP8pY48=QxoEjsYnY7oCWc=niLYr7o2fg@mail.gmail.com>
References: <20220831091912.47894-1-hadess@hadess.net>
         <20220831091912.47894-2-hadess@hadess.net>
         <CABBYNZ+aqTbSR-=R7CP8pY48=QxoEjsYnY7oCWc=niLYr7o2fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2022-08-31 at 13:03 -0700, Luiz Augusto von Dentz wrote:
> > +enum {
> > +       ADAPTER_POWER_STATE_TARGET_NONE = 0,
> > +       ADAPTER_POWER_STATE_TARGET_OFF,
> > +       ADAPTER_POWER_STATE_TARGET_ON
> > +};
> 
> Lets take out the TARGET portion and have all the states PowerState
> can assume including the transitioning ones.

Done, with the rest of the changes, in v5.

I've also fixed the initial rfkill state if the adapter is blocked
before bluetoothd is started.
