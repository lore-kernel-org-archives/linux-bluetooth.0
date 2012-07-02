Return-Path: <cyrus@holtmann.org>
Message-ID: <4FF213FF.4010805@gmail.com>
Date: Mon, 02 Jul 2012 22:34:55 +0100
From: James <theholyettlz@gmail.com>
MIME-Version: 1.0
To: Oliver Neukum <oneukum@suse.de>
CC: Al Cho <acho@suse.com>, linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth dongle (13d3:3304) not responding after reboot until
 suspend/resume
References: <1340312488.2203.16.camel@iseult> <CAKzePaoOQoXjx5QeRJPCcfOdfULF+EZ9BXf8ihM84YL9rb3D6Q@mail.gmail.com> <4FF1D148.4030009@gmail.com> <201207022158.54868.oneukum@suse.de>
In-Reply-To: <201207022158.54868.oneukum@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/07/12 20:58, Oliver Neukum wrote:
> 
> The rfkill switch should do the job.
> 
> 	Regards
> 		Oliver
> 

Unfortunately, it seems the rfkill switch on this notebook only toggles
the hard block on the wlan (judging by rkfill list and continued
Bluetooth activity).

[A more detailed aside: there are two keys on this notebook with a
little antenna icon --- a "special" button separate from the keyboard,
and Fn+F2. Under Linux, only Fn+F2 has any effect. Neither button
generates any X events or show up in showkey or even report an unknown
code in dmesg. (Other multimedia keys work.)

For Windows 7, there seems to be some extra driver that can pick up
keypresses of "special" wireless button. It brings up an on-screen
display when I press the Fn key:

 - Fn+F2 and the "special" button disable wlan, but not Bluetooth.
 - Fn+F3 is marked as the Bluetooth toggle in some OSD, but also
   has no effect.

The only way to turn off Bluetooth I've seen on this notebook is to
soft-block it, either in Windows 7 or Linux.]

Sorry I've not been able to come up with anything helpful here!

Thanks,

James.
