Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46113F1654
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147700; cv=pass; b=jQ1bLRlqz4meJdpkf1ZkKOvqSJZ7ZSvQz5IxLoNypij7thrcw+flZ7s2ocBgg2IZv/Skw8zTGQj1EmW43+ov+H5KFs3NBZvgTz2cNImdjsAQsvfDghWd6QppASeIiDcXuPsPNj7rGdIyIqRNXHESe/qGM6t+NP3p5Ot3yG8uRs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147700; c=relaxed/simple;
	bh=26iSJa6Ag9OqUhWy76i9TLuxIWkc1SZu0UnSrHL/A1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/NvsfTDP6dcDp50BBNQoqduEH0PoSw+HeMwh9EDgXh6N5+4L+ZRCKbqjB8rGmEYEmwqGGytWP47QlHzEzye/0Ll3AqY3Nyc3eXt97UZX47D4KKWSkSu3qDP2j0LKOBsqThWv6nFFgh4Z3WPN3+wr6r1VoEfSqVFaPxw3FdTJzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp2Ie2my; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp2Ie2my"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6500040f128so1036372d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 09:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147698; cv=none;
        d=google.com; s=arc-20240605;
        b=hZV0SGK0iPRXMC/dZfQ+MPqz7KEFdnaieEsCi2PAKvnRHnCg4KtHhXn81rKCltU571
         K1w1iw7LnSwTC2U+I6vmvbnFOtbT59/TDeDUMVlyQ8onoVHA9nty2j4JvlTMRVg2nZfW
         dSbDyuutCZIsKd0/V+pNdLPYPQJElEgQYvaHAJVFOHdK2Zg71qsD77GIkmj+rY3TGX5c
         OySdGKonicla2EabhQJo0bJJCoCrgNB70LWI7iBUj69MzbEIKWVpnyNlqjc9YXwKpT+r
         gcfWfP4QzEP8R34CKC2+6oGCCNHMlZtOooh2ea7JL7w/13kPqt834jI4iUdeAOCuO3o4
         xbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WRTSlLAI4+0YB45zTTy+buPtwPoyT2t/3sHUJL2vC8g=;
        fh=ZZVj5ccnQ9nN9OUb+KrtXe+U8QNQnoDaZ5x2MnLI93s=;
        b=UuFQg8ejaYDaJfKwK11QSmUoWkoV6pNrKtdLiiQ5H1wqKHhhJIP+V2sdkmJVvpuPy1
         bPbhhn5uez1bawf1StEB6R0uMEl8q/BkSQUBbP6gOmuA7jvYo40zCVqzh6GnnvffHQFG
         3zjOMSIZ+7SaZbenDUONvkBBfDr9/LRcT24bslnDU8xQGZkIpNxDOjRpDNpxdPQkWJ31
         H0vF4SUwUy9XMGciwTAy4Klgxj2ztcVIAQpIzpJLURjhqXxwGh3EWjRNaAuHv9/4Zipo
         xciI4Cdk2wZ7iIne1f7A+TmNyM8X1dtrN/IWbN6ztb9PiIGF4hkPHCwwriueCcOX+4G8
         53xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147698; x=1775752498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRTSlLAI4+0YB45zTTy+buPtwPoyT2t/3sHUJL2vC8g=;
        b=Yp2Ie2my7ep811A0BNfUNX5np26ogC2oDYo/fGqGptyT4QSohbpsJUGjeZa/T3Aoeh
         96BIOLUh/IaHfSjenr/PNE/CJrYMMmcOI0vDZQXKgkM6U+gqj4QSUcsct2SjxHIeWTpV
         dzuHeKhHrv+TERemT6B2ZVMZYX0gqArMpSHNYakRbh398vlMoqpPzWL75vfiSQH1Hguh
         9D5iQ3gz3HPnfInxOG1RR5BEYFrDFPjtXNKnRgxOD6xvSMi7r/FGHITLK9Lbg86Wz1V1
         3eayc32lCHvYhHpfKPtkb4Bcuq1d9kL22ejq2pTV4+raFFnBbJavYzl6rbpx9o/ty2Kj
         VZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147698; x=1775752498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WRTSlLAI4+0YB45zTTy+buPtwPoyT2t/3sHUJL2vC8g=;
        b=VnPTFzSwO89p3wOszVCPGLmgnUy9fZqoMvyPMzfcoWeVlt9PDuWUx7XFz2npGTLpIg
         y79xM5xRPplneFAGLeJFZibfgWltmfgaJdY6T22pwMhJ4Q/KirhpvVTimC3jk7Kun4mZ
         DcTKPJ6qU4La1/RSZSBTK8vS8KXaR4OUl4gIy6isGAxZrf4Ew6xH/XxZ6l5ZmZci59IE
         fy/desaK6QlvQVsUfceMsK0AcDua8lYTEfZ2VhtsSlbQtBQU7Cab1L4OXRTRpfBVC+mu
         PxtI1sJiK6cAmRR2rEWWzrbz66NXPDdlzfh580h8DSte7bxYmnRxLBGfVIKoVoxnL3Kg
         Hemg==
