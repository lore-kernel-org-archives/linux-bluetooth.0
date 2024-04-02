Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010615AAAA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083618; cv=none; b=I3JHeG7ZzcFNvmPl7pHOzybKxOF8/k8eABQauBluxWGP4v1gRGOUOVdeeOeWBz73Ep9ol9tgWgxA8uNrZm8kg8c+3H1VJyo61gV8ZMmpkb26Rk4ycmxdDoz2UVzV7HnaqRMA7UUf0rJX2oL7o5NUhIgCuYIkUCukRSb+5I1kh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083618; c=relaxed/simple;
	bh=qrLpk5LACZzFtSv3zcM1Xu79I5bBYXhPSzDAlbcq/YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY7LtvaBVtukxT9ZyrIM4eERTZsDzfhmrHq/CxBnFbMN/tCHDmjNg+vGJUjvqpaXYJuvwA+AnZvfOIgLS/VkzIovxdmt+0qnHBv0eXOnIpHeVpaKEi5LyNROfY5P/iIL1YQ77a9djMWz+dNx2510CQoqwA7vCKhRusswlqcvPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAl/hx2d; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAl/hx2d"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso66286601fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712083614; x=1712688414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5I5rw7PpEkHMgzr0/jlONPXF3f/mK0u3lYvMNBGlN4=;
        b=hAl/hx2dv0VKsuMgRpBt9/Gn6fucmuXK8Ms6G8PtFYUjNVGqvW7O2gBxy8XqZqorOo
         5oTpKXgO90BjKosc7bhPi+iHyEyIshezzqr3n/IIzBOITmoCvh9FI3oIryY1bLwvWAXT
         Scq42ca67DmWWcUVDRQIeE0bvSOQ3W21lzKDOdDleSFZqUkoRm1RgPm73IerdvZJc+3W
         +Gm7aGNupsX+dhp7xQEIzvjP7FIstIH/Z5owg/Pa4Ji5gUigFe55wwYt5shPCxBkr2VL
         cAuOog7mghrMjCZgW6gpNV1EysR/ZMrVnkZJSdUNI/ENvA0drW51HdSSgxqxSjvE2XnU
         UU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712083614; x=1712688414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5I5rw7PpEkHMgzr0/jlONPXF3f/mK0u3lYvMNBGlN4=;
        b=eJ/hOWNVFkMv0t25I/2Y+73H6iNGY18jtSzwVhg6TgWsMeQyZj6TI1IEtLBLep8ZBQ
         YKR2mxyL1Uyp0bOuWW9HXWC7JPE8OSlP6huHjKElm/qwFaXsdOEI3c0mKPqIkuCtUsSe
         FPh6wwf27Ec2JratF2evtKcfr+ecgWd+lbvzb9vUxzHk8GzfD365nvz7StRjpj5zUuw+
         f3U9iDhdk6Phy+Rh6p0++LCh5fm4XISzGiJ+5mRpT7lEtZP32utXa5DPsHP+wEos7IqA
         UOUnEWp1E+H7KoIV+ApLmXWuY3ApMeqtoCmDwoWw2/4MdA/2/KdEMK1FyZSBfyJs2Rzd
         d9oQ==
X-Gm-Message-State: AOJu0YyZoWGkeVEEv7RQQZ/Q5yKw/bm5bDg3O4ELJ/Bng7v8DexzAq8t
	FrnZUN668XdqWTxIfHGyvwNqvxap4zkaGPxSUEyn5F32D6MJtV8VedzvaxG+bK4BI48C9D1KD15
	uIF7IIa8Ir7+XDUNewALmVuqM06w=
X-Google-Smtp-Source: AGHT+IGzWKNDCb+k5fMbT/uxPl8NrycLF9Gsobp00L/s+owNUx2tdXd45JnCz+FrzCWL/bGC+oAEZsNDgOMJvo/V+Io=
X-Received: by 2002:a2e:a311:0:b0:2d8:270f:9764 with SMTP id
 l17-20020a2ea311000000b002d8270f9764mr2280099lje.40.1712083613989; Tue, 02
 Apr 2024 11:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712076170.git.pav@iki.fi> <f40c875abeb7a777812666741a3b4a18ddb498fe.1712076170.git.pav@iki.fi>
