Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APbFYSQBpwy72Niq-d-A8e9TM_vd2SJb1iifAOUzhbzWAA@mail.gmail.com>
References: <CAAu3APbFYSQBpwy72Niq-d-A8e9TM_vd2SJb1iifAOUzhbzWAA@mail.gmail.com>
Date: Wed, 21 Oct 2015 11:31:21 +0300
Message-ID: <CABBYNZL3g+PBxby7BpfAefqGSzJBRmEVo7bve92FVLMKPyQdGA@mail.gmail.com>
Subject: Re: Python reading Eddystone beacons
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Wed, Oct 21, 2015 at 1:26 AM, Barry Byford <31baz66@gmail.com> wrote:
> Hello,
>
> I’m looking to use a Raspberry Pi running the latest Raspbian Jessie operation
> system with Bluez 5.23.
>
> I’m trying to create a workshop for schools to interact with Eddystone
> BLE beacons.
> The workshop will show students the basics of reading the beacon data
> and then it will
> be up to the students to build applications from this using the Python
> programming language.
> The Raspberry Pi allows us to use them as the development platform and
> to run the
> final application also.
> Python is the chosen language as this is what schools seem to be using the most.
>
> The way that I’m currently doing the scanning for the beacon data is
> with this bash
> script:
> #!/bin/bash
> sudo hcitool lescan --duplicates 1>/dev/null &
> trap "sudo kill $!" EXIT
> sudo hcidump --raw
>
> The output is then be parsed with a Python library that would be what
> the students
> called to get the data.
>
> While I’m making some progress with the above shell script it doesn’t seem very
> elegant. It looks like there should be a better way using the D-Bus API.
> I’ve been looking in
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test?id=5.23
> for inspiration but don’t seem to have anything that is showing me the beacon
> advertisement.
>
> Should I be able to get the Eddystone beacon payload using Python with
> the D-Bus API
> in Bluez 5.23?
> Is there a good tutorial/example that I could look at?

bluetoothctl does actually print the advertising data:

[bluetooth]# scan on
Discovery started
[CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes
[CHG] Device XX:XX:XX:XX:XX:XX RSSI: -34
[CHG] Device XX:XX:XX:XX:XX:XX Name: Test beacon
[CHG] Device XX:XX:XX:XX:XX:XX Alias: Test beacon
[CHG] Device XX:XX:XX:XX:XX:XX ServiceData Key: fed8
[CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x00
[CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x20
[CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x02
[CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x30
[CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x31
[CHG] Device XX:XX:XX:XX:XX:XX ServiceData Value: 0x08

It is basically using the properties ServiceData and ManufacturerData:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/device-api.txt

With this all you need to do is to listen for PropertiesChanged and
decode the values, it would probably be good idea to have a python
sample of decoding eddystone beacons, or beacons in general.


-- 
Luiz Augusto von Dentz
