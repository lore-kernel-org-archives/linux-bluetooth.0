Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: remove SCO fragments on connection close
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441807855-17685-1-git-send-email-kubax.t.pawlak@intel.com>
Date: Wed, 9 Sep 2015 08:43:39 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F7522D07-B358-4BC4-A93A-E569F74614FF@holtmann.org>
References: <1441807855-17685-1-git-send-email-kubax.t.pawlak@intel.com>
To: Kuba Pawlak <kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kuba,

> SCO packet reassembler may have a fragment of SCO packet, from
> previous connection, cached and not removed when SCO connection
> is ended. Packets from new SCO connection are then going to be
> attached to that fragment, creating an invalid SCO packets.
> 
> Controllers like Intel's WilkinsPeak are always fragmenting
> SCO packet into 3 parts (#1, #2, #3). Packet #1 contains
> SCO header and audio data, others just audio data. if there is
> a fragment cached from previous connection, i.e. #1, first
> SCO packet from new connection is going to be attached to it
> creating packet consisting of fragments #1-#1-#2. This will
> be forwarded to upper layers. After that, fragment #3 is going
> to be used as a starting point for another SCO packet.
> It does not contain a SCO header, but the code expects it,
> casts a SCO header structure on it, and reads whatever audio
> data happens to be there as SCO packet length and handle.
> From that point on, we are assembling random data into SCO
> packets. Usually it recovers quickly as initial audio data
> usually contains mostly zeros (muted stream), but setups
> of over 4 seconds were observed.
> Issue manifests itself by printing on the console:
> Bluetooth: hci0 SCO packet for unknown connection handle 48
> Bluetooth: hci0 SCO packet for unknown connection handle 2560
> Bluetooth: hci0 SCO packet for unknown connection handle 12288
> It may also show random handles if audio data was non-zeroed.
> Hcidump shows SCO packets with random length and handles.
> 
> Few messages with handle 0 at connection creation are OK
> for some controllers (like WilkinsPeak), as there are SCO packets
> with zeroed handle at the beginning (possible controller bug).
> Few of such messages at connection end, with a handle looking
> OK (around 256, 512, 768 ...) is also OK, as these are last
> SCO packets that were assembled and sent up, before connection
> was broken, but were not handled in time.
> 
> Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
> ---
> drivers/bluetooth/btusb.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 9521b7bcc22d61b7690a928bc09500c883fe5495..e712be14cd745bf32149bee037d727c2fed2fcef 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -516,6 +516,18 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> 	return err;
> }
> 
> +static int btusb_remove_sco_fragment(struct btusb_data *data)
> +{
> +	int err = 0;
> +
> +	spin_lock(&data->rxlock);
> +	kfree_skb(data->sco_skb);
> +	data->sco_skb = NULL;
> +	spin_unlock(&data->rxlock);
> +
> +	return err;
> +}
> +
> static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
> {
> 	struct sk_buff *skb;
> @@ -777,6 +789,7 @@ static void btusb_isoc_complete(struct urb *urb)
> 			}
> 		}
> 	} else if (urb->status == -ENOENT) {
> +		btusb_remove_sco_fragment(data);
> 		/* Avoid suspend failed when usb_kill_urb */
> 		return;
> 	}

I think we need to check Documentation/usb/error-codes.txt since I wonder if we have more than just one error code that would need to trigger this behavior.

So in general this is the suspend case. And in theory SCO packets could survive SCO packets. So while in practice on suspend the SCO connection will go down, I think this is fixing the symptom and not the issue here.

What we should be looking into instead is the btusb_notify function that gets called from the core when new connections are established or voice settings are changed.

This reminds me that the schedule_work in that function should no longer be needed since we can now sleep in the btusb_notify callback. You might want to look into changing this to make the btusb code a lot simpler.

Without looking to deeply into this, it seems that this situation is when you want to reset the sco_skb:

                if (data->isoc_altsetting != new_alts) {                         
                        clear_bit(BTUSB_ISOC_RUNNING, &data->flags);             
                        usb_kill_anchored_urbs(&data->isoc_anchor);              

                        /* Add appropriate comment here explaining why */
                        spin_lock(&data->rxlock);
                        kfree_skb(data->sco_skb);
                        data->sco_skb = NULL;
                        spin_unlock(&data->rxlock);
                                                                                 
                        if (__set_isoc_interface(hdev, new_alts) < 0)            
                                return;                                          
                }

Regards

Marcel

