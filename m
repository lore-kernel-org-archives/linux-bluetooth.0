Return-Path: <cyrus@holtmann.org>
Date: Sat, 4 Oct 2014 16:24:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Include ADV_IND report in Device Connected
 event
Message-ID: <20141004132438.GA314@t440s.P-661HNU-F1>
References: <1412338971-14306-1-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412338971-14306-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Fri, Oct 03, 2014, Alfonso Acosta wrote:
>  void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
> -			   u32 flags, u8 *name, u8 name_len);
> +			   u32 flags, u8 *name, u8 name_len,
> +			   u8 *adv, u8 adv_len);

Now that you're already passing the full hci_conn to this function I
guess it's a bit pointless to add new parameters to it which would
anyway come from that same hci_conn object.

>  void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
> -			   u32 flags, u8 *name, u8 name_len)
> +			   u32 flags, u8 *name, u8 name_len,
> +			   u8 *adv, u8 adv_len)
>  {
>  	char buf[512];
>  	struct mgmt_ev_device_connected *ev = (void *) buf;
> @@ -6183,13 +6184,24 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
>  
>  	ev->flags = __cpu_to_le32(flags);
>  
> -	if (name_len > 0)
> -		eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
> -					  name, name_len);
> +	/* We must ensure that the EIR Data fields are ordered and
> +	 * unique. Keep it simple for now and avoid the problem by not
> +	 * adding any BR/EDR data to the LE adv.
> +	 */
> +	if (adv) {

And once you do the earlier fix I suppose this check becomes:

	if (conn->le_adv_data_len > 0) {

Besides this one issue with the unnecessary extra parameters both of
your patches look good to me.

Johan
