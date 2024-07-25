Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898E19B3D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915439; cv=none; b=jI16b8ahu5O+91gvjZHCv0N4wZih/NleC8UJY+CGl8Y+QjUpvtmeJrCR6ds7VKE18yCcLYLqHvQVOQTKsKBBdqp2GV0Ih+o2Qz1pDgGmCwiZqQF6/aBfmu467Jy5ZzKLUNLkBcm/Pk9PTeyxOA/2jX4LgxFZ71uUPzDSlY38eF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915439; c=relaxed/simple;
	bh=+KwXHTQNTx8Ff7CtCdSxaLdO2vTXUu8SiWPuFI42i9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4ibAMEUZ1OmMBEE92uBwY6blBtZmbZSXoSOVoHe3i4jTtEmauIuUSYAitvmz5/p26s35PDC8xOCmo8IQFuxh5Dbzpd8Ex+wsetgB3cX8xz0TlphseEGtTixc4z7zqb1Jnh/pwDnrT1BOePRKGIKiUxH5pBrl1k0+UveOVUwjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3ZGjkSi; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3ZGjkSi"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef23d04541so2184611fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721915434; x=1722520234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nALifaEseRFJVjD+zpTe3R/eYFBN5jaXpx25gV35Vzs=;
        b=l3ZGjkSiYDTHJW04vkxw61rw9ymD3irBTFX1UMxaGpCcdAe+TnMwPAx2+CCOyjy60K
         /DLYFlB4UWshA95+g3KcmcakXYOiQDmEFojtXFfH4Zumx8fP1j6pSlhCnhp5n03uqgGM
         62IO/TFMLOZPCNUVIAQv4Xv/3ImwWBMQSRqPzbysq7XyyjPosFnoZj7nnpfr22WeT4/A
         EuVAnF0aSVKNyxs/kyC+ginMhJ7TlJEgCohu+f2uhu1AftBfUqxMPD/i/bpzQ3vuNXC1
         OQyxp9qxlbV6VVJtlRcZXd3bIfP64dw49IVgrcmBGHzCJDPOIAqi5L7SEkR8G09SY3vO
         IrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915434; x=1722520234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nALifaEseRFJVjD+zpTe3R/eYFBN5jaXpx25gV35Vzs=;
        b=uFYJtgg6iGGt/HhWiD39MvPXuF4h6gqz9Qec1Py+vGZU2lNdj6x72AryAUHnTDXRGI
         YIuNhs/Z4SPuU+0KFesPbK+SxhQTvdubMyiEqCjh1ud3Viq9HudfWqsJHWD8n79ESS9v
         x4IeOLYEDzDtcB9W8v+G7CQppxd5zj4XytmxBVU7woLoxNDWykMSlhi6jsRMst0VKRFW
         yfi+L1NiqoehePGFhgG4Ue5yb7Tcneo8v3Wfy6sBnIg0CgblbKuugvQ6XxYxFra/qj42
         fabTETvT1B1ASpyS2pztdtspwW8ET/l2tPEUNyNwtAdU165HGrABJKTwm2bjjR8unYRu
         uwQA==
X-Gm-Message-State: AOJu0YwnM8+tKj5F9Mo5wlm40pegQXOJuOcVQVgXYWOGguWlts4a5DIQ
	Oj6ctLV50thBKhgflvDyq16LLG5gqbFq7HLYWPo6ENuVVQCD1zPFz2vHxwV4eou0+G5EiLo5div
	yr8zo8rMpfJTO0aELneuYp9dW6rdelRjB
X-Google-Smtp-Source: AGHT+IFP5tas2IE1uO4uqXrWvQksJmvzk3K19T7MDJxw+Ew4BiTYBDD6eVqs/GSZsM6BLFL80Gba0DZMpidfrZ6iHNo=
X-Received: by 2002:a2e:3611:0:b0:2ef:22a5:9472 with SMTP id
 38308e7fff4ca-2f039d2d9acmr19958011fa.38.1721915433436; Thu, 25 Jul 2024
 06:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724111747.5952-1-quic_nakella@quicinc.com>
 <CABBYNZJ-X9qCcguj4hx5PiH8TxMECbhzYGri7AXCyAgVKXJ09A@mail.gmail.com> <bf554c95-8f24-425e-9ebf-51a3ec34d8ab@quicinc.com>
