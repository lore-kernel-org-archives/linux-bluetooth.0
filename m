Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <93ffd973-dcb0-8d19-dc12-8f959911d127@jp.fujitsu.com>
References: <20171102144352.32353-1-luiz.dentz@gmail.com> <20171102144352.32353-3-luiz.dentz@gmail.com>
 <93ffd973-dcb0-8d19-dc12-8f959911d127@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Nov 2017 14:06:46 +0200
Message-ID: <CABBYNZLEkD5CdfqJP4PvPuM5EzM97+4nS6TJ9zFtSmxKe6Q-dQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] client: Add set-advertise-{duration, timeout}
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Fri, Nov 10, 2017 at 8:40 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Luiz,
>
> With the latest bluez master branch, when sets a advertise timeout and
> times out, bluetoothctl fails to run "advertise off" as below:
>
>   [bluetooth]# set-advertise-duration 4
>   [bluetooth]# set-advertise-timeout 4
>   [bluetooth]# advertise on
>   [CHG] Controller 00:09:DD:40:CA:12 SupportedInstances: 0x04
>   [CHG] Controller 00:09:DD:40:CA:12 ActiveInstances: 0x01
>   Advertising object registered
>   [CHG] Controller 00:09:DD:40:CA:12 SupportedInstances: 0x05
>   [CHG] Controller 00:09:DD:40:CA:12 ActiveInstances: 0x00
>   [bluetooth]# advertise off
>   Failed to unregister advertisement: org.bluez.Error.DoesNotExist

In order for bluetoothd to call Release method you will need to update
the bluetooth.conf D-Bus policy, without that the client has no idea
when the its instance is removed due to timeout causing the problem
above.

>
> Regards,
> Eramoto
>
> On 11/02/2017 11:43 PM, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds the following command which can be used to control the
>> advertisement intervals:
>>
>> [bluetooth]# set-advertise-duration 4
>> [bluetooth]# set-advertise-timeout 4
>> [bluetooth]# advertise on
>> [CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x04
>> [CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x01
>> Advertising object registered
>> [CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x05
>> [CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x00
>> ---
>>  client/advertising.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  client/advertising.h |  2 ++
>>  client/main.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 94 insertions(+)
>



-- 
Luiz Augusto von Dentz
