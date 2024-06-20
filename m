Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1501AD4B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892045; cv=none; b=in5uLMi/B2FUiBhyKRjV4AfThejS14xLZvu1y1WhkKE9vRyTWAfFKnXvaLgAhm6dPrayir8gDv3rIKFvyHJRH5MI2To1uT8t6jWX3zbaEeHNAqErR00cgjuZ5WQNHrLKiaAAUIgdP389I+/Gv4FDg3rddslftxy4chqNBrdVzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892045; c=relaxed/simple;
	bh=GT2KV8HLfuI3zaQ3MtztlsWQP+Q0inT+zouzEZXW19U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS6kqaPWpMBXhqHJV9XGtzrZV2rx9v7leppAvzbz8lFVB7hZUAoAr6cKe1PPPd+2lPLqBfkiHhqRd37uupK4b4Y7wC2etkZfnq8wUtp6QIb9mCPFh7UnLwZLF4XeQ4QuUH1OqjCo1alU/5JNBsB7XRXpOVV0xej3a/AvS+YqL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWL3stqo; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWL3stqo"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso7892301fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718892042; x=1719496842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tADsFsNbCtY/pPto+6iNQxlurqi8FY9L/10GNaVWQSY=;
        b=hWL3stqoAYslugL2pHg5CbZwmIjB9KSa7PQFFfcKCg9BXlUbMmaizmWdWzWS09OhCQ
         QdoeYqq/kNIi8Gj+f28/KeMkG+DW399MGMI6Z9CQiGm7uoCvQMm03wEMEYNtG009P05S
         Fub+qiQDZAz96SjKQ85YakyX0Rs1UzyYqCdVAdScfHSlRiHu2buIvsDU8xgZRWM+kWmm
         ZcUh5kRf5Gd3gq7+qzVm2Z4qDbFWaF6fOEqCZm8/guOI0WSUSt+YPkmLrwDNWBYD+UNo
         6ps1+HdfCAR60QulCXtn7TRCQEBWlxWM0gKMbOfA30SOCHItHIDkhnDJk2c4qfKvQOuI
         Y4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892042; x=1719496842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tADsFsNbCtY/pPto+6iNQxlurqi8FY9L/10GNaVWQSY=;
        b=aNJtK6QgEyMqWSmd0b+ArpXW2908BltJ+UYZ5HeKTAH4yhb/34CXbcstoyZbyuj4RM
         CJ214+lRmonvJ22wcBUq/nCiQk/mIhi9ABRnAGdvLWHPRjeVL50T63LjrPJmEWKD3Rrd
         zgvv6XtFs1HQUConT0r99rdEd7g+OUDvDMdmNKNti7RmBWyv74CmY1taYVezdQ15aEXD
         /lkJZ2AhRZ3sPTosSkahWBPQ15Yfhk05ZZ8HsnlS7KWjE0oflRd5rmlVQ22bxUnDrAyf
         PWCQ5tBgrFK9ocBiA1rtM9tCV0OJ8wNyNlvdXbIiq104ukxdqFLtjkDJNLiUl+J6C1Kw
         IW6A==
X-Gm-Message-State: AOJu0Yx+c8zvms1eDEA8QXox0SPzQdKIlLmRPmByoHl+YhD3tmDMB/uv
	GEkw1ztmv0uU3ZURuqZ45M479O+L5dPsLwmdsvlE02/YZgh0mtvZsOrHGwOB7oACM/cJyeYNHjZ
	GBTVr7tQJYCcJm7zBbk/cRBCAg7oQJQ==
X-Google-Smtp-Source: AGHT+IEpAlbwKBnMNuwKd90LcKy5vsRt1XOvYPo1TRVcAK93uzjxqCVDgteaEvB4CgR46LfPJ3ylnLCmZOr/T0SJvHw=
X-Received: by 2002:a2e:9257:0:b0:2eb:fcea:2f18 with SMTP id
 38308e7fff4ca-2ec3ce7dfdbmr18177301fa.2.1718892041403; Thu, 20 Jun 2024
 07:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620112209.12287-1-quic_prathm@quicinc.com>
