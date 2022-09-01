Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE2ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 10:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiIAKnj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiIAKnc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 06:43:32 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C15A50E2
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 03:43:30 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 4627D200009;
        Thu,  1 Sep 2022 10:43:29 +0000 (UTC)
Message-ID: <6e4975d7cc0f7d16c4bdc46575e80136d5e99283.camel@hadess.net>
Subject: Re: [PATCH BlueZ v5 4/6] adapter-api: Add PowerState property
 documentation
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Thu, 01 Sep 2022 12:43:22 +0200
In-Reply-To: <CABBYNZL3iTX8sLnQy6Bo_kchqiHXr5VUTz0g29ay3xoXLs76Fw@mail.gmail.com>
References: <20220831113647.85110-1-hadess@hadess.net>
         <20220831113647.85110-4-hadess@hadess.net>
         <CABBYNZL3iTX8sLnQy6Bo_kchqiHXr5VUTz0g29ay3xoXLs76Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2022-08-31 at 13:43 -0700, Luiz Augusto von Dentz wrote:
> > +               string PowerState [readonly]
> 
> We should have it documented as experimental as well.

Fixed in v6.
