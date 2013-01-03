Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jan 2013 17:09:16 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Michael Knudsen <michaelknudsendk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Michael Knudsen <m.knudsen@samsung.com>
Subject: Re: [RFC 3/3] Bluetooth:  Provide mgmt API for reading list of
 supported codecs
Message-ID: <20130103190916.GA2114@joana>
References: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
 <1353585909-28400-4-git-send-email-m.knudsen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353585909-28400-4-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

* Michael Knudsen <michaelknudsendk@gmail.com> [2012-11-22 13:05:08 +0100]:

> Provide an API for allowing user space to read the list of codecs
> supported by a given controller.  For now, hardwire PCM support,
> but construct initial list of supported codecs by inspecting the
> relevant bits of the local supported features bit mask.  Later,
> devices that support the appropriate HCI command will read out the
> actual list during controller initialisation.
> ---
>  include/net/bluetooth/hci_core.h |    2 ++
>  include/net/bluetooth/mgmt.h     |    7 +++++++
>  net/bluetooth/hci_core.c         |    3 +++
>  net/bluetooth/hci_event.c        |   21 +++++++++++++++++++++
>  net/bluetooth/mgmt.c             |   36 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 69 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ef5b85d..79fe128 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -153,6 +153,8 @@ struct hci_dev {
>  	__u8		features[8];
>  	__u8		host_features[8];
>  	__u8		commands[64];
> +	__u8		codecs;
> +	__u8		codec[255];
>  	__u8		hci_ver;
>  	__u16		hci_rev;
>  	__u8		lmp_ver;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 22980a7..523dc58 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -350,6 +350,13 @@ struct mgmt_cp_set_device_id {
>  } __packed;
>  #define MGMT_SET_DEVICE_ID_SIZE		8
>  
> +#define MGMT_OP_READ_CODECS		0x0029
> +#define MGMT_READ_CODECS_SIZE		0
> +struct mgmt_rp_read_codecs {
> +	__u8	count;
> +	__u8	codec[0];
> +} __packed;
> +

We think it is better to read the list of codecs from the SCO socket, we need
to allow both oFono and PulseAudio to read them without the need of talking to
BlueZ. Also, bluetoothd has nothing intersting to do with this information.

	Gustavo
