Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: eric.y.miao@gmail.com
In-Reply-To: <1332178663.14217.211.camel@aeonflux>
References: <1332132103-23374-1-git-send-email-eric.miao@canonical.com> <1332178663.14217.211.camel@aeonflux>
From: Eric Miao <eric.miao@canonical.com>
Date: Tue, 20 Mar 2012 09:55:02 +0800
Message-ID: <CAMPhdO8nv3ziFVAo_N56Gwd7ZtqsgA-79pLJ6gsuwGqMYWrZ1w@mail.gmail.com>
Subject: Re: [PATCH] Add udev rule for Ralink WiFi+BT module w/ bccmd
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 20, 2012 at 1:37 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Eric,
>
>> Some Ralink WiFi + CSR BT module needs bluetooth radio to be
>> turned on explicitly with bccmd by the following command:
>>
>> =C2=A0 bccmd psset -r 0x028c 0x0001
>>
>> The HCI will be probed successfully, but due to the default
>> OFF state of the radio, no scan or connection can be made.
>> This patch adds the udev rule so that once the HCI is up,
>> udev will invoke bccmd with warm reset to turn on the radio.
>>
>> [1] https://bugs.launchpad.net/bugs/781556
>> [2] https://bugs.meego.com/show_bug.cgi?id=3D3498
>> [3] http://ubuntuforums.org/showthread.php?t=3D1776108
>> [4] http://ubuntuforums.org/showthread.php?t=3D1703941
>
> why are we doing this in userspace? The btusb.c driver has the option
> for pre-execution HCI commands queue. Why not use that one.

That sounds like a better one, I'll take a look and see if it's possible
to give a revised version. Thanks Marcel.

>
> Also why -r. Meaning why do we need a warmreset? And where is the magic
> 0x028c PS key coming from? Does anybody actually know what it is doing?

The magic came from Ralink FAE actually and it was verified to work
by various people. It was believed it's the bit to turn the radio ON/OFF.
And a warmreset ensures that radio will be ON instantly, other than a
system boot. I'm afraid there is no public documentation about this,
I didn't even find this bit in the CSR BCCMD firmware notes of CSR8510,
could be a vendor specific bit.

>
> Regards
>
> Marcel
>
>