X-Gm-Message-State: AOJu0YygiwhEIaZY8dbmJYm2F0WAH50mZY1i3JOXa/Kve1RF6dQK9Pv2
	hTPGaBxAmmdlT49umAU8zWrD5qJZdUxdEPa8qW+SaVsQ8idESVj4k6TVz8d9qOJALH4Mi4+eIYh
	8OV35nZZfV1px8LSwt2Nh02slqEW9j1e5No/1128=
X-Gm-Gg: AeBDievmThNwiIAZBjGk1cyBZTCEn/HkNVvYiB7NIkXEy0rapekzuthhrGtqOqi8g2b
	ORdqQbCS5BNAQnLtAwcUOPWeN4u7IR5ZewfIYf0izRTK6lWz3D7frpgK7LDM5K6+6t6JsVx7RAE
	0oHKAMv0oKm0Uz1ZxLrvhZ7HqbSK9cUiJ7swuOXaNK6a/q5EOslgXz1icaaH7Hc0QdkCzeJoYBq
	KO+7OhQVz7/IraAoSLi3+fO4qvUiuEFm/SVi1HF09VHp15yWjFWvbq27A28thxz+lz6Qkd0QcF+
	L+GNB4zZtunVYEds1FoB5+eITNWLeNcksM3Z4zJemVvmDoMDwQ3P9wE6jTfuFngyFzo=
X-Received: by 2002:a05:690e:1488:b0:64e:b09f:e862 with SMTP id
 956f58d0204a3-6502fd8a34emr8055499d50.9.1775147697786; Thu, 02 Apr 2026
 09:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402075610.1724091-1-zhangchen200426@163.com>
In-Reply-To: <20260402075610.1724091-1-zhangchen200426@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Apr 2026 12:34:46 -0400
X-Gm-Features: AQROBzCazcGMCKEZfOAZQLVxtKm0bHYf5f9-Yr2NZ_Y6LACa8Xj7kGfWQOCwEyc
Message-ID: <CABBYNZKVUyrKqu55jvOx2oTAgGN0D=Ff=W0K9nq2pVVii38Ovw@mail.gmail.com>
Subject: Re: [PATCH] [BlueZ,v1,1/1] avdtp: ignore Discover cmd when host sends before
To: zhangchen200426@163.com
Cc: linux-bluetooth@vger.kernel.org, Zhang Chen <zhangchen01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 2, 2026 at 3:58=E2=80=AFAM <zhangchen200426@163.com> wrote:
>
> From: Zhang Chen <zhangchen01@kylinos.cn>
>
> Theoretically, the party that initiates the connection should send the DI=
SCOVER
> command. However, some devices, even though they are the connected party,=
 still
> send the DISCOVER command. In such cases, there is a probability of conne=
ction
> failure.
>
> Fails:
>
> < ACL Data TX: Handle 10 flags 0x00 dlen 6
>       Channel: 71 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
>       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 4 nosp 0
> > ACL Data RX: Handle 10 flags 0x02 dlen 8
>       Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 1}
>       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 4 nos=
p 0
>         ACP SEID: 1
>           Media Type: Audio (0x00)
>           SEP Type: SRC (0x00)
>           In use: No
> < ACL Data TX: Handle 10 flags 0x00 dlen 18
>       Channel: 71 len 14 [PSM 25 mode Basic (0x00)] {chan 1}
>       AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 no=
sp 0
>         ACP SEID: 1
>         INT SEID: 37
>         Service Category: Media Transport (0x01)
>         Service Category: Media Codec (0x07)
>           Media Type: Audio (0x00)
>           Media Codec: SBC (0x00)
>             Frequency: 44100 (0x20)
>             Channel Mode: Joint Stereo (0x01)
>             Block Length: 16 (0x10)
>             Subbands: 8 (0x04)
>             Allocation Method: Loudness (0x01)
>             Minimum Bitpool: 2
>             Maximum Bitpool: 53
> > ACL Data RX: Handle 10 flags 0x02 dlen 6
>       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
>       AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 la=
bel 5 >
> > ACL Data RX: Handle 10 flags 0x02 dlen 6
>       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
>       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> < ACL Data TX: Handle 10 flags 0x00 dlen 10
>       Channel: 71 len 6 [PSM 25 mode Basic (0x00)] {chan 1}
>       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nos=
p 0
>         ACP SEID: 25
>           Media Type: Audio (0x00)
>           SEP Type: SNK (0x01)
>           In use: No
>         ACP SEID: 38
>           Media Type: Audio (0x00)
>           SEP Type: SRC (0x00)
>           In use: No
> < ACL Data TX: Handle 10 flags 0x00 dlen 7
>       Channel: 71 len 3 [PSM 25 mode Basic (0x00)] {chan 1}
>       AVDTP: Open (0x06) Command (0x00) type 0x00 label 6 nosp 0
>         ACP SEID: 1
> > ACL Data RX: Handle 10 flags 0x02 dlen 6
>       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
>       AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 6 nosp 0
> < ACL Data TX: Handle 10 flags 0x00 dlen 12
>       L2CAP: Connection Request (0x02) ident 5 len 4
>         PSM: 25 (0x0019)
>         Source CID: 65
> > ACL Data RX: Handle 10 flags 0x02 dlen 12
>       L2CAP: Disconnection Request (0x06) ident 5 len 4
>         Destination CID: 64
>         Source CID: 71
> < ACL Data TX: Handle 10 flags 0x00 dlen 12
>       L2CAP: Disconnection Response (0x07) ident 5 len 4
>         Destination CID: 64
>         Source CID: 71
> > ACL Data RX: Handle 10 flags 0x02 dlen 16
>       L2CAP: Connection Response (0x03) ident 5 len 8
>         Destination CID: 127
>         Source CID: 65
>         Result: Connection refused - PSM not supported (0x0002)
>         Status: No further information available (0x0000)

