Return-Path: <cyrus@holtmann.org>
Message-ID: <4C4B152A.5050003@Atheros.com>
Date: Sat, 24 Jul 2010 22:00:34 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "Gustavo F. Padovan"
	<padovan@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: Use hci_recv_stream_fragment() in UART driver
References: <1279946817-18060-1-git-send-email-gustavo@padovan.org> <20100724044856.GB9787@vigoh>
In-Reply-To: <20100724044856.GB9787@vigoh>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 7/24/2010 10:18 AM, Gustavo F. Padovan wrote:
> * Gustavo F. Padovan<gustavo@padovan.org>  [2010-07-24 01:46:57 -0300]:
>
>> From: Gustavo F. Padovan<padovan@profusion.mobi>
>>
>> Use the new hci_recv_stream_fragment() to reassembly incoming UART
>> streams.
>>
>> Signed-off-by: Gustavo F. Padovan<padovan@profusion.mobi>
>> ---
>>   drivers/bluetooth/hci_h4.c |  103 +-------------------------------------------
>>   1 files changed, 2 insertions(+), 101 deletions(-)
>>
>
> Please, can someone test this code? I don't have such UART hardware to
> make sure that this patch is working.
>

I have tested the reassembly code on HCI_ATH3K driver. But, It would be 
great if someone can verify it on a different serial Bluetooth controller.

Regards
Suraj
