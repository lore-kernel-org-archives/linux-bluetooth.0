Return-Path: <010001623a5a3d47-9a205d5b-5d17-44ed-9cc1-99f3f1448a07-000000@amazonses.com>
Subject: Re: [RFC] Bluetooth: Add new serdev based driver for 3-Wire attached
 controllers
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
References: <20180316221221.130478-1-marcel@holtmann.org>
From: Jeremy Cline <jeremy@jcline.org>
Message-ID: <010001623a5a3d47-9a205d5b-5d17-44ed-9cc1-99f3f1448a07-000000@email.amazonses.com>
Date: Sun, 18 Mar 2018 18:23:35 +0000
MIME-Version: 1.0
In-Reply-To: <20180316221221.130478-1-marcel@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 03/16/2018 03:12 PM, Marcel Holtmann wrote:
> +static int bt3wire_receive_buf(struct serdev_device *serdev, const u8 *buf,
> +			      size_t count)
> +{
> +	struct bt3wire_dev *bdev = serdev_device_get_drvdata(serdev);
> +	size_t i;
> +
> +	for (i = 0; i < count; i++) {
> +		const unsigned char *ptr = buf + i;
> +
> +		switch (bdev->rx_slip_state) {
> +		case SLIP_WAIT_DELIM:
> +			/* The delimiter octet 0xC0 is placed at the start and
> +			 * end of every packet. To synchronize with the packet
> +			 * stream, wait for the delimiter octet and drop any
> +			 * other octets.
> +			 */
> +			if (*ptr == SLIP_DELIM) {
> +				bdev->rx_skb = bt_skb_alloc(MAX_PACKET_SIZE,
> +							    GFP_ATOMIC);
> +				if (bdev->rx_skb)
> +					bdev->rx_slip_state = SLIP_PACKET;
> +			}
> +			break;
> +		case SLIP_PACKET:
> +			/* Receiving the delimiter octet 0xC0 indicates a
> +			 * complete packet, the escape octet 0xDB indicates
> +			 * the switch to an escape sequence, and all other
> +			 * octets are copied into the result.
> +			 */
> +			if (*ptr == SLIP_DELIM) {
> +				bt3wire_process_pkt(bdev, bdev->rx_skb);
> +				bdev->rx_skb = NULL;
> +				bdev->rx_slip_state = SLIP_WAIT_DELIM;
> +			} else if (*ptr == SLIP_ESC) {
> +				bdev->rx_slip_state = SLIP_ESCAPE;
> +			} else {
> +				if (bdev->rx_skb->len < MAX_PACKET_SIZE) {
> +					skb_put_u8(bdev->rx_skb, *ptr);
> +				} else {
> +					kfree_skb(bdev->rx_skb);
> +					bdev->rx_skb = NULL;
> +					bdev->rx_slip_state = SLIP_WAIT_DELIM;
> +				}
> +			}
> +			break;
> +		case SLIP_ESCAPE:
> +			/* As part of the escape sequence, only the octets
> +			 * 0xDC for the delimiter and 0xDD for the escape
> +			 * sequence are valid. All other octets are causing
> +			 * re-sychronization with the delimter.
> +			 */
> +			if (*ptr == SLIP_ESC_DELIM) {
> +				if (bdev->rx_skb->len < MAX_PACKET_SIZE) {
> +					skb_put_u8(bdev->rx_skb, SLIP_DELIM);
> +				} else {
> +					kfree_skb(bdev->rx_skb);
> +					bdev->rx_skb = NULL;
> +					bdev->rx_slip_state = SLIP_WAIT_DELIM;
> +				}
> +				bdev->rx_slip_state = SLIP_PACKET;

Should this be in "if (bdev->rx_skb->len < MAX_PACKET_SIZE)" block?
Otherwise a too-large packet is put in the SLIP_PACKET state instead of
SLIP_WAIT_DELIM.

> +			} else if (*ptr == SLIP_ESC_ESC) {
> +				if (bdev->rx_skb->len < MAX_PACKET_SIZE) {
> +					skb_put_u8(bdev->rx_skb, SLIP_ESC);
> +				} else {
> +					kfree_skb(bdev->rx_skb);
> +					bdev->rx_skb = NULL;
> +					bdev->rx_slip_state = SLIP_WAIT_DELIM;
> +				}
> +				bdev->rx_slip_state = SLIP_PACKET;

Same thing here.

> +			} else {
> +				kfree_skb(bdev->rx_skb);
> +				bdev->rx_skb = NULL;
> +				bdev->rx_slip_state = SLIP_WAIT_DELIM;
> +			}
> +			break;
> +		}
> +	}
> +
> +	bdev->hdev->stat.byte_rx += count;
> +
> +	return count;
> +}


Regards,
Jeremy
