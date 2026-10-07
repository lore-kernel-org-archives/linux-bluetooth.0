Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41A37CD39
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388197; cv=pass; b=J2aSkZFUYofBLtup6mXbN0vMheaVKZ656rLSghPVEBPaLcRbA0NsiDYKZlVVk2HKRCUvZdY1hyWPbE5AVs9QDLEmTvdynlHvZ/yOR6rZhJAPR6CvD6RqPKtBOAIU00oN/6f6khhnV9DHy8zs5NcAgsq8azuIgVgRJWhzUN13yqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388197; c=relaxed/simple;
	bh=aI1S/PXo0ycFEo22BmWEcumzZjRoSKv2OJz08pnOLhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcx6eITHy5zWytPcs61gcT7KdQFlfDK62OphRFJTRV+EUNYeOCJ4W+8cS/zqUsa7RTdyxQzMvnrBqr9eF1peuePLlz3NHQ8ioCbcdlGpY8gFovD9ybmwJdxbG7vv/mh9Iipu4BiwsMeCQM9PyW8FVF/fD9qEsWMkMlFKvMH9hMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8H1KaTa; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8H1KaTa"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ab3fd8adb1so44753547b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 08:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791388192; cv=none;
        d=google.com; s=arc-20260327;
        b=CvjV3nsbPpEvcYoJOrk7NN16Aqc/Nd8h3aC6hsU6pDwEFVZ/S2J0zHpzQFCTqgE9SL
         u/SX+gOYFtnWYSDYERiBPm0BFeVmiO6nS4kMQoJG1S43lGxpMDeSlyxYBV44xBYjQvRM
         31B2p3T4t9qQuqNsn99LUUvhYcXyZMfBQUHJLdgXRWD1b2elYZ+2MxqAaZJb86dvlzLU
         VOrT160fv+gakgaQJuFmKe6OBBCFZTQsD6WpFI1H0GnQGrDo2z6C+XLMeGeNifQRR3Ef
         QjBUxZZV7pzexSiV/jBm9aG3KDU2+BunfY5jUDCTQS0UtN/AtOSeF4HND+C7UdCU7R18
         Gwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AW/w9I475JmXpjH1T0IKv7wBho8pBfCsjYqnfSEDh8w=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=CfB6q56WBD6sY8vbOjTrPUXBNvn5Et6iG+ZtRmdDQiXAIHZBRQ97u95MIGeH7/bI2i
         //jo4fbvog/+KIwsy+mnyNOXfHnORrBFB6KilZnAxfvrvnhPhS0VPtveXFeVWIyLqPMf
         O6BQbuMWm5+t7uPBjO0KzyOd2Xc2IKjlVHX8/Nqebe7hyBxMFfS6wJlC7Rt/jArnm4r8
         Z3aMkdN1IB8TPF6Pp0THhxHr8qNWoj2i9tdIRjxc1xUEewp8bU+bnVo5deeE91nTLeRD
         wcKTei3Bbn716+DxbXf7bNG2a8v3Rb0F06wRvw9cLKD782MjkEv6LLAgX2nNerg+TFbn
         ij4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791388192; x=1791992992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AW/w9I475JmXpjH1T0IKv7wBho8pBfCsjYqnfSEDh8w=;
        b=i8H1KaTajWUAetfSz3gqNCjEuUEn5Ey1aPQ7Wdq0C3N3/2rMqDCM0KxN8eg1xxlnDo
         oKnHzED6kXbknguiaYYUtI9xiapKic//ZmgnGMqbzR7/Gf4wyBawdtgeeIaVvQKrNw+5
         S5YTgQ5Q2d8e6oeORU2zo/f+dS6KqKjV8Ju/Fyo81jEGfDD00m+XKHtCwsBSj5V0EDVS
         338p15Hk1xdzfU+D6vzx8tdr+HUQvkmoaIARlgh7n/N867AXh+1Z8SWYiO6w/6Lj6w43
         Lzx1HgVfjxvLsQSakd8lL7meNQHpN9ulluDVh/Y872naTREjP8rnxOIKTo/65xchDx6E
         ZkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791388192; x=1791992992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AW/w9I475JmXpjH1T0IKv7wBho8pBfCsjYqnfSEDh8w=;
        b=ZbdAflvzaeltANzeWyMW6DPLO2oC5354w9GDZP9a6czHCwwtrbvs8UGjnhHyFckZf/
         I+xsNxdO52U4jyJHMRhXTMq0C7y8Ff5RjgdGPwpvJpenzaV5sXLek9430cQxwGKQpMH1
         Cina3EfTHPKRxMgI/M4ujE4luSk2JYTpQSG1r0nZMQ+Vbf4PeXLmYVsTYwhk2n4hbixW
         D33SGAvDPyKPdYJRN48zDa3PfinS53w65XD+ocewvXbrRgAfkJdF+Q13IA9gnIKYLsqD
         gl7Vo/aph7hcjHxqA0rhTfN6BOW+AGlxgjynWEuJkUapiDKbCKbF/AjXr93dwmSDd16X
         U/vw==
X-Gm-Message-State: AFq9FYIg1Xzf7KlMhYcnVK1QpZ1YZGydZli5kOyNF9AKZo+QCLYn/cpj
	DQ3QLXK9JwhtSICduybFX1bAtDEFyAGZ0r3nkeZAFo30llAUtXGfH8PAP/TkeTD2H2BJgiSuy7p
	34q1JQI2Mh73G1dY8Ts4mhF+4cjfksFvQnGaIoHDh+daV
