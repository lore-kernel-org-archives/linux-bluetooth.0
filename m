Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FD3AEF39
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809225; cv=pass; b=tSpTGZCCfTqKAIFU7MmDr0Bun0y9WcS84fNoto83TSO5WKmMzpz13f/aBAy/BX43n9qRxP8foivOD5nVX6hMALA6TCsWKaJ/57zNqcvqbwr4KEs4mGHVdikHNWAY+Co5PQrK4kcwq7EXI0kL+QrW+SR8nHnpav/FKwwvPQujibM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809225; c=relaxed/simple;
	bh=KGwPJj0KdtEpZFaylURNnedjPWEPziYVQUFwLG9Em04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbizgJbwRl5USQgGJgv2ifAWF39mUJYJMfCgxuTS8PxWoee2RHwij+oJCiqsvH7m9Q7r9aqtCJtuiP7n4/9u2RT3sLHnLRTx+ZIViwbiub1Ittzp17dqgebKwBjnKQm0gI1mdERRNjtomzEJgTOJtsi0ryVABszZgGmtVfL8/eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgSsc7VR; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgSsc7VR"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so8540252d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 07:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772809219; cv=none;
        d=google.com; s=arc-20240605;
        b=Rk4tpvXewssTkhSwu5tHEU2nlPnr8DznygKb3Ii+f1vxD5U9P1PrIyIRFd18hzPNPE
         eIiuW0Z4VOb+5ysC1XUzCSc5lHxoJmkV5ZBGTIA8HTE0mKBi6veG8uaHBwzN4Vj+zn9d
         tDMmFXruvUPdhbp1Y3kg073Afraiyj3LQYk0MyUQuBTJkCV8HrjOPsykeaCNeg2E75EZ
         nvM8BxRPdxwoLverLgX5Tm3Is680DSpUbfMauCpzxtGaKpoHCNf93IWajZwTVajkqF10
         V4WQepbPGjHkKJsV6ffgtyX+A/yRpOzp9HtHjmrf7LgNdjfcbs8kPpRjLgLgzaSX+Uyb
         AwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K+Jto1qKHJJVO1fAQ2cNj8dc8ON09ePTcfEr9q83Iyk=;
        fh=3vCSbKDpVSeNBgeQYcQRRdY50507ZYFO5BE2JEAefWw=;
        b=bKD+ONxc+leGsbVYTnZilGy7DuNoRD6R0cQQL4E1B3xHvMoRaD5416Th3oRirG2HS2
         DBlkMPc3+yBysYsrM3sqiOKdF57JvXYSk2Spl4EzQASPG9hcod6UF6kheIvu/l6pQOi7
         +QkPNABRlDZg79Pyu/hmus3fRHf233TYTJNaFyOmNPQhacDCvda8JSu/AAx6T0NS9gWl
         cRMvh2zJWaGJjgayg1T+9VVgggLuzlsrfuQDAeX0HRJs7jNld9LHy99FbQXUN9JUuITd
         2G7L/mq9xGf6ji0VppqlTAPbW9Xc/bgExnuQ+cHPnEHtpMwdLsmjHza/5PIssQXk024Q
         Tmtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772809219; x=1773414019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+Jto1qKHJJVO1fAQ2cNj8dc8ON09ePTcfEr9q83Iyk=;
        b=HgSsc7VRpoQCKEXJ+soBL61OtMNTbPuIw1rs/KvdeBrzkW9BeWspFcZpF0Hzf6yw9q
         bAdqMzKzXmSQyb3Vjz3Bpn3MhCh0GHek/OHKe/b3luYCsJdX1k8DAKIkzpnArOZyxmWD
         vnxyqx9rlnIjg4/wMRyx5UOJUiyqFqWDDUeG4hC4QfLuwmPaPN7eYUMUsTMU3+f65DhN
         C4oSurL09Wq1BQ8d0+CG+YS1XG86g/NXwRgIb06/ihIvAe5y5DYZc6FxivZzWZLbUnI3
         894qumeYdTpp5nNcpQQxkTKH40Whp+KleJKzMiiPsSHACS7fwbmy0UtiJfSbSOy+LQsM
         UV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809219; x=1773414019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+Jto1qKHJJVO1fAQ2cNj8dc8ON09ePTcfEr9q83Iyk=;
        b=t0MLHxJ2+T1tzDODo364Zo01rvkcLBxJcElnoDM+umzyIhgDxErxsrGYs0DTcpAKeI
         YDpaNTnEEhlrfY2UZvbn/e4rS64hz0DEpH+GmIbg4aLmYsBqFrvtiDO4BjCf92DXrkzg
         CI5mF3wfIEXNiRW/8hQLPeLGCwJwSSLVcTO0+rFdbqF9o5bwW3thzqe3P/mWwQKWRQT1
         ih43dYVFxs1slI/deqppuk17+hy4m3MGnrLCpQ3P+LSni/PNvByTZYjjzUnwi3wQWjer
         nT4cuHFuUC8XER1fWJPjKcW8oaEJcngCZhBmVpkN995zQgwjbPMXInUtuX+bL+qEiLuw
         dpww==
