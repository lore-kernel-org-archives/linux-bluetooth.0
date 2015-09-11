Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [Patch v3] Bluetooth: remove SCO fragments on connection close
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441901220-548-1-git-send-email-kubax.t.pawlak@intel.com>
Date: Fri, 11 Sep 2015 10:46:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <48B5B7CD-E7FE-4FF9-9DB9-BB67CE99C34D@holtmann.org>
References: <1441901220-548-1-git-send-email-kubax.t.pawlak@intel.com>
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
> contains mostly zeros (muted stream), but setups of over
> 4 seconds were observed.
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
> sane (around 256, 512, 768 ...) is also OK, as these are last
> SCO packets that were assembled and sent up, before connection
> was ended, but were not handled in time.
> 
> This issue may still manifest itself on WilkinsPeak as it sometimes,
> at SCO connection creation, does not send third fragment of first
> SCO packet (#1-#2-#1-#2-#3...). This is a firmware bug and this
> patch does not address it.
> 
> Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
> ---
> drivers/bluetooth/btusb.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 9521b7bcc22d61b7690a928bc09500c883fe5495..95c1455823dd668c1d9a97da352728fb53f27a4e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1277,6 +1277,18 @@ static void btusb_work(struct work_struct *work)
> 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> 			usb_kill_anchored_urbs(&data->isoc_anchor);
> 
> +			/* When isochronous interface settings need to change, because
> +			 * SCO connection was added or removed, a packet fragment may
> +			 * be left in reassembler. It would then be attached to SCO
> +			 * fragments of later SCO connections, in the end creating wrongly
> +			 * reassembled SCO stream with packets of random lengths and handles.
> +			 * Clear outstanding fragment when interface settings change.
> +			 */

I reworded the comment and make it actually fit into 80 chars max per line. After that I applied your patch to bluetooth-next tree.

Regards

Marcel

