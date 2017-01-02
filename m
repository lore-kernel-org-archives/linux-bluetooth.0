Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <45893082-1bae-cfce-5210-38cadd8cb993@nathanshearer.ca>
References: <45893082-1bae-cfce-5210-38cadd8cb993@nathanshearer.ca>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Jan 2017 14:03:26 +0200
Message-ID: <CABBYNZ+WteYE2boD8C4JJ6avPz3JxJTM_zzFAx72snY4HczMbw@mail.gmail.com>
Subject: Re: Unable to Pair Bose QC35 with Bluez 5.43 or Bluez 5.39
To: Nathan Shearer <mail@nathanshearer.ca>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

On Sat, Dec 31, 2016 at 1:04 AM, Nathan Shearer <mail@nathanshearer.ca> wrote:
> Hello,
>
> I have been using my Bose QC35 headphones with my Gentoo computers for a
> long time now. Recently I updated my computer and am now unable to pair
> my headphones.
>
> Before, when they worked, I had to follow the process at
> http://unix.stackexchange.com/questions/292189/pairing-bose-qc-35-over-bluetooth-on-fedora
> which was to change the ControllerMode from dual to bredr, pair, then
> change it back to dual.
>
> However now when I follow that process, I am unable to pair at all in
> any ControllerMode (dual, bredr, or le). When I try to pair with
> bluetoothctl as root I get this error message:
>
> [bluetooth]# pair 08:DF:1F:E3:46:93
> Attempting to pair with 08:DF:1F:E3:46:93
> [CHG] Device 08:DF:1F:E3:46:93 Connected: yes
> [CHG] Device 08:DF:1F:E3:46:93 Paired: yes
> Pairing successful
> [CHG] Device 08:DF:1F:E3:46:93 Connected: no
> [bluetooth]# connect 08:DF:1F:E3:46:93
> Attempting to connect to 08:DF:1F:E3:46:93
> Failed to connect: org.bluez.Error.Failed
>
> And in /var/log/messages I get:
>
> Dec 30 15:53:50 varws03 bluetoothd[27559]: a2dp-sink profile connect
> failed for 08:DF:1F:E3:46:93: Protocol not available

This normally indicate that there isnt any stream endpoint registered,
so perhaps PulseAudio has crashed or is not running for some reason?

> How do I pair my headphones to my computer? Which protocol is not
> available and how do I add it?
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