In-Reply-To: <bf554c95-8f24-425e-9ebf-51a3ec34d8ab@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jul 2024 09:50:21 -0400
Message-ID: <CABBYNZKz-W-Nu=L+Y63sY_1Lhjna7x=y=ERgYBnpF4t6Diwbhg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] hcitool - Added option for Peripheral Initiated
 Connection Parameter Update Request.
To: Naga Bhavani Akella <quic_nakella@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, schapman@lixar.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Thu, Jul 25, 2024 at 3:21=E2=80=AFAM Naga Bhavani Akella
<quic_nakella@quicinc.com> wrote:
>
> Hi Luiz Augusto von Dentz,
>
> Thank you for the comments.
>
> On 7/24/2024 9:53 PM, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Wed, Jul 24, 2024 at 7:20=E2=80=AFAM Naga Bhavani Akella
> > <quic_nakella@quicinc.com> wrote:
> >>
> >> There is no option in hcitool when Peripheral wants to
> >> initiate Connection Parameter Update Request, hence
> >> added provision to be able to send LL_CONNECTION_PARAM_REQ
> >> using hcitool.
> >>
> >> Required for PTS TC - GAP/CONN/CPUP/BV-02-C
> >>
> >> Reference link for discussion :
> >> https://lore.kernel.org/linux-bluetooth/
> >> Search for Subject - LE Connection Update Disallowed
> >> git code link :
> >> https://gist.github.com/SandyChapman/4a64c9ea22cd27d935e3
> >> ---
> >>  lib/hci.c       | 81 +++++++++++++++++++++++++++++++++++++++++++
> >>  lib/hci_lib.h   | 35 +++++++++++++++++++
> >>  tools/hcitool.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  3 files changed, 208 insertions(+)
> >>
> >> diff --git a/lib/hci.c b/lib/hci.c
> >> index 937e65d48..294b0bbd8 100644
> >> --- a/lib/hci.c
> >> +++ b/lib/hci.c
> >> @@ -1119,6 +1119,87 @@ int hci_send_cmd(int dd, uint16_t ogf, uint16_t=
 ocf, uint8_t plen, void *param)
