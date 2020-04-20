Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5135C54FCC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 23:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88277206B9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 23:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MskGdxoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDTXyw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgDTXyv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 19:54:51 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B025CC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 16:54:51 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m18so9765089otq.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0UKf6riZkWYAJaroh0dJi6lT0BkvdtM0mD8/n9ggr6o=;
        b=MskGdxoqUv3IiQd/zQ4+pXS05K+yhykLckku0krHTrxkldXyh0DdDg48D1VtpOrp1M
         MUOAMB4xKv0KnSG6i+orxOgGrNRajTZITYn8y/ayZ0xM5v+2bDATNsaqghf3toE1+YrO
         WMI7DnCsQg86fBpexPCVuNlvRzO1shHHK9Y2X6DSXMUfMUJWl5dX7HUogffeTVcU0bpi
         zg4HYj2Kda98KqCN5cHmWgf8T/BoRebr+cR34DM6pPT0VmU39TaHLdUMeHYob8i3KmZK
         Tt+gfQAK5gFELczb29j+f+R9lJ73oacp4xc0uchzA8NnKI5QZjitmA2NEbZeAqM1iYFN
         BCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0UKf6riZkWYAJaroh0dJi6lT0BkvdtM0mD8/n9ggr6o=;
        b=lRVVYe4r10/6U7bUY8IK+zZkKIcO9lBGnzfTGhzEDQAy4KxKvBj3lsM1/FyYisy/yQ
         fOnTysXsRcoknlTwEYnFrBUKztJBpHnlXX4tpc94/Xyln1oADo2Qy1chVdg+2idvvGh1
         2U4YIAl6gZrT97AwH+E96WLvdk/1USL+MvlYb5JG3DOijt/7WdNnpkLzrVMpbRcTQlw+
         OYja/uMrhhZ/sp4XMsp1FYqgQGOJl/Em/797xiH2XJ/5crktsmlHnvyDSUJvuXj8v8bJ
         uHrq0hszC3zci1Ga04hrg7DSNnYMGb/DM2d5ndhLs5v9EuAmM+xMyFkWKwWmRLYSNoJQ
         psIg==
X-Gm-Message-State: AGi0PuYcueWQvDj4Yc09EWSU6nsQL2rn+tN79ZO+/WNQ2aPlHATXv2BM
        VoFUCJKMio8dx41CkNuc/DP1t1PlcTNhS0QzJro=
X-Google-Smtp-Source: APiQypIAUoLttRmKztEGSHPMtLCpi3SxuMrUL1e7rGfbxDgr0DBxEoqSZzu9DnmN4j3xJqHlv/z1m7z5RMJyfe1weo8=
X-Received: by 2002:a9d:644:: with SMTP id 62mr10264947otn.177.1587426890855;
 Mon, 20 Apr 2020 16:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
 <20200219120940.1509224-1-david@ixit.cz> <20200419234937.4zozkqgpt557m3o6@pali>
