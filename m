Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E56ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 20:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiIAUKP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiIAUKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 16:10:13 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45791C92E
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 13:10:09 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id DD0831C0005;
        Thu,  1 Sep 2022 20:10:07 +0000 (UTC)
Message-ID: <507eb017ee07075386127b40a35765513cf8de4b.camel@hadess.net>
Subject: Re: [PATCH BlueZ v7 1/6] adapter: Keep track of whether the adapter
 is rfkill'ed
From:   Bastien Nocera <hadess@hadess.net>
To:     patchwork-bot+bluetooth@kernel.org
Cc:     linux-bluetooth@vger.kernel.org
Date:   Thu, 01 Sep 2022 22:10:07 +0200
In-Reply-To: <166205821606.5769.2196808396648976031.git-patchwork-notify@kernel.org>
References: <20220901110719.176944-1-hadess@hadess.net>
         <166205821606.5769.2196808396648976031.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2022-09-01 at 18:50 +0000, patchwork-bot+bluetooth@kernel.org
wrote:
> Hello:
> 
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> 
> On Thu,  1 Sep 2022 13:07:14 +0200 you wrote:
> > Instead of only replying to D-Bus requests with an error saying the
> > adapter is blocked, keep track of the rfkill being enabled or
> > disabled
> > so we know the rfkill state of the adapter at all times.
> > ---
> >  src/adapter.c | 25 +++++++++++++--
> >  src/adapter.h |  1 +
> >  src/btd.h     |  1 +
> >  src/rfkill.c  | 89 ++++++++++++++++++++++++++++++++++++++---------
> > ----
> >  4 files changed, 91 insertions(+), 25 deletions(-)
> 
> Here is the summary with links:
>   - [BlueZ,v7,1/6] adapter: Keep track of whether the adapter is
> rfkill'ed
>    
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=abf5ba6b80ad
>   - [BlueZ,v7,2/6] adapter: Implement PowerState property
>    
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58021a665b7f
>   - [BlueZ,v7,3/6] client: Print the PowerState property
>    
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48992da64f52
>   - [BlueZ,v7,4/6] adapter-api: Add PowerState property documentation
>    
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6e49216ad47d
>   - [BlueZ,v7,5/6] adapter: Fix typo in function name
>    
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61f4f2895882
>   - [BlueZ,v7,6/6] adapter: Remove experimental flag for PowerState
>     (no matching commit)
> 
> You are awesome, thank you!

Sweet, thanks!

The links are missing "commit/" in the URL though, so should be:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=abf5ba6b80ad
not:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=abf5ba6b80ad
