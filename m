Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYMP7YRu1=P4Uf9T_RfOKQFPvZq8sK+GGi0T1jB6GDXcDQ@mail.gmail.com>
References: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
	<CACUGKYPwTxRS8JN78J-oPSwz0mhnKvxHg=ybm5vyiKivEpM03A@mail.gmail.com>
	<20120910235838.GA26986@samus>
	<CACUGKYMP7YRu1=P4Uf9T_RfOKQFPvZq8sK+GGi0T1jB6GDXcDQ@mail.gmail.com>
Date: Wed, 12 Sep 2012 19:52:36 -0700
Message-ID: <CACUGKYN-+AKvVOZwxR7b6cvSujBMRHnjzNGcGezYynP2gTm6KA@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: John Tobias <john.tobias.ph@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello again,

I enabled the GATT in my bluetoothd and found out that there was an
unimplemented attribute (below) and might be the reason why the iPhone
connection got disconnected after 30 secs.

2012-09-12 15:36:55.419980 > ACL data: handle 76 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Type req (0x08) on handle 0x0039

I would like to know if anyone here has a patch?.

Regards,

john


On Mon, Sep 10, 2012 at 5:45 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> thanks for the info.
>
> Regards,
>
> john
>
> On Mon, Sep 10, 2012 at 4:58 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
>> Hi John,
>>
>> On 16:34 Mon 10 Sep, John Tobias wrote:
>>> Just to follow up, I used hcidump and found out an interesting info:
>>>
>>>     bdaddr 5C:35:3C:72:B2:AF type 1
>>> > HCI Event: Command Status (0x0f) plen 4
>>>     LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
>>> > HCI Event: LE Meta Event (0x3e) plen 19
>>>     LE Connection Complete
>>>       status 0x00 handle 77, role master
>>>       bdaddr 5C:35:3C:72:B2:AF (Random)
>>> > ACL data: handle 77 flags 0x02 dlen 11
>>>     ATT: Read By Type req (0x08)
>>>       start 0x0001, end 0xffff
>>>       type-uuid 0x2a00
>>> > HCI Event: Disconn Complete (0x05) plen 4
>>>     status 0x00 handle 77 reason 0x13
>>>     Reason: Remote User Terminated Connection
>>>
>>>
>>> The iPhone was requesting for "ATT: Read By Type req (0x08)" and the
>>> gatttool seems not reponding. So, after 30 secs the iPhone dropped the
>>> connection.
>>>
>>> Any idea how the gatttool could respond to the said request?.
>>
>> The problem is that gatttool still hasn't any support for sending
>> responses. bluetoothd has, if you enable GATT support, 'EnableGatt' in
>> '/etc/bluetooth/main.conf' (usual location).
>>
>> But using 'bluetoothd' means that will need to use the D-Bus API, which
>> makes me wonder that having a simple GATT server inside gatttool makes
>> some sense, for some use cases.
>>
>>>
>>> Regards,
>>>
>>> john
>>>
>>>
>>> On Mon, Sep 10, 2012 at 2:35 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>>> > Hello Guys,
>>> >
>>> > I am using pandaboard with USB BLE dongle and an apps in iPhone that
>>> > do the advertising. I was able to connect to the said device from my
>>> > pandaboard using the following commands:
>>> >
>>> > gatttool -i hci1 -m 27 -I -b 74:xx:xx:xx:xx:xx
>>> > connect
>>> >
>>> > But, I've noticed that after 30 secs, the iPhone dropped off the
>>> > connection. I am just wondering if anyone here have tried playing with
>>> > the iPhone using the ble connection?.
>>> >
>>> > Regards,
>>> >
>>> > John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> Cheers,
>> --
>> Vinicius
