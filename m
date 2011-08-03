Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110803175810.GC28119@joana>
References: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
 <1312310109-27082-2-git-send-email-anderson.briglia@openbossa.org> <20110803175810.GC28119@joana>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Wed, 3 Aug 2011 14:04:41 -0400
Message-ID: <CALJ2SBJuP5Rk9CCCtT9sim=NOLYy5bfYHZ2gdrHo86S1ceH23w@mail.gmail.com>
Subject: Re: [RFC 1/7] Bluetooth: Add RSSI Monitor commands
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Padovan,

On Wed, Aug 3, 2011 at 1:58 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> Hi Briglia,
>
> * Anderson Briglia <anderson.briglia@openbossa.org> [2011-08-02 14:35:03 -0400]:
>
>> This patch adds two new Management commands: Enable/Disable RSSI
>> Monitor. This command is used to handle a list of monitors in order to
>> monitor the RSSI value of a connection. It is useful on Proximity
>> profile implementation.
>>
>> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
>> ---
>>  include/net/bluetooth/mgmt.h |   12 ++++++++++++
>>  net/bluetooth/mgmt.c         |   22 ++++++++++++++++++++++
>>  2 files changed, 34 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index 5428fd3..ef3b636 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -211,6 +211,18 @@ struct mgmt_cp_unblock_device {
>>       bdaddr_t bdaddr;
>>  } __packed;
>>
>> +#define MGMT_OP_ENABLE_RSSI_MONITOR  0x001F
>> +struct mgmt_cp_enable_rssi_monitor {
>> +     bdaddr_t bdaddr;
>> +     __s8 low_alert_trigger;
>> +     __s8 high_alert_trigger;
>> +} __packed;
>> +
>> +#define MGMT_OP_DISABLE_RSSI_MONITOR 0x0020
>> +struct mgmt_cp_disable_rssi_monitor {
>> +     bdaddr_t bdaddr;
>> +} __packed;
>> +
>
> Make much more sense to me call this ADD/REMOVE. We add an rssi monitor to the
> list and then remove it from the list.
>

Actually it depends. From the userspace point of view, there is no
list to add or remove elements. The user/application just enable or
disable the RSSI monitoring for a connection. But, I can't see
problems in changing the commands names if you prefer.

>        Gustavo
>



-- 
INdT - Instituto Nokia de tecnologia
+55 92 2126 1122
+55 92 8423 3183
