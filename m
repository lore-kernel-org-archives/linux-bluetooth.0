Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vincent Petry <pvince81@googlemail.com>
Subject: Re: Apparent bluez 5.48 regression: Headphones fail to reconnect
 after suspend/resume
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Vincent Petry <pvince81@googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d74ae042-eec6-e4bb-45f9-904631fe642b@gmail.com>
 <CABBYNZJ3NfZnM0A3ni=G1kXN4Yt5CeBbV5H0OaRfs8f07BmzAg@mail.gmail.com>
Message-ID: <88feb93f-928f-9783-7d16-b4b87b402a1a@gmail.com>
Date: Tue, 30 Jan 2018 07:47:24 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ3NfZnM0A3ni=G1kXN4Yt5CeBbV5H0OaRfs8f07BmzAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On 01/25/2018 07:43 PM, Luiz Augusto von Dentz wrote:
> Hi Vincent,
>
> On Thu, Jan 25, 2018 at 4:44 AM, Vincent Petry <pvince81@googlemail.com> wrote:
>> Hello,
>>
>> I just joined the mailing list so can't directly reply to old messages,
>> so sending with same title.
>>
>> I'm experiencing the same issue as Robert here
>> https://www.spinics.net/lists/linux-bluetooth/msg73824.html, happening
>> on the same laptop Dell XPS 13 but with different sub-model 9333, but on
>> openSUSE Tumbleweed.
>>
>> It looks like the bluez component is in a wrong state when either
>> loading btusb with modprobe later on or resuming from suspend. The
>> workaround is to restart the systemd bluetooth daemon. I suspect that
>> plugging in USB bluetooth dongles would also have the same issue but I
>> don't have one to test.
> Does the system have any controller after resume? Does bluetoothctl
> report any device at all?
After resume from suspend, bluetoothctl sees the controller, yes and it
does report my usual three devices from the saved list.

When I tell it to connect to the headset (which is turned on), I can
hear the headset beep shortly which is the signal for connection, but
then it disconnects again:
Attempting to connect to E3:XX:XX:XX:XX:XX
[CHG] Device E3:XX:XX:XX:XX:XX Connected: yes
Failed to connect: org.bluez.Error.Failed
[CHG] Device E3:XX:XX:XX:XX:XX Connected: no

If I tell it to connect to my bluetooth watch it stays connected.

Now I wanted to try accessing characteristics but the command
"select-attribute" has gone missing ? I also tried "help gatt" as it
seems to be a submenu but it says "Too many argumnets". Possibly another
bug in bluez ? (I can send a separate email for this one if you want)

Anyway, I have a Python script that uses Dbus and said Python script is
able to connect to my watch and talk to it even in this state.

So the bluez 5.48 regression seems to be specifically with headsets and
also with scanning/discovering. I don't have any other device types to
test with.

The workaround is to restart the bluetooth service and enable bluetooth
afterwards.

Please make sure to look at
https://bugzilla.suse.com/show_bug.cgi?id=1076898 for logs I posted.

If you guys cannot reproduce the first regression I could try and bisect
bluez locally to find the breaking change. For this I need to know how
to set up bluez on my system after compiling. Is there any guide about
this ? Should I tell it to overwrite the existing libs and reboot or is
restarting the bluetooth service sufficient to make it use the newly
installed version ?

Thanks,

Vincent

>> It used to work correctly before the upgrade from 5.47 to 5.48.
>>
>> See my original report here for details:
>> https://bugzilla.suse.com/show_bug.cgi?id=1076898
>> Robert's report https://bugzilla.redhat.com/show_bug.cgi?id=1534857,
>> also confirmed by a third person.
>>
>> Please let us know if this is reproducible on your side or whether it's
>> an isolated case specific to our Dell hardware.
>>
>> Thanks,
>>
>> Vincent Petry
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

