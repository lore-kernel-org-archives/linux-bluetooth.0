Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Mar 2014 13:28:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 02/10] emulator: Use timeout for sending inquiry
 results
Message-ID: <20140312112853.GB7489@localhost.P-661HNU-F1>
References: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1394406363-6751-3-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394406363-6751-3-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Mar 10, 2014, Lukasz Rymanowski wrote:
> +#define DEFAULT_INQUIRY_INTERVAL 100 /* 100 miliseconds */
> +
>  #define MAX_BTDEV_ENTRIES 16
>  
> +
>  static const uint8_t LINK_KEY_NONE[16] = { 0 };

Seems like you're introducing an unnecessary empty line above.

>  static const uint8_t LINK_KEY_DUMMY[16] = {	0, 1, 2, 3, 4, 5, 6, 7,
>  						8, 9, 0, 1, 2, 3, 4, 5 };
> @@ -528,9 +540,13 @@ void btdev_destroy(struct btdev *btdev)
>  	if (!btdev)
>  		return;
>  
> +	if (btdev->inquiry_id)
> +		timeout_remove(btdev->inquiry_id);

We usually check for valid timeout or GSource IDs with id > 0.

> +
>  	del_btdev(btdev);
>  
>  	free(btdev);
> +	btdev = NULL;
>  }

This last btdev = NULL is pointless since you're leaving the function
and the variable goes out of scope.

>  
> -	struct bt_hci_evt_inquiry_complete ic;
> +	struct inquiry_data *data = user_data;
> +	struct btdev *btdev = data->btdev;
> +	int sent = data->sent_count;
>  	int i;
>  
> -	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
> +	for (i = data->iter; i < MAX_BTDEV_ENTRIES; i++, data->iter++) {

Iterating data->iter and i++ throughout the entire loop seems overkill
I'd just assign the resulting value of i to data->iter once you've
exited to loop.

> +		/*Lets sent 10 inquiry results at once */
> +		if (sent + 10 == data->sent_count)
> +			break;

I'd prefer if we can make this so that you instead have the timeout
called as many times as necessary and send just one event each time.
I.e. upon reception of HCI_Inquiry you check the duration of the
inquiry, the maximum amount of responses, MAX_BTDEV_ENTRIES and
determine how frequently the timeout should be called in order to send
all events by the time the inquiry should complete.

> +static void inquiry_cmd(struct btdev *btdev, const void *cmd)
> +{
> +	struct inquiry_data *data;
> +	struct bt_hci_evt_inquiry_complete ic;
> +	int status = BT_HCI_ERR_HARDWARE_FAILURE;
> +
> +	if (btdev->inquiry_id) {

if (btdev->inquiry_id > 0)

> +	data = malloc(sizeof(*data));
> +	if (!data)
> +		goto error;

We usually use "failed" for this kind of labels.

> +	btdev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
> +				inquiry_callback, data, inquiry_destroy);

This looks like possibly incorrect indentation. The indentation should
go past the opening ( and then have more lines if necessary.

Johan
