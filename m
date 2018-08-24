Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 24 Aug 2018 16:11:26 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, mka@chromium.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_qca: Add poweroff support during
 hci down for wcn3990
In-Reply-To: <153509324560.28926.8058929411568681471@swboyd.mtv.corp.google.com>
References: <20180823112935.17342-1-bgodavar@codeaurora.org>
 <20180823112935.17342-2-bgodavar@codeaurora.org>
 <153509324560.28926.8058929411568681471@swboyd.mtv.corp.google.com>
Message-ID: <2c9dd1f73c513a676738a47dd65ffce8@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stephen,

On 2018-08-24 12:17, Stephen Boyd wrote:
> Quoting Balakrishna Godavarthi (2018-08-23 04:29:35)
>> This patch enables power off support for hci down and power on support
>> for hci up. As wcn3990 power sources are ignited by regulators, we 
>> will
>> turn off them during hci down, i.e. an complete power off of wcn3990.
>> So while hci up, we will call vendor specific open/close and setup 
>> which
>> will turn on the regulators, requests BT chip version and download the
>> firmware.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index e182f6019f68..98d33c6b8909 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -595,6 +595,9 @@ static int qca_close(struct hci_uart *hu)
>>         struct qca_serdev *qcadev;
>>         struct qca_data *qca = hu->priv;
>> 
>> +       if (!qca)
>> +               return 0;
> 
> Does this happen? If it does it seems like a failure in the caller to
> know what's going on.

[Bala]: yes qca_close() function will execute twice i.e. when we remove 
the BT module.

         while we remove the module,hci_dev_doc_close() will call 
hdev->close() i.e. hci_uart_close() which is Qualcomm specific close.
         in hci_uart_close() we will call qca_close() which will free the 
memory.
         after that proto close will also call qca_close().
         Here hci_uart_close and proto close are assigned to same 
function pointer i.e. qca_close().

-- 
Regards
Balakrishna.