In-Reply-To: <20240620112209.12287-1-quic_prathm@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jun 2024 10:00:29 -0400
Message-ID: <CABBYNZJxmK99e5uV8xHKsdijbeMXHQsTE+b1JjxZu5r43cfDmA@mail.gmail.com>
Subject: Re: [PATCH v1] [PTS] Included peripheral mode for fixing of few PTS
 Test Cases
To: quic_prathm@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 7:23=E2=80=AFAM <quic_prathm@quicinc.com> wrote:
>
> From: Prathibha Madugonde <quic_prathm@quicinc.com>
>
> Fix for below Test Cases:
> GAP/SEC/SEM/BV-56-C
> GAP/SEC/SEM/BV-57-C
> GAP/SEC/SEM/BV-58-C
> GAP/SEC/SEM/BV-59-C
> GAP/SEC/SEM/BV-60-C
> GAP/SEC/SEM/BV-61-C
>
> For all above test cases, PTS tool is adding Battery Level Characteristic=
s in the GAP service. And PTS is expecting to write value to Battery Level =
Characteristics.
> When IUT and PTS are connected from bluetoothctl tool, GAP service and it=
s characterisitics are not showing in the bluetoothctl terminal.

Ok, this is sort of weird if that is intentional to expose Battery
Level Characteristic on GAP service, so there is no Battery Service?
Not sure why it would be using Battery Level either, or is this
something you can influence with some (PIXIT?) configuration? If the
idea is just to have the peripheral acting as a GATT client any
attribute would do it so the choice here seems really odd, what I'd
expect is that one could configure the attribute/handle that it wants
to send the GATT operations.

