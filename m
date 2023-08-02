Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DEDC04A94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHBUa0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 16:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHBUaY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 16:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7826A2;
        Wed,  2 Aug 2023 13:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FBD561AFE;
        Wed,  2 Aug 2023 20:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E347FC433C9;
        Wed,  2 Aug 2023 20:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691008223;
        bh=EmWbaenOMDMD6nYdMzBFCScTkic4CvjgRoEjkBg+bnE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VvEEJn4ZP6H4Q7fIJSQjyMaGQyiLccK7NXIEXRuMbSrVtwDsqvcAejUc2tGH5pae6
         fMQ7pxeSQBIuhEwYHHI27EyCsNmhk9p7nA8AHCvgfG8Pk4s5A9vAWpy7qjVyLqHQtF
         R6FoA3B9ngUfgMdE7WBiuKHfMEEq7sv/pZFRiirj/+UK2XWO075tP5HAmzNLoJ58sD
         F5n6tRD2YRHmhFBwp9qCso2O/92w/PHOhwMmElhigy4x7WBM418XzRFgsas+oP2Gpr
         O9C6dRL9rgRlmmEbn2vnJW/kWRcdIWyjDNtrbApwfOAoyfxjKDfnM/AS4/65d2Rzil
         V0Jwvv2I4L/PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4843C6445B;
        Wed,  2 Aug 2023 20:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Add WCN3988 Bluetooth support for Fairphone 4
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169100822279.572.3966556819111433761.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 20:30:22 +0000
References: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
In-Reply-To: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org, quic_bgodavar@quicinc.com,
        quic_rjliao@quicinc.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 02 Aug 2023 08:56:27 +0200 you wrote:
> Add support in the btqca/hci_qca driver for the WCN3988 and add it to
> the sm7225 Fairphone 4 devicetree.
> 
> Devicetree patches go via Qualcomm tree, the rest via their respective
> trees.
> 
> --
> Previously with the RFC version I've had problems before with Bluetooth
> scanning failing like the following:
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: net: qualcomm: Add WCN3988
    https://git.kernel.org/bluetooth/bluetooth-next/c/d2a31b6f9701
  - [v3,2/2] Bluetooth: btqca: Add WCN3988 support
    https://git.kernel.org/bluetooth/bluetooth-next/c/f2e1dd87c9cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


