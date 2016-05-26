Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <208452938.148411464235812012.JavaMail.weblogic@epmlwas03d>
References: <208452938.148411464235812012.JavaMail.weblogic@epmlwas03d>
Date: Thu, 26 May 2016 16:12:52 +0300
Message-ID: <CABBYNZK=rWwg60HE4dSjMZOf-Q-Bj86XnhYdk6UioPW6qH8svQ@mail.gmail.com>
Subject: Re: Why network PAN immediately disconnect to mobile phone after connecting?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: hyungju.song@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi HJ,

On Thu, May 26, 2016 at 7:10 AM, 송형주 <hyungju.song@samsung.com> wrote:
> Hello,
> I wander the Network PAN api.
>
> I tested two cases to connect the bluetooth Network,
> Device A is paired Phone B. Phone is woring the NAP service.
>
> Test case 1 > I used the connmanctl.
>
> Paired the device A and phone by using the "bluetoothctl".
> Checking the pairedstatus is success.
>
> Then, I  call the dbus command to use command-line network manager api that is "  dbus-send --system --dest=net.connman --print-reply  /net/connman/service/bluetooth_000000000000_444444444444 net.connman.Service.Connect  "
>
> After sending the command, Device A is connected to Phone A.
> Bluetooth network connection is working well.
>

Next time use a pastebin like service or an attachment for HCI trace.

> Test case 2 > I used the bluez api.
>
> Paired the device A and phone by using the "bluetoothctl".
> Checking the pairedstatus is success.
>
> Then, I used to dbus command that is " dbus-send --system --dest=org.bluez --print-reply  /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx org.bluez.Network1.Connect string:"nap" ".
> After sending the command, i can receive  siganl  that network connect is true and return the bluetooth network interface "bnep0".
> But, immediately device is disconnected after connectiong network.
> Why network connection is not working when i used the bluez api.

It is actually quite simple, dbus-send disconnects from D-Bus once it
exit which will make bluetoothd to release the connection, if you want
the network to stay up you can use the following:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/test-network

-- 
Luiz Augusto von Dentz
