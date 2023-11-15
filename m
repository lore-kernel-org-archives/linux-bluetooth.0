Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E784375
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Nov 2023 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRJV7ZZM"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68202C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 16:22:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c83d37a492so45964841fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 16:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700007741; x=1700612541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kyejc4TU7FQyA+o5AMTItHacp0/eFmeYBqiADKOUHEQ=;
        b=kRJV7ZZMTtJwcbv2E52F0EKFeEfNg60fRIvwJZYOthBCnLrdylNfAayCow2dhZt4PY
         oMXqWf8PwgegHP9RTHsude5wXZTBeFfJeWG+hkHcMXVtTQEBIrz0Goqe1iOUiEYUIKLn
         ooMQJ88L26hoAokdxH6WNdTBVV1S2SRaVr2ff5WueCgDBjSMH0+o18X+EfGFmts+MMuf
         ULMx/H8c1HVamTNCxZAuplkLndtD4vA1+Wr1UKRuGWBvW50JfeYtkyuMTLPbiGzGzKIa
         iE6ffEaeNKdkJ6jp0/jfh8MHt4xu7x4Al/c4EOclkCRE1z++9WQNHAV3NO+ZVmg2Fus+
         EZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700007741; x=1700612541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kyejc4TU7FQyA+o5AMTItHacp0/eFmeYBqiADKOUHEQ=;
        b=ItoVaFLNGVJ7rdueQJAuG8851a7lVasrbN8QEHiqbtFJGB9UTERol0grdFZ3z1rHhh
         V61mrtnagIm8NMIWREO5HnlJCoJjPLP6yhoEcGmFqqMoNTF51cjMuXF+5aWeuGByHxxq
         edt1xM49IN8gFtfxLrKtkMte7YZXYQAKu1AzBNTHBsMbhZh55DUqr6zrWcZ+ClEzdTAN
         8bDbB1O4BVyywqGdEnpOxnTJCvkdqJ/NP0SWUBdh50fW15QG23hL3XPObB3TuOfaKk7u
         YwSan9WmRvgtlS4UxsgmJTiC/RKp+WGFkdEiq4MavW/CSrUPeyOKsOrd75j34zm3ADEq
         WNNg==
X-Gm-Message-State: AOJu0YxpK6H7sRpgx3dAF4Cud1BD9+NE8SSKCu9uRYsS59vTU3ZGxHJ/
	IVGBY8/EnG9XOtdU1md6FG9NRjyA9OvCpaWqxWWMdK2PLZI=
X-Google-Smtp-Source: AGHT+IGxmZLnmjSB0jBYACsFIdwSXsHtS0qCJaQsnoRRh4u6f79xn5YqyMpm7hKUvJRagvJ2O/MkWiHtgEk/2limdNw=
X-Received: by 2002:a2e:1449:0:b0:2bc:b9c7:7ba8 with SMTP id
 9-20020a2e1449000000b002bcb9c77ba8mr2879252lju.43.1700007741411; Tue, 14 Nov
 2023 16:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
In-Reply-To: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Nov 2023 19:22:08 -0500
Message-ID: <CABBYNZL-HXk5_NkVr_7VLSxO0esvT8GqEFJd4Kni4kTPNjxtkw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc: extend MediaEndpoint1 API with SelectQoS
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Oct 28, 2023 at 10:42=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Change unicast BAP configuration to proceed as:
>
> 0. SelectProperties(endpoint)
> 1. ASCS Config Codec
> 2. ASCS Server notifies ASE
> 3. SelectQoS(configuration)  [optional]
> 4. ASCS Config QoS
> 5. SetConfiguration(transport)
>
> Previously, SelectProperties had to return also the QoS
> configuration. However, it is impossible for it to provide it properly,
> because the values supported by the server are known only after ASCS
> Config Codec.
>
> This resolves the issue by adding a new method call, which is supposed
> to return suitable QoS values.
>
> Remove the QoS input parameter from the SelectProperties() call, as the
> server supported QoS settings may depend on the codec configuration, and
> are not known yet at that point.
>
> For convenience, e.g. when mandatory QoS presets are used, the endpoint
> does not need to implement SelectQoS(). In this case the QoS values
> returned by SelectProperties are used.

Id leave the endpoint the option to return the QoS on
SelectProperties, if it doesn't then we call SelectQoS, that said this
also means we need to wait until the endpoint respond with the QoS in
order to create the socket or we have to create the socket without any
QoS which afaik is required to bind.

> ---
>
> Notes:
>     Alternative to this is calling SelectProperties() twice at the
>     two different stages of the ASE setup steps.
>
>     However, if the second SelectProperties() call returns a different
>     Capabilities configuration, we'd need to either (i) do Config Codec a=
gain
>     or (ii) fail the configuration.
>
>     Doing Config Codec again introduces a chance of getting stuck looping=
,
>     if client is not behaving correctly, which doesn't sound like good
>     design. Failing the configuration raises question why have the
>     Capabilities as return parameters at all. So instead, make it a separ=
ate
>     method.

Well it is also possible that the server returns non-optiomal
preferences compared to a different codec configuration but we can
only know that once the codec is configured, so we need to be prepared
for the headset to misbehave like many do in case of A2DP, but in case
of BAP they can messed up in both Codec configuration and QoS stages.