You may consider throwing away the device you got, it is prefectly
valid to have a discovery both ways, AVDTP does allows either way to
setup a stream after all.

> Works:
>
> < ACL Data TX: Handle 12 flags 0x00 dlen 6
>       Channel: 77 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
>       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 11 nosp 0
> > ACL Data RX: Handle 12 flags 0x02 dlen 8
>       Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 0}
>       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 11 no=
sp 0
>         ACP SEID: 1
>           Media Type: Audio (0x00)
>           SEP Type: SRC (0x00)
>           In use: No
> < ACL Data TX: Handle 12 flags 0x00 dlen 18
>       Channel: 77 len 14 [PSM 25 mode Basic (0x00)] {chan 0}
>       AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 12 n=
osp 0
>         ACP SEID: 1
>         INT SEID: 13
>         Service Category: Media Transport (0x01)
>         Service Category: Media Codec (0x07)
>           Media Type: Audio (0x00)
>           Media Codec: SBC (0x00)
>             Frequency: 44100 (0x20)
>             Channel Mode: Joint Stereo (0x01)
>             Block Length: 16 (0x10)
>             Subbands: 8 (0x04)
>             Allocation Method: Loudness (0x01)
>             Minimum Bitpool: 2
>             Maximum Bitpool: 53
> > ACL Data RX: Handle 12 flags 0x02 dlen 6
>       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
>       AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 la=
bel 12>
> > ACL Data RX: Handle 12 flags 0x02 dlen 6
>       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
>       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0

Yeah, and that just breaks the command sequence in the process, so
this is a pretty bad idea if you ask me.

> < ACL Data TX: Handle 12 flags 0x00 dlen 7
>       Channel: 77 len 3 [PSM 25 mode Basic (0x00)] {chan 0}
>       AVDTP: Open (0x06) Command (0x00) type 0x00 label 13 nosp 0
>         ACP SEID: 1
> > HCI Event: Number of Completed... (0x13) plen 5
>         Num handles: 1
>         Handle: 12
>         Count: 1
> > ACL Data RX: Handle 12 flags 0x02 dlen 6
>       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
>       AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 13 nosp 0
>
> Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
> ---
>  profiles/audio/avdtp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index d475a545e..243c828bf 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -413,6 +413,8 @@ struct avdtp {
>
>         /* Attempt stream setup instead of disconnecting */
>         gboolean stream_setup;
> +
> +       gboolean discover_start;
>  };
>
>  static GSList *state_callbacks =3D NULL;
> @@ -1418,6 +1420,11 @@ static gboolean avdtp_discover_cmd(struct avdtp *s=
ession, uint8_t transaction,
>         struct seid_info *seps, *p;
>         gboolean ret;
>
> +       if (session->discover_start) {
> +               DBG("DISCOVER_CMD has been sent before.");
> +               return TRUE;
> +       }
> +
>         sep_count =3D queue_length(session->lseps);
>
>         if (sep_count =3D=3D 0) {
> @@ -2496,6 +2503,8 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct bt=
d_device *device,
>          * with respect to the disconnect timer */
>         session->stream_setup =3D TRUE;
>
> +       session->discover_start =3D FALSE;
> +
>         session->dc_timeout =3D DISCONNECT_TIMEOUT;
>
>         avdtp_connect_cb(chan, NULL, session);
> @@ -3484,6 +3493,7 @@ int avdtp_discover(struct avdtp *session, avdtp_dis=
cover_cb_t cb,
>         if (err =3D=3D 0) {
>                 session->discover->cb =3D cb;
>                 session->discover->user_data =3D user_data;
> +               session->discover_start =3D TRUE;
>         } else if (session->discover) {
>                 g_free(session->discover);
>                 session->discover =3D NULL;
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
