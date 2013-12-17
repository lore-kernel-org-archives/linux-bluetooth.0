Return-Path: <cyrus@holtmann.org>
Message-ID: <52B01BA3.3000707@linux.intel.com>
Date: Tue, 17 Dec 2013 11:38:43 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH_v2 2/6] android/pan: Rename connect_cb to bt_io_connect_cb
References: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1387231516-4127-2-git-send-email-ravikumar.veeramally@linux.intel.com> <20131217092750.GA26363@x220.p-661hnu-f1>
In-Reply-To: <20131217092750.GA26363@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 17.12.2013 11:27, Johan Hedberg wrote:
> Hi Ravi,
>
> On Tue, Dec 17, 2013, Ravi kumar Veeramally wrote:
>> Renaming for easy readability.
>> ---
>>   android/pan.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/android/pan.c b/android/pan.c
>> index ec589cf..03db350 100644
>> --- a/android/pan.c
>> +++ b/android/pan.c
>> @@ -162,7 +162,7 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
>>   	dev->io = NULL;
>>   }
>>   
>> -static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
>> +static void bt_io_connect_cb(GIOChannel *chan, GError *err, gpointer data)
>>   {
>>   	struct pan_device *dev = data;
>>   	uint16_t src, dst;
>> @@ -238,7 +238,7 @@ static void bt_pan_connect(const void *buf, uint16_t len)
>>   	ba2str(&dev->dst, addr);
>>   	DBG("connecting to %s %s", addr, dev->iface);
>>   
>> -	dev->io = bt_io_connect(connect_cb, dev, NULL, &gerr,
>> +	dev->io = bt_io_connect(bt_io_connect_cb, dev, NULL, &gerr,
>>   					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
>>   					BT_IO_OPT_DEST_BDADDR, &dev->dst,
>>   					BT_IO_OPT_PSM, BNEP_PSM,
> This might actually cause more confusion since the assumption is that
> bt_io_* prefixed symbols are part of the btio code. The current naming doesn't
> bother me, but if you wanna suggest something else like pan_connected
> I'm fine with that too).
  Ok, ignore this patch, let the same cb name continue.

Ravi.
