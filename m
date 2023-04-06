Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F75C76196
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 21:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbjDFVAg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbjDFVAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06857ED5;
        Thu,  6 Apr 2023 14:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D849164CBA;
        Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E65F4C433AA;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814820;
        bh=rAs0EQ8DTvyaFqe2XUSUKx0TAecI3Kfv4Oh+Vb886/Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kNRYnplY8j6ydAxWmWKXf/VcKpN+h78xVE3Cv6ApVUhr4pQSLZ8S6ZLiE0p2oHTuq
         rdEj8hOpXqVP4MbBcIJWE06a8tTGzbUOr8P7UgLJ9dbJjeEg1UQIcEX44d09mb/aRv
         hJLqZ3c8uqXUqZgYEknMq9ebAB50/vVyOkcQHsjXbwIi1jQTNndI6scDx7BQlYgqzJ
         F3wmI4PXCUrqtxDbvRuLS5KQ5E4YGldNcY25tYOQqz4b0q9b8Eyul2uUkc4ktTOdSx
         c4TIi40h8peqGU7krRJSXSkcoheDtjB1GfJbOvrPkGd1aPA3Rja6/ZipVjMBqjmPX8
         Y3kGAvwjAh9og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3D02E4F155;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_h5: Complements reliable packet processing
 logic
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482085.2619.8551087940289417594.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230404022711.86515-1-eddy.zhang@rock-chips.com>
In-Reply-To: <20230404022711.86515-1-eddy.zhang@rock-chips.com>
To:     Qiqi Zhang <eddy.zhang@rock-chips.com>
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Apr 2023 10:27:11 +0800 you wrote:
> As shown in the schematic diagram below.There may be a critical
> scenario in the current code. If the device does not receive an
> pure ack sent by the host due to insufficient receive buffer or
> other reasons and triggers a retransmission, the host will always
> be in an 'out-of-order' state.The state machine will get stuck.
> 
>        host                 device
>      SEQ3,ACK4 --------->
>                <--------- SEQ4,ACK4
>      pure ACK  ---------> (not received)
> (out-of-order) <--------- SEQ4,ACK4(retransmission)
>                 ........
> (out-of-order) <--------- SEQ4,ACK4(retransmission)
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_h5: Complements reliable packet processing logic
    https://git.kernel.org/bluetooth/bluetooth-next/c/13a6ebae665d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


