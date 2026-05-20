Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D783E5EE8
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285638; cv=pass; b=S+kYRVa4pxDcLI7X1oYj6t5lzKnmkSOgt9EoPek1UiLDQJzedJO1dK9KZEJg6wGQ96SxbfDZ9LaqmrnfaBxX6eLLv8iw7faxX2no5lfLEDCsbM1NWnq+x9gLI+JkRyNRGFxBR6sKj0IscB5oymwCmWGhIyB8FOVps8mKyv3s3OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285638; c=relaxed/simple;
	bh=a6iXobOed3sRPLM97RG69+W2Ae5HzR387KOzpzYwEYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpCZ8N63wW/1GVoSA/LW/7wrXVQRL59dS3mIYgDUY891qH8QzOI+ndUF0t8XPrXguG1DE+N6Bymifr10DyVkea16B78chu76rh+H/RLhqoGO6lNIhctAn9cefDKRZQ7yGFX479Ua+6pLjQiY3oM5PM3DAP/5jOHjnWEgox3R0Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEnWpFHO; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEnWpFHO"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c7492a2ceso4208171d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285633; cv=none;
        d=google.com; s=arc-20240605;
        b=Xh/o8a9lBdkG7goBcNnpNu8j3nCs7ZU9N/vh8ViS350kVNtM5wktyecQlSsgdnXVde
         AJpcs+GN90qGbGU1R5/giYnFiws36l34vCgADzby+D87OZ8sW+3JKfUNE6e6TNvYbIp5
         Mmc8tiT5iwI4EfP7EVc4odB0ghrSMoiY0oundOcpX3raKtLs3lmY/bvFcYdBaMdDYjhU
         jV2tXgH0DZbtLaah2D8Pfowtqcggd/dTKltup4GQDu8y14nDjw776dzqmhc++CiptQgv
         5uiG1bsODlKNF1MNURfE4Lgq1ptOoODcAjWhLjQt5G0SKiHX8tq7bHlQIVX/1jxDJ4uE
         yo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        fh=qAF0Hb1PS780Rcy5LjirXLtUtmDP0nG9YzxPBcvBIcI=;
        b=QoPjmZBi6KmAGwb1Q7iGHetag34/x1R51YPi1kIVOrHpqaUZB/o8MSVkjgjWLjQ+vn
         ZKSoeBTf2Z1qkWGj5Pt+Po7W2z4qVZ5Ok3XPMGu8RFjfbx2iYjF1OQn02H44yso5BXCg
         WMmd94u1Zh+6tNAq0C+r4BP6Dzz+rlTFv8Qo6Sfx81umfL8W+IhH8A4w4jI9aPGE09rS
         TXU1wSftAH9fAiRXY7TEPRy9D5NlRgNhZrnYvbRYpzsO4qvqM3eXOJOi2+dn6U8RMLnu
         qwTK4uHbOwFsjLo0Fq9QXfkGJeHhcCP34m4xB41WQwZ8pZEl6Q5h+G98TDBI3bQHwX8c
         hvqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285633; x=1779890433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        b=fEnWpFHO7e2e/VG5DchH7LlYMbMdAfAmL3bznExqaIWg6YvPBBaQtm8fTLKHkukjiQ
         v7DZMO1fGA7ywqfhOKgWbL1/p/3t78DMj2sFb7cwigEZtmcJmVb3C0zcM1xV/3RHAgOY
         Mv1ooeFagkOhWQfeMaFiLJ3GjpZgCf3XEdc95ihRfUMJL6tBW/7EtPvDYGWQBh2rH33Z
         rFHzjbpldgkgchoYwUEOP5cCmkYSpLjQ3+0ZJscxLcu+3Y9CWcOh+1yeCyzYf3YjH0kQ
         ed7bBOiwf70tpeX7qjuDr2CeMGjUph1GcmuriSf/JaqILD5I4TUGi0A0aBmHVFNxCMMs
         XVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285633; x=1779890433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        b=mNdXxI5CB4yjnmopnX5jwkYtx3zRjbe8Te9XRyl9GDe/b/zpPtpe4/QwPrT3v0Dqax
         BP7y7ICawOVD13HYFwPPO9P/mM11ZdpCJgmi8EnTIs5UXnxE90e/W8r82LMCMagWdoI4
         Dic5ian+JBdkLIiNKh714vjNF9oLrAM+kAxIRJeLLoFBYF2NKyqiN9raTag0HtJ+sjmu
         8YUt++S1G2/PU83UydM02+tWn36ShlVFGOQ2OY+gAgprTg2k3S3gNbZ30li087orOo8n
         ADE9xCgf/z7VyesSbjtN3LLtFYKPYsz7aK9i1iUNjFkFAmi5is4J4A5ABp0rpjrVIowe
         RgXA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ums7bt0h4uW3IYv73YvhIN/cFATMKxzGLVv2NiOAxgHL+LuTRmAMpKKon56g8cy5lXH13O+uZ7TkQvXFf4zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA5Ancf63k+Fe3UDH6cRrguoyiE+k2N+6Tqf/NmRbepEJelUVR
	EL/9A0iZD95saic+wORQL1mDzaqAsC+dmR2D9VKSdksPOX91obf4SOEPzWI+rLoIMcIMhbjB3vK
	vOVqopiB4ILzYp4xm/Ty33bIojQ0dpfg=
