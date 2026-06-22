Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8503B2FD1
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135778; cv=pass; b=Po1aONJ9ru6Ts+De+09yNl9ieYhfg5aeoQj8rKR2ggI5bD9US5HicfdWVCXHq1qj+8/oilqf0QV+lFfv2bmqXXQKNXP8m/PiPib1IPKAJHWk67iK8RxvuvcvUVKaLBPToISe4L6QDsjqqxTfwkiQwuwjaKoP0KTBV9vkbfogN4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135778; c=relaxed/simple;
	bh=STes/6VQzHB8vw36+rDUBpk8mBjZEtc1eFMHGkF9IKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlehQAMgQoU8wrEAQPsF4wlp3FEuvllRMaAo3V8EtbFZahyoWWu3WUoQzoNZmUgH7NUR5/Pj4DgeP7b92MthtGUtq8XioV3fruLnvUSTU2d4ZSk+iylbuS8kEU+HIkLp8N+rFdqS+Zp4VLsInQVLUKh7l4s9EPhqbEjRjt81LlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byI42qHg; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byI42qHg"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-662bcc30fafso4406494d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 06:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782135775; cv=none;
        d=google.com; s=arc-20240605;
        b=TeS6Gun5Bb0Jt1cXUraYmUoKTVgDF+gWny4UWp4DuHea3ba6JF1QlGdWI3GvragAEl
         T29OOm2ba90ugOpEeuj1SS1sFv7amZY3Nwrg0c19EF3R17YmaZTjIlZV1XzaLLy8KHwC
         wHIj46x0X2i5G/6EkC97kg49WTPvRIDzmPErddFDSby9Ely/yGU3PQH+9RZr5t+3jcXF
         nNDsFp3AGaCfTCmvcJ8nRD6p07yKkdx8pyhFV+9hoJF0Hx6YMi3oiOf18M1uxyvcIAIl
         L5TqvGxg5gvmUHIr0o1RYT6Qc8nAniJLVDfeISPKqql3Yw8Ky0lPBxO5RM7NAY8ADy34
         ZwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5HUCoPi7fAQubJY3F1tcgiIykDf3rQCgR2CJAnM3aDs=;
        fh=A/Q/jNPcPJyWlB/0KiTqrmPoa5p+gzL1PJrZG/U2mxs=;
        b=Tf8hs99hCjgvfmOiz1/mWD8mvvUpMkx9MDjHfHdOiO9ePjagZFAEn/FfOZi3w/yZWM
         CmpR1Vjzlq86XDe7RCyHDiwjsZHJPTL8zkEBQFFD4rta4C0d6WJfrbwbIls5ZlQ6wWK1
         nCRo3pWuWVcKb7BiyjM9qzkt4O0ZPyAGfD9UmuYiEZIJY9fhLpjogtoesPVEjb9rEfmd
         aL7GXodsJbTTIyh0MzYF4Kl0nRaK8MhsY7JR4y/POVMQCEcyQmgmJyI9inPTT+jTNi06
         ZEvKDZ4PWiF4xCXKPEpU7zCJYyivoOOSzX3+E5j/01wsEErmATAztk9gdLAQVwh+mLZZ
         j/lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782135775; x=1782740575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HUCoPi7fAQubJY3F1tcgiIykDf3rQCgR2CJAnM3aDs=;
        b=byI42qHgGKL6oUKqrZ58dyvMZ95lTQExLXQ5aJRz6knP0hsIrb/Jrbwhh3vyToqqAp
         Bu+8lEEBv1cWtl0EjgoQaUSQu1jWbc7WxyKN9cDdSMso3bJ8rFnhTiQHXNVTNkAbcOz5
         TY9spB6vDuYW/7z6V2YntLM14iYcpLqDM7qtFSKL7NzG4LTl9WBTF/K49JPq0E1xD2OQ
         3DrRxWjt9EN2MztkKLMnNohR+zia2alMAYKmkiqWXX99t6/cpu/mjaGj0kk3A+68QMql
         SPVhOD7sgsGcl3ITvFokuSY6fWN8Fwlt8xWx62tQNIDhANyVHx5h2JWOB2/EHeqg5KmC
         mTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135775; x=1782740575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HUCoPi7fAQubJY3F1tcgiIykDf3rQCgR2CJAnM3aDs=;
        b=Nb+21+A0tVMrt3SCSilY2oerAPQbs+lTSx6NVRQiWtqpdILp3qHEdAWmABt784D0yD
         zeJYEm87iSkcGq71Tfh/HuEx+rLYzVs/wqVFXKMbliH61ousJxVKFNi1VVb9dT0A9VRw
         C4bGItDAJdYDP2PhGE05G5FznbhAx4cx+HWPB408WZ56ttAJ4a9mwicwIgpOgzXZfjWu
         kFJr9cJWQA69V7OBoJxhB/F8zi91zbKWKswvY9imSdZHSbo3TH3/twLyGQjZzIp/ed3Q
         cOzcMHQaVP9H7B/dapEmBiGevYPKHsp2/5IsBWpSQSchoKsAhZBoe2hi12Ji2m6RK2Ls
         BA7Q==
X-Gm-Message-State: AOJu0YwOTVyhR4sijzQlqY8F7gCjqtR9jfTcIFOBJ9KGGqklxA93WUgj
	g+qORm5GEgttgD62HuJWUIkBYUwPKclmJ2MqrB+/1LOGZzPK0wfKvEH9zGM+lGtwj6CvdeC+927
	JVuU2L/GgCoJvJLClN+FJTJruzaPFJKK/BR4afcw=
X-Gm-Gg: AfdE7cmugYVRv1RVqrXZmohkdFfw6UTWXAwiCaKfOzGH1Czgrhh2aUpc2zQ6r0cI68A
	MBbAGDw2jp6rWs3X1baeZ4Xr16HWgjCEw8t9fb1b3NBbf3qIbKUzw09D6pcvo1slj7skpELfJLI
	62bowzVxiEZSv+EEMfv2sEZOw1gAxiK8q9Ra77qREoEl0H1yi02xDl5bq1bKYxo7Uae/gecr7SX
	GIaRXvQygDGmhiTJemb09yBuc02qAg+/MJ8XHJK6AqRGusPTGAS7gk/HB0j9G/qXI2zxi9kcytQ
	3EQ3WJp3+DyuG+pj8s2pxmKacgca7/WHTCY+Fy98Z1oocSyWXrk1lJ9riKc=
X-Received: by 2002:a05:690e:1c1a:b0:658:e645:7736 with SMTP id
 956f58d0204a3-662ffed6097mr12019520d50.39.1782135774446; Mon, 22 Jun 2026
 06:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620192228.2692610-1-geraldonetto@gmail.com>
In-Reply-To: <20260620192228.2692610-1-geraldonetto@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jun 2026 09:42:42 -0400
X-Gm-Features: AVVi8CenzoXiPGFwJHOyas0djeveFpTwwEWtloI4EY0tX4WR1xcYwJdvz7oTE4I
Message-ID: <CABBYNZJqC7vwxHiSVQ+7oATG=fv3ADMoW8THW3_z3w0TFfd0mQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared: harden btsnoop trace parsing
To: Geraldo Netto <geraldonetto@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geraldo,