In-Reply-To: <f40c875abeb7a777812666741a3b4a18ddb498fe.1712076170.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Apr 2024 14:46:40 -0400
Message-ID: <CABBYNZKNDG2AQ-XAKpgsnB5Cm1haQyXNLjfmqnGSziJtXEw7OA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/8] iso-tester: Add tests for TX timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Apr 2, 2024 at 12:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add TX timestamping test utilities in new tester-utils.h, so that they
> can be shared between testers.
>
> Add tests:
>
> ISO Send - TX Timestamping
> ISO Send - TX Sched Timestamping
> ISO Send - TX Msg Timestamping
> ---
>  tools/iso-tester.c   | 169 ++++++++++++++++++++++++++++++++++++++++---
>  tools/tester-utils.h | 163 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 322 insertions(+), 10 deletions(-)
>  create mode 100644 tools/tester-utils.h
>
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index 60afef301..c12675a18 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -18,6 +18,9 @@
>  #include <poll.h>
>  #include <stdbool.h>
>
> +#include <linux/errqueue.h>
> +#include <linux/net_tstamp.h>
> +
>  #include <glib.h>
>
>  #include "lib/bluetooth.h"
> @@ -34,6 +37,8 @@
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
>
> +#include "tester-utils.h"
> +
>  #define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
>  { \
>         .interval =3D _interval, \
> @@ -462,11 +467,12 @@ struct test_data {
>         uint16_t handle;
>         uint16_t acl_handle;
>         struct queue *io_queue;
> -       unsigned int io_id[2];
> +       unsigned int io_id[3];
>         uint8_t client_num;
>         int step;
>         bool reconnect;
>         bool suspending;
> +       struct tx_tstamp_data tx_ts;
>  };
>
>  struct iso_client_data {
> @@ -487,6 +493,10 @@ struct iso_client_data {
>         size_t base_len;
>         bool listen_bind;
>         bool pa_bind;
> +       uint32_t so_timestamping;
> +       bool msg_timestamping;
> +       unsigned int send_extra;
> +       unsigned int send_extra_pre_ts;

It is probably a good idea to start documenting what each of these
fields are meant to do, I have no idea what are the last 2 for btw.

>  };
>
>  typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *i=
o);
> @@ -677,15 +687,14 @@ static void io_free(void *data)
>  static void test_data_free(void *test_data)
>  {
>         struct test_data *data =3D test_data;
> +       unsigned int i;
>
>         if (data->io_queue)
>                 queue_destroy(data->io_queue, io_free);
>
> -       if (data->io_id[0] > 0)
> -               g_source_remove(data->io_id[0]);
> -
> -       if (data->io_id[1] > 0)
> -               g_source_remove(data->io_id[1]);
> +       for (i =3D 0; i < ARRAY_SIZE(data->io_id); ++i)
> +               if (data->io_id[i] > 0)
> +                       g_source_remove(data->io_id[i]);
>
>         free(data);
>  }
> @@ -987,6 +996,38 @@ static const struct iso_client_data connect_16_2_1_s=
end =3D {
>         .send =3D &send_16_2_1,
>  };
>
> +static const struct iso_client_data connect_send_tx_timestamping =3D {
> +       .qos =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .send =3D &send_16_2_1,
> +       .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
> +                                       SOF_TIMESTAMPING_OPT_ID |
> +                                       SOF_TIMESTAMPING_TX_SOFTWARE),
> +       .send_extra =3D 1,
> +       .send_extra_pre_ts =3D 2,
> +};
> +
> +static const struct iso_client_data connect_send_tx_sched_timestamping =
=3D {
> +       .qos =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .send =3D &send_16_2_1,
> +       .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
> +                                       SOF_TIMESTAMPING_TX_SOFTWARE |
> +                                       SOF_TIMESTAMPING_OPT_TSONLY |
> +                                       SOF_TIMESTAMPING_TX_SCHED),
> +       .send_extra =3D 1,
> +};
> +
> +static const struct iso_client_data connect_send_tx_msg_timestamping =3D=
 {
> +       .qos =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .send =3D &send_16_2_1,
> +       .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
> +                                       SOF_TIMESTAMPING_TX_SOFTWARE),
> +       .send_extra =3D 1,
> +       .msg_timestamping =3D true,
> +};
> +
>  static const struct iso_client_data listen_16_2_1_recv =3D {
>         .qos =3D QOS_16_2_1,
>         .expect_err =3D 0,
> @@ -1410,14 +1451,17 @@ static void bthost_recv_data(const void *buf, uin=
t16_t len, void *user_data)
>         struct test_data *data =3D user_data;
>         const struct iso_client_data *isodata =3D data->test_data;
>
> +       --data->step;
> +
>         tester_print("Client received %u bytes of data", len);
>
>         if (isodata->send && (isodata->send->iov_len !=3D len ||
>                         memcmp(isodata->send->iov_base, buf, len))) {
>                 if (!isodata->recv->iov_base)
>                         tester_test_failed();
> -       } else
> +       } else if (!data->step) {
>                 tester_test_passed();
> +       }
>  }
>
>  static void bthost_iso_disconnected(void *user_data)
> @@ -2058,17 +2102,95 @@ static void iso_recv(struct test_data *data, GIOC=
hannel *io)
>         data->io_id[0] =3D g_io_add_watch(io, G_IO_IN, iso_recv_data, dat=
a);
>  }
>
> -static void iso_send(struct test_data *data, GIOChannel *io)
> +static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
> +                                                       gpointer user_dat=
a)
>  {
> +       struct test_data *data =3D user_data;
>         const struct iso_client_data *isodata =3D data->test_data;
> -       ssize_t ret;
> +       int sk =3D g_io_channel_unix_get_fd(io);
> +       int err;
> +
> +       data->step--;
> +
> +       err =3D tx_tstamp_recv(&data->tx_ts, sk, isodata->send->iov_len);
> +       if (err > 0)
> +               return TRUE;
> +       else if (!err && !data->step)
> +               tester_test_passed();
> +       else
> +               tester_test_failed();
> +
> +       data->io_id[2] =3D 0;
> +       return FALSE;
> +}
> +
> +static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
> +{
> +       const struct iso_client_data *isodata =3D data->test_data;
> +       struct so_timestamping so =3D {
> +               .flags =3D isodata->so_timestamping,
> +       };
>         int sk;
> +       int err;
> +       unsigned int count;
> +
> +       if (!(isodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK)=
)
> +               return;
> +
> +       tester_print("Enabling TX timestamping");
> +
> +       tx_tstamp_init(&data->tx_ts, isodata->so_timestamping);
> +
> +       for (count =3D 0; count < isodata->send_extra + 1; ++count)
> +               data->step +=3D tx_tstamp_expect(&data->tx_ts);
>
>         sk =3D g_io_channel_unix_get_fd(io);
>
> +       data->io_id[2] =3D g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue=
, data);
> +
> +       if (isodata->msg_timestamping)
> +               so.flags &=3D ~SOF_TIMESTAMPING_TX_RECORD_MASK;
> +
> +       err =3D setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(s=
o));
> +       if (err < 0) {
> +               tester_warn("setsockopt SO_TIMESTAMPING: %s (%d)",
> +                                               strerror(errno), errno);
> +               tester_test_failed();
> +               return;
> +       }
> +}
> +
> +static void iso_send_data(struct test_data *data, GIOChannel *io)
> +{
> +       const struct iso_client_data *isodata =3D data->test_data;
> +       char control[CMSG_SPACE(sizeof(uint32_t))];
> +       struct msghdr msg =3D {
> +               .msg_iov =3D (struct iovec *)isodata->send,
> +               .msg_iovlen =3D 1,
> +       };
> +       struct cmsghdr *cmsg;
> +       ssize_t ret;
> +       int sk;
> +
>         tester_print("Writing %zu bytes of data", isodata->send->iov_len)=
;
>
> -       ret =3D writev(sk, isodata->send, 1);
> +       sk =3D g_io_channel_unix_get_fd(io);
> +
> +       if (isodata->msg_timestamping) {
> +               memset(control, 0, sizeof(control));
> +               msg.msg_control =3D control;
> +               msg.msg_controllen =3D sizeof(control);
> +
> +               cmsg =3D CMSG_FIRSTHDR(&msg);
> +               cmsg->cmsg_level =3D SOL_SOCKET;
> +               cmsg->cmsg_type =3D SO_TIMESTAMPING;
> +               cmsg->cmsg_len =3D CMSG_LEN(sizeof(uint32_t));
> +
> +               *((uint32_t *)CMSG_DATA(cmsg)) =3D (isodata->so_timestamp=
ing &
> +                                       SOF_TIMESTAMPING_TX_RECORD_MASK);
> +       }
> +
> +       ret =3D sendmsg(sk, &msg, 0);
>         if (ret < 0 || isodata->send->iov_len !=3D (size_t) ret) {
>                 tester_warn("Failed to write %zu bytes: %s (%d)",
>                                 isodata->send->iov_len, strerror(errno), =
errno);
> @@ -2076,6 +2198,22 @@ static void iso_send(struct test_data *data, GIOCh=
annel *io)
>                 return;
>         }
>
> +       data->step++;
> +}
> +
> +static void iso_send(struct test_data *data, GIOChannel *io)
> +{
> +       const struct iso_client_data *isodata =3D data->test_data;
> +       unsigned int count;
> +
> +       for (count =3D 0; count < isodata->send_extra_pre_ts; ++count)
> +               iso_send_data(data, io);
> +
> +       iso_tx_timestamping(data, io);
> +
> +       for (count =3D 0; count < isodata->send_extra + 1; ++count)
> +               iso_send_data(data, io);
> +
>         if (isodata->bcast) {
>                 tester_test_passed();
>                 return;
> @@ -3197,6 +3335,17 @@ int main(int argc, char *argv[])
>         test_iso("ISO Send - Success", &connect_16_2_1_send, setup_powere=
d,
>                                                         test_connect);
>
> +       test_iso("ISO Send - TX Timestamping", &connect_send_tx_timestamp=
ing,
> +                                               setup_powered, test_conne=
ct);
> +
> +       test_iso("ISO Send - TX Sched Timestamping",
> +                       &connect_send_tx_sched_timestamping, setup_powere=
d,
> +                       test_connect);
> +
> +       test_iso("ISO Send - TX Msg Timestamping",
> +                       &connect_send_tx_msg_timestamping, setup_powered,
> +                       test_connect);

Add a comment for each test to describe what they are doing, are these
supposed to test different flags that can be passed on to
SO_TXTIMESTAMP?

>         test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powe=
red,
>                                                         test_listen);
>
> diff --git a/tools/tester-utils.h b/tools/tester-utils.h

Perhaps just have as tools/tester.h

> new file mode 100644
> index 000000000..617de842e
> --- /dev/null
> +++ b/tools/tester-utils.h
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2022  Intel Corporation.
> + *
> + */
> +
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <time.h>
> +#include <sys/socket.h>
> +#include <linux/errqueue.h>
> +#include <linux/net_tstamp.h>
> +
> +#include <glib.h>
> +
> +#define SEC_NSEC(_t)  ((_t) * 1000000000LL)
> +#define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
> +
> +struct tx_tstamp_data {
> +       struct {
> +               uint32_t id;
> +               uint32_t type;
> +       } expect[16];
> +       unsigned int pos;
> +       unsigned int count;
> +       unsigned int sent;
> +       uint32_t so_timestamping;
> +};
> +
> +static inline void tx_tstamp_init(struct tx_tstamp_data *data,
> +                               uint32_t so_timestamping)
> +{
> +       memset(data, 0, sizeof(*data));
> +       memset(data->expect, 0xff, sizeof(data->expect));
> +
> +       data->so_timestamping =3D so_timestamping;
> +}
> +
> +static inline int tx_tstamp_expect(struct tx_tstamp_data *data)
> +{
> +       unsigned int pos =3D data->count;
> +       int steps;
> +
> +       if (data->so_timestamping & SOF_TIMESTAMPING_TX_SCHED) {
> +               g_assert(pos < ARRAY_SIZE(data->expect));
> +               data->expect[pos].type =3D SCM_TSTAMP_SCHED;
> +               data->expect[pos].id =3D data->sent;
> +               pos++;
> +       }
> +
> +       if (data->so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE) {
> +               g_assert(pos < ARRAY_SIZE(data->expect));
> +               data->expect[pos].type =3D SCM_TSTAMP_SND;
> +               data->expect[pos].id =3D data->sent;
> +               pos++;
> +       }
> +
> +       data->sent++;
> +
> +       steps =3D pos - data->count;
> +       data->count =3D pos;
> +       return steps;
> +}
> +
> +static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, in=
t len)
> +{
> +       unsigned char control[512];
> +       ssize_t ret;
> +       char buf[1024];
> +       struct msghdr msg;
> +       struct iovec iov;
> +       struct cmsghdr *cmsg;
> +       struct scm_timestamping *tss =3D NULL;
> +       struct sock_extended_err *serr =3D NULL;
> +       struct timespec now;
> +
> +       iov.iov_base =3D buf;
> +       iov.iov_len =3D sizeof(buf);
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.msg_iov =3D &iov;
> +       msg.msg_iovlen =3D 1;
> +       msg.msg_control =3D control;
> +       msg.msg_controllen =3D sizeof(control);
> +
> +       ret =3D recvmsg(sk, &msg, MSG_ERRQUEUE);
> +       if (ret < 0) {
> +               tester_warn("Failed to read from errqueue: %s (%d)",
> +                                                       strerror(errno), =
errno);
> +               return -EINVAL;
> +       }
> +
> +       if (data->so_timestamping & SOF_TIMESTAMPING_OPT_TSONLY) {
> +               if (ret !=3D 0) {
> +                       tester_warn("Packet copied back to errqueue");
> +                       return -EINVAL;
> +               }
> +       } else if (len > ret) {
> +               tester_warn("Packet not copied back to errqueue: %zd", re=
t);
> +               return -EINVAL;
> +       }
> +
> +       for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg !=3D NULL;
> +                                       cmsg =3D CMSG_NXTHDR(&msg, cmsg))=
 {
> +               if (cmsg->cmsg_level =3D=3D SOL_SOCKET &&
> +                                       cmsg->cmsg_type =3D=3D SCM_TIMEST=
AMPING) {
> +                       tss =3D (void *)CMSG_DATA(cmsg);
> +               } else if (cmsg->cmsg_level =3D=3D SOL_BLUETOOTH &&
> +                                       cmsg->cmsg_type =3D=3D BT_SCM_ERR=
OR) {
> +                       serr =3D (void *)CMSG_DATA(cmsg);
> +               }
> +       }
> +
> +       if (!tss) {
> +               tester_warn("SCM_TIMESTAMPING not found");
> +               return -EINVAL;
> +       }
> +
> +       if (!serr) {
> +               tester_warn("BT_SCM_ERROR not found");
> +               return -EINVAL;
> +       }
> +
> +       if (serr->ee_errno !=3D ENOMSG ||
> +                               serr->ee_origin !=3D SO_EE_ORIGIN_TIMESTA=
MPING) {
> +               tester_warn("BT_SCM_ERROR wrong for timestamping");
> +               return -EINVAL;
> +       }
> +
> +       clock_gettime(CLOCK_REALTIME, &now);
> +
> +       if (TS_NSEC(&now) < TS_NSEC(tss->ts) ||
> +                       TS_NSEC(&now) > TS_NSEC(tss->ts) + SEC_NSEC(10)) =
{
> +               tester_warn("nonsense in timestamp");
> +               return -EINVAL;
> +       }
> +
> +       if (data->pos >=3D data->count) {
> +               tester_warn("Too many timestamps");
> +               return -EINVAL;
> +       }
> +
> +       if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
> +                               serr->ee_data !=3D data->expect[data->pos=
].id) {
> +               tester_warn("Bad timestamp id %u", serr->ee_data);
> +               return -EINVAL;
> +       }
> +
> +       if (serr->ee_info !=3D data->expect[data->pos].type) {
> +               tester_warn("Bad timestamp type %u", serr->ee_info);
> +               return -EINVAL;
> +       }
> +
> +       tester_print("Got valid TX timestamp %u", data->pos);
> +
> +       ++data->pos;
> +
> +       return data->count - data->pos;
> +}
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
