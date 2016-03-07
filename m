Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGN7-kDF6GzLYpx0tsXXiEnq1W2zCVEo2am9PX8a7Hdm=w@mail.gmail.com>
References: <CAEZxfGPvzMVj++anQKY_6RREvmyT-vBnWqYpRiHJVvKKKb3YsQ@mail.gmail.com>
 <CABBYNZK35diyf=VMGikSJ79+qR=8F5adLt=ddkaOPv3f2x-Ksg@mail.gmail.com>
 <CAEZxfGPZOj+uHQde5Lzb3G9HyF-vvDR8R29BatccKkOMkcwGSg@mail.gmail.com> <CAEZxfGN7-kDF6GzLYpx0tsXXiEnq1W2zCVEo2am9PX8a7Hdm=w@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 7 Mar 2016 16:36:25 +0100
Message-ID: <CAEZxfGM7mpnCP8tM9Mr1OR3EVG_0RoNCCrR+Wv593E0ZQCNM7g@mail.gmail.com>
Subject: Re: Write should return error if device is disconnected while
 expecting a response
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

(gentle ping)

On Thu, Mar 3, 2016 at 10:46 AM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> Since I'm expecting a response and device gets disconnected, I should
> get a write error don't you think?
>
> On Wed, Mar 2, 2016 at 4:19 PM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
>> It does:
>>
>> [DFU_Test:/service000c/char000d]# write 01 04
>> Attempting to write /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service000c/char000d
>> [CHG] Device F1:6F:DE:EC:F1:D6 Connected: no
>> [CHG] Device F1:6F:DE:EC:F1:D6 Connected: yes
>> [CHG] Device F1:6F:DE:EC:F1:D6 Name: DfuTarg
>> [CHG] Device F1:6F:DE:EC:F1:D6 Alias: DfuTarg
>>
>> On Wed, Mar 2, 2016 at 2:31 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi François,
>>>
>>> On Wed, Mar 2, 2016 at 9:31 AM, François Beaufort
>>> <beaufort.francois@gmail.com> wrote:
>>>> When writing to a characteristic and that a disconnection happens
>>>> before getting a write (error) response, BlueZ should inform that
>>>> write operation failed.
>>>> See my real example logs below:
>>>>
>>>> [DFU_Test:/service000c/char000d]# write 01 04
>>>> Attempting to write /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service000c/char000d
>>>>
>>>>
>>>>
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 9
>>>>                                                    [hci0] 5.066808
>>>>       ATT: Write Request (0x12) len 4
>>>>         Handle: 0x000e
>>>>           Data: 0104
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5                                                                    [hci0] 5.106370
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> HCI Event: Vendor (0xff) plen 7                                                                                         [hci0] 5.579396
>>>>         82 12 95 40 10 36 59                             ...@.6Y
>>>>> HCI Event: Disconnect Complete (0x05) plen 4                                                                            [hci0] 5.580376
>>>>         Status: Success (0x00)
>>>>         Handle: 32
>>>>         Reason: Connection Timeout (0x08)
>>>> @ Device Disconnected: F1:6F:DE:EC:F1:D6 (2) reason 1
>>>
>>> Interesting, does bluetoothctl print anything after this?
>>>
>>> --
>>> Luiz Augusto von Dentz
