Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jun 2010 23:09:24 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Saurabh Thukral <saurabhth@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Inquiry Result with repeated set of MAC addresses - Is it a
 problem with Bluetooth device ?
Message-ID: <20100606150924.GA8474@jh-x301>
References: <AANLkTimX-ofkv4oekES0kfi7l_y4yLMVAO8A9e0Nx5tg@mail.gmail.com>
 <20100606085624.GA393@jh-x301>
 <AANLkTimcKrBh6kVCo1mtZgqxQkPip8xg8ADQhEuFJc82@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimcKrBh6kVCo1mtZgqxQkPip8xg8ADQhEuFJc82@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jun 06, 2010, Saurabh Thukral wrote:
> This behaviour is observed on HP Elitebook using broadcom bluetooth
> adaptor. However when I run the same test on Compaq 510 laptop having
> the same adaptor, only a single Inquiry result is returned and then
> inquiry completes.

Is there any difference between the host operating systems and bluetooth
stacks on these two laptops?

> Please note that this is irrespective of whether there is standard
> inquiry or Inquiry with RSSI.

If you get the behavior for non-RSSI events it sounds like a bug in the
controller.

> I think having multiple inquiry results
> all having same MAC address is wrong for following 2 reasons:
> 
> 1) The procedure of discovery of devices becomes longer
> 
> 2) I programmed getting inquiry result by sending hci_send_cmd and
> then polling on hci socket fd for all the events. Since I would be
> getting multiple events all having result for the same MAC address,
> this creates a burden to weed out all duplicate entries and return one
> entry containing MAC address only. I think this way is wrong.

You're entitled to your opinion and I do understand it to some extent,
but unfortunately I'm not aware of any standard HCI commands or
parameters through which you could make the controller not exhibit this
behavior (the behavior with non-RSSI events seems like a bug in the
controller though). Btw, why not let bluetoothd take care of the
discovery for you? It already has code for detecting duplicate BT
addresses (though it will send multiple D-Bus signals for them in case a
UI is interested in the signal strength variations).

Johan