> >>         return 0;
> >>  }
> >>
> >> +int hci_send_acl_data(int dd, uint16_t handle, uint8_t dlen,
> >> +                       struct signal_hdr *sh, struct signal_payload_h=
dr *plh,
> >> +                       void *pl)
> >> +{
> >> +       uint8_t type =3D HCI_ACLDATA_PKT;
> >> +       hci_acl_hdr ha;
> >> +       struct iovec iv[5];
> >> +       int ivn;
> >> +
> >> +       ha.handle =3D handle;
> >> +       ha.dlen =3D dlen;
> >> +
> >> +       iv[0].iov_base =3D &type;
> >> +       iv[0].iov_len =3D 1;
> >> +       iv[1].iov_base =3D &ha;
> >> +       iv[1].iov_len =3D HCI_ACL_HDR_SIZE;
> >> +       ivn =3D 2;
> >> +
> >> +       printf("\nACL Packet details[handle:%x, length:%d]\n",
> >> +                       ha.handle, ha.dlen);
> >> +
> >> +       if (dlen) {
> >> +               iv[2].iov_base =3D sh;
> >> +               iv[2].iov_len =3D 4; //HCI_SIGNAL_HDR_SIZE;
> >> +               ivn =3D 3;
> >> +               printf("\nACL signal command details[length:%d, cid:%d=
]\n",
> >> +                               sh->len, sh->cid);
> >> +               if (sh->len > 0) {
> >> +                       iv[3].iov_base =3D plh;
> >> +                       iv[3].iov_len =3D 4; //HCI_SIGNAL_PAYLOAD_HDR_=
SIZE;
> >> +                       ivn =3D 4;
> >> +                       if (plh->len > 0) {
> >> +                               iv[4].iov_base =3D pl;
> >> +                               iv[4].iov_len =3D plh->len;
> >> +                               ivn =3D 5;
> >> +                       }
> >> +               }
> >> +       }
> >> +
> >> +       while (writev(dd, iv, ivn) < 0) {
> >> +               if (errno =3D=3D EAGAIN || errno =3D=3D EINTR)
> >> +                       continue;
> >> +               return -1;
> >> +       }
> >> +       return 0;
> >> +}
> >> +
> >> +int hci_signal_le_con_param_update_req(int dd, uint16_t handle,
> >> +                                               uint16_t interval_min,
> >> +                                               uint16_t interval_max,
> >> +                                               uint16_t slave_latency=
,
> >> +                                               uint16_t timeout_multi=
plier)
> >> +{
> >> +       struct signal_hdr sh;
> >> +       struct signal_payload_hdr pl;
> >> +       struct le_con_param_update_req ur;
> >> +
> >> +       uint16_t length =3D 0x0010;
> >> +
> >> +       memset(&sh, 0, sizeof(sh));
> >> +       memset(&pl, 0, sizeof(pl));
> >> +       memset(&ur, 0, sizeof(ur));
> >> +
> >> +       sh.len =3D HCI_SIGNAL_LE_CON_PARAM_UPDATE_REQ_SIZE;
> >> +       sh.cid =3D HCI_LE_CHANNEL_ID;
> >> +
> >> +       pl.code =3D LE_CON_PARAM_UPDATE_REQ_CODE;
> >> +       pl.id =3D 0x77;
> >> +       pl.len =3D LE_CON_PARAM_UPDATE_LEN;
> >> +
> >> +       ur.interval_min =3D interval_min;
> >> +       ur.interval_max =3D interval_max;
> >> +       ur.slave_latency =3D slave_latency;
> >> +       ur.timeout_multiplier =3D timeout_multiplier;
> >> +
> >> +       if (hci_send_acl_data(dd, handle, length, &sh, &pl, &ur) < 0)
> >> +               return -1;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  int hci_send_req(int dd, struct hci_request *r, int to)
> >>  {
> >>         unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
> >> diff --git a/lib/hci_lib.h b/lib/hci_lib.h
> >> index baf3d3e12..fe0458a1b 100644
> >> --- a/lib/hci_lib.h
> >> +++ b/lib/hci_lib.h
> >> @@ -35,12 +35,47 @@ struct hci_version {
> >>         uint16_t lmp_subver;
> >>  };
> >>
> >> +struct hci_acl_hdr {
> >> +       uint16_t handle;
> >> +       uint16_t len;
> >> +};
> >> +
> >> +struct signal_hdr {
> >> +       uint16_t len;
> >> +       uint16_t cid;
> >> +};
> >> +
> >> +struct signal_payload_hdr {
> >> +       uint8_t  code;
> >> +       uint8_t  id;
> >> +       uint16_t len;
> >> +};
> >> +
> >> +struct le_con_param_update_req {
> >> +       uint16_t interval_min;
> >> +       uint16_t interval_max;
> >> +       uint16_t slave_latency;
> >> +       uint16_t timeout_multiplier;
> >> +};
> >> +#define HCI_SIGNAL_LE_CON_PARAM_UPDATE_REQ_SIZE 0x000C
> >> +#define HCI_LE_CHANNEL_ID                       0x0005
> >> +#define LE_CON_PARAM_UPDATE_REQ_CODE            0x12
> >> +#define LE_CON_PARAM_UPDATE_LEN                 0x0008
> >> +
> >>  int hci_open_dev(int dev_id);
> >>  int hci_close_dev(int dd);
> >>  int hci_send_cmd(int dd, uint16_t ogf, uint16_t ocf, uint8_t plen, vo=
id *param);
> >> +int hci_send_acl_data(int dd, uint16_t handle, uint8_t dlen,
> >> +                               struct signal_hdr *sh,
> >> +                               struct signal_payload_hdr *plh, void *=
pl);
> >>  int hci_send_req(int dd, struct hci_request *req, int timeout);
> >>
> >>  int hci_create_connection(int dd, const bdaddr_t *bdaddr, uint16_t pt=
ype, uint16_t clkoffset, uint8_t rswitch, uint16_t *handle, int to);
> >> +int hci_signal_le_con_param_update_req(int dd, uint16_t handle,
> >> +                                               uint16_t interval_min,
> >> +                                               uint16_t interval_max,
> >> +                                               uint16_t slave_latency=
,
> >> +                                               uint16_t timeout_multi=
plier);
> >>  int hci_disconnect(int dd, uint16_t handle, uint8_t reason, int to);
> >>
> >>  int hci_inquiry(int dev_id, int len, int num_rsp, const uint8_t *lap,=
 inquiry_info **ii, long flags);
> >> diff --git a/tools/hcitool.c b/tools/hcitool.c
> >> index 639ee6a51..ce611bb72 100644
> >> --- a/tools/hcitool.c
> >> +++ b/tools/hcitool.c
> >> @@ -3369,6 +3369,97 @@ static void cmd_lecup(int dev_id, int argc, cha=
r **argv)
> >>         hci_close_dev(dd);
> >>  }
> >>
> >> +static const char *acl_lecup_help =3D
> >> +       "Usage:\n"
> >> +       "\tacllecup <handle> <min> <max> <latency> <timeout>\n"
> >> +       "\tOptions:\n"
> >> +       "\t    -H, --handle <0xXXXX>  LE connection handle\n"
> >> +       "\t    -m, --min <interval>   Range: 0x0006 to 0x0C80\n"
> >> +       "\t    -M, --max <interval>   Range: 0x0006 to 0x0C80\n"
> >> +       "\t    -l, --latency <range>  Slave latency. Range: 0x0000 to =
0x03E8\n"
> >> +       "\t    -t, --timeout  <time>  N * 10ms. Range: 0x000A to 0x0C8=
0\n"
> >> +       "\n\t min/max range: 7.5ms to 4s. Multiply factor: 1.25ms"
> >> +       "\n\t timeout range: 100ms to 32.0s. Larger than max interval\=
n";
> >
> > Since to be the same as lecup, is the only difference being a
> > peripheral? We could perhaps attempt to detect if the handle is for a
> > peripheral, or add another parameter. Also perhaps this should have
> > been done via main.conf:
> >
> > # LE default connection parameters.  These values are superceeded by an=
y
> > # specific values provided via the Load Connection Parameters interface
> > #MinConnectionInterval=3D
> > #MaxConnectionInterval=3D
> > #ConnectionLatency=3D
> > #ConnectionSupervisionTimeout=3D
> >
> > But perhaps the kernel is not attempting to use them when connected as
> > a peripheral? It probably should though.
> After connection is established successfully, there is L2CAP_CONNECTION_P=
ARAMETER_UPDATE_REQ sent by peripheral,
> it has the values that were given in main.conf file.
>
> PTS requires us to initiate connection parameter request way after this i=
s done,
> to initiate this again currently we don't have any option in hcitool
> (if central doesn't support Connection Parameters Request Procedure) henc=
e added this option.
>
> This option is to send L2CAP_CONNECTION_PARAMETER_UPDATE_REQ (CODE 0x12) =
from the peripheral.
> This is required in the case where Central doesn't support Connection Par=
ameters Request Procedure.
> As per Spec statement -
>
> "If the Central, the Peripheral, or both do not support the Connection
> Parameters Request procedure, then the Central shall send an
> LL_CONNECTION_UPDATE_IND PDU (the Peripheral shall not send this
> PDU) while the Peripheral shall use the L2CAP LE Signaling channel (see [=
Vol
> 3] Part A, Section 4.20 and Section 4.21)."

I know what the procedure is, no need to keep quoting it, what perhaps
you don't realize is that this procedure is in fact implemented:

https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/l2cap_cor=
e.c#L1587

So it should be sending that L2CAP PDU if you had configured a
connection interval range that doesn't include the current connection
interval.

> >
> >> +static void cmd_acl_lecup(int dev_id, int argc, char **argv)
> >> +{
> >> +       uint16_t handle =3D 0, min, max, latency, timeout;
> >> +       int opt, dd, base;
> >> +       int options =3D 0;
> >> +
> >> +       /* Aleatory valid values */
> >> +       min =3D 0x0C8;
> >> +       max =3D 0x0960;
> >> +       latency =3D 0x0007;
> >> +       timeout =3D 0x0C80;
> >> +
> >> +       for_each_opt(opt, lecup_options, NULL) {
> >> +               if (optarg && strncasecmp("0x", optarg, 2) =3D=3D 0)
> >> +                       base =3D 16;
> >> +               else
> >> +                       base =3D 10;
> >> +
> >> +               switch (opt) {
> >> +               case 'H':
> >> +                       handle =3D strtoul(optarg, NULL, base);
> >> +                       break;
> >> +               case 'm':
> >> +                       min =3D strtoul(optarg, NULL, base);
> >> +                       break;
> >> +               case 'M':
> >> +                       max =3D strtoul(optarg, NULL, base);
> >> +                       break;
> >> +               case 'l':
> >> +                       latency =3D strtoul(optarg, NULL, base);
> >> +                       break;
> >> +               case 't':
> >> +                       timeout =3D strtoul(optarg, NULL, base);
> >> +                       break;
> >> +               default:
> >> +                       printf("%s", acl_lecup_help);
> >> +                       return;
> >> +               }
> >> +               options =3D 1;
> >> +       }
> >> +
> >> +       if (options =3D=3D 0) {
> >> +               helper_arg(5, 5, &argc, &argv, acl_lecup_help);
> >> +
> >> +               handle =3D strtoul(argv[0], NULL, 0);
> >> +               min =3D strtoul(argv[1], NULL, 0);
> >> +               max =3D strtoul(argv[2], NULL, 0);
> >> +               latency =3D strtoul(argv[3], NULL, 0);
> >> +               timeout =3D strtoul(argv[4], NULL, 0);
> >> +       }
> >> +
> >> +       if (handle =3D=3D 0 || handle > 0x0EFF) {
> >> +               printf("%s", acl_lecup_help);
> >> +               return;
> >> +       }
> >> +
> >> +       if (dev_id < 0)
> >> +               dev_id =3D hci_get_route(NULL);
> >> +
> >> +       dd =3D hci_open_dev(dev_id);
> >> +       if (dd < 0) {
> >> +               fprintf(stderr, "HCI device open failed\n");
> >> +               exit(1);
> >> +       }
> >> +
> >> +       fprintf(stderr, "Signal LE Connection Update Request: %d %d %d=
 %d %d\n",
> >> +                       handle, min, max, latency, timeout);
> >> +       if (hci_signal_le_con_param_update_req(dd, htobs(handle), htob=
s(min),
> >> +                                               htobs(max), htobs(late=
ncy),
> >> +                                               htobs(timeout)) < 0) {
> >> +               int err =3D -errno;
> >> +
> >> +               fprintf(stderr, "Could not change connection params: %=
s(%d)\n",
> >> +                                                       strerror(-err)=
, -err);
> >> +       }
> >> +
> >> +       hci_close_dev(dd);
> >> +}
> >> +
> >>  static struct {
> >>         char *cmd;
> >>         void (*func)(int dev_id, int argc, char **argv);
> >> @@ -3417,6 +3508,7 @@ static struct {
> >>         { "lecc",     cmd_lecc,    "Create a LE Connection"           =
    },
> >>         { "ledc",     cmd_ledc,    "Disconnect a LE Connection"       =
    },
> >>         { "lecup",    cmd_lecup,   "LE Connection Update"             =
    },
> >> +       { "acllecup", cmd_acl_lecup, "LE ACL Connection Param Update R=
eq" },
> >>         { NULL, NULL, 0 }
> >>  };
> >>
> >> --
> >>
> >
> >
> -Bhavani



--=20
Luiz Augusto von Dentz
