Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <7642C481-01E5-430D-ACAC-CBB0FA47F595@holtmann.org>
References: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1530876944-17453-7-git-send-email-jaganathx.kanakkassery@intel.com> <7642C481-01E5-430D-ACAC-CBB0FA47F595@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Mon, 9 Jul 2018 10:36:59 +0530
Message-ID: <CAJzH+brebETANST+fxiNKpo+h34oYL1z6SKQZtAGNg+3D-RXkw@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] Bluetooth: Define PHY flags in hdev and set 1M
 as default
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jul 7, 2018 at 2:26 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaganath,
>
>> 1M is mandatory to be supported by LE controllers and the same
>> would be set in power on. This patch defines hdev flags for
>> LE PHYs and set 1M to default.
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
>> ---
>> include/net/bluetooth/hci.h | 7 +++++++
>> net/bluetooth/hci_core.c    | 4 ++++
>> 2 files changed, 11 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 73e48be..1b5d79b 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -261,6 +261,13 @@ enum {
>>       HCI_FORCE_BREDR_SMP,
>>       HCI_FORCE_STATIC_ADDR,
>>
>> +     HCI_LE_PHY_1M_TX,
>> +     HCI_LE_PHY_1M_RX,
>> +     HCI_LE_PHY_2M_TX,
>> +     HCI_LE_PHY_2M_RX,
>> +     HCI_LE_PHY_CODED_TX,
>> +     HCI_LE_PHY_CODED_RX,
>> +
>>       __HCI_NUM_FLAGS,
>> };
>
> so first of all, these are not yet defined as of patch 05/18 and I am not sure that using flags is the best choice here. You need to provide some reasoning why you did it this way.
>
I did it this way as i took it as current LE controller PHY state.
But maintaining tx_def_phys and rx_def_phys in hdev seems to be better here.
I will modify patch if you are Ok with it.

Thanks,
Jaganath
