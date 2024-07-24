Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E091159568
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838220; cv=none; b=j6uqNPsCFK6TuFkeavIAFBcbGEou9f0NNSXLq7XlvP4wJEeUgMrGRh24goHpQndJddEm2g+YJyyv7Nwci8YD25IGtj3GYnzhjCKl3yMQY8oKVCb9TXfFYZXE2tbuctKp3ZblXxNoUaDTaA+jOoTV5V0h0/wunjHbNzoOdYRbnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838220; c=relaxed/simple;
	bh=yiUZBhIKsD/qSwQT7IYeM2Gl84oEIAcVybtZUsDk9UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hrqg+NpYPsuWFGiISOOwITr8tIp6WrKGc4aAqYb3SsXJAZ/kudKYLvY/vALFmKqLD/fj6Jpl7u1RDJp+3J/ANFW67+mogBrp7FUYVBqaWcRS6Td6MsusWzFiovN+ax6JOaY1Mwd9tIGhHF6NftwRLeJtOmtDFazHc40wQRSMtTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7fpApQX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7fpApQX"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso22325271fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721838215; x=1722443015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gycfx5DXblqMeR95z+zVo6F1cepJpIY8QDD42KlE6yQ=;
        b=h7fpApQXQnpW2XPat3FI5fVmzD9MhUKxpRA+dIsKCDzEHRAJcpEhnIObK7pJ37qrdA
         Inn4JSkGMmeDtc5fg7YOu+fRpWtC4DE/yQ+n1mPrOONtDzI3wBUABK7I3ThFjgQ40k+D
         g3VUmqQpOm6b7BHST6rriOGhbd86LQWw0VOFHSkq9cSiNYoC3aH6eG8JoK0S+VRB6QW+
         tZLQoCoSNoLWnfrV0WOdIaLzvzBZaL1otele6silou/YIxV7Kar/1MTKW26/0E4hm/SJ
         ZxXgeRd18nh+MPMrSCtkWU4lJdwSlDAyLZgvDrDVZdLuosdqcAN4UaDXlhusUJ0shPxX
         1Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838215; x=1722443015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gycfx5DXblqMeR95z+zVo6F1cepJpIY8QDD42KlE6yQ=;
        b=Tv8yNmxHQc/1B3N0FV1urmqAdOtNfl8mDl1W3uYQhAITtXvR/rYLMbzSVoy3sMol56
         8wBVap0fUSSyFIDpxwQxzzVNIzI+C7/xtYloDUpCc1FqnNZ806HMlMg10VY9sLT85kjf
         q3HViVVh83kItT/Zmvy6n6tYtrEPbRgN26nQeAID4EYR5nbEzIQ7PNWcqaYWcGsv92kr
         VW2pjZgFGMBLQ2yuUcvm7ORlOW4dwA/xtPETO8acIhxauErjbRRSP6fyG083gHBZpA5n
         4b1hKOgmoScDx4L6hUnoesDeT8RHRwB8LVJ08G2G7mNIIFkzt8ERm6pDrP8F+9Ok4MYu
         FfvA==
X-Gm-Message-State: AOJu0YwaYkRhI51VPGPtImAgkixSpvMQuDrW/ulXP0I4BgJLL329JtY9
	yXG9BDZxMv3mKz07vYdfM/ZFfxishsOQIC5yAlTiGXazOtfq3xzGn3JUII07/USK2VkOcB1OROh
	czB7t0bJ/I/+6XjZF22ufoBiVoT9zDEp/
X-Google-Smtp-Source: AGHT+IFBEY/KvYA9vteEF6Nl7C3MhogPg5nC712K8Mdr06Vc9CZ1Wmhy3J4todScSbcdkZVLgFlAapaQ8LD9st1DOjQ=
X-Received: by 2002:a2e:a581:0:b0:2ef:296d:1de3 with SMTP id
 38308e7fff4ca-2f039b4d69fmr5140561fa.0.1721838214899; Wed, 24 Jul 2024
 09:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724111747.5952-1-quic_nakella@quicinc.com>
