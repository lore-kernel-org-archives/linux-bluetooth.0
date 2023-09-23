Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403A7CE7A89
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Sep 2023 09:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjIWJOT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Sep 2023 05:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjIWJOT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Sep 2023 05:14:19 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D5136
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Sep 2023 02:14:12 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Rt3Nb2jcbz49Psw;
        Sat, 23 Sep 2023 12:14:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1695460447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jK0/+mlqnTF6UIanKWHATQ7cco3waG6M+WU8Awo/Eps=;
        b=ZJEMXjKzcyU8gxZPSukv/yimdMFfItUZndKj398u+dDpfr+DOBC5T5XqMK//84pd9UQXVO
        cR5FPEjBdQGoVOTTMhJHkTEzBL5YkWUN024VyV+esjhnNesBW2BX234RAA9yfSvUNJu2LH
        +/TuF0L3sBh0HekguVC2grZkUQna2NuaXhVqUQC7q1ZxwAQjcIvWE6xTOd7B2+Uor2zVEu
        LtCwFFo3rBSE8JwgBkefDzV2otjSSEf6qwuDTxNmm9Bg12w3P2kgXXk2S7aXAgzg1q2MaQ
        Sws0nEkTRZSkdSw8KMiJ9fFCrc3rxzH1hqgIFsZqg5jBxP32vDQFtwHFtILUjw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1695460447; a=rsa-sha256;
        cv=none;
        b=ZcyRyFE9jR+cF0JwYtxI6N4Qmq5sR6RN70iYVRtDol0Nv8W9J6HeZFo30xjM+Z5/TrX2H2
        b8iu6tosnBjqSZetFxuCkm9jB2PIxpeowqVAnoB2Rkgk7C+EOA8NzH9TX0DKd4dPp4rgFH
        VxOYBhk6oUqaWUiWkd2nLmhvHm+K5MHF2vnN2zXZT4W1YHdQSdg9gvCwUU2jjMmB8YUWo9
        xMOtTBPNVOVXIvyzS4OiPrFyQQLXZlJoyqgpUK1jf8q+/G/dVFfy/RXSlkT5AdE+q8mNSu
        T9s/7z+DH4b6PQ9BmrZX9COhzdjd1PjNDud9T3kuqICJxChyRxIV5Gtg6KbnVA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1695460447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jK0/+mlqnTF6UIanKWHATQ7cco3waG6M+WU8Awo/Eps=;
        b=CIM/6RPSFed6JMJ/A+hmcTUy12Svr4mJ1fGHtk2y1UzUu9QIspNmpte7pv1ZO69n2Nb8nh
        5Ao/hoJoEBTB7l8XywkasXCC/pVEUqombWRuwcgDhhrR2MWe4zDsmxJCNZp2eTRRJMBJXX
        afNcZ58HFJfK0hwaYcFYQgwbB1xpKuIn1D9GuzOXLPS2Ll0yiSttz+XoeHocJQNjqLCjXq
        KyNTnFTabP9e8rwEK9WxFH1k3yYwW0pcnAiCkn4SlS2qudR/G45zVxPG+HSOuoWRRMi99i
        ofldpx+YUZv9dij1Zx90Xt6sB+p17DDWgwzWhYwh4Xz/bZqm9Y9vgu53omt4bQ==
Message-ID: <9100eb19ee8fb16e78cfee86e953dfe2afd6efe9.camel@iki.fi>
Subject: Re: [PATCH v2 6/6] doc/media: Convert media-api.rst into manpages
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Sat, 23 Sep 2023 12:14:05 +0300
In-Reply-To: <20230922192335.1060601-6-luiz.dentz@gmail.com>
References: <20230922192335.1060601-1-luiz.dentz@gmail.com>
         <20230922192335.1060601-6-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

pe, 2023-09-22 kello 12:23 -0700, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This splits media-api.rst into org.bluez.Media<interface>.rst and
> generate manpages for them.

I made a pass looking at the implementations of the transport/endpoint
and SetConfiguration/SelectProperties/SelectConfiguration and comparing
to docs.

Note that the SelectProperties API has a problem with BAP endpoint
configuration. We maybe should redesign it while we still can?

I think generally at least from Pipewire side there's no need to keep
backward compatibility while this is experimental. We can target BlueZ
master branch.


SelectProperties API problem:

As BAP client one first does Config Codec (ASCS =C2=A75.1) which takes
Target_Latency, Target_PHY and Codec.

After this, the ASE properties (ACSS Table 4.3) in Codec Configured
state contain the server supported values for Max_Transport_Latency,
Presentation_Delay_Min/Max etc.

SelectProperties is called before Config Codec, so it cannot
necessarily know the server supported values. In this case the sound
server cannot fill in QoS correctly.

The client-invoked SetConfiguration API also seems to have similar
issue.

Probably: SelectProperties should be called twice, once to get
parameters for Config Codec, and then again to get parameters for
Config QoS. Or, there should be a separate "SelectCodec" and
"SelectQoS" calls. Calling "SelectProperties" twice could be simpler
for everyone.=C2=A0

In client-invoked "SetConfiguration" API, one probably should only pass
in the parameters needed for Config Codec, and BlueZ should then make a
SelectProperties call to get the QoS ones once the server-side values
are known.

I can take a look at this...


MediaTransport:

"Delay" field only exists for A2DP in code.

"Volume" field only exists for A2DP in code.

"Links" is ucast only in code.

"QoS.TargetLatency" does not exist in code. Maybe it should be exposed
for consistency, since it's expected as return from SelectProperties.


SetConfiguration:

SetConfiguration properties dict when called by BlueZ contains exactly
the properties of the transport. The documentation probably should say
that this is so.

When called by client, the contents of the properties dict are expected
to be different. QoS parameters are not packed in a "QoS" dict. Maybe
they should be. The "PHY" key is also still a string here.

The documented input parameters expected from client are wrong, the
documentation explains fields of struct bt_bap_pac_qos, but what the
code parses are that of struct bt_bap_qos.

"MaximumLatency": no such field in code, seems to be called "Latency"
everywhere.


SelectProperties:

In code, the return parameter expects QoS parameters (struct
bt_bap_qos) to be packed in "QoS" dict.

They are not packed in "QoS" dict in the input parameters. These are
not exactly QoS, but instead struct bt_bap_pac_qos, so not clear if
they should be packed.

The input and return parameters are not documented. The input QoS
contains fields of struct bt_bap_pac_qos. The return QoS has fields of
struct bt_bap_qos.


MediaEndpoint:

The endpoints published by BlueZ only have the properties
"UUID", "Codec", "Capabilities", "Device".

The documentation lists various other things, but they are not
implemented as server endpoint properties.

As client endpoint properties:

"RTN" is expected to be present in code, but is not documented.

"MaximumLatency" "Location" "SupportedContext" "Context" are documented
but not present in code.


--=20
Pauli Virtanen
