Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <D2DE79F2.1BDF6%adam.moore@savant.com>
References: <CAAu3APaeS_7xnuTW_JgdJKkAcfY1x4zU=3VxTkSHqEZYsSkY_A@mail.gmail.com>
	<CABBYNZJT5=LMZHecjKYJNVvMn-F4LgJuanqRv6Xoy2sCmsH5qA@mail.gmail.com>
	<CAAu3APagY3WKx=9kjHx7oAtOhy1b_cPiJ-HAgvzCPmFPbanodw@mail.gmail.com>
	<D2DE79F2.1BDF6%adam.moore@savant.com>
Date: Tue, 9 Feb 2016 08:00:52 +0000
Message-ID: <CAAu3APbwKOBrWbqjrWJ9oCJ_tzNHau9ne4A36_MQgcbsyB30cQ@mail.gmail.com>
Subject: Re: Error 133 (0x85): GATT ERROR
From: Barry Byford <31baz66@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On 9 February 2016 at 01:12, Adam Moore <adam.moore@savantsystems.com> wrote:
> Hi Barry,
>
>
> On 2/8/16, 2:08 PM, "linux-bluetooth-owner@vger.kernel.org on behalf of
> Barry Byford" <linux-bluetooth-owner@vger.kernel.org on behalf of
> 31baz66@gmail.com> wrote:
>
>>Hello Luiz,
>>
>>On 8 February 2016 at 10:13, Luiz Augusto von Dentz
>><luiz.dentz@gmail.com> wrote:
>>> Hi Barry,
>>>
>>> On Sat, Feb 6, 2016 at 10:30 PM, Barry Byford <31baz66@gmail.com> wrote:
>>>> Hello,
>>[snip]
>>>> The code I have running can be found at:
>>>>
>>>>https://github.com/ukBaz/python-bluezero/blob/master/examples/battery_se
>>>>rvice.py
>>[snip]
>>>> On the Nordic nRF Master Control Panel (BLE) app I can see in the log
>>>> 'Error 133 (0x85): GATT ERROR)'
>>[snip]
>>> Perhaps if you can take the HCI and bluetoothd it should help to see
>>> where is the problem. Btw, it could be that Android is attempting to
>>> connect over BR/EDR or did you configure your adapter to as BLE only?
>>
>>If I do a hcidump when I try to connect from my phone I get the following:
>>
>>- HCI Event: Connect Request (0x04) plen 10
>>    bdaddr xx:xx:xx:xx:xx:xx class 0x5a020c type ACL
>>- HCI Event: Command Status (0x0f) plen 4
>>    Reject Connection Request (0x01|0x000a) status 0x00 ncmd 1
>>- HCI Event: Connect Complete (0x03) plen 11
>>    status 0x0f handle 65 bdaddr xx:xx:xx:xx:xx:xx type ACL encrypt 0x00
>>    Error: Connection Rejected due to Unacceptable BD_ADDR
>>
>>According to my phone the code on the Raspberry Pi is advertising with
>>only the 'LE General Discoverable Mode' flag set. The 'BR/EDR not
>>Supported' is not set.
>>I've looked at the DBus API documentation again and it is not obvious
>>that I can change this setting on the advertisement. Am I missing
>>something?
>
> Have you tried setting ControllerMode = le in bluez¹s main.conf?  If set,
> bluetoothd will explicitly enable le and disable br/edr in the kernel via
> the management interface, and that should set advertising flags
> appropriately.  There does not appear to be a DBus API, probably because
> this is more of a static setting.

Thanks for the suggestion. I've added that setting to the
/etc/bluetooth/main.conf and when the Raspberry Pi advertises it now
has the 'BR/EDR Not supported' flag set.
Now when I try to connect from my phone it fails with the same error
message on my phone although in the hcidump and bluetoothd logs
nothing appears when the phone tries to connect.

Thanks again for the suggestion.

Regards,
Barry