X-Gm-Gg: AYBFou1NKj93O4pZX4syIeKr5e63tYHmizMML605n/Qjq5TZbKEzc9Syx+o57ZhC6z4
	3uDe3bLw6ppwgNCK+AHFmrutvUtumGHTk2jqy4ZTdbeq4la21lN8TW8KPD9tK6P0WTgDJ2z2Oju
	qgXQCHQVhLCfz0kV9Ue+dYhOPH0Cv2+7uAmha4e9NWdCWSCq96uI/z+mkHrs34gr8Qx7HsXq5de
	M83rzjlpxpxELwE8ZmpbFJ+IAA3ovbVtYvFJ4XG3ozfGrSc9zYYaCxwKYQP/3VnziPQcMeM1Jnj
	PHjkgYmlvxP+28Fmsvdhx3FwiLuvGY++aGQ3Xzv892rsb08caxUVu2C+nWbD6OC7pNlH9STLPD3
	Lj/LztFEOk846WkcH5tVSrFmRyzeKhLXoIo3pyyvbvEc=
X-Received: by 2002:a05:690c:a782:b0:8ab:422f:a8a3 with SMTP id
 00721157ae682-8b05afa8cadmr12803927b3.104.1791388191785; Wed, 07 Oct 2026
 08:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007144717.3832330-1-oss@fourdim.xyz>
In-Reply-To: <20261007144717.3832330-1-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Oct 2026 11:49:40 -0400
X-Gm-Features: AclHuK9ajkRe1Ywr27aRy9eVUl6niv8ngoaRfv0gutbnTelu4YExk1ZH_zu6aDY
Message-ID: <CABBYNZKenK-vhhQXsS4PCB7zoEV8xyGvO77MiJ+V6dK-+7Y1Cw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Reject signalling responses in
 invalid states
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, Oct 7, 2026 at 10:47=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> A peer can send configuration messages while an
> incoming channel is in BT_CONNECT2, before the
> security or deferred accept gate has completed. A
> configuration response can then promote the channel
> to BT_CONNECTED. Configuration responses can also
> act on channels that are closing, and a late connection
> response can move a disconnecting channel back to
> BT_CONFIG.
>
> Accept connection responses only while waiting in
> BT_CONNECT. Answer configuration requests in
> BT_CONNECT2, but defer our own request until
> BT_CONFIG so configuration cannot complete before
> the gate. Ignore configuration responses outside
> BT_CONFIG and BT_CONNECTED, and only complete
> configuration in BT_CONFIG.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
> v3:
>   - git lint on comments
> v2: https://lore.kernel.org/linux-bluetooth/20260929154219.2366060-1-oss@=
fourdim.xyz/
>   - resolve the patch conflict
> v1: https://lore.kernel.org/linux-bluetooth/20260928173324.1837653-1-oss@=
fourdim.xyz/
>
>  net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 49a998804908..cb4ec42f99e3 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4438,6 +4438,10 @@ static int l2cap_connect_create_rsp(struct l2cap_c=
onn *conn,
>
>         lockdep_assert_held(&chan->conn->lock);
>
> +       /* Ignore a late response after the channel has left BT_CONNECT. =
*/
> +       if (chan->state !=3D BT_CONNECT)
> +               goto done;
> +
>         switch (result) {
>         case L2CAP_CR_SUCCESS:
>                 if (__l2cap_get_chan_by_dcid(conn, dcid)) {
> @@ -4467,6 +4471,7 @@ static int l2cap_connect_create_rsp(struct l2cap_co=
nn *conn,
>                 break;
>         }
>
> +done:
>         l2cap_chan_unlock(chan);
>         l2cap_chan_put(chan);
>
> @@ -4604,7 +4609,13 @@ static inline int l2cap_config_req(struct l2cap_co=
nn *conn,
>                 goto unlock;
>         }
>
> -       if (!test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
> +       /* A channel in BT_CONNECT2 has not passed security or userspace
> +        * accept yet. Answer the peer's request, but hold our own until
> +        * the channel reaches BT_CONFIG: the CONNECT2 -> CONFIG sites se=
nd
> +        * it. Connected channels may also need to reconfigure.
> +        */
> +       if ((chan->state =3D=3D BT_CONFIG || chan->state =3D=3D BT_CONNEC=
TED) &&
> +           !test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
>                 u8 buf[64];
>                 l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_RE=
Q,
>                                l2cap_build_conf_req(chan, buf, sizeof(buf=
)), buf);
> @@ -4657,6 +4668,10 @@ static inline int l2cap_config_rsp(struct l2cap_co=
nn *conn,
>
>         lockdep_assert_held(&chan->conn->lock);
>
> +       /* Connected channels may also receive reconfiguration responses.=
 */
> +       if (chan->state !=3D BT_CONFIG && chan->state !=3D BT_CONNECTED)
> +               goto done;
> +
>         switch (result) {
>         case L2CAP_CONF_SUCCESS:
>                 l2cap_conf_rfc_get(chan, rsp->data, len);
> @@ -4724,6 +4739,9 @@ static inline int l2cap_config_rsp(struct l2cap_con=
n *conn,
>         if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
>                 set_default_fcs(chan);
>
> +               if (chan->state !=3D BT_CONFIG)
> +                       goto done;
> +
>                 if (chan->mode =3D=3D L2CAP_MODE_ERTM ||
>                     chan->mode =3D=3D L2CAP_MODE_STREAMING)
>                         err =3D l2cap_ertm_init(chan);
> --
> 2.55.0

Sashiko flagged a problem with these changes:

https://sashiko.dev/#/patchset/20261007144717.3832330-1-oss%40fourdim.xyz

--=20
Luiz Augusto von Dentz
