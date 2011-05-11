Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 May 2011 13:47:36 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Eponymous - <the.epon@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: HCI data payload not getting through when using BlueZ
Message-ID: <20110511164736.GA22065@joana>
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Eponymous - <the.epon@gmail.com> [2011-05-11 09:52:28 +0100]:

> Hi,
> 
> I've ran into an issue where data doesn't seem to be received by a slave device.
> 
> I do the following:
> 
> Using Gentoo Linux (2.6.34-gentoo-r1)
> Using BlueZ 4.81
> 
> 1. Use BlueZ to connect to two Bluetooth devices using HCI only. This
> is over USB.
> 
> 2. I set one device as a slave and then create a connection between
> the two. This completes sucessfully and can be seen on both sides.
> 
> 3. I then try to send an acl packet with the word "hi" in it and it is
> not received on the other side.

There a utility called l2test in the bluez sources. Check if it works for you.
Using -r in one side to listen and -s in the other side to send data. Or
l2test -h and see all options.

-- 
Gustavo F. Padovan
http://profusion.mobi
