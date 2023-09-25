Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F72CD54BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Sep 2023 19:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjIYTZB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Sep 2023 15:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjIYTY7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Sep 2023 15:24:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D3101
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Sep 2023 12:24:52 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso121769481fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Sep 2023 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695669890; x=1696274690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzBWbovDD16kBxCEH0xkSy+YZfw9wutbMWDfxWxFbZs=;
        b=R5tGVCARdOQPLmuY3aVDLMRz/svgvMK/41UG+RHml8n8Nzch1C5KPPbEssPFQcNk4w
         Vt3TsUfcITXmJexf16cvFjbwFYQjQPEwAbNm9dgBEewyiyCUyiYPdrm4IgLFhMvxfq0h
         5g9+7pmIjTlT/OJ77BZkLQqybUKhoWBnw7uW+4gKFQmHo2wR/aApzWfhThsTYPFAkTzx
         VbQXf/x/EUYhn+mFwL3ndZ4+ph0uDiGDTtKLYH525JLB/GP11BJ4C7uibyCesTHmOVja
         vnfKUXiLTnm36N/P/fZMkfByZACuDicjU8KHeek8aaX2gUiaUjuuXZvy26T2XDc/7FPO
         SOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695669890; x=1696274690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzBWbovDD16kBxCEH0xkSy+YZfw9wutbMWDfxWxFbZs=;
        b=rcyv+0ZMisNQzrTr76YyaL5IZ3zfRbp7sSvnClOGKMbs77Ua0o5jNaaxHRz5nu0Etm
         9r1BOhDbgzK7HbUTMBfeBbQ8uec1Q+XnuRo25XDGHI+oE7S1mBnrQeieebtT4aH+DZyR
         wMMsOhi8HQu6KfJa2HqrzQpxAHoBf0ukuLwqiyHqeeB7wrRpKJwcUe3RvMuV8W+rBw+N
         jtsKIxi689/cjpJQOv2w/hfowXt50bbvDBE2xYefFfjFqxtkzQpZjGVNKPZvpOVirIlH
         kTnMOItktBPsXrdZ6qxhSEADayyEhxquQgpmja8iHQVygPU635nKAbXE9x6ViICXyFvR
         ufEw==
X-Gm-Message-State: AOJu0YxImUHWM6JY9IjOZ7K86uKGA8P9112TOpvFTyy+n9PeA+hKR0SX
        iGzaYrnzsnu6PjuqVM0n1QgECnLjDv1r7XAVxlBmN6HBVsPY/g==
X-Google-Smtp-Source: AGHT+IE9tde9IOR86zh433x1mU6GCG4Wl4bubQVarQMV+9kQkrexfg4NNTCeAe6CoJv1HUUupDXxgptEXhPpZXmKoGI=
X-Received: by 2002:a2e:9555:0:b0:2bd:1804:29fa with SMTP id
 t21-20020a2e9555000000b002bd180429famr6431807ljh.39.1695669890094; Mon, 25
 Sep 2023 12:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230922192335.1060601-1-luiz.dentz@gmail.com>
 <20230922192335.1060601-6-luiz.dentz@gmail.com> <9100eb19ee8fb16e78cfee86e953dfe2afd6efe9.camel@iki.fi>
