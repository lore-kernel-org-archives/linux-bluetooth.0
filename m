Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Use continuous scanning when creating LE connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8ygH+uLF8gxTY5PW=2CNHNbKxo9VZYOTOBcuUK3ND6pFQ@mail.gmail.com>
Date: Mon, 30 Nov 2015 09:52:28 -0800
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <79FDC25B-B74E-49C8-93BA-8B6D60D89A59@holtmann.org>
References: <1448880520-12810-1-git-send-email-johan.hedberg@gmail.com> <CAD0=r8ygH+uLF8gxTY5PW=2CNHNbKxo9VZYOTOBcuUK3ND6pFQ@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>> All LE connections are now triggered through a preceding passive scan
>> and waiting for a connectable advertising report. This means we've got
>> the best possible guarantee that the device is within range and should
>> be able to request the controller to perform continuous scanning. This
>> way we minimize the risk that we miss out on any advertising packets.
>> 
>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>> ---
>> net/bluetooth/hci_conn.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index e2600213cd50..f28741d78e0b 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -726,8 +726,12 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
>>        if (hci_update_random_address(req, false, &own_addr_type))
>>                return;
>> 
>> +       /* Set interval and window to same value to enable continuous
>> +        * scanning.
>> +        */
>>        cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
>> -       cp.scan_window = cpu_to_le16(hdev->le_scan_window);
>> +       cp.scan_window = cp.scan_interval;
>> +
> So I'm not 100% sure, but I think this code will make classic, or
> interleaved inquiry not report during LE connection establishment.
> When doing interleaved inquiry, depending on HCI_QUIRK_SIMULTANEOUS_DISCOVERY
> we might be doing classic inquiry at same time LE scan is done.
> Filling whole scan window with LE scan
> will cause no time on radio left for classic on some controllers.

that depends on how the controller schedules it. The values are just recommendations and it can always decide to interrupt LE scanning. I assume most controllers will do exactly that since they treat LE scanning as lowest priority.

Also keep in mind that after 2 seconds, the LE create connection attempt will be aborted and it will fall back to normal LE scanning that is not full duty cycle.

Reality is that if you want to connect to a certain device, then you want to connect to it. Period. So everything else is secondary at that point. The only thing a controller should care about is SCO/eSCO connections and ACL links for A2DP and everything else can be handled after the LE connection has been established. Missing an inquiry event is certainly irrelevant.

Regards

Marcel

