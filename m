Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: property changes emited but not captured, why?::
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <57025247.3080709@nomovok.com>
 <CABBYNZ+AxeD1SJ7DV1=FWGT_269nwbpksyXmkseAU-evcdS-RA@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Yunchuan Geng <yunchuan.geng@nomovok.com>
Message-ID: <5702B94A.8020003@nomovok.com>
Date: Mon, 4 Apr 2016 21:58:18 +0300
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+AxeD1SJ7DV1=FWGT_269nwbpksyXmkseAU-evcdS-RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

Thanks for the comments.

The idea is to verify the bluez use case in python. ultimately Qt 
application will be deployed.
I am expecting a notification by signal from bluez about property changes.

What do you means about subscribing to the signal properly? Basically I 
just test what ever
comes with bluez, not modify anything which make change, Only those 
print for debug purpose.

I am trying to add debug message in g_dbus_emit_property_changed 
function to see what
is wrong, but did not found the message printed anywhere(I am using 
ubuntu with self compiled bluez5).

Any suggestion about enable/check debug message in 
g_dbus_emit_property_changed would also help.


Best regards,
Yunchuan

On 04.04.2016 16:04, Luiz Augusto von Dentz wrote:
> Hi Yunchuan,
>
> On Mon, Apr 4, 2016 at 2:38 PM, Yunchuan Geng <yunchuan.geng@nomovok.com> wrote:
>> Hi,
>>
>> I am testing map-client python script from bluez-5.30. Everything works
>> fine, except that I found I can not capture the properties change signal,
>> which I confirmed from log did been emitted from parse_subject function in
>> obexd/client/map.c
>>
>> In order to check if the signal is captured in python script or not, I have
>> patched the script like this. But have not catch any signal the
>> parse_subject
>> function has emitted.
>>
>> Could anyone tell me why and how to correctly capture property changes
>> emitted by g_dbus_emit_property_changed function.
>>
>>
>> Yunchuan
>>
>> =====Patch=====
>> diff --git a/test/map-client b/test/map-client
>> index b9695da..634b91a 100755
>> --- a/test/map-client
>> +++ b/test/map-client
>> @@ -118,6 +119,9 @@ class MapClient:
>>                  mainloop.quit()
>>
>>          def properties_changed(self, interface, properties, invalidated,
>> path):
>> +                print(properties)
>> +                print(interface)
>> +                print(path)
>>                  req = self.props.get(path)
>>                  if req == None:
>>                          return
>>
> Have you tried using obexctl or the idea is to use python? I guess it
> is perhaps not subscribing to the signal properly.
>