> Therefore need to use other existing tools, here we used btgatt-client to=
ol.
> For GAP/SEC/SEM/BV-56-C , GAP/SEC/SEM/BV-57-C, GAP/SEC/SEM/BV-58-C test c=
ases the IUT should be in peripheral mode(advertise and accept connection) =
and GATT client role as per GAP.TS.p44.
> Added peripheral mode in the btgatt-client tool for PASSING those test ca=
ses.
>
> Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
> ---
>  tools/btgatt-client.c | 97 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 91 insertions(+), 6 deletions(-)
>
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index b47914da3..2b732e454 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -36,6 +36,8 @@
>  #include "src/shared/gatt-helpers.h"
>
>  #define ATT_CID 4
> +#define CENTRAL_MODE   1
> +#define PERIPHERAL_MODE   2
>
>  #define PRLOG(...) \
>         printf(__VA_ARGS__); print_prompt();
> @@ -1633,6 +1635,68 @@ static void signal_cb(int signum, void *user_data)
>         }
>  }
>
> +static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec,
> +                                                       uint8_t src_type)
> +{
> +       int sk, nsk;
> +       struct sockaddr_l2 srcaddr, addr;
> +       socklen_t optlen;
> +       struct bt_security btsec;
> +       char ba[18];
> +
> +       sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> +       if (sk < 0) {
> +               perror("Failed to create L2CAP socket");
> +               return -1;
> +       }
> +
> +       /* Set up source address */
> +       memset(&srcaddr, 0, sizeof(srcaddr));
> +       srcaddr.l2_family =3D AF_BLUETOOTH;
> +       srcaddr.l2_cid =3D htobs(ATT_CID);
> +       srcaddr.l2_bdaddr_type =3D src_type;
> +       bacpy(&srcaddr.l2_bdaddr, src);
> +
> +       if (bind(sk, (struct sockaddr *) &srcaddr, sizeof(srcaddr)) < 0) =
{
> +               perror("Failed to bind L2CAP socket");
> +               goto fail;
> +       }
> +
> +       /* Set the security level */
> +       memset(&btsec, 0, sizeof(btsec));
> +       btsec.level =3D sec;
> +       if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &btsec,
> +                                                       sizeof(btsec)) !=
=3D 0) {
> +               fprintf(stderr, "Failed to set L2CAP security level\n");
> +               goto fail;
> +       }
> +
> +       if (listen(sk, 10) < 0) {
> +               perror("Listening on socket failed");
> +               goto fail;
> +       }
> +
> +       printf("Started listening on ATT channel. Waiting for connections=
\n");
> +
> +       memset(&addr, 0, sizeof(addr));
> +       optlen =3D sizeof(addr);
> +       nsk =3D accept(sk, (struct sockaddr *) &addr, &optlen);
> +       if (nsk < 0) {
> +               perror("Accept failed");
> +               goto fail;
> +       }
> +
> +       ba2str(&addr.l2_bdaddr, ba);
> +       printf("Connect from %s\n", ba);
> +       close(sk);
> +
> +       return nsk;
> +
> +fail:
> +       close(sk);
> +       return -1;
> +}
> +
>  static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t ds=
t_type,
>                                                                         i=
nt sec)
>  {
> @@ -1709,6 +1773,7 @@ static void usage(void)
>         printf("Options:\n"
>                 "\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n=
"
>                 "\t-d, --dest <addr>\t\tSpecify the destination address\n=
"
> +               "\t-p, --peripheral mode\t\t\tStar Listening on Att Chann=
el\n"
>                 "\t-t, --type [random|public] \tSpecify the LE address ty=
pe\n"
>                 "\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
>                 "\t-s, --security-level <sec> \tSet security level (low|m=
edium|"
> @@ -1720,6 +1785,7 @@ static void usage(void)
>  static struct option main_options[] =3D {
>         { "index",              1, 0, 'i' },
>         { "dest",               1, 0, 'd' },
> +       { "peripheral",         1, 0, 'p' },
>         { "type",               1, 0, 't' },
>         { "mtu",                1, 0, 'm' },
>         { "security-level",     1, 0, 's' },
> @@ -1738,9 +1804,10 @@ int main(int argc, char *argv[])
>         bdaddr_t src_addr, dst_addr;
>         int dev_id =3D -1;
>         int fd;
> +       int peri_cent =3D CENTRAL_MODE;
>         struct client *cli;
>
> -       while ((opt =3D getopt_long(argc, argv, "+hvs:m:t:d:i:",
> +       while ((opt =3D getopt_long(argc, argv, "+hvs:m:t:d:p:i:",
>                                                 main_options, NULL)) !=3D=
 -1) {
>                 switch (opt) {
>                 case 'h':
> @@ -1809,6 +1876,17 @@ int main(int argc, char *argv[])
>                         }
>
>                         break;
> +               case 'p':
> +                       if (strcmp(optarg, "peripheral") =3D=3D 0)
> +                                peri_cent =3D PERIPHERAL_MODE;
> +                       else if (strcmp(optarg, "central") =3D=3D 0)
> +                               peri_cent =3D CENTRAL_MODE;
> +                       else {
> +                               fprintf(stderr,
> +                                       "Allowed Modes: peripheral, centr=
al\n");
> +                               return EXIT_FAILURE;
> +                       }
> +            break;
>                 default:
>                         fprintf(stderr, "Invalid option: %c\n", opt);
>                         return EXIT_FAILURE;
> @@ -1836,14 +1914,21 @@ int main(int argc, char *argv[])
>                 return EXIT_FAILURE;
>         }
>
> -       if (!dst_addr_given) {
> -               fprintf(stderr, "Destination address required!\n");
> -               return EXIT_FAILURE;
> -       }
> +    if(peri_cent =3D=3D CENTRAL_MODE)
> +    {
> +        if (!dst_addr_given) {
> +            fprintf(stderr, "Destination address required!\n");
> +            return EXIT_FAILURE;
> +        }
> +
> +    }
>
>         mainloop_init();
>
> -       fd =3D l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
> +    if(peri_cent =3D=3D CENTRAL_MODE)
> +        fd =3D l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec)=
;
> +    else
> +        fd =3D l2cap_le_att_listen_and_accept(&src_addr, sec, BDADDR_LE_=
PUBLIC);
>         if (fd < 0)
>                 return EXIT_FAILURE;
>
> --
> 2.17.1
>
>


--=20
Luiz Augusto von Dentz
