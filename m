Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1586316808.864730.1466588544143.JavaMail.zimbra@redhat.com>
References: <1606210521.630724.1466514115545.JavaMail.zimbra@redhat.com> <1586316808.864730.1466588544143.JavaMail.zimbra@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Jun 2016 12:52:11 +0300
Message-ID: <CABBYNZLjbZFT3Oev7XsW5WhFzju5Zhv6XbPu10VUQ_s39Uo9Cg@mail.gmail.com>
Subject: Re: Unable to pair with Genius Navigator 900 Pro mouse
To: Jaroslav Skarvada <jskarvad@redhat.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaroslav,

On Wed, Jun 22, 2016 at 12:42 PM, Jaroslav Skarvada <jskarvad@redhat.com> wrote:
>
>
> ----- Original Message -----
>> Hi,
>>
>> hopefully this is the right list (please don't blame me if not :)
>>
>> It seems it is no more possible to pair with Genius Navigator 900
>> Pro mouse. It seems it's older mouse probably with no SSP/
>> built-in PIN.
>>
>> # bluetoothctl
>> [bluetooth]# pair ADDR
>> [CHG] Device ADDR Connected: yes
>> [CHG] Device ADDR Connected: no
>> [CHG] Device ADDR Connected: yes
>> Failed to pair: org.bluez.Error.AuthenticationRejected
>> [CHG] Device ADDR Connected: no
>>
>> Hcitool "trick":
>> # hcitool cc ADDR;hcitool auth ADDR
>> HCI authentication request failed: Input/output error
>>
>> The above error is shown before the PIN dialog appears. I also
>> tried Blueman GUI, but it tracebacks (report also sent).
>>
>> Moreover:
>> # hciconfig hci0 sspmode 0
>> Can't set Simple Pairing mode on hci0: Input/output error (5)
>>
>> So I cannot try without SSP. It seems there is nothing related
>> in dmesg.
>>
>> IIRC the mouse worked in the past.
>>
>> $ uname -r
>> 4.5.7-200.fc23.x86_64
>>
>> OS: Fedora 23
>> userspace: bluez-5.39
>>
>> machine: Lenovo ThinkPad X240
>> adapter probably: Intel Centrino 7260 2 x 2 AC+ BT 4.0
>> module: btintel: Intel Bluetooth firmware file:
>> intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
>>
>> Could you advice some other tricks how to get it working?
>> I could also bisect the problem later
>>
>> thanks & regards
>>
>> Jaroslav
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> I wasn't right, the mouse seems to support autopairing and I paired it
> without problem under RHEL-7 and it also works there without problem.
> I tried to shuffle user-space bluez and there is no change, so it has to be
> kernel. I also tried with CSR USB dongle. Regarding the sspmode error,
> it's probably not supported by the HW. To sum it up:
>
> kernel-3.10.0-229.el7.x86_64 - it works
> kernel-4.5.7-200.fc23.x86_64 - it doesn't work

Try collecting the HCI trace with btmon, btw make sure you have an
agent registered and set as default.

> I am going to bisect with vanilla kernel
>
> thanks & regards
>
> Jaroslav
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
