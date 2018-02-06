Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vincent Petry <pvince81@googlemail.com>
Subject: Re: Apparent bluez 5.48 regression: Headphones fail to reconnect
 after suspend/resume
To: Nathaniel McCallum <npmccallum@redhat.com>,
        Vincent Petry <pvince81@googlemail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d74ae042-eec6-e4bb-45f9-904631fe642b@gmail.com>
 <CABBYNZJ3NfZnM0A3ni=G1kXN4Yt5CeBbV5H0OaRfs8f07BmzAg@mail.gmail.com>
 <88feb93f-928f-9783-7d16-b4b87b402a1a@gmail.com>
 <CAOASepPE0AtSCaMc085eOZdX1X_E7mxxa0a+tcSNc3mGGioMog@mail.gmail.com>
Message-ID: <73597a16-0a96-4d6f-64f5-46a7bb3f983a@gmail.com>
Date: Tue, 6 Feb 2018 07:53:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAOASepPE0AtSCaMc085eOZdX1X_E7mxxa0a+tcSNc3mGGioMog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have bisected bluez between 5.47 (good) and 5.48 (bad) to find the
breaking commit for the headset reconnect issue.

Here are the results:

git bisect start
# bad: [0d1e3b9c5754022c779da129025d493a198d49cf] Release 5.48
git bisect bad 0d1e3b9c5754022c779da129025d493a198d49cf
# good: [d139fd866241fe0d99b5e430f937c8d6160cc7dd] Release 5.47
git bisect good d139fd866241fe0d99b5e430f937c8d6160cc7dd
# bad: [65aaf36f2a36895e4a351ac3fa1cb8da87d4589c] mesh: Correct length
test in agent.c:request_ascii
git bisect bad 65aaf36f2a36895e4a351ac3fa1cb8da87d4589c
# good: [c50a8a397d4abd994a9115230279d5fe922b4aa5] adapter: Add
btd_request_authorization_cable_configured()
git bisect good c50a8a397d4abd994a9115230279d5fe922b4aa5
# bad: [c133489d54cb6d28c3fd308557937acbc5245f5e] battery: Add BT SIG
reserved number used by Battery Service
git bisect bad c133489d54cb6d28c3fd308557937acbc5245f5e
# good: [e577e478e9cb1d1a22e63fd7d8fff07c471590de] gatt: Add
implementation of link option
git bisect good e577e478e9cb1d1a22e63fd7d8fff07c471590de
# bad: [5b9596dac4d0e25c5179be8643726a02c058b00a] advertising: Add
implementation of Duration and Timeout
git bisect bad 5b9596dac4d0e25c5179be8643726a02c058b00a
# bad: [f9a2b1f515c7f5dced80397f4ea891d6c372175d] client: Fix not
detecting advertising instance is no longer valid
git bisect bad f9a2b1f515c7f5dced80397f4ea891d6c372175d
# bad: [d6e9539e31c6bb5afd39ec6f09c518d232e6345d] doc/advertising-api:
Mark LEAdvertisingManager1 stable
git bisect bad d6e9539e31c6bb5afd39ec6f09c518d232e6345d
# good: [10760c91c234fe2bfedf924c9e61f31861c2dc72] gatt: Fix crash while
disconnecting ATT
git bisect good 10760c91c234fe2bfedf924c9e61f31861c2dc72
# first bad commit: [d6e9539e31c6bb5afd39ec6f09c518d232e6345d]
doc/advertising-api: Mark LEAdvertisingManager1 stable

For every step I ran the following script that compiles and install into
the system and then restarts the service, followed by modprobe btusb.
The order is important to simulate hotplug or a return from a suspended
system.

Steps:

1. Run compile script from
https://gist.github.com/PVince81/95d01439490355babd4c405d28a548dc
2. Enable bluetooth in Plasma 5 panel
3. Run bluetoothctl
4. Run "connect" command with headset's address
5. Wait for connect. If it connects, test changing the volume in Plasma
5 which will trigger a pop sound to confirm it works.

