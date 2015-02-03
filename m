Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <009201d03f81$a37f89c0$ea7e9d40$@samsung.com>
References: <009201d03f81$a37f89c0$ea7e9d40$@samsung.com>
Date: Tue, 3 Feb 2015 10:58:23 +0200
Message-ID: <CABBYNZLPvA=ya9cU9rFLDsVJDv0HB4RKQ++MTcRYxv0gKrDAGA@mail.gmail.com>
Subject: Re: Unable to setup Gatt
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arman Uguray <armansito@chromium.org>,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Feb 3, 2015 at 9:18 AM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> Hi,
>
>
>
> We are trying to setup two machines, with btgatt-server and btgatt-client
> running on either side.
>
>
>
> On btgatt-server: (--index hci0 –r)
>
> 1.       hciconfig hci0 up
>
> 2.       hciconfig hci0 leadv
>
> 3.       bluetoothd is running with –ndE option.
>

Afaik you should not run bluetoothd and btgatt-server along side
because they both listen to the same cid. (ATT_CID = 4)

>
> “Started listening on ATT channel, waiting for connections”
>
>
>
> On btgatt-client: (--index hci0 –d <server addr>)
>
> 1.       hciconfig hci0 up
>
> 2.       bluetoothd –ndE
>

The is similar situation as the server, you have to decide what client
you want to use and not try to use both together.

>
> After running btgatt-client with above options, it gets connected to
> btgatt-server and returns below error message,
>
> “GATT Discovery procedure failed – error code 0x0a”
>
> Which means “ATTR_NOT_FOUND”, and ATT is not ready.
>

Most likely there where a conflict while setting up the server.

>
> Could anyone please help us, if we missed any steps to make the gatt
> server/client up and running?

Id say you should try with bluetoothd alone, try to pair and watch for
objects being create with interface org.bluez.GattService1, you can
monitor that with dbus-monitor for now until we are adapting
bluetoothctl to show them, d-feet is another option. Also please make
sure you have btmon running so in case you detect any problems you can
send us the logs of the traffic.

>
>
> Thanks,
>
> Best Regards,
>
> Bharat



-- 
Luiz Augusto von Dentz
