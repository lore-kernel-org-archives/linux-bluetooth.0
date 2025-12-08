Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40D25DD1E
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210315; cv=none; b=iDFMWwbrSXEZAsb4RAgnC2E5LGjZWJ6tXb4rcvYAzDen6NiYJ8PSfIm7x0ofLI561pkYsiFt012Z+azcI31CZ7MlP4h0h1IHnk5TutTVvAlbpO0nZ8OKER53IjC2oQhugirh0cUscT+nPWIADKpy8nR0hno+2W6PNCAh1lQnp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210315; c=relaxed/simple;
	bh=FzRiaJ9X+mhw1JiqTbY8RaNzHi2FIyRrpCfUBi9itao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIzNsT2pcjaeLlXj+oCdRf2of87Glg037ftWmz5/nb1uMQ1F0qv9s81M+dgmUzBpB9uqeUTneqbT1tmiv5WZM7ZQE29SloppejYu20B3MTT89FNI/zT9dINbQNiWKaoRRlky8jhkRxVEXE8MuYP/jPyqPEGNS69LgBE37Z0wEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgk6ozzO; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgk6ozzO"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a2dced861so46718131fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 08:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765210312; x=1765815112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DckzFlE0RyJfLzkGl8T3KAKDTaTXGmzCGMfHQZm5Fs=;
        b=Tgk6ozzO4IYXQqCit6xDENe4188hAe6XOtxOX+dEClX1zuuE7p0OnuV6481tqgNLZr
         VkF8y/jyvzLce3zvYZgoI6r/GcTYvmuDFuhPmaUpQaMIO7y/llmO8Jeriy5w1ZywqzCm
         GoXmfg6Fus8xJ4lftkFTqoJt6iXZYs8DnjIiwcQQfw+LwktHJx0w7Wwak2PUkDgLrnko
         S7l7xeyE4f6AuUqaI4a1qbVDdSKg2Ys14HW8hDHGzWM2a8tIil12i0dGgAP4mCu0Add+
         d7SlgLxEHPvkcN8zq/aAaIBWD3WtPUmFavx5Zr21ddszM0YE2Byoj9XuNiqeGwPFlH4l
         PsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210312; x=1765815112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DckzFlE0RyJfLzkGl8T3KAKDTaTXGmzCGMfHQZm5Fs=;
        b=g02dCeWkjw8fDbUFmSTZRbVlKHaEDUpYFQ1uzmt54KhcbwDJ1ZuaDh/cIUwGNTZrwQ
         yr80kAbWGSVl0qaMVNIfOqxkjUGLVQRB4OC0ebuSD/4fNMnSMhQDaL1cyz7DITRAf1x1
         Yb1HjOKcPkj5Ry9o5dh/NlBCKK5fqJ8fD5Wtj8xnRckg42SaajLHvqkLRC2DpWPkyDpB
         5MrScTg/1FMggOEoe8jTdbSt2kk/JCAA1K+VSCkkSh8u2vkWeFS1Fxk+MKtD8O24n9ft
         fVoyLf6d+mR1rxwmfAiBQMPU5iK3se74qKriOkr2PMAMkVskyx7W9CIDUHHm2RmF7NvE
         LwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYGTAwXsMaJ9LJ9GmPs0AwIRh4WYj7EezMJ8fIBKyuIXC1sYBOKUTIUyZ8ioVGPWkUmBNhH+svxztvBwzFmlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHL1mrdMJtS0Xoe+EVfR3QkCI5Hh9LWGy8EKtkWutkI3i0V2y
	rOqsjIujRnjGwmDXluhsT1Wu7mnsa5itO6qOy8US8P2HH016/44DPARUKi7WEzMAWDdoiJLw6UP
	G44tSLgi/Lp+wSyCzLlK8ZlZJpS0RtVU=
X-Gm-Gg: ASbGncuMLN+ZMgYkvZ7vtBZqFL6nMkzxYq8DbUhNn8d5Lp8moBHgqZPxloBnPJh5hzV
	OT3PWzL/HOC/nutnqEQqinCZxyijlde6Y/RBhjZyIcNp590wDLhwn3yvgit1VtSIfy8x0ir4CSm
	QuC5zqdU8UiE6LuOgSzL6RON8xb+kUha677YBhVm7V0tY/t712/2NCn8jjE0afiG0UjutciFOvz
	nhO1ps358FmGBmsL7/J938tf441iN/hqoB3EU00ixR5AVihYkIr4D8l7DiqEWj2M/YBUA==
X-Google-Smtp-Source: AGHT+IHbEvzp5inz3gNpnfpINpaqAb2WQiJoCd5Ywr51sgYj6dEaHGLohRHhRZLV8aLmI4ld3RlpyFe0ruk4PmT/Wvg=
X-Received: by 2002:a05:651c:b11:b0:378:e3a7:5dfa with SMTP id
 38308e7fff4ca-37ed83cd4f3mr21457211fa.20.1765210311330; Mon, 08 Dec 2025
 08:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208203056891J84Xq6wiMu3r7HXa_mRb3@zte.com.cn> <20251208203245047U3UW5v2aGUumhmvjLl96E@zte.com.cn>
