Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL3g+PBxby7BpfAefqGSzJBRmEVo7bve92FVLMKPyQdGA@mail.gmail.com>
References: <CAAu3APbFYSQBpwy72Niq-d-A8e9TM_vd2SJb1iifAOUzhbzWAA@mail.gmail.com>
	<CABBYNZL3g+PBxby7BpfAefqGSzJBRmEVo7bve92FVLMKPyQdGA@mail.gmail.com>
Date: Thu, 22 Oct 2015 13:47:03 +0100
Message-ID: <CAAu3APYJ+ro+aC6L7CCCxvg9rBtQAwewt_=ufvSuf6FGq+0c2g@mail.gmail.com>
Subject: Re: Python reading Eddystone beacons
From: Barry Byford <31baz66@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On 21 October 2015 at 09:31, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> On Wed, Oct 21, 2015 at 1:26 AM, Barry Byford <31baz66@gmail.com> wrote:
>> I’m looking to use a Raspberry Pi running the latest Raspbian Jessie operation
>> system with Bluez 5.23.
>> The way that I’m currently doing the scanning for the beacon data is
>> with this bash
>> script:
>> #!/bin/bash
>> sudo hcitool lescan --duplicates 1>/dev/null &
>> trap "sudo kill $!" EXIT
>> sudo hcidump --raw
>>
>> Should I be able to get the Eddystone beacon payload using Python with
>> the D-Bus API
>> in Bluez 5.23?
>> Is there a good tutorial/example that I could look at?
>
> bluetoothctl does actually print the advertising data:
>
> [bluetooth]# scan on
> Discovery started
> [CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes
> [CHG] Device XX:XX:XX:XX:XX:XX RSSI: -34
> [CHG] Device XX:XX:XX:XX:XX:XX Name: Test beacon
> [CHG] Device XX:XX:XX:XX:XX:XX Alias: Test beacon
> [CHG] Device XX:XX:XX:XX:XX:XX ServiceData Key: fed8
> [CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x00
> [CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x20
> [CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x02
> [CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x30
> [CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x31
> [CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x08

Thanks for pointing me in the direction of bluetoothctl. However I'm
not getting my beacon advertising data out with bluetoothctl.
It reports things like my phone that is waiting to be paired but no beacons.

What is the best way to get debug information out?.


> It is basically using the properties ServiceData and ManufacturerData:
>
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/device-api.txt
>
> With this all you need to do is to listen for PropertiesChanged and
> decode the values,
I will get the bluetoothctl working before looking at this but thanks for
the information this was what I was looking for.

> it would probably be good idea to have a python
> sample of decoding eddystone beacons, or beacons in general.
I would certainly find it helpful. :-)

Thanks,
Barry