X-Gm-Gg: Acq92OF8dhDsZ3/78XRse68ZqFpdDFY15/lp7kZ9HUaP5WA0XWGPm5D/jE1Gs0StJYO
	EHE+wCsI7BjIJzKOTF28rklh5wafeJ7iE8MVJeUMEwi/GwDe/j8vU2agURHRjYA+wB5g4DQdTw0
	blV0ZeXjQHosQIGs0rQ3NsoQi/DsBzgNZ01JwsrOA9m6EFsBGug/wzihe1K+dFTE/RxaOVxgPth
	vRemzfymJQeZ+C5LuQ3ARgKDqNnlaU7Ox1Oagjx5thXXvT+0wy4Slrh1NnKofrzYmiQ7noZR3wp
	zYqxO9iYtoH/7hZRNQy0l1xPwMPVAjZcXax7zZck4bT6fw6r4/G+f//zlc15ytf+kXeETg==
X-Received: by 2002:a05:690e:2502:10b0:656:30a1:70e3 with SMTP id
 956f58d0204a3-65e228469fcmr20278863d50.53.1779285633031; Wed, 20 May 2026
 07:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
In-Reply-To: <20260520135034.1060859-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 10:00:21 -0400
X-Gm-Features: AVHnY4IdFrVeMyCQglDoLVCdIs5UC3o9rHcSrMblsA2cwCBRrhR-fiJEvzNPD_M
Message-ID: <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, May 20, 2026 at 9:50=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
> signaling packets up to the channel MTU and dispatches each command
> without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
> within radio range can send a fixed-channel CID 0x0001 packet that is
> larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
> pairing.
>
> In a real-radio stock-kernel run, one 681-byte signaling
> packet containing 168 zero-length ECHO_REQ commands made the target
> transmit 168 ECHO_RSP frames over about 220 ms.
>
> Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
> reject larger signaling packets before dispatching their commands. When
> the over-MTUsig packet contains a request command, send one
> L2CAP_COMMAND_REJECT_RSP with L2CAP_REJ_MTU_EXCEEDED and the first
> request identifier; packets for which no valid request command is found
> are dropped.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarit=
o@gmail.com
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
> harness that sends a single fixed-channel signaling packet containing
> packed zero-length ECHO_REQ commands. The patched code builds for
> net/bluetooth/l2cap_core.o on x86_64 defconfig. There are no in-tree
> Bluetooth selftests that reference l2cap_sig_channel(), L2CAP_SIG_MTU,
> or L2CAP_ECHO_REQ.
>
> The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
> trace to the initial git import; no later introducing commit is
> available for a Fixes tag.
>
> Changes in v2:
> - Replace the per-PDU echo-count cap with the MTUsig direction from
>   review.
> - Reject the whole over-MTUsig signaling packet with one
>   L2CAP_REJ_MTU_EXCEEDED command reject.
> - Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
>   command identifier is found.
>
> v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@=
gmail.com
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 60 +++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 5172afee54943..e0a1f2293679a 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -33,6 +33,7 @@
>  /* L2CAP defaults */
>  #define L2CAP_DEFAULT_MTU              672
>  #define L2CAP_DEFAULT_MIN_MTU          48
> +#define L2CAP_SIG_MTU                  48      /* BR/EDR signaling MTU *=
/
>  #define L2CAP_DEFAULT_FLUSH_TO         0xFFFF
>  #define L2CAP_EFS_DEFAULT_FLUSH_TO     0xFFFFFFFF
>  #define L2CAP_DEFAULT_TX_WINDOW                63
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 77dec104a9c36..5417e3cb0636d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5626,6 +5626,55 @@ static inline void l2cap_sig_send_rej(struct l2cap=
_conn *conn, u16 ident)
>         l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
>  }
>
> +static bool l2cap_sig_cmd_is_req(u8 code)
> +{
> +       switch (code) {
> +       case L2CAP_CONN_REQ:
> +       case L2CAP_CONF_REQ:
> +       case L2CAP_DISCONN_REQ:
> +       case L2CAP_ECHO_REQ:
> +       case L2CAP_INFO_REQ:
> +       case L2CAP_CONN_PARAM_UPDATE_REQ:
> +       case L2CAP_LE_CONN_REQ:
> +       case L2CAP_ECRED_CONN_REQ:
> +       case L2CAP_ECRED_RECONF_REQ:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static u8 l2cap_sig_first_req_ident(const struct sk_buff *skb)
> +{
> +       const u8 *data =3D skb->data;
> +       unsigned int len =3D skb->len;
> +
> +       while (len >=3D L2CAP_CMD_HDR_SIZE) {
> +               const struct l2cap_cmd_hdr *cmd =3D (const void *)data;
> +               u16 cmd_len =3D le16_to_cpu(cmd->len);
> +
> +               if (cmd->ident && l2cap_sig_cmd_is_req(cmd->code))
> +                       return cmd->ident;
> +
> +               if (cmd_len > len - L2CAP_CMD_HDR_SIZE)
> +                       break;
> +
> +               data +=3D L2CAP_CMD_HDR_SIZE + cmd_len;
> +               len -=3D L2CAP_CMD_HDR_SIZE + cmd_len;
> +       }

Weird, does the AI come up with this? The id is actually _not_
important because the error code will essentially indicate that the
entire packet was rejected. Therefore, it doesn't matter if the id is
for a request or a response, it still needs rejection if it exceeds
the MTU, so this seems overengineered.

> +       return 0;
> +}
> +
> +static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 id=
ent)
> +{
> +       struct l2cap_cmd_rej_mtu rej;
> +
> +       rej.reason =3D cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
> +       rej.max_mtu =3D cpu_to_le16(L2CAP_SIG_MTU);
> +       l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
> +}
> +
>  static inline void l2cap_sig_channel(struct l2cap_conn *conn,
>                                      struct sk_buff *skb)
>  {
> @@ -5638,6 +5687,17 @@ static inline void l2cap_sig_channel(struct l2cap_=
conn *conn,
>         if (hcon->type !=3D ACL_LINK)
>                 goto drop;
>
> +       if (skb->len > L2CAP_SIG_MTU) {
> +               u8 ident =3D l2cap_sig_first_req_ident(skb);
> +
> +               BT_DBG("signaling packet exceeds MTU");
> +
> +               if (ident)
> +                       l2cap_sig_send_mtu_rej(conn, ident);
> +
> +               goto drop;
> +       }
> +
>         while (skb->len >=3D L2CAP_CMD_HDR_SIZE) {
>                 u16 len;
>
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