>
>     ***
>
>     If two methods is too much, we could in principle get rid of the
>     SelectProperties() call and leave only SelectQoS.
>
>     Instead, the sound server would call SetConfiguration() on a remote
>     endpoint it chooses, and provide the configuration parameters there.
>     IIUC, this is how it is supposed to work for BAP Broadcast currently.
>     This might need some sort of "Ready" property on the Device1 DBus obj=
ect
>     or elsewhere (e.g. the endpoints), so that it's simple for the sound
>     server to wait until all endpoints have been exposed in DBus.
>
>     This might also be preferable way to do it, since only the component
>     closer to the user i.e. the sound server knows which endpoint the use=
r
>     wanted to use, and when BlueZ guesses wrong it avoids needing to tear
>     down the old configuration and reconfigure (which we have to do for
>     A2DP).

In principle Im nore in favor of keeping the logic of bluetoothd
calling into the endpoint object when it is necessary, we also may
apply the same logic as for A2DP that use the last configuration when
reconnecting, so there is no guessing but more of a policy of using
the last configuration to make the reconnections as quick as possible.
If the user wants to change the configuration he can do via
SetConfiguration, but this normally requires a user interaction, also
if the idea would be to have the reconnection policy on top of
bluetoothd Id say it is probably not recommended as that would
probably be slower and it may not know all the endpoints registered in
order to properly infer what is the best configuration to use.

>     ***
>
>     This series was tested also vs. this
>     https://gitlab.freedesktop.org/pvir/pipewire/-/commits/bap-selectqos
>
>  doc/org.bluez.MediaEndpoint.rst | 66 +++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoin=
t.rst
> index 6754d6e3b..4ffe6951c 100644
> --- a/doc/org.bluez.MediaEndpoint.rst
> +++ b/doc/org.bluez.MediaEndpoint.rst
> @@ -66,6 +66,8 @@ array{byte} SelectConfiguration(array{byte} capabilitie=
s)
>         Note: There is no need to cache the selected configuration since =
on
>         success the configuration is send back as parameter of SetConfigu=
ration.
>
> +.. _SelectProperties:
> +
>  dict SelectProperties(dict capabilities)
>  ````````````````````````````````````````
>
> @@ -79,8 +81,58 @@ dict SelectProperties(dict capabilities)
>
>         :uint32 Locations:
>
> +       See `MediaEndpoint Properties`_ for their possible values.
> +
> +       Returns a configuration which can be used to setup a transport:
> +
> +       :array{byte} Capabilities:
> +
> +               See **org.bluez.MediaTransport(5)**.
> +
> +       :array{byte} Metadata [optional]:
> +
> +               See **org.bluez.MediaTransport(5)**.
> +
> +       :dict QoS:
> +
> +               See **org.bluez.MediaTransport(5)**.
> +
> +               The following fields shall be provided:
> +
> +               :byte TargetLatency:
> +               :byte PHY:
> +
> +               If `SelectQoS`_ is not implemented, then values for
> +               all other ``QoS`` fields are also determined by the
> +               value returned here.
> +
> +       Note: There is no need to cache the selected properties since
> +       on success the configuration is sent back as parameter of
> +       `SetConfiguration`_ and `SelectQoS`_.
> +
> +.. _SelectQoS:
> +
> +dict SelectQoS(dict configuration)
> +``````````````````````````````````
> +
> +       Select BAP unicast QoS to be used for a transport, based on
> +       server capabilities and selected configuration.
> +
> +       :object Endpoint:
> +
> +       :array{byte} Capabilities:
> +
> +               The configuration, as returned by `SelectProperties`_.
> +
> +       :array{byte} Metadata [optional]:
> +
> +               The metadata, as returned by `SelectProperties`_.
> +
>         :dict QoS:
>
> +               Server endpoint supported and preferred values.  See
> +               `MediaEndpoint Properties`_ for their possible values.
> +
>                 :byte Framing:
>                 :byte PHY:
>                 :uint16 MaximumLatency:
> @@ -89,18 +141,16 @@ dict SelectProperties(dict capabilities)
>                 :uint32 PreferredMinimumDelay:
>                 :uint32 PreferredMaximumDelay:
>
> -       See `MediaEndpoint Properties`_ for their possible values.
> +       Returns a QoS configuration which can be used to setup a transpor=
t:
>
> -       Returns a configuration which can be used to setup a transport:
> -
> -       :array{byte} Capabilities:
> -       :array{byte} Metadata [optional]:
>         :dict QoS:
>
> -       See `SetConfiguration`_ for their possible values.
> +               See **org.bluez.MediaTransport(5)** QoS property for
> +               possible values.
>
> -       Note: There is no need to cache the selected properties since on
> -       success the configuration is send back as parameter of SetConfigu=
ration.
> +       Note: There is no need to cache the selected properties since
> +       on success the configuration is sent back as parameter of
> +       `SetConfiguration`_.
>
>  void ClearConfiguration(object transport)
>  `````````````````````````````````````````
> --
> 2.41.0
>


--=20
Luiz Augusto von Dentz
