Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100606085624.GA393@jh-x301>
References: <AANLkTimX-ofkv4oekES0kfi7l_y4yLMVAO8A9e0Nx5tg@mail.gmail.com>
	<20100606085624.GA393@jh-x301>
Date: Sun, 6 Jun 2010 19:36:46 +0530
Message-ID: <AANLkTimcKrBh6kVCo1mtZgqxQkPip8xg8ADQhEuFJc82@mail.gmail.com>
Subject: Re: Inquiry Result with repeated set of MAC addresses - Is it a
	problem with Bluetooth device ?
From: Saurabh Thukral <saurabhth@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Saurabh Wrote:
>> The observation is that suppose a device(Nokia N73) with MAC address
>> M1 is discoverable, the response to Inquiry Request command is often a
>> set of multiple Inquiry Result each with the same MAC address M1.
>>
>> I had expected that only one Inquiry result with MAC address M1 should
>> have been returned. But here what we find is that multiple such
>> results with the same MAC address are returned.
>>

Johan Wrote:
>
> It's most likely neither, but simply as it's intended to be. I presume
> the inquiry results contain the RSSI which will most likely be different
> in each event. The purpose of the multiple events is to give you updates
> if the signal strength to the device changes.

This behaviour is observed on HP Elitebook using broadcom bluetooth
adaptor. However when I run the same test on Compaq 510 laptop having
the same adaptor, only a single Inquiry result is returned and then
inquiry completes.

Please note that this is irrespective of whether there is standard
inquiry or Inquiry with RSSI. I think having multiple inquiry results
all having same MAC address is wrong for following 2 reasons:

1) The procedure of discovery of devices becomes longer

2) I programmed getting inquiry result by sending hci_send_cmd and
then polling on hci socket fd for all the events. Since I would be
getting multiple events all having result for the same MAC address,
this creates a burden to weed out all duplicate entries and return one
entry containing MAC address only. I think this way is wrong.


-- 
Regards,
Saurabh Thukral
