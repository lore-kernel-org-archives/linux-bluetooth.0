Return-Path: <cyrus@holtmann.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kiran Kumar Raparthy' <kiran.kumar@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: hyungseoung.yoo <hyungseoung.yoo@samsung.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Android Kernel Team
	<kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, "Jaikumar
 Ganesh" <jaikumarg@android.com>
Subject: RE: [PATCH - RESEND] Bluetooth: Keep master role when SCO or eSCO
 is active
Date: Fri, 27 Jun 2014 09:24:36 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17267FAF@AcuExch.aculab.com>
References: <1403860813-360-1-git-send-email-kiran.kumar@linaro.org>
In-Reply-To: <1403860813-360-1-git-send-email-kiran.kumar@linaro.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Kiran Kumar Raparthy
> From: "hyungseoung.yoo" <hyungseoung.yoo@samsung.com>
>=20
> Preserve the master role when SCO or eSCO is active
> as this improves compatability with lots of
> headset and chipset combinations.
>=20
> This is one of the number of patches from the Android AOSP
> common.git tree, which is used on almost all Android devices.
> It looks like it would improve support for compatibility with
> lot of headset,so I wanted to submit it for review to see
> if it should go upstream.
...
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 15010a2..cfb1355 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1915,6 +1915,14 @@ unlock:
>  	hci_conn_check_pending(hdev);
>  }
>=20
> +static inline bool is_sco_active(struct hci_dev *hdev)
> +{
> +	if (hci_conn_hash_lookup_state(hdev, SCO_LINK, BT_CONNECTED) ||
> +	    hci_conn_hash_lookup_state(hdev, ESCO_LINK, BT_CONNECTED))
> +		return true;
> +	return false;
> +}

Why not just return the value of the Boolean expression?

	David
