Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1728136E
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106340; cv=none; b=sGIcjmSGa08Fv1Tn596niP6VKUA6sThFZ0FzyjSiR1FhnyRRe6SuLAS+HV9Y0EipSuR5/gNKckapQOaioF54LwFZRFmPNit98DUL+gatOfX+goC3xkPFn5K8d/cSUjDg3Q/cHRa3MyYdMYXs6Z8jVnf8RHBGlSzcK+jmZDcSvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106340; c=relaxed/simple;
	bh=VGU2jqjM1eDzaeXCY1ueOiBrwJpx8PaNYV+BjYMlMuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/zpSeBSFbn+eQbSIUlco6q2gKThKjbtCcPJLRMuX0PJYO2EmLyoIVNnVSdIW/fkIDENO0ILP+FGOQE42AxK7FSOa93Zv0Yz0eUHBuWMP/5w0uuZZ+WJ/iaxOqN5np20pARSLulfIkmFSUpImWBQ5G1c5PNodLYrLBdXppQVxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWb/nWuz; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWb/nWuz"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so51499151fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106336; x=1741711136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmYTiOyYdgxTMnTyZvmB72Ins7S5OAXFHK2xkz7UX4k=;
        b=XWb/nWuzp8PYpn367PSHkBYzlA7YtAfRyLuMXsgrucESFIY/ftLthZyVsK7zDWak45
         Hb+VZ3UvS7IUXk7IGTo2WyovoPr8ocdmdSfR62uSs/WMzbvzwy8eDw9ko578LBbWKI1G
         x85mdcUn3FnZvW9NEaD1hrLA5OHIjYCZjCB1QKjUuQ4rheXZC/m5ZP/S+sX9200av7ww
         czQWOdKBuGEZZsy5Ua0gqqmN2uTJ1sJz/XJOfP4x/8YYVeUz4AWu0jQoGQjUyMBr/07F
         PlTLVR0J6H4kltGnjyQcQ5/CM7AsPP8JanqC+C0nxJWvE3jJFbVnTWMqXE7xNduYlmMw
         v0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106336; x=1741711136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmYTiOyYdgxTMnTyZvmB72Ins7S5OAXFHK2xkz7UX4k=;
        b=KZgGW18crL2XX9+Jf2WUTcFMMd+oPsA162DSLtJVVPVQM1bCw0HaCWqvT/Lwh0rs0R
         /v5wGNU6C8kyEqPtDUes7/VV/sRlZ1M3fyZRlaH+LzQ/5erUwGays2O4XF3w9bvybgYV
         5tAWiqMSuAtli3NvvfS6xlEQugt24ifz37pXmqJsvXbQ+zOCIShTybr1oHks6LT3oD86
         LS3TWpgLMIy9ms5myjwHWybMRZB4f6XniApLgL6cTIhjGySzQt1etLsNSrXJzocnaVDQ
         MVroVlOgFP49EVn+uRSW3NOGq1vQBHOv8xu0ItrEFHAmQ4gTuEn/nwC8pSqwwaYpQPXt
         SHGQ==
X-Gm-Message-State: AOJu0YzGPQpis9V/mq6h2VsZghNJEo7k5zM+q7DwAQdiEBysyVziTfKe
	epLv1nk+5t9BZxcL6cMdfVj/rnSfFGxp4x7ycIxOx02T5snH9Tcc4DQltVTH6uhlsu9iSH/cpPN
	DNF/MAlf8mrE2kYu1uqqMO4KI4zihkfTs
X-Gm-Gg: ASbGncvIPqg7hS+QkwId/jRPKrcozvjPxpUflDXLUiLcX1Wj4CwPUBFV2ohb5xuC/SL
	FHRmMDdK8C0gNz8RLX9RdvVxL75KP+Vd50Ym3MD41UWuB52/lumcM6SdCXzIONidNC9qUBQ3WJa
	L/k1JWRyOxweEH1aGrbDpZgCM6
X-Google-Smtp-Source: AGHT+IH4LwUwepCcH32p9Kl3vEeEp7nXT6RDSES2Ch3fIWAT5kYMGzmPIOQffIxC5/5Jil2rDmWVtPY7BCtGDNILRzk=
X-Received: by 2002:a05:651c:19a2:b0:30b:c6c2:43bc with SMTP id
 38308e7fff4ca-30bc6c24656mr25834161fa.19.1741106335543; Tue, 04 Mar 2025
 08:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304162955.149884-1-luiz.dentz@gmail.com>
