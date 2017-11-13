Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] client: Add set-advertise-{duration, timeout}
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20171102144352.32353-1-luiz.dentz@gmail.com>
 <20171102144352.32353-3-luiz.dentz@gmail.com>
 <93ffd973-dcb0-8d19-dc12-8f959911d127@jp.fujitsu.com>
 <CABBYNZLEkD5CdfqJP4PvPuM5EzM97+4nS6TJ9zFtSmxKe6Q-dQ@mail.gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <01566c37-896a-f5ee-ed94-9dca9f6539c6@jp.fujitsu.com>
Date: Mon, 13 Nov 2017 14:15:54 +0900
MIME-Version: 1.0
In-Reply-To: <CABBYNZLEkD5CdfqJP4PvPuM5EzM97+4nS6TJ9zFtSmxKe6Q-dQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thank you for your help.
I hit this problem because my bluetooth.conf was old.

Regards,
Eramoto

On 11/10/2017 09:06 PM, Luiz Augusto von Dentz wrote:
> Hi Eramoto,
> 
> On Fri, Nov 10, 2017 at 8:40 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> Hi Luiz,
>>
>> With the latest bluez master branch, when sets a advertise timeout and
>> times out, bluetoothctl fails to run "advertise off" as below:
>>
>>   [bluetooth]# set-advertise-duration 4
>>   [bluetooth]# set-advertise-timeout 4
>>   [bluetooth]# advertise on
>>   [CHG] Controller 00:09:DD:40:CA:12 SupportedInstances: 0x04
>>   [CHG] Controller 00:09:DD:40:CA:12 ActiveInstances: 0x01
>>   Advertising object registered
>>   [CHG] Controller 00:09:DD:40:CA:12 SupportedInstances: 0x05
>>   [CHG] Controller 00:09:DD:40:CA:12 ActiveInstances: 0x00
>>   [bluetooth]# advertise off
>>   Failed to unregister advertisement: org.bluez.Error.DoesNotExist
> 
> In order for bluetoothd to call Release method you will need to update
> the bluetooth.conf D-Bus policy, without that the client has no idea
> when the its instance is removed due to timeout causing the problem
> above.
> 
>>
>> Regards,
>> Eramoto
>>
>> On 11/02/2017 11:43 PM, Luiz Augusto von Dentz wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> This adds the following command which can be used to control the
>>> advertisement intervals:
>>>
>>> [bluetooth]# set-advertise-duration 4
>>> [bluetooth]# set-advertise-timeout 4
>>> [bluetooth]# advertise on
>>> [CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x04
>>> [CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x01
>>> Advertising object registered
>>> [CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x05
>>> [CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x00
>>> ---
>>>  client/advertising.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  client/advertising.h |  2 ++
>>>  client/main.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 94 insertions(+)
>>
> 
> 
> 