On Sat, Jun 20, 2026 at 3:22=E2=80=AFPM Geraldo Netto <geraldonetto@gmail.c=
om> wrote:
>
> ---
>  Makefile.am          |   6 +
>  monitor/analyze.c    |   4 +-
>  monitor/control.c    |   2 +-
>  src/shared/btsnoop.c | 303 +++++++++++------
>  src/shared/btsnoop.h |   6 +-
>  unit/test-btsnoop.c  | 794 +++++++++++++++++++++++++++++++++++++++++++
>  unit/test-btsnoop.h  |   3 +

Looks like this is actually trying to introduce a new test suite for
btsnoop, which is probably fine, but the changes to shared/btsnoop.The
changes to shared/btsnoop.{c,h} should be split into their own commit
with a description of why the changes are necessary. Similarly, the
tests themselves need descriptions explaining what each test does.

>  7 files changed, 1009 insertions(+), 109 deletions(-)
>  create mode 100644 unit/test-btsnoop.c
>  create mode 100644 unit/test-btsnoop.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 76c4ab5d4..4887934a9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -587,6 +587,12 @@ unit_tests +=3D unit/test-textfile
>  unit_test_textfile_SOURCES =3D unit/test-textfile.c src/textfile.h src/t=
extfile.c
>  unit_test_textfile_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
>
> +unit_tests +=3D unit/test-btsnoop
> +
> +unit_test_btsnoop_SOURCES =3D unit/test-btsnoop.c \
> +                               src/shared/btsnoop.h src/shared/btsnoop.c
> +unit_test_btsnoop_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> +
>  unit_tests +=3D unit/test-crc
>
>  unit_test_crc_SOURCES =3D unit/test-crc.c monitor/crc.h monitor/crc.c
> diff --git a/monitor/analyze.c b/monitor/analyze.c
> index de9c23603..c9400ceb3 100644
> --- a/monitor/analyze.c
> +++ b/monitor/analyze.c
> @@ -1404,8 +1404,8 @@ void analyze_trace(const char *path)
>                 struct timeval tv;
>                 uint16_t index, opcode, pktlen;
>
> -               if (!btsnoop_read_hci(btsnoop_file, &tv, &index, &opcode,
> -                                                               buf, &pkt=
len))
> +               if (!btsnoop_read_hci(btsnoop_file, &tv, &index,
> +                                       &opcode, buf, sizeof(buf), &pktle=
n))
>                         break;
>
>                 switch (opcode) {
> diff --git a/monitor/control.c b/monitor/control.c
> index 83347d5db..975e1d117 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -1564,7 +1564,7 @@ void control_reader(const char *path, bool pager)
>                         uint16_t index, opcode;
>
>                         if (!btsnoop_read_hci(btsnoop_file, &tv, &index,
> -                                                       &opcode, buf, &pk=
tlen))
> +                                       &opcode, buf, sizeof(buf), &pktle=
n))
>                                 break;
>
>                         if (opcode =3D=3D 0xffff)
> diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
> index 9ce2f2655..39960c4b8 100644
> --- a/src/shared/btsnoop.c
> +++ b/src/shared/btsnoop.c
> @@ -13,6 +13,7 @@
>  #endif
>
>  #define _GNU_SOURCE
> +#include <errno.h>
>  #include <endian.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -47,12 +48,16 @@ static const uint8_t btsnoop_id[] =3D { 0x62, 0x74, 0=
x73, 0x6e,
>
>  static const uint32_t btsnoop_version =3D 1;
>
> +#define BTSNOOP_EPOCH_OFFSET 0x00E03AB44A676000ull
> +#define BTSNOOP_UNIX_TIME_OFFSET 946684800ll
> +
>  struct pklg_pkt {
>         uint32_t        len;
>         uint64_t        ts;
>         uint8_t         type;
>  } __attribute__ ((packed));
>  #define PKLG_PKT_SIZE (sizeof(struct pklg_pkt))
> +#define PKLG_PAYLOAD_OFFSET (PKLG_PKT_SIZE - sizeof(uint32_t))
>
>  struct btsnoop {
>         int ref_count;
> @@ -271,13 +276,14 @@ bool btsnoop_write(struct btsnoop *btsnoop, struct =
timeval *tv,
>                 if (!btsnoop_rotate(btsnoop))
>                         return false;
>
> -       ts =3D (tv->tv_sec - 946684800ll) * 1000000ll + tv->tv_usec;
> +       ts =3D (tv->tv_sec - BTSNOOP_UNIX_TIME_OFFSET) * 1000000ll +
> +                                                               tv->tv_us=
ec;
>
>         pkt.size  =3D htobe32(size);
>         pkt.len   =3D htobe32(size);
>         pkt.flags =3D htobe32(flags);
>         pkt.drops =3D htobe32(drops);
> -       pkt.ts    =3D htobe64(ts + 0x00E03AB44A676000ll);
> +       pkt.ts    =3D htobe64(ts + BTSNOOP_EPOCH_OFFSET);
>
>         written =3D write(btsnoop->fd, &pkt, BTSNOOP_PKT_SIZE);
>         if (written < 0)
> @@ -324,6 +330,121 @@ static uint32_t get_flags_from_opcode(uint16_t opco=
de)
>         return 0xff;
>  }
>
> +static ssize_t read_exact(int fd, void *data, size_t size)
> +{
> +       uint8_t *ptr =3D data;
> +       size_t offset =3D 0;
> +
> +       while (offset < size) {
> +               ssize_t len;
> +
> +               len =3D read(fd, ptr + offset, size - offset);
> +               if (len < 0) {
> +                       if (errno =3D=3D EINTR)
> +                               continue;
> +                       return -1;
> +               }
> +
> +               if (len =3D=3D 0)
> +                       break;
> +
> +               offset +=3D len;
> +       }
> +
> +       return offset;
> +}
> +
> +static bool read_packet_data(struct btsnoop *btsnoop, void *data,
> +                               uint16_t data_size, uint32_t toread,
> +                               uint16_t *size)
> +{
> +       ssize_t len;
> +
> +       if (!size || (!data && toread)) {
> +               btsnoop->aborted =3D true;
> +               return false;
> +       }
> +
> +       if (toread > data_size) {
> +               btsnoop->aborted =3D true;
> +               return false;
> +       }
> +
> +       len =3D read_exact(btsnoop->fd, data, toread);
> +       if (len !=3D (ssize_t) toread) {
> +               btsnoop->aborted =3D true;
> +               return false;
> +       }
> +
> +       *size =3D toread;
> +
> +       return true;
> +}
> +
> +static bool decode_btsnoop_timestamp(uint64_t raw_ts, struct timeval *tv=
)
> +{
> +       uint64_t ts;
> +
> +       if (raw_ts < BTSNOOP_EPOCH_OFFSET)
> +               return false;
> +
> +       ts =3D raw_ts - BTSNOOP_EPOCH_OFFSET;
> +       tv->tv_sec =3D (ts / 1000000ll) + BTSNOOP_UNIX_TIME_OFFSET;
> +       tv->tv_usec =3D ts % 1000000ll;
> +
> +       return true;
> +}
> +
> +static void get_pklg_opcode(uint8_t type, uint16_t *index, uint16_t *opc=
ode)
> +{
> +       switch (type) {
> +       case 0x00:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_COMMAND_PKT;
> +               break;
> +       case 0x01:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_EVENT_PKT;
> +               break;
> +       case 0x02:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_ACL_TX_PKT;
> +               break;
> +       case 0x03:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_ACL_RX_PKT;
> +               break;
> +       case 0x08:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_SCO_TX_PKT;
> +               break;
> +       case 0x09:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_SCO_RX_PKT;
> +               break;
> +       case 0x12:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_ISO_TX_PKT;
> +               break;
> +       case 0x13:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_ISO_RX_PKT;
> +               break;
> +       case 0x0b:
> +               *index =3D 0x0000;
> +               *opcode =3D BTSNOOP_OPCODE_VENDOR_DIAG;
> +               break;
> +       case 0xfc:
> +               *index =3D 0xffff;
> +               *opcode =3D BTSNOOP_OPCODE_SYSTEM_NOTE;
> +               break;
> +       default:
> +               *index =3D 0xffff;
> +               *opcode =3D 0xffff;
> +               break;
> +       }
> +}
> +
>  bool btsnoop_write_hci(struct btsnoop *btsnoop, struct timeval *tv,
>                         uint16_t index, uint16_t opcode, uint32_t drops,
>                         const void *data, uint16_t size)
> @@ -377,99 +498,53 @@ bool btsnoop_write_phy(struct btsnoop *btsnoop, str=
uct timeval *tv,
>         return btsnoop_write(btsnoop, tv, flags, 0, data, size);
>  }
>
> -static bool pklg_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
> -                                       uint16_t *index, uint16_t *opcode=
,
> -                                       void *data, uint16_t *size)
> +static bool pklg_read_hci(struct btsnoop *btsnoop,
> +                       struct timeval *tv, uint16_t *index, uint16_t *op=
code,
> +                       void *data, uint16_t data_size, uint16_t *size)
>  {
>         struct pklg_pkt pkt;
> +       uint32_t pkt_len;
>         uint32_t toread;
>         uint64_t ts;
>         ssize_t len;
>
> -       len =3D read(btsnoop->fd, &pkt, PKLG_PKT_SIZE);
> +       len =3D read_exact(btsnoop->fd, &pkt, PKLG_PKT_SIZE);
>         if (len =3D=3D 0)
>                 return false;
>
> -       if (len < 0 || len !=3D PKLG_PKT_SIZE) {
> +       if (len !=3D PKLG_PKT_SIZE) {
>                 btsnoop->aborted =3D true;
>                 return false;
>         }
>
>         if (btsnoop->pklg_v2) {
> -               toread =3D le32toh(pkt.len) - (PKLG_PKT_SIZE - 4);
> +               pkt_len =3D le32toh(pkt.len);
>
>                 ts =3D le64toh(pkt.ts);
>                 tv->tv_sec =3D ts & 0xffffffff;
>                 tv->tv_usec =3D ts >> 32;
>         } else {
> -               toread =3D be32toh(pkt.len) - (PKLG_PKT_SIZE - 4);
> +               pkt_len =3D be32toh(pkt.len);
>
>                 ts =3D be64toh(pkt.ts);
>                 tv->tv_sec =3D ts >> 32;
>                 tv->tv_usec =3D ts & 0xffffffff;
>         }
>
> -       if (toread > BTSNOOP_MAX_PACKET_SIZE) {
> -                btsnoop->aborted =3D true;
> -                return false;
> -        }
> -
> -       switch (pkt.type) {
> -       case 0x00:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_COMMAND_PKT;
> -               break;
> -       case 0x01:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_EVENT_PKT;
> -               break;
> -       case 0x02:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_ACL_TX_PKT;
> -               break;
> -       case 0x03:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_ACL_RX_PKT;
> -               break;
> -       case 0x08:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_SCO_TX_PKT;
> -               break;
> -       case 0x09:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_SCO_RX_PKT;
> -               break;
> -       case 0x12:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_ISO_TX_PKT;
> -               break;
> -       case 0x13:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_ISO_RX_PKT;
> -               break;
> -       case 0x0b:
> -               *index =3D 0x0000;
> -               *opcode =3D BTSNOOP_OPCODE_VENDOR_DIAG;
> -               break;
> -       case 0xfc:
> -               *index =3D 0xffff;
> -               *opcode =3D BTSNOOP_OPCODE_SYSTEM_NOTE;
> -               break;
> -       default:
> -               *index =3D 0xffff;
> -               *opcode =3D 0xffff;
> -               break;
> +       if (pkt_len < PKLG_PAYLOAD_OFFSET) {
> +               btsnoop->aborted =3D true;
> +               return false;
>         }
>
> -       len =3D read(btsnoop->fd, data, toread);
> -       if (len < 0) {
> +       toread =3D pkt_len - PKLG_PAYLOAD_OFFSET;
> +       if (toread > BTSNOOP_MAX_PACKET_SIZE) {
>                 btsnoop->aborted =3D true;
>                 return false;
>         }
>
> -       *size =3D toread;
> +       get_pklg_opcode(pkt.type, index, opcode);
>
> -       return true;
> +       return read_packet_data(btsnoop, data, data_size, toread, size);
>  }
>
>  static uint16_t get_opcode_from_flags(uint8_t type, uint32_t flags)
> @@ -512,84 +587,106 @@ static uint16_t get_opcode_from_flags(uint8_t type=
, uint32_t flags)
>         return 0xffff;
>  }
>
> -bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
> -                                       uint16_t *index, uint16_t *opcode=
,
> -                                       void *data, uint16_t *size)
> +static bool read_uart_type(struct btsnoop *btsnoop, uint32_t *toread,
> +                                                               uint8_t *=
type)
>  {
> -       struct btsnoop_pkt pkt;
> -       uint32_t toread, flags;
> -       uint64_t ts;
> -       uint8_t pkt_type;
>         ssize_t len;
>
> -       if (!btsnoop || btsnoop->aborted)
> -               return false;
> -
> -       if (btsnoop->pklg_format)
> -               return pklg_read_hci(btsnoop, tv, index, opcode, data, si=
ze);
> -
> -       len =3D read(btsnoop->fd, &pkt, BTSNOOP_PKT_SIZE);
> -       if (len =3D=3D 0)
> -               return false;
> -
> -       if (len < 0 || len !=3D BTSNOOP_PKT_SIZE) {
> +       if (!*toread) {
>                 btsnoop->aborted =3D true;
>                 return false;
>         }
>
> -       toread =3D be32toh(pkt.len);
> -       if (toread > BTSNOOP_MAX_PACKET_SIZE) {
> +       len =3D read_exact(btsnoop->fd, type, 1);
> +       if (len !=3D 1) {
>                 btsnoop->aborted =3D true;
>                 return false;
>         }
>
> -       flags =3D be32toh(pkt.flags);
> +       (*toread)--;
>
> -       ts =3D be64toh(pkt.ts) - 0x00E03AB44A676000ll;
> -       tv->tv_sec =3D (ts / 1000000ll) + 946684800ll;
> -       tv->tv_usec =3D ts % 1000000ll;
> +       return true;
> +}
> +
> +static bool decode_btsnoop_record(struct btsnoop *btsnoop, uint32_t flag=
s,
> +                                       uint32_t *toread, uint16_t *index=
,
> +                                       uint16_t *opcode)
> +{
> +       uint8_t pkt_type;
>
>         switch (btsnoop->format) {
>         case BTSNOOP_FORMAT_HCI:
>                 *index =3D 0;
>                 *opcode =3D get_opcode_from_flags(0xff, flags);
> -               break;
> -
> +               return true;
>         case BTSNOOP_FORMAT_UART:
> -               len =3D read(btsnoop->fd, &pkt_type, 1);
> -               if (len < 0) {
> -                       btsnoop->aborted =3D true;
> +               if (!read_uart_type(btsnoop, toread, &pkt_type))
>                         return false;
> -               }
> -               toread--;
>
>                 *index =3D 0;
>                 *opcode =3D get_opcode_from_flags(pkt_type, flags);
> -               break;
> -
> +               return true;
>         case BTSNOOP_FORMAT_MONITOR:
>                 *index =3D flags >> 16;
>                 *opcode =3D flags & 0xffff;
> -               break;
> -
> +               return true;
>         default:
>                 btsnoop->aborted =3D true;
>                 return false;
>         }
> +}
>
> -       len =3D read(btsnoop->fd, data, toread);
> -       if (len < 0) {
> +bool btsnoop_read_hci(struct btsnoop *btsnoop,
> +                       struct timeval *tv, uint16_t *index, uint16_t *op=
code,
> +                       void *data, uint16_t data_size, uint16_t *size)
> +{
> +       struct btsnoop_pkt pkt;
> +       uint32_t toread, flags;
> +       ssize_t len;
> +
> +       if (!btsnoop || !tv || !index || !opcode || !size || btsnoop->abo=
rted)
> +               return false;
> +
> +       if (btsnoop->pklg_format)
> +               return pklg_read_hci(btsnoop, tv, index, opcode,
> +                                                       data, data_size, =
size);
> +
> +       len =3D read_exact(btsnoop->fd, &pkt, BTSNOOP_PKT_SIZE);
> +       if (len =3D=3D 0)
> +               return false;
> +
> +       if (len !=3D BTSNOOP_PKT_SIZE) {
>                 btsnoop->aborted =3D true;
>                 return false;
>         }
>
> -       *size =3D toread;
> +       toread =3D be32toh(pkt.len);
> +       if (toread > BTSNOOP_MAX_PACKET_SIZE) {
> +               btsnoop->aborted =3D true;
> +               return false;
> +       }
>
> -       return true;
> +       flags =3D be32toh(pkt.flags);
> +
> +       if (!decode_btsnoop_timestamp(be64toh(pkt.ts), tv)) {
> +               btsnoop->aborted =3D true;
> +               return false;
> +       }
> +
> +       if (!decode_btsnoop_record(btsnoop, flags, &toread, index, opcode=
))
> +               return false;
> +
> +       return read_packet_data(btsnoop, data, data_size, toread, size);
>  }
>
>  bool btsnoop_read_phy(struct btsnoop *btsnoop, struct timeval *tv,
> -                       uint16_t *frequency, void *data, uint16_t *size)
> +                               uint16_t *frequency, void *data, uint16_t=
 *size)
>  {
> +       (void) btsnoop;
> +       (void) tv;
> +       (void) frequency;
> +       (void) data;
> +       (void) size;
> +
>         return false;
>  }
> diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
> index c24755d56..796604c58 100644
> --- a/src/shared/btsnoop.h
> +++ b/src/shared/btsnoop.h
> @@ -106,8 +106,8 @@ bool btsnoop_write_hci(struct btsnoop *btsnoop, struc=
t timeval *tv,
>  bool btsnoop_write_phy(struct btsnoop *btsnoop, struct timeval *tv,
>                         uint16_t frequency, const void *data, uint16_t si=
ze);
>
> -bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
> -                                       uint16_t *index, uint16_t *opcode=
,
> -                                       void *data, uint16_t *size);
> +bool btsnoop_read_hci(struct btsnoop *btsnoop,
> +                       struct timeval *tv, uint16_t *index, uint16_t *op=
code,
> +                       void *data, uint16_t data_size, uint16_t *size);
>  bool btsnoop_read_phy(struct btsnoop *btsnoop, struct timeval *tv,
>                         uint16_t *frequency, void *data, uint16_t *size);
> diff --git a/unit/test-btsnoop.c b/unit/test-btsnoop.c
> new file mode 100644
> index 000000000..710209097
> --- /dev/null
> +++ b/unit/test-btsnoop.c
> @@ -0,0 +1,794 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <endian.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <glib.h>
> +
> +#include "src/shared/att-types.h"
> +#include "src/shared/btsnoop.h"
> +#include "unit/test-btsnoop.h"
> +
> +#define BTSNOOP_EPOCH_OFFSET 0x00E03AB44A676000ull
> +#define PKLG_PAYLOAD_OFFSET 9
> +
> +struct test_btsnoop_hdr {
> +       uint8_t id[8];
> +       uint32_t version;
> +       uint32_t type;
> +} __packed;
> +
> +struct test_btsnoop_pkt {
> +       uint32_t size;
> +       uint32_t len;
> +       uint32_t flags;
> +       uint32_t drops;
> +       uint64_t ts;
> +} __packed;
> +
> +struct test_pklg_pkt {
> +       uint32_t len;
> +       uint64_t ts;
> +       uint8_t type;
> +} __packed;
> +
> +static const uint8_t btsnoop_id[] =3D {
> +       0x62, 0x74, 0x73, 0x6e, 0x6f, 0x6f, 0x70, 0x00
> +};
> +
> +static void append_bytes(GByteArray *array, const void *data, size_t siz=
e)
> +{
> +       if (!size)
> +               return;
> +
> +       g_byte_array_append(array, data, size);
> +}
> +
> +static void append_btsnoop_header(GByteArray *array, uint32_t format)
> +{
> +       struct test_btsnoop_hdr hdr;
> +
> +       memcpy(hdr.id, btsnoop_id, sizeof(btsnoop_id));
> +       hdr.version =3D htobe32(1);
> +       hdr.type =3D htobe32(format);
> +
> +       append_bytes(array, &hdr, sizeof(hdr));
> +}
> +
> +static void append_btsnoop_packet(GByteArray *array, uint32_t len,
> +                                       uint32_t flags, uint64_t ts,
> +                                       const void *data, size_t data_len=
)
> +{
> +       struct test_btsnoop_pkt pkt;
> +
> +       pkt.size =3D htobe32(len);
> +       pkt.len =3D htobe32(len);
> +       pkt.flags =3D htobe32(flags);
> +       pkt.drops =3D 0;
> +       pkt.ts =3D htobe64(ts);
> +
> +       append_bytes(array, &pkt, sizeof(pkt));
> +       append_bytes(array, data, data_len);
> +}
> +
> +static void append_pklg_packet(GByteArray *array, bool little_endian,
> +                               uint32_t payload_len, uint64_t ts,
> +                               uint8_t type, const void *data, size_t da=
ta_len)
> +{
> +       struct test_pklg_pkt pkt;
> +       uint32_t len =3D PKLG_PAYLOAD_OFFSET + payload_len;
> +
> +       pkt.len =3D little_endian ? htole32(len) : htobe32(len);
> +       pkt.ts =3D little_endian ? htole64(ts) : htobe64(ts);
> +       pkt.type =3D type;
> +
> +       append_bytes(array, &pkt, sizeof(pkt));
> +       append_bytes(array, data, data_len);
> +}
> +
> +static char *write_tmp_trace(const void *data, size_t size)
> +{
> +       char *path =3D NULL;
> +       ssize_t written;
> +       int fd;
> +
> +       fd =3D g_file_open_tmp("bluez-btsnoop-XXXXXX", &path, NULL);
> +       g_assert(fd >=3D 0);
> +       written =3D write(fd, data, size);
> +       g_assert_cmpint(written, =3D=3D, (ssize_t) size);
> +       g_assert_cmpint(close(fd), =3D=3D, 0);
> +
> +       return path;
> +}
> +
> +static char *new_tmp_path(void)
> +{
> +       char *path =3D NULL;
> +       int fd;
> +
> +       fd =3D g_file_open_tmp("bluez-btsnoop-XXXXXX", &path, NULL);
> +       g_assert(fd >=3D 0);
> +       g_assert_cmpint(close(fd), =3D=3D, 0);
> +       unlink(path);
> +
> +       return path;
> +}
> +
> +static void unlink_rotated(const char *path, unsigned int count)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i <=3D count; i++) {
> +               char *name;
> +
> +               name =3D g_strdup_printf("%s.%u", path, i);
> +               unlink(name);
> +               g_free(name);
> +       }
> +}
> +
> +static bool read_tmp_trace(const void *trace, size_t trace_len,
> +                               unsigned long flags, uint16_t data_size,
> +                               uint8_t *data, uint16_t *size,
> +                               uint16_t *index, uint16_t *opcode,
> +                               struct timeval *tv)
> +{
> +       struct btsnoop *btsnoop;
> +       char *path;
> +       bool result;
> +
> +       path =3D write_tmp_trace(trace, trace_len);
> +       btsnoop =3D btsnoop_open(path, flags);
> +       unlink(path);
> +       g_free(path);
> +
> +       if (!btsnoop)
> +               return false;
> +
> +       result =3D btsnoop_read_hci(btsnoop, tv, index, opcode, data,
> +                                                       data_size, size);
> +       btsnoop_unref(btsnoop);
> +
> +       return result;
> +}
> +
> +static bool read_trace_file(const char *path, unsigned long flags,
> +                               uint8_t *data, uint16_t data_size,
> +                               uint16_t *size, uint16_t *index,
> +                               uint16_t *opcode, struct timeval *tv)
> +{
> +       struct btsnoop *btsnoop;
> +       bool result;
> +
> +       btsnoop =3D btsnoop_open(path, flags);
> +       g_assert_nonnull(btsnoop);
> +
> +       result =3D btsnoop_read_hci(btsnoop, tv, index, opcode, data,
> +                                                       data_size, size);
> +       btsnoop_unref(btsnoop);
> +
> +       return result;
> +}
> +
> +static void test_btsnoop_hci_valid(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x01, 0x02, 0x03 };
> +       uint8_t data[sizeof(payload)];
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0xffff;
> +       uint16_t opcode =3D 0xffff;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
> +       append_btsnoop_packet(trace, sizeof(payload), 0x02,
> +                       BTSNOOP_EPOCH_OFFSET + 1234567, payload,
> +                       sizeof(payload));
> +
> +       g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(d=
ata),
> +                                       data, &size, &index, &opcode, &tv=
));
> +       g_assert_cmpint(index, =3D=3D, 0);
> +       g_assert_cmpint(opcode, =3D=3D, BTSNOOP_OPCODE_COMMAND_PKT);
> +       g_assert_cmpint(size, =3D=3D, sizeof(payload));
> +       g_assert_cmpint(memcmp(data, payload, sizeof(payload)), =3D=3D, 0=
);
> +       g_assert_cmpint(tv.tv_sec, =3D=3D, 946684801);
> +       g_assert_cmpint(tv.tv_usec, =3D=3D, 234567);
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_btsnoop_create_invalid_args(void)
> +{
> +       char *path =3D new_tmp_path();
> +
> +       g_assert_null(btsnoop_create(path, 0, 1, BTSNOOP_FORMAT_HCI));
> +       g_assert_null(btsnoop_create("/tmp/bluez/no/such/path", 0, 0,
> +                                                       BTSNOOP_FORMAT_HC=
I));
> +       g_assert_null(btsnoop_ref(NULL));
> +       btsnoop_unref(NULL);
> +       g_assert_cmpint(btsnoop_get_format(NULL), =3D=3D, BTSNOOP_FORMAT_=
INVALID);
> +
> +       g_free(path);
> +}
> +
> +static void test_btsnoop_open_invalid_headers(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       struct test_btsnoop_hdr hdr;
> +       char *path;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
> +       ((struct test_btsnoop_hdr *) trace->data)->version =3D htobe32(2)=
;
> +       path =3D write_tmp_trace(trace->data, trace->len);
> +       g_assert_null(btsnoop_open(path, 0));
> +       unlink(path);
> +       g_free(path);
> +       g_byte_array_set_size(trace, 0);
> +
> +       memset(&hdr, 0x55, sizeof(hdr));
> +       append_bytes(trace, &hdr, sizeof(hdr));
> +       path =3D write_tmp_trace(trace->data, trace->len);
> +       g_assert_null(btsnoop_open(path, 0));
> +       g_assert_null(btsnoop_open(path, BTSNOOP_FLAG_PKLG_SUPPORT));
> +       unlink(path);
> +       g_free(path);
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_btsnoop_write_hci_roundtrip(void)
> +{
> +       const uint8_t command[] =3D { 0x01, 0x02, 0x03 };
> +       const uint8_t event[] =3D { 0x04, 0x05 };
> +       uint8_t data[sizeof(command)];
> +       struct btsnoop *btsnoop;
> +       struct timeval tv =3D { .tv_sec =3D 946684802, .tv_usec =3D 34567=
8 };
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +       char *path =3D new_tmp_path();
> +
> +       btsnoop =3D btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_HCI);
> +       g_assert_nonnull(btsnoop);
> +       g_assert_cmpint(btsnoop_get_format(btsnoop), =3D=3D, BTSNOOP_FORM=
AT_HCI);
> +       g_assert_true(btsnoop_write_hci(btsnoop, &tv, 0,
> +                                       BTSNOOP_OPCODE_COMMAND_PKT, 0,
> +                                       command, sizeof(command)));
> +       g_assert_true(btsnoop_write_hci(btsnoop, &tv, 0,
> +                                       BTSNOOP_OPCODE_EVENT_PKT, 0,
> +                                       event, sizeof(event)));
> +       g_assert_false(btsnoop_write_hci(btsnoop, &tv, 1,
> +                                       BTSNOOP_OPCODE_COMMAND_PKT, 0,
> +                                       command, sizeof(command)));
> +       g_assert_false(btsnoop_write_hci(btsnoop, &tv, 0,
> +                                       BTSNOOP_OPCODE_NEW_INDEX, 0,
> +                                       command, sizeof(command)));
> +       btsnoop_unref(btsnoop);
> +
> +       g_assert_true(read_trace_file(path, 0, data, sizeof(data), &size,
> +                                               &index, &opcode, &tv));
> +       g_assert_cmpint(index, =3D=3D, 0);
> +       g_assert_cmpint(opcode, =3D=3D, BTSNOOP_OPCODE_COMMAND_PKT);
> +       g_assert_cmpint(size, =3D=3D, sizeof(command));
> +       g_assert_cmpint(memcmp(data, command, sizeof(command)), =3D=3D, 0=
);
> +
> +       btsnoop =3D btsnoop_open(path, 0);
> +       g_assert_nonnull(btsnoop);
> +       g_assert_true(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, dat=
a,
> +                                                       sizeof(data), &si=
ze));
> +       g_assert_true(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, dat=
a,
> +                                                       sizeof(data), &si=
ze));
> +       g_assert_cmpint(opcode, =3D=3D, BTSNOOP_OPCODE_EVENT_PKT);
> +       g_assert_cmpint(size, =3D=3D, sizeof(event));
> +       g_assert_cmpint(memcmp(data, event, sizeof(event)), =3D=3D, 0);
> +       g_assert_false(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, da=
ta,
> +                                                       sizeof(data), &si=
ze));
> +       btsnoop_unref(btsnoop);
> +
> +       unlink(path);
> +       g_free(path);
> +}
> +
> +static void test_btsnoop_write_monitor_roundtrip(void)
> +{
> +       const uint8_t payload[] =3D { 0xaa, 0xbb };
> +       uint8_t data[sizeof(payload)];
> +       struct btsnoop *btsnoop;
> +       struct timeval tv =3D { .tv_sec =3D 946684800, .tv_usec =3D 0 };
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +       char *path =3D new_tmp_path();
> +
> +       btsnoop =3D btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_MONITOR);
> +       g_assert_nonnull(btsnoop);
> +       g_assert_true(btsnoop_write_hci(btsnoop, &tv, 7, 0x1234, 0,
> +                                               payload, sizeof(payload))=
);
> +       btsnoop_unref(btsnoop);
> +
> +       g_assert_true(read_trace_file(path, 0, data, sizeof(data), &size,
> +                                               &index, &opcode, &tv));
> +       g_assert_cmpint(index, =3D=3D, 7);
> +       g_assert_cmpint(opcode, =3D=3D, 0x1234);
> +       g_assert_cmpint(size, =3D=3D, sizeof(payload));
> +       g_assert_cmpint(memcmp(data, payload, sizeof(payload)), =3D=3D, 0=
);
> +
> +       unlink(path);
> +       g_free(path);
> +}
> +
> +static void test_btsnoop_write_phy_and_rotate(void)
> +{
> +       const uint8_t payload[] =3D { 0x01 };
> +       struct btsnoop *btsnoop;
> +       struct timeval tv =3D { .tv_sec =3D 946684800, .tv_usec =3D 0 };
> +       char *path =3D new_tmp_path();
> +
> +       g_assert_false(btsnoop_write(NULL, &tv, 0, 0, payload,
> +                                                       sizeof(payload)))=
;
> +
> +       btsnoop =3D btsnoop_create(path, 24, 1, BTSNOOP_FORMAT_SIMULATOR)=
;
> +       g_assert_nonnull(btsnoop);
> +       g_assert_true(btsnoop_write_phy(btsnoop, &tv, 2402, payload,
> +                                                       sizeof(payload)))=
;
> +       btsnoop_unref(btsnoop);
> +
> +       btsnoop =3D btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_HCI);
> +       g_assert_nonnull(btsnoop);
> +       g_assert_false(btsnoop_write_phy(btsnoop, &tv, 2402, payload,
> +                                                       sizeof(payload)))=
;
> +       btsnoop_unref(btsnoop);
> +
> +       unlink(path);
> +       unlink_rotated(path, 1);
> +       g_free(path);
> +}
> +
> +static void test_btsnoop_monitor_valid(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0xaa, 0xbb };
> +       uint8_t data[sizeof(payload)];
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0xffff;
> +       uint16_t opcode =3D 0xffff;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_MONITOR);
> +       append_btsnoop_packet(trace, sizeof(payload), 0x00051234,
> +                       BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
> +
> +       g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(d=
ata),
> +                                       data, &size, &index, &opcode, &tv=
));
> +       g_assert_cmpint(index, =3D=3D, 5);
> +       g_assert_cmpint(opcode, =3D=3D, 0x1234);
> +       g_assert_cmpint(size, =3D=3D, sizeof(payload));
> +       g_assert_cmpint(memcmp(data, payload, sizeof(payload)), =3D=3D, 0=
);
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_btsnoop_uart_valid(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x04, 0x0e, 0x01, 0x00 };
> +       uint8_t data[sizeof(payload) - 1];
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0xffff;
> +       uint16_t opcode =3D 0xffff;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
> +       append_btsnoop_packet(trace, sizeof(payload), 0,
> +                       BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
> +
> +       g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(d=
ata),
> +                                       data, &size, &index, &opcode, &tv=
));
> +       g_assert_cmpint(index, =3D=3D, 0);
> +       g_assert_cmpint(opcode, =3D=3D, BTSNOOP_OPCODE_EVENT_PKT);
> +       g_assert_cmpint(size, =3D=3D, sizeof(payload) - 1);
> +       g_assert_cmpint(memcmp(data, payload + 1, sizeof(data)), =3D=3D, =
0);
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_btsnoop_uart_opcode_map(void)
> +{
> +       static const struct {
> +               uint8_t type;
> +               uint32_t flags;
> +               uint16_t opcode;
> +       } cases[] =3D {
> +               { 0x01, 0x00, BTSNOOP_OPCODE_COMMAND_PKT },
> +               { 0x02, 0x00, BTSNOOP_OPCODE_ACL_TX_PKT },
> +               { 0x02, 0x01, BTSNOOP_OPCODE_ACL_RX_PKT },
> +               { 0x03, 0x00, BTSNOOP_OPCODE_SCO_TX_PKT },
> +               { 0x03, 0x01, BTSNOOP_OPCODE_SCO_RX_PKT },
> +               { 0x05, 0x00, BTSNOOP_OPCODE_ISO_TX_PKT },
> +               { 0x05, 0x01, BTSNOOP_OPCODE_ISO_RX_PKT },
> +               { 0x99, 0x00, 0xffff },
> +       };
> +       unsigned int i;
> +
> +       for (i =3D 0; i < G_N_ELEMENTS(cases); i++) {
> +               GByteArray *trace =3D g_byte_array_new();
> +               const uint8_t payload[] =3D { cases[i].type, 0x00 };
> +               uint8_t data[1];
> +               struct timeval tv;
> +               uint16_t size =3D 0;
> +               uint16_t index =3D 0;
> +               uint16_t opcode =3D 0;
> +
> +               append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
> +               append_btsnoop_packet(trace, sizeof(payload), cases[i].fl=
ags,
> +                               BTSNOOP_EPOCH_OFFSET, payload, sizeof(pay=
load));
> +
> +               g_assert_true(read_tmp_trace(trace->data, trace->len, 0,
> +                                               sizeof(data), data, &size=
,
> +                                               &index, &opcode, &tv));
> +               g_assert_cmpint(opcode, =3D=3D, cases[i].opcode);
> +               g_byte_array_unref(trace);
> +       }
> +}
> +
> +static void test_btsnoop_rejects_small_capacity(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x01, 0x02, 0x03 };
> +       uint8_t data[4] =3D { 0xa5, 0xa5, 0xa5, 0xa5 };
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
> +       append_btsnoop_packet(trace, sizeof(payload), 0x02,
> +                       BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
> +
> +       g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 2, data=
,
> +                                               &size, &index, &opcode, &=
tv));
> +       g_assert_cmpint(data[0], =3D=3D, 0xa5);
> +       g_assert_cmpint(data[1], =3D=3D, 0xa5);
> +       g_assert_cmpint(data[2], =3D=3D, 0xa5);
> +       g_assert_cmpint(data[3], =3D=3D, 0xa5);
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_btsnoop_rejects_timestamp_underflow(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
> +       append_btsnoop_packet(trace, 0, 0x02, BTSNOOP_EPOCH_OFFSET - 1,
> +                                                               NULL, 0);
> +
> +       g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL=
,
> +                                               &size, &index, &opcode, &=
tv));
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_btsnoop_rejects_uart_zero_length(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
> +       append_btsnoop_packet(trace, 0, 0, BTSNOOP_EPOCH_OFFSET, NULL, 0)=
;
> +
> +       g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL=
,
> +                                               &size, &index, &opcode, &=
tv));
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_btsnoop_rejects_uart_short_type(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
> +       append_btsnoop_packet(trace, 1, 0, BTSNOOP_EPOCH_OFFSET, NULL, 0)=
;
> +
> +       g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL=
,
> +                                               &size, &index, &opcode, &=
tv));
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_btsnoop_rejects_short_payload(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x01, 0x02 };
> +       uint8_t data[3];
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
> +       append_btsnoop_packet(trace, 3, 0x02, BTSNOOP_EPOCH_OFFSET,
> +                                       payload, sizeof(payload));
> +
> +       g_assert_false(read_tmp_trace(trace->data, trace->len, 0,
> +                                       sizeof(data), data, &size,
> +                                       &index, &opcode, &tv));
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_pklg_big_endian_valid(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x0e, 0x01, 0x00 };
> +       uint8_t data[sizeof(payload)];
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0xffff;
> +       uint16_t opcode =3D 0xffff;
> +
> +       append_pklg_packet(trace, false, sizeof(payload),
> +                       ((uint64_t) 123 << 32) | 456, 0x01, payload,
> +                       sizeof(payload));
> +
> +       g_assert_true(read_tmp_trace(trace->data, trace->len,
> +                                       BTSNOOP_FLAG_PKLG_SUPPORT, sizeof=
(data),
> +                                       data, &size, &index, &opcode, &tv=
));
> +       g_assert_cmpint(index, =3D=3D, 0);
> +       g_assert_cmpint(opcode, =3D=3D, BTSNOOP_OPCODE_EVENT_PKT);
> +       g_assert_cmpint(size, =3D=3D, sizeof(payload));
> +       g_assert_cmpint(memcmp(data, payload, sizeof(payload)), =3D=3D, 0=
);
> +       g_assert_cmpint(tv.tv_sec, =3D=3D, 123);
> +       g_assert_cmpint(tv.tv_usec, =3D=3D, 456);
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_pklg_little_endian_valid(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x01, 0x02, 0x03 };
> +       uint8_t data[sizeof(payload)];
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0xffff;
> +       uint16_t opcode =3D 0xffff;
> +
> +       append_pklg_packet(trace, true, sizeof(payload),
> +                       ((uint64_t) 456 << 32) | 123, 0x00, payload,
> +                       sizeof(payload));
> +
> +       g_assert_true(read_tmp_trace(trace->data, trace->len,
> +                                       BTSNOOP_FLAG_PKLG_SUPPORT, sizeof=
(data),
> +                                       data, &size, &index, &opcode, &tv=
));
> +       g_assert_cmpint(index, =3D=3D, 0);
> +       g_assert_cmpint(opcode, =3D=3D, BTSNOOP_OPCODE_COMMAND_PKT);
> +       g_assert_cmpint(size, =3D=3D, sizeof(payload));
> +       g_assert_cmpint(data[0], =3D=3D, payload[0]);
> +       g_assert_cmpint(tv.tv_sec, =3D=3D, 123);
> +       g_assert_cmpint(tv.tv_usec, =3D=3D, 456);
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_pklg_rejects_short_length(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       struct test_pklg_pkt pkt;
> +       const uint8_t padding[] =3D { 0x00, 0x00, 0x00 };
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +
> +       pkt.len =3D htobe32(PKLG_PAYLOAD_OFFSET - 1);
> +       pkt.ts =3D 0;
> +       pkt.type =3D 0x01;
> +
> +       append_bytes(trace, &pkt, sizeof(pkt));
> +       append_bytes(trace, padding, sizeof(padding));
> +
> +       g_assert_false(read_tmp_trace(trace->data, trace->len,
> +                                       BTSNOOP_FLAG_PKLG_SUPPORT, 0, NUL=
L,
> +                                       &size, &index, &opcode, &tv));
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_pklg_rejects_small_capacity(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x01, 0x02, 0x03 };
> +       uint8_t data[4] =3D { 0xa5, 0xa5, 0xa5, 0xa5 };
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +
> +       append_pklg_packet(trace, false, sizeof(payload), 0, 0x01, payloa=
d,
> +                                                       sizeof(payload));
> +
> +       g_assert_false(read_tmp_trace(trace->data, trace->len,
> +                                       BTSNOOP_FLAG_PKLG_SUPPORT, 2, dat=
a,
> +                                       &size, &index, &opcode, &tv));
> +       g_assert_cmpint(data[0], =3D=3D, 0xa5);
> +       g_assert_cmpint(data[1], =3D=3D, 0xa5);
> +       g_assert_cmpint(data[2], =3D=3D, 0xa5);
> +       g_assert_cmpint(data[3], =3D=3D, 0xa5);
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_pklg_rejects_short_payload(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x01, 0x02, 0x03 };
> +       uint8_t data[4];
> +       struct timeval tv;
> +       uint16_t size =3D 0;
> +       uint16_t index =3D 0;
> +       uint16_t opcode =3D 0;
> +
> +       append_pklg_packet(trace, false, 4, 0, 0x01, payload,
> +                                                       sizeof(payload));
> +
> +       g_assert_false(read_tmp_trace(trace->data, trace->len,
> +                                       BTSNOOP_FLAG_PKLG_SUPPORT, sizeof=
(data),
> +                                       data, &size, &index, &opcode, &tv=
));
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_pklg_type_map(void)
> +{
> +       static const struct {
> +               uint8_t type;
> +               uint16_t index;
> +               uint16_t opcode;
> +       } cases[] =3D {
> +               { 0x02, 0x0000, BTSNOOP_OPCODE_ACL_TX_PKT },
> +               { 0x03, 0x0000, BTSNOOP_OPCODE_ACL_RX_PKT },
> +               { 0x08, 0x0000, BTSNOOP_OPCODE_SCO_TX_PKT },
> +               { 0x09, 0x0000, BTSNOOP_OPCODE_SCO_RX_PKT },
> +               { 0x12, 0x0000, BTSNOOP_OPCODE_ISO_TX_PKT },
> +               { 0x13, 0x0000, BTSNOOP_OPCODE_ISO_RX_PKT },
> +               { 0x0b, 0x0000, BTSNOOP_OPCODE_VENDOR_DIAG },
> +               { 0xfc, 0xffff, BTSNOOP_OPCODE_SYSTEM_NOTE },
> +               { 0xaa, 0xffff, 0xffff },
> +       };
> +       const uint8_t payload[] =3D { 0x00, 0x01, 0x02 };
> +       unsigned int i;
> +
> +       for (i =3D 0; i < G_N_ELEMENTS(cases); i++) {
> +               GByteArray *trace =3D g_byte_array_new();
> +               uint8_t data[sizeof(payload)];
> +               struct timeval tv;
> +               uint16_t size =3D 0;
> +               uint16_t index =3D 0;
> +               uint16_t opcode =3D 0;
> +
> +               append_pklg_packet(trace, false, sizeof(payload), 0,
> +                                               cases[i].type, payload,
> +                                               sizeof(payload));
> +
> +               g_assert_true(read_tmp_trace(trace->data, trace->len,
> +                                               BTSNOOP_FLAG_PKLG_SUPPORT=
,
> +                                               sizeof(data), data, &size=
,
> +                                               &index, &opcode, &tv));
> +               g_assert_cmpint(index, =3D=3D, cases[i].index);
> +               g_assert_cmpint(opcode, =3D=3D, cases[i].opcode);
> +               g_byte_array_unref(trace);
> +       }
> +}
> +
> +static void test_btsnoop_truncation_fuzz(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x01, 0x02, 0x03 };
> +       size_t len;
> +
> +       append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
> +       append_btsnoop_packet(trace, sizeof(payload), 0x02,
> +                       BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
> +
> +       for (len =3D 0; len < trace->len; len++) {
> +               uint8_t data[sizeof(payload)];
> +               struct timeval tv;
> +               uint16_t size =3D 0;
> +               uint16_t index =3D 0;
> +               uint16_t opcode =3D 0;
> +
> +               g_assert_false(read_tmp_trace(trace->data, len, 0,
> +                                               sizeof(data), data, &size=
,
> +                                               &index, &opcode, &tv));
> +       }
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +static void test_pklg_truncation_fuzz(void)
> +{
> +       GByteArray *trace =3D g_byte_array_new();
> +       const uint8_t payload[] =3D { 0x01, 0x02, 0x03 };
> +       size_t len;
> +
> +       append_pklg_packet(trace, false, sizeof(payload), 0, 0x01, payloa=
d,
> +                                                       sizeof(payload));
> +
> +       for (len =3D 0; len < trace->len; len++) {
> +               uint8_t data[sizeof(payload)];
> +               struct timeval tv;
> +               uint16_t size =3D 0;
> +               uint16_t index =3D 0;
> +               uint16_t opcode =3D 0;
> +
> +               g_assert_false(read_tmp_trace(trace->data, len,
> +                                               BTSNOOP_FLAG_PKLG_SUPPORT=
,
> +                                               sizeof(data), data, &size=
,
> +                                               &index, &opcode, &tv));
> +       }
> +
> +       g_byte_array_unref(trace);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       g_test_init(&argc, &argv, NULL);
> +
> +       g_test_add_func("/btsnoop/hci/valid", test_btsnoop_hci_valid);
> +       g_test_add_func("/btsnoop/create/invalid",
> +                       test_btsnoop_create_invalid_args);
> +       g_test_add_func("/btsnoop/open/invalid",
> +                       test_btsnoop_open_invalid_headers);
> +       g_test_add_func("/btsnoop/write/hci-roundtrip",
> +                       test_btsnoop_write_hci_roundtrip);
> +       g_test_add_func("/btsnoop/write/monitor-roundtrip",
> +                       test_btsnoop_write_monitor_roundtrip);
> +       g_test_add_func("/btsnoop/write/phy-and-rotate",
> +                       test_btsnoop_write_phy_and_rotate);
> +       g_test_add_func("/btsnoop/monitor/valid", test_btsnoop_monitor_va=
lid);
> +       g_test_add_func("/btsnoop/uart/valid", test_btsnoop_uart_valid);
> +       g_test_add_func("/btsnoop/uart/opcode-map",
> +                       test_btsnoop_uart_opcode_map);
> +       g_test_add_func("/btsnoop/capacity/reject",
> +                       test_btsnoop_rejects_small_capacity);
> +       g_test_add_func("/btsnoop/timestamp/underflow",
> +                       test_btsnoop_rejects_timestamp_underflow);
> +       g_test_add_func("/btsnoop/uart/zero-length",
> +                       test_btsnoop_rejects_uart_zero_length);
> +       g_test_add_func("/btsnoop/uart/short-type",
> +                       test_btsnoop_rejects_uart_short_type);
> +       g_test_add_func("/btsnoop/payload/short",
> +                       test_btsnoop_rejects_short_payload);
> +       g_test_add_func("/pklg/big-endian/valid", test_pklg_big_endian_va=
lid);
> +       g_test_add_func("/pklg/little-endian/valid",
> +                       test_pklg_little_endian_valid);
> +       g_test_add_func("/pklg/length/short", test_pklg_rejects_short_len=
gth);
> +       g_test_add_func("/pklg/capacity/reject",
> +                       test_pklg_rejects_small_capacity);
> +       g_test_add_func("/pklg/payload/short", test_pklg_rejects_short_pa=
yload);
> +       g_test_add_func("/pklg/type-map", test_pklg_type_map);
> +       g_test_add_func("/btsnoop/fuzz/truncation",
> +                       test_btsnoop_truncation_fuzz);
> +       g_test_add_func("/pklg/fuzz/truncation", test_pklg_truncation_fuz=
z);
> +
> +       return g_test_run();
> +}
> diff --git a/unit/test-btsnoop.h b/unit/test-btsnoop.h
> new file mode 100644
> index 000000000..9a12f3e71
> --- /dev/null
> +++ b/unit/test-btsnoop.h
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +void add_pklg_tests(void);
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
