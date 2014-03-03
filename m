Return-Path: <cyrus@holtmann.org>
Message-ID: <531446EA.6020701@gmx.net>
Date: Mon, 03 Mar 2014 09:10:02 +0000
From: Benjamin Adler <benadler@gmx.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Receiving data in BLE non-connectable undirected advertisements
References: <5310A4A9.2000907@gmx.net> <D7B9B661-DFF0-4AB7-8CAD-F2ACC8FDDBE8@holtmann.org>
In-Reply-To: <D7B9B661-DFF0-4AB7-8CAD-F2ACC8FDDBE8@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 28.02.2014 15:46, Marcel Holtmann wrote:
> You can just write an advertising receiver by using Bluetooth HCI
 > User Channel feature from the 3.13 kernel.  With the help of
 > src/shared/hci.c (if that license is acceptable to you), this is
 > trivial. If the license is not acceptable, then you have to
> write your own HCI handling.
>
> The BlueZ source code contains samples in form of tools/ibeacon.c
 > and others on how to write such small program for direct access
> of the HCI interface. If you use this sample code, then please
 > comply with the license as well here.

regarding the license, this is more of a hobby project, so GPL is perfect.

Looking at hci.{c,h}, there is (except for the license) not a single 
comment that would help explain things (to bluetooth-newcomers). The 
functions might have descriptive names, but I'm missing the bigger picture.

Reading ibeacon.c, I get the impression the code is made for sending 
advertisements, not for receiving them. I might be wrong though, there's 
no comments either. None of the other filenames in tools/ made me hope I 
could find sample code for receiving non-connectable advertisements.

Marcel, could you either point me to some sample code, or help me 
understand hci.c (or list the required steps) so that I can write my own?

thanks!
ben
