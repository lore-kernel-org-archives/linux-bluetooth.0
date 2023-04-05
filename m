Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEF2C76188
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 04:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbjDEEHx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 00:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbjDEEHM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 00:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82475598;
        Tue,  4 Apr 2023 21:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FF0863AF6;
        Wed,  5 Apr 2023 04:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56247C433EF;
        Wed,  5 Apr 2023 04:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667596;
        bh=z1edpR72+pNOINPLtRAsAhpnTIUMgiOahipQJ2kekxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wpn4fe3lfjlqFtHjlsiaxpO95c8mn9XH039jhN5rhvVx3vIhi1CecCtNn24BV/AwO
         27Mo4A6NW7QygNBI1Uz3yg1Po3lcvavfqstMjGNCTxebE4ld3PjCLpehJ7NUOUkBD2
         Im6ViB+qJzR5g2JVXCb0p5QxxMAfyRghXokCnM4mnAR3ivMu6l/6K5iNvIODZ/edzf
         tkfAjPd0Xs6J6jhMwTY2pibpMEyMOF996YXXx/ryYQuw//MQo12Xm6nsbEWpZ6m2B0
         BeBgtd8/TnS7FBJ2GhSVb3VACos89nEax+BCICA5rLO4O3KYy6KdhwFzB/85rr/6Md
         yEh58KwGFFKjw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Mark Pearson <markpearson@lenovo.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 0/4] Attempt at adding WCN6855 BT support
Date:   Tue,  4 Apr 2023 21:09:07 -0700
Message-Id: <168066774409.443656.13544084231334926154.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230131043816.4525-1-steev@kali.org>
References: <20230131043816.4525-1-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 30 Jan 2023 22:38:12 -0600, Steev Klimaszewski wrote:
> This v2 of the patchset is somewhat of an RFC/RFT, and also just something to
> get this out there.
> 
> First things first, I do not have access to the specs nor the schematics, so a
> lot of this was done via guess work, looking at the acpi tables, and looking at
> how a similar device (wcn6750) was added.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: net: Add WCN6855 Bluetooth
      (no commit info)
[2/4] Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855
      (no commit info)
[3/4] arm64: dts: qcom: sc8280xp: Define uart2
      commit: 9db28f297526f17c6575ec0eefc93a8b1642cff7
[4/4] arm64: dts: qcom: thinkpad-x13s: Add bluetooth
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
