Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jul 2015 13:59:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: dogan yazar <doganyazar@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Advertising API, possible to set LE only?
Message-ID: <20150716105937.GA18341@t440s.lan>
References: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi dogan,

On Thu, Jul 16, 2015, dogan yazar wrote:
> In the Advertising API, org.bluez.LEAdvertisement1 has Type field
> which can be "broadcast" or "peripheral".
> When I set it to be peripheral, the outgoing advertisement packets has
> the advertisement flags:
> 0x02 (BLE_GAP_ADV_FLAG_LE_GENERAL_DISC_MODE) and I guess that is why
> when I try to connect the peripheral from my Android, I get a pairing
> request back.
> 
> Is there a way to set BLE_GAP_ADV_FLAG_BR_EDR_NOT_SUPPORTED on the
> flags as well to show I only support LE and so I can also skip the
> pairing requests.

You could try setting ControllerMode=le in the [General] section of
/etc/bluetooth/main.conf and restart bluetoothd. Another option is to
disable BR/EDR manually with btmgmt ("btmgmt bredr off").

Johan
