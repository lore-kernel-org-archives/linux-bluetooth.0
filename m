Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201710060854.v968s6kT020905@web12.vgs.ws.untd.com>
References: <201710060854.v968s6kT020905@web12.vgs.ws.untd.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Oct 2017 12:31:17 +0300
Message-ID: <CABBYNZ+Kj1rh0k9OaU6oJzyfYiHJMzZxtxbSnwjQb71vB+cNng@mail.gmail.com>
Subject: Re: "hcitool lescan" can't detect BLE simulators!
To: "R. Rajesh Jeba Anbiah" <ng4rrjanbiah@rediffmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 6, 2017 at 11:54 AM, R. Rajesh Jeba Anbiah
<ng4rrjanbiah@rediffmail.com> wrote:
> I hope, this is the right forum, if not kindly excuse and direct me to the right forum.
>
> I have noticed that "hcitool lescan" and "sudo bluetoothctl" can't detect app simulated beacons (For example, using
> https://play.google.com/store/apps/details?id=net.alea.beaconsimulator&hl=en ). These app simulated beacons are successfully getting recognized by Android & iOS based apps.
>
> Is there any additional check done in BlueZ to skip these app simulated beacons. If so, is there anyway to disable that?

For non-connectable beacons you will need to set a filter e.g:

bluetoothctl> set-scan-filter-uuids
bluetoothctl> scan on

General discovery only scan for connectable devices.

> (I'm on Raspbian GNU/Linux 9 (stretch))
>
> TIA
>
> ___________________________
>
> Date & Time: Fri Oct  6 2017, 02:24:06 PM IST
> Sent via http://GuideMe.ITgo.com/mail
>
> Use Quick Mail @ GuideMe.ITgo.com
> (It's No Signup... No Password... Mail Service!!)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
