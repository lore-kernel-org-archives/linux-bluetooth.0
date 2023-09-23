Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA467CE7A88
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Sep 2023 11:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjIWL3E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Sep 2023 07:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjIWL3E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Sep 2023 07:29:04 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAFD199
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Sep 2023 04:28:57 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Rt6N6053nz49Q1V;
        Sat, 23 Sep 2023 14:28:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1695468534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nyx9BV46aknPHo4HailiEsYzn6LxbgDQxCbFpFbcaOY=;
        b=Ob2GWKeGgoYZt3beVmR/foPNzhLX2V7cK7rSsoHfMr6Q/UPXDhHkkanp610/k9HKRKiON0
        TF+uoaZLS3+qCAcwMg//UaLajTwmquUPn9EG7qe6vIMLiUCMC0BytMd2qMnuj1xQC3lsjk
        aWHVjMe/NIfS6IrAheiiMwcUkt0hLDYtBQvbzNEqCvx6bqeQNqupmM21upRtjaA4XMMdgX
        IgbTdzHUd5ZRdGkWEsXI90KJDd85QvWMQhGAoIJCFo6yTlA0quxfvUUTKBc4qkYljzBPz8
        It/9qII84Lehoea8PR1lOqb08u8ZjW7j2h8fftuhjoEGwICGL4HnybOil/XNvA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1695468534; a=rsa-sha256;
        cv=none;
        b=Cz8Y9fD1GR95vbq+/xYrr9a9EVwm/qSQArWBw/icQU4ebfBhaEWu8yWXKwK3K08mCJqiIK
        tI3C51ivYqeJhoId4v+Ze7QLgmDp6JqVzrGIhmlUw3kHDuNEFCe0HBY0nankckH/seEdb8
        3I+ph1dIJfuPI6zuX2L5T4ijvuEDycYj4AVYgRCVLzeS8sq0uq/u7dTclMjMsE3yX8AfB+
        HiFtWOmVL+65WkpMjmZO8IAFFwbcx/6nWA4yFWxZbhTdfbBDys236VDsYiKPMMsm+3YAZz
        UnX+i88uN4Ok8m8/aKRa+amVa8htzeVCyHAeRT6sGhAr4U/tbXiWDkHeg4ZLVg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1695468534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nyx9BV46aknPHo4HailiEsYzn6LxbgDQxCbFpFbcaOY=;
        b=oP28ooQeqy0DjsvwAsrIiV/TChUtzoBNtyT4+SBdo4TX3sTdyNr9X7a/WWYHtepjC3VCrg
        XJqJInv899mKMH9qpgFl7FxdaalohSGJugRzmLOOmNHeCfyJsGDN1yfDvOa52931xzRe4V
        hp8qYHbHNrenfISrGt1QX5qjfFOVympZblRj4+axKZwV829pj1Jx3xndDtMzJ0HXe64Mkz
        yf08lYWwLCHXi5NTyQtr6/08yOPQQbPDrUyP7lo/I2VLw8qBOpMIe/jYlGBz5gfDqzPfqK
        NxF8TMklnMVPD91+xsdZoXgwdV32t3yyovoN2GLU/G1eAybYCujnH6tpCLi9WA==
Message-ID: <b5dc735326b930322ca3dbfb50addc6de314e329.camel@iki.fi>
Subject: Re: [PATCH v2 6/6] doc/media: Convert media-api.rst into manpages
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Sat, 23 Sep 2023 14:28:51 +0300
In-Reply-To: <9100eb19ee8fb16e78cfee86e953dfe2afd6efe9.camel@iki.fi>
References: <20230922192335.1060601-1-luiz.dentz@gmail.com>
         <20230922192335.1060601-6-luiz.dentz@gmail.com>
         <9100eb19ee8fb16e78cfee86e953dfe2afd6efe9.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