In-Reply-To: <9100eb19ee8fb16e78cfee86e953dfe2afd6efe9.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 25 Sep 2023 12:24:37 -0700
Message-ID: <CABBYNZJ51nCXhmohvjr+XMuJ5yb1fw-Wao50RyyGuBx+NADmSg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc/media: Convert media-api.rst into manpages
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sat, Sep 23, 2023 at 2:14=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> pe, 2023-09-22 kello 12:23 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This splits media-api.rst into org.bluez.Media<interface>.rst and
> > generate manpages for them.
>
> I made a pass looking at the implementations of the transport/endpoint
> and SetConfiguration/SelectProperties/SelectConfiguration and comparing
> to docs.
>
> Note that the SelectProperties API has a problem with BAP endpoint
> configuration. We maybe should redesign it while we still can?
>
> I think generally at least from Pipewire side there's no need to keep
> backward compatibility while this is experimental. We can target BlueZ
> master branch.
>
>
> SelectProperties API problem:
>
> As BAP client one first does Config Codec (ASCS =C2=A75.1) which takes
> Target_Latency, Target_PHY and Codec.
>
> After this, the ASE properties (ACSS Table 4.3) in Codec Configured
> state contain the server supported values for Max_Transport_Latency,
> Presentation_Delay_Min/Max etc.
>
> SelectProperties is called before Config Codec, so it cannot
> necessarily know the server supported values. In this case the sound
> server cannot fill in QoS correctly.
>
> The client-invoked SetConfiguration API also seems to have similar
> issue.
>
> Probably: SelectProperties should be called twice, once to get
> parameters for Config Codec, and then again to get parameters for
> Config QoS. Or, there should be a separate "SelectCodec" and
> "SelectQoS" calls. Calling "SelectProperties" twice could be simpler
> for everyone.
>
> In client-invoked "SetConfiguration" API, one probably should only pass
> in the parameters needed for Config Codec, and BlueZ should then make a
> SelectProperties call to get the QoS ones once the server-side values
> are known.
>
> I can take a look at this...

Sound like a good idea, it means the actual configuration is always
done via SelectProperties, that said we need to make sure this works
with A2DP as well or state that it only applies to BAP, we could
perhaps introduce a property to indicate that the endpoint implements
SelectProperties.

>
> MediaTransport:
>
> "Delay" field only exists for A2DP in code.

Yeah, the PresentationDelay was moved into QoS property.

> "Volume" field only exists for A2DP in code.

That is subject to change though.

> "Links" is ucast only in code.

Will mark it as unicast only.

> "QoS.TargetLatency" does not exist in code. Maybe it should be exposed
> for consistency, since it's expected as return from SelectProperties.

Yeah, it seems we never implemented it, but I consider it a gap not a
inconsistency with the code.

>
> SetConfiguration:
>
> SetConfiguration properties dict when called by BlueZ contains exactly
> the properties of the transport. The documentation probably should say
> that this is so.
>
> When called by client, the contents of the properties dict are expected
> to be different. QoS parameters are not packed in a "QoS" dict. Maybe
> they should be. The "PHY" key is also still a string here.

Is it? Or perhaps I had changed it later on when splitting the
documentation on a per-interface, at least on
org.bluez.MediaEndpoint.rst there is no entry were PHY is a string, or
you are talking about the actual code here?

> The documented input parameters expected from client are wrong, the
> documentation explains fields of struct bt_bap_pac_qos, but what the
> code parses are that of struct bt_bap_qos.
>
> "MaximumLatency": no such field in code, seems to be called "Latency"
> everywhere.

The way Im designing these properties are that MediaEndpoint actually
carries the preferences and MediaTransport the configuration as far as
BAP is concerned, perhaps I shall actually state it though.

>
> SelectProperties:
>
> In code, the return parameter expects QoS parameters (struct
> bt_bap_qos) to be packed in "QoS" dict.
>
> They are not packed in "QoS" dict in the input parameters. These are
> not exactly QoS, but instead struct bt_bap_pac_qos, so not clear if
> they should be packed.

Input shall be considered the remote preferences and the output the
local configuration.

> The input and return parameters are not documented. The input QoS
> contains fields of struct bt_bap_pac_qos. The return QoS has fields of
> struct bt_bap_qos.

I will attempt to clarify that.

>
> MediaEndpoint:
>
> The endpoints published by BlueZ only have the properties
> "UUID", "Codec", "Capabilities", "Device".
>
> The documentation lists various other things, but they are not
> implemented as server endpoint properties.
>
> As client endpoint properties:
>
> "RTN" is expected to be present in code, but is not documented.
>
> "MaximumLatency" "Location" "SupportedContext" "Context" are documented
> but not present in code.
>
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
