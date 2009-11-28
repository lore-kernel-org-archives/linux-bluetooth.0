Return-Path: <cyrus@holtmann.org>
Message-ID: <4B115279.3060705@openwide.fr>
Date: Sat, 28 Nov 2009 17:40:25 +0100
From: Pierre Ficheux <pierre.ficheux@openwide.fr>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Right way of pairing?
References: <912bb79a0911272152y6fb12a05p299090e97ac91a54@mail.gmail.com>
In-Reply-To: <912bb79a0911272152y6fb12a05p299090e97ac91a54@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

nirav rabara a écrit :
> Hi,
> 
> I am newbie to bluetooth world, For pairing I am connecting RFCOM
> socket, I can show this connection on /org/bluez/789(pid of
> process)/hci0 as dev_00_05_AD_EF_F8_A5 and linkkey information in
> linkkeys file. but when I close this RFCOM socket (or when application
> kills) all the information regarding the device pairing getting lost.
> 
> Is this the right way of pairing ??
> 
> I know that API has also available for device pairing, but I want to
> use Dbus as less as possible due to the time take by dbus fucntions
> calls and also I am not so comfortable with dbus API.
> 
> Can anybody suggest me the right way to pair devices?? Is it
> compulsory to use DBUS API for pairing OR any other way without using
> Dbus API
> 
> Your suggestion would be a great help for me.....
> 


You can use "simple-agent". It's a text based python script you can find
in the "test" directory of bluez sources.

Once your phone request for pairing, the original version of the script
allows you to input the PIN code. You can modify the script to send a
default PIN code value  such as 0000.

Works fine for me.

regards

-- 
Pierre FICHEUX -/- CTO OW/OS4I, France -\- pierre.ficheux@openwide.fr
                                         http://www.os4i.com
                                         http://www.ficheux.org
I would love to change the world, but they won't give me the source code


