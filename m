Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC17C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 May 2023 09:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjENJvp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 May 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjENJvm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 May 2023 05:51:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C54E6E
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 May 2023 02:51:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so102632052a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 May 2023 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684057897; x=1686649897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1B3du+5hpvlLOa22naBqYj3xDgWNzyGiPg0V7Tn+jlA=;
        b=VsizmiPhgVVC017QpqyleBMJ6rMsZ6adYRvRLnGhJXvM5cBZfIoBWaE5nAB954jxuN
         st8r7Jl2src32zEaX6zbGMKCiu/DYREMSOJntv28ncNe4MSjbwcsNNkEmqojhzwQEMPy
         TiBhkH/9MVvjWgr9rszUv8nLkchIcB6+CUOdCpMWnINKSz68ArWroDy8k4La6Qykyg2n
         DOs0t3N/qXQmPLzO8QOvRH0VdPmTxIlbWAGttWitZNSWTlWdu+xemCmudRUbUvti2qmT
         KdJwNdT7SWSzkvsaP/xzEujH99ic+BiL12UtQqqlNMPnrRZ4vf9e45hbZUG1l+nuJ2Kv
         YrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684057897; x=1686649897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B3du+5hpvlLOa22naBqYj3xDgWNzyGiPg0V7Tn+jlA=;
        b=Gwn+2XT03fvLw9G2rYxr2+seZzcl624Hw38W0AKVszR+1jYlowLnYw3pyeByV7pYJ7
         sygNKPZXOc/7M3tNDWvcoPSEfJjeMbGl4v+La4c/ifiEHyrYCDvac3DcEXuJdECmvO/h
         yLjFg1OWs/D8tc6wqqeep2dt05Z41Y+Dq12ZoLLbag5JpBaa4bpGZqUc7HQggCOfDUOs
         keJ2Ou2N2WHdySwg70zX4bTQy1VkmcvmxzxlWYM17VCXaMFu2gcEIPBbmeAeNKGPwejd
         KhDxgWpRTelrgN6Nu857dI0j/GpdwPIB4jKQSI1YweL/BebGEeGAYy2x7o8nG0b0RH4X
         hQCA==
X-Gm-Message-State: AC+VfDzLqba+3qPAKrvruRlWOK1+qTMNlIw7vjX8AxICiHEkoRCGcC6V
        kfWDnewEJ2lIz9ABmaJuDgtrwyCXmwIreoFZMq1Y9Q==
X-Google-Smtp-Source: ACHHUZ58XebRfUPqpJ87adEoTJVSm4nYzk/motHLFcYmh+n/Hi1XU9+7Z/l1hQUhfE06kxij9bcHjA==
X-Received: by 2002:a17:907:8689:b0:96a:316f:8aaa with SMTP id qa9-20020a170907868900b0096a316f8aaamr12388354ejc.37.1684057896845;
        Sun, 14 May 2023 02:51:36 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:715f:ddce:f2ba:123b])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7cb89000000b005021d210899sm5663978edt.23.2023.05.14.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 02:51:36 -0700 (PDT)
Date:   Sun, 14 May 2023 11:51:33 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     pabeni@redhat.com, alistair@alistair23.me,
        linux-arm-kernel@lists.infradead.org, jernej.skrabec@gmail.com,
        robh+dt@kernel.org, davem@davemloft.net,
        linux-bluetooth@vger.kernel.org, conor+dt@kernel.org,
        anarsoul@gmail.com, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, edumazet@google.com,
        marcel@holtmann.org, wens@csie.org, linux-kernel@vger.kernel.org,
        samuel@sholland.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: net: realtek-bluetooth: Add RTL8822BS
Message-ID: <20230514095133.b4ojnu6y222kzhcb@krzk-bin>
References: <20230514074731.70614-1-rudi@heitbaum.com>
 <20230514074731.70614-2-rudi@heitbaum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230514074731.70614-2-rudi@heitbaum.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, 14 May 2023 07:47:29 +0000, Rudi Heitbaum wrote:
> Add compatible string for RTL8822BS for existing Realtek Bluetooth
> driver.
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---
>  .../devicetree/bindings/net/realtek-bluetooth.yaml  | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml: properties:compatible:oneOf:1:items: 'oneOf' conditional failed, one must be fixed:
	[{'enum': ['realtek,rtl8821cs-bt']}, {'const': ['realtek,rtl8822bs-bt', 'realtek,rtl8822cs-bt']}] is not of type 'object'
	['realtek,rtl8822bs-bt', 'realtek,rtl8822cs-bt'] is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml: properties:compatible:oneOf:1:items: 'oneOf' conditional failed, one must be fixed:
	[{'enum': ['realtek,rtl8821cs-bt']}, {'const': ['realtek,rtl8822bs-bt', 'realtek,rtl8822cs-bt']}] is not of type 'object'
	['realtek,rtl8822bs-bt', 'realtek,rtl8822cs-bt'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 167, in <module>
    sg.check_trees(filename, testtree)
    ...
  File "/usr/lib/python3.10/sre_parse.py", line 599, in _parse
    raise source.error(msg, len(this) + 1 + len(that))
re.error: bad character range s-b at position 18

Note: You even broke the dtschema :)

See https://patchwork.ozlabs.org/patch/1781021

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
