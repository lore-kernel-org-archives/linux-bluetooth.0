Return-Path: <cyrus@holtmann.org>
Message-ID: <4ED32168.6090902@globaledgesoft.com>
Date: Mon, 28 Nov 2011 11:21:36 +0530
From: sathish <sathish.n@globaledgesoft.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: AVRCP
References: <4E9CF709.6080706@globaledgesoft.com> <CAMOw1v7vqcsqFS3AmuoxHxQXXo-CWea8xJFSomyfDgkFo3b4FQ@mail.gmail.com>
In-Reply-To: <CAMOw1v7vqcsqFS3AmuoxHxQXXo-CWea8xJFSomyfDgkFo3b4FQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  On Wednesday 19 October 2011 03:43 AM, Lucas De Marchi wrote:
> Hi Sathish
>
> On Tue, Oct 18, 2011 at 1:48 AM, sathish<sathish.n@globaledgesoft.com>  wrote:
>> Hi,
>>    I like to know , how to implement avrcp between two systems in Linux using
>> bluez . Is there any one one who can help me. where bluez supports both
>> control and target. but how to implement it .
> The functionality provided in control role is very limited. It's only
> some pieces of 1.0 spec. Since target only reacts to commands coming
> from CT, you'll not be able to do anything useful with 2 systems using
> Linux.
>
>
> If you want to use it only as target, it has all the mandatory
> features of AVRCP 1.3 + some optional ones. Then you can use it by:
>
> 1) Enable the Media interface in /etc/bluetooth/audio.conf
> 2) Start bluetoothd service
> 3) Start test/mpris-player
> 4) Use a media player that supports mpris 2.0: amarok, rhytmbox and a
> few others.
>
> If you are going to implement it in a media player, I suggest
> implementing our dbus interface, so you can cut the 3rd step.
>
>
> regards,
> Lucas De Marchi
>
Hi sir,
  Sub: Regarding Media interface in audio.conf & few others

     I have used the bluez dbus api for VolumeUp and VolumeDown and its 
working fine. I want few suggestions how to extract MetaData information 
from player(I am using amarok) where it is usually a AVRCP TG and to 
send those information to AVRCP CT. And what are the Media interfaces i 
need to change ? I am using ubuntu 10.04 LTS. It will be very useful for 
my study

-- 
Thanks&  Regards,
Sathish N

