Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: eric.y.miao@gmail.com
In-Reply-To: <CAMPhdO8nv3ziFVAo_N56Gwd7ZtqsgA-79pLJ6gsuwGqMYWrZ1w@mail.gmail.com>
References: <1332132103-23374-1-git-send-email-eric.miao@canonical.com>
 <1332178663.14217.211.camel@aeonflux> <CAMPhdO8nv3ziFVAo_N56Gwd7ZtqsgA-79pLJ6gsuwGqMYWrZ1w@mail.gmail.com>
From: Eric Miao <eric.miao@canonical.com>
Date: Tue, 20 Mar 2012 22:36:40 +0800
Message-ID: <CAMPhdO9NxqKAFymdnHq1HNchvzvggUyGbUdX1be0MP_KHnYq5w@mail.gmail.com>
Subject: Re: [PATCH] Add udev rule for Ralink WiFi+BT module w/ bccmd
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 20, 2012 at 9:55 AM, Eric Miao <eric.miao@canonical.com> wrote:
> On Tue, Mar 20, 2012 at 1:37 AM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Eric,
>>
>>> Some Ralink WiFi + CSR BT module needs bluetooth radio to be
>>> turned on explicitly with bccmd by the following command:
>>>
>>> =C2=A0 bccmd psset -r 0x028c 0x0001
>>>
>>> The HCI will be probed successfully, but due to the default
>>> OFF state of the radio, no scan or connection can be made.
>>> This patch adds the udev rule so that once the HCI is up,
>>> udev will invoke bccmd with warm reset to turn on the radio.
>>>
>>> [1] https://bugs.launchpad.net/bugs/781556
>>> [2] https://bugs.meego.com/show_bug.cgi?id=3D3498
>>> [3] http://ubuntuforums.org/showthread.php?t=3D1776108
>>> [4] http://ubuntuforums.org/showthread.php?t=3D1703941
>>
>> why are we doing this in userspace? The btusb.c driver has the option
>> for pre-execution HCI commands queue. Why not use that one.
>
> That sounds like a better one, I'll take a look and see if it's possible
> to give a revised version. Thanks Marcel.

Hmm... have thought about this twice, and I still prefer the bccmd
command in user space. Converting this very straight-forward setting
w/ bccmd into HCI commands would make it rather awkward.

And so the further question would be the bluetooth-hid2hcd.rules,
will this file gradually disappear and the necessary operations be
made into the kernel code eventually?