In-Reply-To: <20250304162955.149884-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Mar 2025 11:38:43 -0500
X-Gm-Features: AQ5f1JoE0fYeMt7T_eDSa_H35jfnJ5tQJ5pfoPbO2Q2Ap2jQWYG9aAQ3S-ortcs
Message-ID: <CABBYNZLLFG_2JZCYTpcspUp3fN-3=MFoUup-i4X9jBifddN=AA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
To: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Cc: Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Mar 4, 2025 at 11:29=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables buffer flow control for SCO/eSCO
> (see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
> recently this has caused the following problem and is actually a nice
> addition for the likes of Socket TX complete:
>
> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > HCI Event: Command Complete (0x0e) plen 11
>       Read Buffer Size (0x04|0x0005) ncmd 1
>         Status: Success (0x00)
>         ACL MTU: 1021 ACL max packet: 5
>         SCO MTU: 240  SCO max packet: 8
> ...
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > HCI Event: Hardware Error (0x10) plen 1
>         Code: 0x0a
>
> Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci.h      |  6 ++++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 28 ++++++++++++++++++++++++++++
>  net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b99818df8ee7..70169533c940 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -448,6 +448,7 @@ enum {
>         HCI_WIDEBAND_SPEECH_ENABLED,
>         HCI_EVENT_FILTER_CONFIGURED,
>         HCI_PA_SYNC,
> +       HCI_SCO_FLOWCTL,
>
>         HCI_DUT_MODE,
>         HCI_VENDOR_DIAG,
> @@ -1544,6 +1545,11 @@ struct hci_rp_read_tx_power {
>         __s8     tx_power;
>  } __packed;
>
> +#define HCI_OP_WRITE_SYNC_FLOWCTL      0x0c2f
> +struct hci_cp_write_sync_flowctl {
> +       __u8     enable;
> +} __packed;
> +
>  #define HCI_OP_READ_PAGE_SCAN_TYPE     0x0c46
>  struct hci_rp_read_page_scan_type {
>         __u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 2f320eeddfec..cf18cf65fe5e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
>  #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
>  #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
> +#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
>  #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ=
)
>  #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
>  #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BRE=
DR))
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e7ec12437c8b..63eec8b80ff1 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3564,11 +3564,25 @@ static void hci_sched_sco(struct hci_dev *hdev)
>                         BT_DBG("skb %p len %d", skb, skb->len);
>                         hci_send_frame(hdev, skb);
>
> +                       hdev->sco_cnt--;
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
>                                 conn->sent =3D 0;
>                 }
>         }
> +
> +       /* Restore sco_cnt if flow control has not been enabled as
> +        * HCI_EV_NUM_COMP_PKTS won't be generated.
> +        */
> +       if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
> +               hdev->sco_cnt =3D hdev->sco_pkts;
> +
> +               /* As flow control is disabled force tx_work to run if th=
ere are
> +                * still packets left in the queue.
> +                */
> +               if (conn && !skb_queue_empty(&conn->data_q))
> +                       queue_work(hdev->workqueue, &hdev->tx_work);
> +       }
>  }
>
>  static void hci_sched_esco(struct hci_dev *hdev)
> @@ -3588,11 +3602,25 @@ static void hci_sched_esco(struct hci_dev *hdev)
>                         BT_DBG("skb %p len %d", skb, skb->len);
>                         hci_send_frame(hdev, skb);
>
> +                       hdev->sco_cnt--;
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
>                                 conn->sent =3D 0;
>                 }
>         }
> +
> +       /* Restore sco_cnt if flow control has not been enabled as
> +        * HCI_EV_NUM_COMP_PKTS won't be generated.
> +        */
> +       if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
> +               hdev->sco_cnt =3D hdev->sco_pkts;
> +
> +               /* As flow control is disabled force tx_work to run if th=
ere are
> +                * still packets left in the queue.
> +                */
> +               if (!skb_queue_empty(&conn->data_q))
> +                       queue_work(hdev->workqueue, &hdev->tx_work);
> +       }
>  }
>
>  static void hci_sched_acl_pkt(struct hci_dev *hdev)
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c4c2cf51b219..aaa6164fc3e3 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3769,6 +3769,27 @@ static int hci_write_ca_timeout_sync(struct hci_de=
v *hdev)
>                                      sizeof(param), &param, HCI_CMD_TIMEO=
UT);
>  }
>
> +/* Enable SCO flow control if supported */
> +static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
> +{
> +       struct hci_cp_write_sync_flowctl cp;
> +       int err;
> +
> +       /* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLO=
WCTL */
> +       if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
> +               return 0;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.enable =3D 0x01;
> +
> +       err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
> +                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +       if (!err)
> +               hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
> +
> +       return err;
> +}
> +
>  /* BR Controller init stage 2 command sequence */
>  static const struct hci_init_stage br_init2[] =3D {
>         /* HCI_OP_READ_BUFFER_SIZE */
> @@ -3787,6 +3808,8 @@ static const struct hci_init_stage br_init2[] =3D {
>         HCI_INIT(hci_clear_event_filter_sync),
>         /* HCI_OP_WRITE_CA_TIMEOUT */
>         HCI_INIT(hci_write_ca_timeout_sync),
> +       /* HCI_OP_WRITE_SYNC_FLOWCTL */
> +       HCI_INIT(hci_write_sync_flowctl_sync),
>         {}
>  };
>
> --
> 2.48.1

Looks like this is working when internally, so I wonder what is going
on if you don't receive NOCP on Intel controllers, that said perhaps
we need some way to detect if NOCP is not being generated, perhaps via
timer, then disable HCI_SCO_FLOWCTL, the issue is this perhaps could
cause hiccups at the start of the stream so perhaps we could do the
opposite and always start without setting HCI_SCO_FLOWCTL and only if
NOCP is generated then set HCI_SCO_FLOWCTL which can then be
persisted, thoughts?

--=20
Luiz Augusto von Dentz