X-Gm-Message-State: AOJu0YwIfdff7CtiMhzIWUY5nZHxKlHXGtnrqp82c2Prwh2oesQQqEzs
	7xPq3cJi+Oc1/dbis3DEnvgxCOCvcVBSfHwLPElsn/l/w1vkZ9dXVU4HJAS0Y2g1e8E5+1HxQBW
	Np3O2UMXotqjTXD7iozoCWltW4MBLbOY=
X-Gm-Gg: ATEYQzxU+lNDdJE/BUZB7qk2fYhvA9RVUHmKKJhF37ueV22aCcdGsIRHHURTaZE6HDw
	qD/QKcKVQVn5H/+urC7b78jAty2Gh1hkFOffrWOjwN7DQwlnF4S2NzLew73t+GKXpoOgwHQh/NT
	59a86/qAqNDMfNTAEHDqtriMcXd/l3koULTlgsvBUlNJpabtByx9N/TncR3++MBQXXsCiSXnO+4
	f9/5t3P6L3edAapW2aTueghAgkZMIZHjinLOzmgETQDQhRfIt4h7c61BJz6fLY4wn5VeBeVgpHS
	EYClJ4ZcqsbEYlBsjfBr5FvMB7BqfxZkcAYxCbYVs5Ty6SyJUwSLLrgsiD7EeBvPcSgN9A==
X-Received: by 2002:a53:b442:0:b0:64c:f14f:8f7e with SMTP id
 956f58d0204a3-64d1429b317mr1779469d50.47.1772809217783; Fri, 06 Mar 2026
 07:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305083833.369358-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20260305083833.369358-1-jinwang.li@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Mar 2026 10:00:06 -0500
X-Gm-Features: AaiRm51mnXB5GGQMRtriRbsbkmIJ29Tj3MnIytR8iAFV9ihVnsMDEtFJeWnCA5c
Message-ID: <CABBYNZKNJ4SY_E3WE5JZmUkjvdxA0f_pFMnJv_K6kOt+-JRe2A@mail.gmail.com>
Subject: Re: [PATCH v2] transport: Fix set volume failure with invalid device volume
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jinwang,

On Thu, Mar 5, 2026 at 3:38=E2=80=AFAM Jinwang Li <jinwang.li@oss.qualcomm.=
com> wrote:
>
> When AVRCP is connected earlier than AVDTP, this invalid device volume
> causes the A2DP sink to reject the peer's registration for the
> EVENT_VOLUME_CHANGED notification. As a result, subsequent attempts to
> set the volume fail.
>
> Fix this by ensuring a valid device volume is returned when the device
> volume is invalid, allowing volume registration to succeed.
>
> Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume =
properly")
> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
> ---
>  profiles/audio/transport.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> Changes from v1:
>  - Return the max volume from media_transport_get_a2dp_volume()
>    when there is no A2DP transport and the device volume is invalid.
>  - Restore the default device volume in device_new().
>  - Update the commit subject name.
>  - Link to v1
>    https://lore.kernel.org/all/20260122063640.310090-1-jinwang.li@oss.qua=
lcomm.com/
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index d9feef768..41d8d0a75 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -2767,6 +2767,7 @@ static void media_transport_emit_volume(struct medi=
a_transport *transport)
>  int media_transport_get_a2dp_volume(struct btd_device *dev)
>  {
>         GSList *l;
> +       int volume;
>
>         if (dev =3D=3D NULL)
>                 return -1;
> @@ -2793,7 +2794,11 @@ int media_transport_get_a2dp_volume(struct btd_dev=
ice *dev)
>          * of ordering between AVRCP and A2DP session start. (Note BAP+VC=
P do
>          * not have this issue.)
>          */
> -       return btd_device_get_volume(dev);
> +       volume =3D btd_device_get_volume(dev);
> +       if (volume < 0)
> +               volume =3D 127;

This doesn't work because the behavior differs depending on the role,
as a source we need to return -1, so I suggest doing this instead:

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 724b46c592ff..326dfdab7e3d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4296,9 +4296,16 @@ static void target_init(struct avrcp *session)
        if (target->version < 0x0104)
                return;

-       if (avrcp_volume_supported(target))
+       if (avrcp_volume_supported(target)) {
                session->supported_events |=3D
                                (1 << AVRCP_EVENT_VOLUME_CHANGED);
+               /* Check if transport volume hasn't been initialized then s=
et it
+                * to max so it works properly if the controller attempts t=
o
+                * subscribe to AVRCP_EVENT_VOLUME_CHANGED.
+                */
+               if (media_transport_get_a2dp_volume(session->dev) < 0)
+                       media_transport_set_a2dp_volume(session->dev, 127);
+       }

        session->supported_events |=3D
                                (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED)=
 |

> +       return volume;
>  }
>
>  void media_transport_set_a2dp_volume(struct btd_device *dev, int volume)
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