la, 2023-09-23 kello 12:14 +0300, Pauli Virtanen kirjoitti:
> Hi Luiz,
>=20
> pe, 2023-09-22 kello 12:23 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > This splits media-api.rst into org.bluez.Media<interface>.rst and
> > generate manpages for them.
>=20
> I made a pass looking at the implementations of the transport/endpoint
> and SetConfiguration/SelectProperties/SelectConfiguration and comparing
> to docs.
>=20
> Note that the SelectProperties API has a problem with BAP endpoint
> configuration. We maybe should redesign it while we still can?
>=20
> I think generally at least from Pipewire side there's no need to keep
> backward compatibility while this is experimental. We can target BlueZ
> master branch.
>=20
>=20
> SelectProperties API problem:
>=20
> As BAP client one first does Config Codec (ASCS =C2=A75.1) which takes
> Target_Latency, Target_PHY and Codec.
>=20
> After this, the ASE properties (ACSS Table 4.3) in Codec Configured
> state contain the server supported values for Max_Transport_Latency,
> Presentation_Delay_Min/Max etc.
>=20
> SelectProperties is called before Config Codec, so it cannot
> necessarily know the server supported values. In this case the sound
> server cannot fill in QoS correctly.
>=20
> The client-invoked SetConfiguration API also seems to have similar
> issue.
>=20
> Probably: SelectProperties should be called twice, once to get
> parameters for Config Codec, and then again to get parameters for
> Config QoS. Or, there should be a separate "SelectCodec" and
> "SelectQoS" calls. Calling "SelectProperties" twice could be simpler
> for everyone.=C2=A0
>=20
> In client-invoked "SetConfiguration" API, one probably should only pass
> in the parameters needed for Config Codec, and BlueZ should then make a
> SelectProperties call to get the QoS ones once the server-side values
> are known.
>=20
> I can take a look at this...
>=20
>=20
> MediaTransport:
>=20
> "Delay" field only exists for A2DP in code.
>=20
> "Volume" field only exists for A2DP in code.
>=20
> "Links" is ucast only in code.
>=20
> "QoS.TargetLatency" does not exist in code. Maybe it should be exposed
> for consistency, since it's expected as return from SelectProperties.
>=20
>=20
> SetConfiguration:
>=20
> SetConfiguration properties dict when called by BlueZ contains exactly
> the properties of the transport. The documentation probably should say
> that this is so.
>=20
> When called by client, the contents of the properties dict are expected
> to be different. QoS parameters are not packed in a "QoS" dict. Maybe
> they should be. The "PHY" key is also still a string here.

Also, "Framing" is boolean here (elsewhere it's byte).

>=20
> The documented input parameters expected from client are wrong, the
> documentation explains fields of struct bt_bap_pac_qos, but what the
> code parses are that of struct bt_bap_qos.
>=20
> "MaximumLatency": no such field in code, seems to be called "Latency"
> everywhere.
>=20
>=20
> SelectProperties:
>=20
> In code, the return parameter expects QoS parameters (struct
> bt_bap_qos) to be packed in "QoS" dict.
>=20
> They are not packed in "QoS" dict in the input parameters. These are
> not exactly QoS, but instead struct bt_bap_pac_qos, so not clear if
> they should be packed.
>=20
> The input and return parameters are not documented. The input QoS
> contains fields of struct bt_bap_pac_qos. The return QoS has fields of
> struct bt_bap_qos.
>=20
>=20
> MediaEndpoint:
>=20
> The endpoints published by BlueZ only have the properties
> "UUID", "Codec", "Capabilities", "Device".
>=20
> The documentation lists various other things, but they are not
> implemented as server endpoint properties.
>=20
> As client endpoint properties:
>=20
> "RTN" is expected to be present in code, but is not documented.

"RTN" is called "Retransmissions" elsewhere.

>=20
> "MaximumLatency" "Location" "SupportedContext" "Context" are documented
> but not present in code.
>=20
>=20

