Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Receiving data in BLE non-connectable undirected advertisements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <531446EA.6020701@gmx.net>
Date: Mon, 3 Mar 2014 07:28:25 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A2B9E0B0-27CE-45EC-A4E8-FB630C17DA14@holtmann.org>
References: <5310A4A9.2000907@gmx.net> <D7B9B661-DFF0-4AB7-8CAD-F2ACC8FDDBE8@holtmann.org> <531446EA.6020701@gmx.net>
To: Benjamin Adler <benadler@gmx.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Benjamin,

>> You can just write an advertising receiver by using Bluetooth HCI
> > User Channel feature from the 3.13 kernel.  With the help of
> > src/shared/hci.c (if that license is acceptable to you), this is
> > trivial. If the license is not acceptable, then you have to
>> write your own HCI handling.
>> 
>> The BlueZ source code contains samples in form of tools/ibeacon.c
> > and others on how to write such small program for direct access
>> of the HCI interface. If you use this sample code, then please
> > comply with the license as well here.
> 
> regarding the license, this is more of a hobby project, so GPL is perfect.
> 
> Looking at hci.{c,h}, there is (except for the license) not a single comment that would help explain things (to bluetooth-newcomers). The functions might have descriptive names, but I'm missing the bigger picture.
> 
> Reading ibeacon.c, I get the impression the code is made for sending advertisements, not for receiving them. I might be wrong though, there's no comments either. None of the other filenames in tools/ made me hope I could find sample code for receiving non-connectable advertisements.
> 
> Marcel, could you either point me to some sample code, or help me understand hci.c (or list the required steps) so that I can write my own?

maybe you need to just read the HCI part of the Bluetooth Core specification. The tools/ibeacon.c is a perfect example on how to get started with HCI commands. You just need to figure out on how to do scanning instead of advertising.

Regards

Marcel

