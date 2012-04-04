Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Mk10friZJRfRe_ZyuXQcYJbActGTHZr1HEwtc8pQUwjw@mail.gmail.com>
References: <1333458907-28940-1-git-send-email-hemant.gupta@stericsson.com>
	<CAJdJm_Mk10friZJRfRe_ZyuXQcYJbActGTHZr1HEwtc8pQUwjw@mail.gmail.com>
Date: Wed, 4 Apr 2012 17:55:18 +0530
Message-ID: <CACj007nKHwA2NVu2hc9ZGxWmeCamaR8w2m2FqKz5ueRGpSpYsA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Fix packet type for ESCO Link
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Tue, Apr 3, 2012 at 7:20 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Hemant,
>
> On Tue, Apr 3, 2012 at 9:15 AM, Hemant Gupta
> <hemant.gupta@stericsson.com> wrote:
>> This patch fixes the packet type for ESCO Link which was incorrectly
>> set for EDR ESCO Packet Types. Anding esco_type with ~EDR_ESCO_MASK
>> results in loosing information of esco packet type (EDR Packet
>> types are inverted as per BT Spec) that resulted in wrong calculation
>> of packet type in hci_setup_sync() API causing the HCI Setup Synchronous
>> Connection Command to fail.
>>
>> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
>> ---
>>  net/bluetooth/hci_conn.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 947172b..bff6bc1 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -396,7 +396,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>>                        conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
>>                break;
>>        case ESCO_LINK:
>> -               conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
>> +               conn->pkt_type = hdev->esco_type ^ ~EDR_ESCO_MASK;
>
> I don't know ESCO, but using XOR (~MASK) will basically invert all
> bits not set in the mask (and keep those in the mask untouched).
>
> This means even reserved/RFU bits will be set. I suspect this is not desirable.

Thanks for the suggestion, I have updated the patch today. Please have
a look at the same and let me know your comments.
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
