Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201205011821.q41ILXXx011867@imr-ma03.mx.aol.com>
References: <201204271541.q3RFfVd5006035@imr-da04.mx.aol.com>
	<4F9B0108.2000007@tu-ilmenau.de>
	<CABBYNZJ2ygZ42r==cDbBFmtzmOFTA-HnDCWk_XM669pHYtfs5Q@mail.gmail.com>
	<201205011821.q41ILXXx011867@imr-ma03.mx.aol.com>
Date: Wed, 2 May 2012 11:08:34 +0300
Message-ID: <CABBYNZLLCj_cA__ZQazR81OUScbtAKJrbCfV70O3BgTC05=ueg@mail.gmail.com>
Subject: Re: main.conf issues
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Kal Torak <chronognosis@aim.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kal,

On Tue, May 1, 2012 at 9:20 PM, Kal Torak <chronognosis@aim.com> wrote:
>> You don't have to do that in main.conf, except for class, those values
>> are only used when there is nothing already configured, so to change
>> this you really should be using D-Bus. You can find under
>> tests/test-adapter how to set this permanently in the configuration of
>> the adapter.
>>
> I do that, via tests/test-adapter, and right now it works, thanks to
> both. I was paired both devices, my phone with my pc and I can use
> obex-stuff and so. But when I've paired devices, then this appears
> at /var/log/messages
>
> May  1 14:10:33 p5s800-vm dbus[411]: [system] Rejected send message, 2
> matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
> comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Device"
> member="GetProperties" error name="(unset)" requested_reply="0"
> destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")

It seems some security policy is blocking PulseAudio to send messages
to bluetoothd, check your /etc/dbus-1/system.d/bluetooth.conf, there
is a sample configuration file in the repository src/bluetooth.conf
which should work with PulseAudio.


-- 
Luiz Augusto von Dentz