In-Reply-To: <20251208203245047U3UW5v2aGUumhmvjLl96E@zte.com.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Dec 2025 11:11:39 -0500
X-Gm-Features: AQt7F2roSVB9tzO3fFLdNYcFap9rXz7vnrQazKcFG1-_bxfrCf9BK5U1uBlx1xY
Message-ID: <CABBYNZKy8Tska8N-9U0yR=M=tT9XtQ+O-Y4oQp4gy6LV1GOphg@mail.gmail.com>
Subject: Re: [RFC 1/2] Bluetooth: hci_conn: Add tracepoints for debugging
To: wang.yaxin@zte.com.cn
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, 
	qiu.yutan@zte.com.cn, chen.junlin@zte.com.cn, jiang.kun2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 8, 2025 at 7:32=E2=80=AFAM <wang.yaxin@zte.com.cn> wrote:
>
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
>
> Add tracepoints for tracking hci_conn_hold, hci_conn_drop, and hci_conn_d=
el
> to facilitate debugging and viewing call stacks.
> The existing Bluetooth debugging method, BT_DBG, cannot trace call stacks=
.
>
> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
> ---
>  include/net/bluetooth/hci_core.h |  3 ++
>  include/trace/events/bluetooth.h | 80 ++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_conn.c         |  4 ++
>  3 files changed, 87 insertions(+)
>  create mode 100644 include/trace/events/bluetooth.h
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 2b261e74e2c4..5e01e6c501c1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -29,6 +29,7 @@
>  #include <linux/idr.h>
>  #include <linux/leds.h>
>  #include <linux/rculist.h>
> +#include <trace/events/bluetooth.h>
>
>  #include <net/bluetooth/hci.h>
>  #include <net/bluetooth/hci_drv.h>
> @@ -1620,6 +1621,7 @@ static inline void hci_conn_put(struct hci_conn *co=
nn)
>
>  static inline struct hci_conn *hci_conn_hold(struct hci_conn *conn)
>  {
> +       trace_hci_conn_hold(conn);
>         BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt)=
);
>
>         atomic_inc(&conn->refcnt);
> @@ -1630,6 +1632,7 @@ static inline struct hci_conn *hci_conn_hold(struct=
 hci_conn *conn)
>
>  static inline void hci_conn_drop(struct hci_conn *conn)
>  {
> +       trace_hci_conn_drop(conn);
>         BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt)=
);
>
>         if (atomic_dec_and_test(&conn->refcnt)) {
> diff --git a/include/trace/events/bluetooth.h b/include/trace/events/blue=
tooth.h
> new file mode 100644
> index 000000000000..dd6446263e83
> --- /dev/null
> +++ b/include/trace/events/bluetooth.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM bluetooth
> +
> +#if !defined(_TRACE_BLUETOOTH_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_BLUETOOTH_H
> +
> +#include <linux/tracepoint.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +TRACE_EVENT(hci_conn_hold,
> +
> +       TP_PROTO(void *conn_ptr),
> +
> +       TP_ARGS(conn_ptr),
> +
> +       TP_STRUCT__entry(
> +               __field(void *, conn_addr)
> +               __field(int, refcnt)
> +       ),
> +
> +       TP_fast_assign(
> +               struct hci_conn *conn =3D (struct hci_conn *)conn_ptr;
> +
> +               __entry->conn_addr =3D conn;
> +               __entry->refcnt =3D atomic_read(&conn->refcnt);
> +       ),
> +
> +       TP_printk("conn_addr=3D%p, orig refcnt=3D%d",
> +                       __entry->conn_addr, __entry->refcnt)
> +)
> +
> +TRACE_EVENT(hci_conn_drop,
> +
> +       TP_PROTO(void *conn_ptr),
> +
> +       TP_ARGS(conn_ptr),
> +
> +       TP_STRUCT__entry(
> +               __field(void *, conn_addr)
> +               __field(int, refcnt)
> +       ),
> +
> +       TP_fast_assign(
> +               struct hci_conn *conn =3D (struct hci_conn *)conn_ptr;
> +
> +               __entry->conn_addr =3D conn;
> +               __entry->refcnt =3D atomic_read(&conn->refcnt);
> +       ),
> +
> +       TP_printk("conn_addr=3D%p, orig refcnt=3D%d",
> +                       __entry->conn_addr, __entry->refcnt)
> +)
> +
> +TRACE_EVENT(hci_conn_del,
> +
> +       TP_PROTO(void *conn_ptr),
> +
> +       TP_ARGS(conn_ptr),
> +
> +       TP_STRUCT__entry(
> +               __field(void *, conn_addr)
> +                __field(int, refcnt)
> +       ),
> +
> +       TP_fast_assign(
> +               struct hci_conn *conn =3D (struct hci_conn *)conn_ptr;
> +
> +               __entry->conn_addr =3D conn;
> +               __entry->refcnt =3D atomic_read(&conn->refcnt);
> +       ),
> +
> +       TP_printk("conn_addr=3D%p, orig refcnt=3D%d",
> +                       __entry->conn_addr, __entry->refcnt)
> +)

Is this preferred over just using the likes of bt_dev_dbg/dynamic
debug though? Or you use it just not to spam with the rest of the
debug files like hci_conn.c may have?
https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
it does seem to be possible to enable debugging of just
hci_conn_hold/hci_conn_drop.

> +#endif /* _TRACE_BLUETOOTH_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 99efeed6a766..74a02cf7ba14 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -35,6 +35,9 @@
>  #include <net/bluetooth/iso.h>
>  #include <net/bluetooth/mgmt.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/bluetooth.h>
> +
>  #include "smp.h"
>  #include "eir.h"
>
> @@ -1129,6 +1132,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
>
>  void hci_conn_del(struct hci_conn *conn)
>  {
> +       trace_hci_conn_del(conn);
>         struct hci_dev *hdev =3D conn->hdev;
>
>         BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
> --
> 2.27.0



--=20
Luiz Augusto von Dentz