In-Reply-To: <20240724111747.5952-1-quic_nakella@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Jul 2024 12:23:22 -0400
Message-ID: <CABBYNZJ-X9qCcguj4hx5PiH8TxMECbhzYGri7AXCyAgVKXJ09A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] hcitool - Added option for Peripheral Initiated
 Connection Parameter Update Request.
To: Naga Bhavani Akella <quic_nakella@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, schapman@lixar.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 24, 2024 at 7:20=E2=80=AFAM Naga Bhavani Akella
<quic_nakella@quicinc.com> wrote:
>
> There is no option in hcitool when Peripheral wants to
> initiate Connection Parameter Update Request, hence
> added provision to be able to send LL_CONNECTION_PARAM_REQ
> using hcitool.
>
> Required for PTS TC - GAP/CONN/CPUP/BV-02-C
>
> Reference link for discussion :
> https://lore.kernel.org/linux-bluetooth/
> Search for Subject - LE Connection Update Disallowed
> git code link :
> https://gist.github.com/SandyChapman/4a64c9ea22cd27d935e3
> ---
>  lib/hci.c       | 81 +++++++++++++++++++++++++++++++++++++++++++
>  lib/hci_lib.h   | 35 +++++++++++++++++++
>  tools/hcitool.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 208 insertions(+)
>
> diff --git a/lib/hci.c b/lib/hci.c
> index 937e65d48..294b0bbd8 100644
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -1119,6 +1119,87 @@ int hci_send_cmd(int dd, uint16_t ogf, uint16_t oc=
f, uint8_t plen, void *param)
>         return 0;
>  }
>
> +int hci_send_acl_data(int dd, uint16_t handle, uint8_t dlen,
> +                       struct signal_hdr *sh, struct signal_payload_hdr =
*plh,
> +                       void *pl)
> +{
> +       uint8_t type =3D HCI_ACLDATA_PKT;
> +       hci_acl_hdr ha;
> +       struct iovec iv[5];
> +       int ivn;
> +
> +       ha.handle =3D handle;
> +       ha.dlen =3D dlen;
> +
> +       iv[0].iov_base =3D &type;
> +       iv[0].iov_len =3D 1;
> +       iv[1].iov_base =3D &ha;
> +       iv[1].iov_len =3D HCI_ACL_HDR_SIZE;
> +       ivn =3D 2;
> +
> +       printf("\nACL Packet details[handle:%x, length:%d]\n",
> +                       ha.handle, ha.dlen);
> +
> +       if (dlen) {
> +               iv[2].iov_base =3D sh;
> +               iv[2].iov_len =3D 4; //HCI_SIGNAL_HDR_SIZE;
> +               ivn =3D 3;
> +               printf("\nACL signal command details[length:%d, cid:%d]\n=
",
> +                               sh->len, sh->cid);
> +               if (sh->len > 0) {
> +                       iv[3].iov_base =3D plh;
> +                       iv[3].iov_len =3D 4; //HCI_SIGNAL_PAYLOAD_HDR_SIZ=
E;
> +                       ivn =3D 4;
> +                       if (plh->len > 0) {
> +                               iv[4].iov_base =3D pl;
> +                               iv[4].iov_len =3D plh->len;
> +                               ivn =3D 5;
> +                       }
> +               }
> +       }
> +
> +       while (writev(dd, iv, ivn) < 0) {
> +               if (errno =3D=3D EAGAIN || errno =3D=3D EINTR)
> +                       continue;
> +               return -1;
> +       }
> +       return 0;
> +}
> +
> +int hci_signal_le_con_param_update_req(int dd, uint16_t handle,
> +                                               uint16_t interval_min,
> +                                               uint16_t interval_max,
> +                                               uint16_t slave_latency,
> +                                               uint16_t timeout_multipli=
er)
> +{
> +       struct signal_hdr sh;
> +       struct signal_payload_hdr pl;
> +       struct le_con_param_update_req ur;
> +
> +       uint16_t length =3D 0x0010;
> +
> +       memset(&sh, 0, sizeof(sh));
> +       memset(&pl, 0, sizeof(pl));
> +       memset(&ur, 0, sizeof(ur));
> +
> +       sh.len =3D HCI_SIGNAL_LE_CON_PARAM_UPDATE_REQ_SIZE;
> +       sh.cid =3D HCI_LE_CHANNEL_ID;
> +
> +       pl.code =3D LE_CON_PARAM_UPDATE_REQ_CODE;
> +       pl.id =3D 0x77;
> +       pl.len =3D LE_CON_PARAM_UPDATE_LEN;
> +
> +       ur.interval_min =3D interval_min;
> +       ur.interval_max =3D interval_max;
> +       ur.slave_latency =3D slave_latency;
> +       ur.timeout_multiplier =3D timeout_multiplier;
> +
> +       if (hci_send_acl_data(dd, handle, length, &sh, &pl, &ur) < 0)
> +               return -1;
> +
> +       return 0;
> +}
> +
>  int hci_send_req(int dd, struct hci_request *r, int to)
>  {
>         unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
> diff --git a/lib/hci_lib.h b/lib/hci_lib.h
> index baf3d3e12..fe0458a1b 100644
> --- a/lib/hci_lib.h
> +++ b/lib/hci_lib.h
> @@ -35,12 +35,47 @@ struct hci_version {
>         uint16_t lmp_subver;
>  };
>
> +struct hci_acl_hdr {
> +       uint16_t handle;
> +       uint16_t len;
> +};
> +
> +struct signal_hdr {
> +       uint16_t len;
> +       uint16_t cid;
> +};
> +
> +struct signal_payload_hdr {
> +       uint8_t  code;
> +       uint8_t  id;
> +       uint16_t len;
> +};
> +
> +struct le_con_param_update_req {
> +       uint16_t interval_min;
> +       uint16_t interval_max;
> +       uint16_t slave_latency;
> +       uint16_t timeout_multiplier;
> +};
> +#define HCI_SIGNAL_LE_CON_PARAM_UPDATE_REQ_SIZE 0x000C
> +#define HCI_LE_CHANNEL_ID                       0x0005
> +#define LE_CON_PARAM_UPDATE_REQ_CODE            0x12
> +#define LE_CON_PARAM_UPDATE_LEN                 0x0008
> +
>  int hci_open_dev(int dev_id);
>  int hci_close_dev(int dd);
>  int hci_send_cmd(int dd, uint16_t ogf, uint16_t ocf, uint8_t plen, void =
*param);
> +int hci_send_acl_data(int dd, uint16_t handle, uint8_t dlen,
> +                               struct signal_hdr *sh,
> +                               struct signal_payload_hdr *plh, void *pl)=
;
>  int hci_send_req(int dd, struct hci_request *req, int timeout);
>
>  int hci_create_connection(int dd, const bdaddr_t *bdaddr, uint16_t ptype=
, uint16_t clkoffset, uint8_t rswitch, uint16_t *handle, int to);
> +int hci_signal_le_con_param_update_req(int dd, uint16_t handle,
> +                                               uint16_t interval_min,
> +                                               uint16_t interval_max,
> +                                               uint16_t slave_latency,
> +                                               uint16_t timeout_multipli=
er);
>  int hci_disconnect(int dd, uint16_t handle, uint8_t reason, int to);
>
>  int hci_inquiry(int dev_id, int len, int num_rsp, const uint8_t *lap, in=
quiry_info **ii, long flags);
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index 639ee6a51..ce611bb72 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -3369,6 +3369,97 @@ static void cmd_lecup(int dev_id, int argc, char *=
*argv)
>         hci_close_dev(dd);
>  }
>
> +static const char *acl_lecup_help =3D
> +       "Usage:\n"
> +       "\tacllecup <handle> <min> <max> <latency> <timeout>\n"
> +       "\tOptions:\n"
> +       "\t    -H, --handle <0xXXXX>  LE connection handle\n"
> +       "\t    -m, --min <interval>   Range: 0x0006 to 0x0C80\n"
> +       "\t    -M, --max <interval>   Range: 0x0006 to 0x0C80\n"
> +       "\t    -l, --latency <range>  Slave latency. Range: 0x0000 to 0x0=
3E8\n"
> +       "\t    -t, --timeout  <time>  N * 10ms. Range: 0x000A to 0x0C80\n=
"
> +       "\n\t min/max range: 7.5ms to 4s. Multiply factor: 1.25ms"
> +       "\n\t timeout range: 100ms to 32.0s. Larger than max interval\n";