Looking at the commit in question I can't tell in what way it is related
to our headset issues. Maybe a bluez expert can help here ? :-)

Please let me know if I can help testing patches.

Cheers,

Vincent


On 02/01/2018 07:36 PM, Nathaniel McCallum wrote:
> I'm seeing this too. My headphones go through a connect/disconnect
> cycle a few times and then quit. Unpairing and repairing does make it
> work.
>
> On Tue, Jan 30, 2018 at 1:47 AM, Vincent Petry <pvince81@googlemail.com> wrote:
>> Hello,
>>
>> On 01/25/2018 07:43 PM, Luiz Augusto von Dentz wrote:
>>> Hi Vincent,
>>>
>>> On Thu, Jan 25, 2018 at 4:44 AM, Vincent Petry <pvince81@googlemail.com> wrote:
>>>> Hello,
>>>>
>>>> I just joined the mailing list so can't directly reply to old messages,
>>>> so sending with same title.
>>>>
>>>> I'm experiencing the same issue as Robert here
>>>> https://www.spinics.net/lists/linux-bluetooth/msg73824.html, happening
>>>> on the same laptop Dell XPS 13 but with different sub-model 9333, but on
>>>> openSUSE Tumbleweed.
>>>>
>>>> It looks like the bluez component is in a wrong state when either
>>>> loading btusb with modprobe later on or resuming from suspend. The
>>>> workaround is to restart the systemd bluetooth daemon. I suspect that
>>>> plugging in USB bluetooth dongles would also have the same issue but I
>>>> don't have one to test.
>>> Does the system have any controller after resume? Does bluetoothctl
>>> report any device at all?
>> After resume from suspend, bluetoothctl sees the controller, yes and it
>> does report my usual three devices from the saved list.
>>
>> When I tell it to connect to the headset (which is turned on), I can
>> hear the headset beep shortly which is the signal for connection, but
>> then it disconnects again:
>> Attempting to connect to E3:XX:XX:XX:XX:XX
>> [CHG] Device E3:XX:XX:XX:XX:XX Connected: yes
>> Failed to connect: org.bluez.Error.Failed
>> [CHG] Device E3:XX:XX:XX:XX:XX Connected: no
>>
>> If I tell it to connect to my bluetooth watch it stays connected.
>>
>> Now I wanted to try accessing characteristics but the command
>> "select-attribute" has gone missing ? I also tried "help gatt" as it
>> seems to be a submenu but it says "Too many argumnets". Possibly another
>> bug in bluez ? (I can send a separate email for this one if you want)
>>
>> Anyway, I have a Python script that uses Dbus and said Python script is
>> able to connect to my watch and talk to it even in this state.
>>
>> So the bluez 5.48 regression seems to be specifically with headsets and
>> also with scanning/discovering. I don't have any other device types to
>> test with.
>>
>> The workaround is to restart the bluetooth service and enable bluetooth
>> afterwards.
>>
>> Please make sure to look at
>> https://bugzilla.suse.com/show_bug.cgi?id=1076898 for logs I posted.
>>
>> If you guys cannot reproduce the first regression I could try and bisect
>> bluez locally to find the breaking change. For this I need to know how
>> to set up bluez on my system after compiling. Is there any guide about
>> this ? Should I tell it to overwrite the existing libs and reboot or is
>> restarting the bluetooth service sufficient to make it use the newly
>> installed version ?
>>
>> Thanks,
>>
>> Vincent
>>
>>>> It used to work correctly before the upgrade from 5.47 to 5.48.
>>>>
>>>> See my original report here for details:
>>>> https://bugzilla.suse.com/show_bug.cgi?id=1076898
>>>> Robert's report https://bugzilla.redhat.com/show_bug.cgi?id=1534857,
>>>> also confirmed by a third person.
>>>>
>>>> Please let us know if this is reproducible on your side or whether it's
>>>> an isolated case specific to our Dell hardware.
>>>>
>>>> Thanks,
>>>>
>>>> Vincent Petry
>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

