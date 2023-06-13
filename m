Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85FAEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 22:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbjFMW1a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjFMW1W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74961BCA;
        Tue, 13 Jun 2023 15:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C1463BB0;
        Tue, 13 Jun 2023 22:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC32C433C0;
        Tue, 13 Jun 2023 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695239;
        bh=+QQcsUVeQ9XRaJDJnjuZElieryUDQ6op05ZbHP6EsJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcuwVV5LayDGPjQm5yW8VWis/SRe4mR7Zq0xa7C0TWkXMyT//B8T/K4ZdD0QsqYLN
         7CySmQS55/M8CsY+IVEeKyikW0HaR97Jek8DesQpEUvynx4LsJwwMxeN9u8RBZFEc4
         CZ8IupaMENl7TfeKQ9bBcYzxxUUzXgBLvYH3htNroYHPKxdmGG2dA5RGqmN6vitfMp
         gHe/dc8DfQSMyAWBytTYRyW/icUYm3xtFVk6Kxw2YC3saKuR8yigxYMYw+epJwoXsY
         8gcfOgZM/KdSUiEBf5XPZoZfCVFD/j1KVbKKqyKNAOUZ1jmMUdxPqiw37rpSe7xEbw
         Xtu1QMG3YCfsg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Eric Dumazet <edumazet@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] Add WCN3988 Bluetooth support for Fairphone 4
Date:   Tue, 13 Jun 2023 15:30:17 -0700
Message-Id: <168669542895.1315701.16862270566326485356.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com>
References: <20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 12 May 2023 15:58:22 +0200, Luca Weiss wrote:
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

Applied, thanks!

[3/4] arm64: dts: qcom: sm6350: add uart1 node
      commit: b179f35b887b2d17e93f1827550290669bc6b110
[4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add Bluetooth
      commit: c4ef464b24c5aefb7e23eb8fcc08250a783a529b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