In-Reply-To: <20200419234937.4zozkqgpt557m3o6@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Apr 2020 16:54:39 -0700
Message-ID: <CABBYNZ+4YWejhbYq_wCYq23acKoq3AarzGykEM952Po4h_83kA@mail.gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Apr 19, 2020 at 4:49 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> I'm sending next attempt for userspace <--> kernel API for specifying
> connection settings of SCO socket. I was thinking more about it and I
> was able to remove some members from struct bt_voice_setup which are not
> needed for Linux SCO sockets (e.g. specifying different routing then
> over HCI).
>
> Here is this API:
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index fabee6db0abb..f1f482bdf526 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -122,6 +122,37 @@ struct bt_voice {
>  #define BT_SNDMTU              12
>  #define BT_RCVMTU              13
>
> +#define BT_VOICE_SETUP         14
> +
> +#define BT_VOICE_PKT_TYPE_CAP_SCO      BIT(0)
> +#define BT_VOICE_PKT_TYPE_CAP_ESCO     BIT(1)
> +struct bt_voice_pkt_type {
> +       __u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
> +       __u8 retrans_effort;
> +       __u16 pkt_type;
> +       __u16 max_latency;
> +};
> +struct bt_voice_setup {
> +       __u32 tx_bandwidth;
> +       __u32 rx_bandwidth;
> +       __u16 tx_codec_frame_size;
> +       __u16 rx_codec_frame_size;
> +       __u8 tx_coding_format[5];
> +       __u8 rx_coding_format[5];
> +       __u8 input_coding_format[5];
> +       __u8 output_coding_format[5];
> +       __u16 input_coded_data_size;
> +       __u16 output_coded_data_size;
> +       __u8 input_pcm_data_format;
> +       __u8 output_pcm_data_format;
> +       __u8 input_pcm_msb_position;
> +       __u8 output_pcm_msb_position;
> +       __u32 input_bandwidth;
> +       __u32 output_bandwidth;
> +       __u32 pkt_types_count;
> +       struct bt_voice_pkt_type pkt_types[];
> +};

We might be better off splitting the local only, coding format
related, from the QoS that goes over the air, afaik one don't have to
reprogram the coding format for every connection, or perhpas Im
confusing with how ISO commands works in this regard.

>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
>
>
> Structure specify settings for exactly one codec.
>
> Meaning of those members is same as for Enhanced Setup Synchronous
> Connection HCI command.
>
> Let me a bit explain it:
>
> Members tx_bandwidth, rx_bandwidth, tx_codec_frame_size,
> rx_codec_frame_size, tx_coding_format and rx_coding_format specify AIR
> codec and all of them are needed to correctly describe codec used by
> bluetooth adapter to transmit data over the air. All of these members
> are also part of Enhanced Setup Synchronous Connection command and
> application which want to use vendor codec needs to control of all them.
>
> Members input_coding_format, output_coding_format,
> input_coded_data_size, output_coded_data_size, input_bandwidth and
> output_bandwidth describe LOCAL codec, format of audio data which is
> passed by application to the bluetooth adapter. It does not have to be
> same as AIR codec and in this case bluetooth adapter is doing HW
> encoding/decoding.

Does that assumes that we can only have one local codec active at
time? How about 2 devices connected, one using CVSD and another mSBC?
If we can't configure the hardware codecs on a per connection basis
then chances are this won't be that useful for things like a desktop
environment as in order to support multiple devices connecting, with
or without wideband speech, we would have to switch to sofware
enconding/deconding, but perhaps Im wrong and it indeed possible but I
doubt that because HW encoding/decoding normally use dedicated DSP and
I don't think that would be able to deal with different codecs in
parallel, which means that in order to use HW encoding/decoding we
would have to artificially limit the number of SCO connection to 1 to
avoid random drop outs when using HW codecs.

> When coding_format is PCM then additional parameters for PCM format
> needs to be specified, more exactly they are in members:
> input_pcm_data_format, output_pcm_data_format, input_pcm_msb_position
> and output_pcm_msb_position.
>
> For modern audio applications is is required to control all of these PCM
> parameters as audio application does not have to reencode everything to
> one format (e.g. 8Hz/s16le), but let bluetooth adapter to do reencoding
> at HW level.
>
> The last pkt_types[] array (with pkt_types_count items) defines what
> type bluetooth packets and SCO/eSCO mode can be used with particular
> codec.
>
> So all members of that structure are needed for userspace audio
> applications (e.g. pulseaudio) and without them it is not possible
> implement custom vendor SCO codecs which are already used in bluetooth
> headsets. Also without them it is not possible to use HW encoders in
> bluetooth chip, e.g. mSBC and applications are forced to use in-software
> encoding/decoding which may be slow or increase latency or power usage.
>
> And here are some example how to use it:
>
> SCO socket that would accept 16kHz PCM s16le data and bluetooth chip
> would encode it to mSBC over the air.
>
>   #define HCI_CODING_FORMAT_PCM 0x04
>   #define HCI_CODING_FORMAT_MSBC 0x05
>   #define HCI_PCM_DATA_FORMAT_2COMP 0x02
>   static const struct bt_voice_setup voice_setup =3D {
>     .tx_bandwidth =3D 8000,
>     .rx_bandwidth =3D 8000,
>     .tx_codec_frame_size =3D 60,
>     .rx_codec_frame_size =3D 60,
>     .tx_coding_format =3D { HCI_CODING_FORMAT_MSBC },
>     .rx_coding_format =3D { HCI_CODING_FORMAT_MSBC },
>     .input_coding_format =3D { HCI_CODING_FORMAT_PCM },
>     .output_coding_format =3D { HCI_CODING_FORMAT_PCM },
>     .input_coded_data_size =3D 16,
>     .output_coded_data_size =3D 16,
>     .input_pcm_data_format =3D HCI_PCM_DATA_FORMAT_2COMP,
>     .output_pcm_data_format =3D HCI_PCM_DATA_FORMAT_2COMP,
>     .input_pcm_msb_position =3D 0,
>     .output_pcm_msb_position =3D 0,
>     .input_bandwidth =3D 32000,
>     .output_bandwidth =3D 32000,
>     .pkt_types_count =3D 2,
>     .pkt_types =3D {
>       { BT_VOICE_PKT_TYPE_CAP_ESCO, 0x02, EDR_ESCO_MASK & ~ESCO_2EV3, 0x0=
00d }, /* T2 */
>       { BT_VOICE_PKT_TYPE_CAP_ESCO, 0x02, EDR_ESCO_MASK | ESCO_EV3,   0x0=
008 }, /* T1 */
>     },
>   };
>   int fd =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
>   bind(fd, ...);
>   setsockopt(fd, SOL_BLUETOOTH, BT_VOICE_SETUP, &voice_setup, sizeof(voic=
e_setup));
>   connect(fd, ...);
>
>
> SCO socket that would accept AuriStream codec from application and tell
> bluetooth chip to pass-throu as is over the air:
>
>   #define HCI_CODING_FORMAT_TRANSPARENT 0x03
>   static const struct bt_voice_setup voice_setup =3D {
>     .tx_bandwidth =3D 4000,
>     .rx_bandwidth =3D 4000,
>     .tx_codec_frame_size =3D 60,
>     .rx_codec_frame_size =3D 60,
>     .tx_coding_format =3D { HCI_CODING_FORMAT_TRANSPARENT },
>     .rx_coding_format =3D { HCI_CODING_FORMAT_TRANSPARENT },
>     .input_coding_format =3D { HCI_CODING_FORMAT_TRANSPARENT },
>     .output_coding_format =3D { HCI_CODING_FORMAT_TRANSPARENT },
>     .input_coded_data_size =3D 8,
>     .output_coded_data_size =3D 8,
>     .input_pcm_data_format =3D 0,
>     .output_pcm_data_format =3D 0,
>     .input_pcm_msb_position =3D 0,
>     .output_pcm_msb_position =3D 0,
>     .input_bandwidth =3D 4000,
>     .output_bandwidth =3D 4000,
>     .pkt_types_count =3D 1,
>     .pkt_types =3D {
>       { BT_VOICE_PKT_TYPE_CAP_ESCO, 0x02, 0x003F, 16 },
>     },
>   };
>   int fd =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
>   bind(fd, ...);
>   setsockopt(fd, SOL_BLUETOOTH, BT_VOICE_SETUP, &voice_setup, sizeof(voic=
e_setup));
>   connect(fd, ...);
>
>
> That API is designed for Enhanced Setup Synchronous Connection HCI
> command, but can also be used by plain Setup Synchronous Connection HCI
> command. Plain version has just reduced set of features and basically
> instead of AIR codec members and LOCAL codec members use just one u16
> member voice_setting, which is just subset of all those possible
> Enhanced settings and can be generated from them. E.g. transparent
> coding format is encoded in voice_setting as 0x0003, usage of CVSD HW
> encoder from pcm_s16le_8kHz as 0x0060, but e.g. usage of mSBC HW encoder
> is not possible to specify.
>
> Please let me know what do you think about it. Thanks



--=20
Luiz Augusto von Dentz