Since to be the same as lecup, is the only difference being a
peripheral? We could perhaps attempt to detect if the handle is for a
peripheral, or add another parameter. Also perhaps this should have
been done via main.conf:

# LE default connection parameters.  These values are superceeded by any
# specific values provided via the Load Connection Parameters interface
#MinConnectionInterval=3D
#MaxConnectionInterval=3D
#ConnectionLatency=3D
#ConnectionSupervisionTimeout=3D

But perhaps the kernel is not attempting to use them when connected as
a peripheral? It probably should though.

> +static void cmd_acl_lecup(int dev_id, int argc, char **argv)
> +{
> +       uint16_t handle =3D 0, min, max, latency, timeout;
> +       int opt, dd, base;
> +       int options =3D 0;
> +
> +       /* Aleatory valid values */
> +       min =3D 0x0C8;
> +       max =3D 0x0960;
> +       latency =3D 0x0007;
> +       timeout =3D 0x0C80;
> +
> +       for_each_opt(opt, lecup_options, NULL) {
> +               if (optarg && strncasecmp("0x", optarg, 2) =3D=3D 0)
> +                       base =3D 16;
> +               else
> +                       base =3D 10;
> +
> +               switch (opt) {
> +               case 'H':
> +                       handle =3D strtoul(optarg, NULL, base);
> +                       break;
> +               case 'm':
> +                       min =3D strtoul(optarg, NULL, base);
> +                       break;
> +               case 'M':
> +                       max =3D strtoul(optarg, NULL, base);
> +                       break;
> +               case 'l':
> +                       latency =3D strtoul(optarg, NULL, base);
> +                       break;
> +               case 't':
> +                       timeout =3D strtoul(optarg, NULL, base);
> +                       break;
> +               default:
> +                       printf("%s", acl_lecup_help);
> +                       return;
> +               }
> +               options =3D 1;
> +       }
> +
> +       if (options =3D=3D 0) {
> +               helper_arg(5, 5, &argc, &argv, acl_lecup_help);
> +
> +               handle =3D strtoul(argv[0], NULL, 0);
> +               min =3D strtoul(argv[1], NULL, 0);
> +               max =3D strtoul(argv[2], NULL, 0);
> +               latency =3D strtoul(argv[3], NULL, 0);
> +               timeout =3D strtoul(argv[4], NULL, 0);
> +       }
> +
> +       if (handle =3D=3D 0 || handle > 0x0EFF) {
> +               printf("%s", acl_lecup_help);
> +               return;
> +       }
> +
> +       if (dev_id < 0)
> +               dev_id =3D hci_get_route(NULL);
> +
> +       dd =3D hci_open_dev(dev_id);
> +       if (dd < 0) {
> +               fprintf(stderr, "HCI device open failed\n");
> +               exit(1);
> +       }
> +
> +       fprintf(stderr, "Signal LE Connection Update Request: %d %d %d %d=
 %d\n",
> +                       handle, min, max, latency, timeout);
> +       if (hci_signal_le_con_param_update_req(dd, htobs(handle), htobs(m=
in),
> +                                               htobs(max), htobs(latency=
),
> +                                               htobs(timeout)) < 0) {
> +               int err =3D -errno;
> +
> +               fprintf(stderr, "Could not change connection params: %s(%=
d)\n",
> +                                                       strerror(-err), -=
err);
> +       }
> +
> +       hci_close_dev(dd);
> +}
> +
>  static struct {
>         char *cmd;
>         void (*func)(int dev_id, int argc, char **argv);
> @@ -3417,6 +3508,7 @@ static struct {
>         { "lecc",     cmd_lecc,    "Create a LE Connection"              =
 },
>         { "ledc",     cmd_ledc,    "Disconnect a LE Connection"          =
 },
>         { "lecup",    cmd_lecup,   "LE Connection Update"                =
 },
> +       { "acllecup", cmd_acl_lecup, "LE ACL Connection Param Update Req"=
 },
>         { NULL, NULL, 0 }
>  };
>
> --
>


--=20
Luiz Augusto von Dentz
