Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1438843403.19625.7.camel@dlenski-ultra>
References: <1438843403.19625.7.camel@dlenski-ultra>
Date: Sun, 9 Aug 2015 18:44:26 +0300
Message-ID: <CABBYNZL6vGkzZ-aEObSK+5YASOD_s3n+7JNoBG+p33c5F4mbgw@mail.gmail.com>
Subject: Re: setting BLE connection interval from an unprivileged program?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Daniel Lenski <dlenski@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Aug 6, 2015 at 9:43 AM, Daniel Lenski <dlenski@gmail.com> wrote:
> I'm working on Linux tools to communicate with the TomTom's GPS sport
> watches over Bluetooth LE. I've figured out all the relevant details
> of the protocol by snooping on traffic with the official Android app
> [1], and have some working code in C to communicate with the devices
> by creating L2CAP sockets and bit-banging ATT packets.
>
> These devices transfer GPS activity files to the host, and an activity
> file for an hour-long run or ride will be about 200 KiB in size. Using
> default settings for an L2CAP socket, data transfer is *extremely*
> slow, about 300 B/s of user data.
>
> The BLE connection interval directly impacts the transfer rate [2],
> and the minimum (7.5 msec) should be specified to maximize the data
> transfer rate, but the L2CAP socket interface doesn't clearly give a
> way to do this.
>
> Wireshark shows that when the L2CAP connection is created to the
> watch, the host (Linux 3.19) proposes a connection interval of 50-70
> msec:
>
>     Bluetooth HCI Command - LE Create Connection
>         Connection Interval Min: 40 (50 msec)
>         Connection Interval Max: 56 (70 msec)
>         Connection Latency: 0 (number events)
>         Supervision Timeout: 42 (0.42 sec)
>         Min CE Length: 0 (0 msec)
>         Max CE Length: 0 (0 msec)
>
> I have found a couple ways to force a shorter connection interval, and
> indeed I get about a 6x speedup in data transfer rate at the minimum
> connection interval, but these use "raw" HCI sockets and require
> elevated privileges [3].
>
> 1) Create an HCI socket first, selecting the desired connection
>    interval, and then an L2CAP socket. I'm don't actually know *why*
>    this works... does every l2cap socket to a given remote device
>    actually use the same underlying HCI connection?
>
>     did = hci_get_route(NULL);
>     dd = hci_open_dev(did);
>
>     uint16_t hci_handle;
>     result = hci_le_create_conn(dd,
>         htobs(0x0004), htobs(0x0004), 0,
>         LE_RANDOM_ADDRESS, dst_addr, LE_PUBLIC_ADDRESS,
>         htobs(0x0006) /*min_interval*/, htobs(0x0006) /*max_interval*/,
>         htobs(0) /*latency*/, htobs(200) /*supervision_timeout*/,
>         htobs(0x0001), htobs(0x0001), &hci_handle, 25000);
>
>     // L2CAP socket (uses the already-created HCI connection?)
>     fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
>
> 2) Create a L2CAP socket with default settings, then use
>    hci_le_conn_update() to update the connection parameters. This
>    seems suboptimal since it requires negotiating the connection
>    settings twice, but allows me to avoid redundantly specifying some
>    of the other HCI details:
>
>     // create L2CAP socket first, then get HCI handle
>     fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
>
>     struct l2cap_conninfo l2cci;
>     int length = sizeof l2cci;
>     int result = getsockopt(fd, SOL_L2CAP, L2CAP_CONNINFO, &l2cci,
>         &length);
>
>     result = hci_le_conn_update(dd, l2cci.hci_handle,
>         0x0006 /* min_interval */, 0x0006 /* max_interval */,
>         0 /* latency */, 200 /* supervision_timeout */, 2000);
>
> Questions:
>
> * Is there a better way to accomplish this in an unprivileged program?

It depends what you are planning to do, for GATT/ATT there is probably
no way to share the socket since there could be other application
trying to access other profiles. There is always the possibility to
write a plugin to provide the settings per profile but we are still
discussing an API to inform this to the kernel so it can select what
settings shall be used based on the requested values.

>   Is there some L2CAP socket option which I can use to set the LE
>   connection interval parameters?

Currently no, but there are people currently working on adding socket
options for these, but then again if this is GATT/ATT socket it will
probably be controlled by bluetoothd.

> * Why does the Linux kernel default to a needlessly long minimum
>   connection interval when creating a L2CAP socket?

I guess it is the defaults from the spec, but in case the peripheral
updates it the kernel will remember next time it connects, so I guess
the peripheral don't bother to change anything that the central
requests?

>
> Thanks
> Dan Lenski
>
> [1]: TomTom BLE protocol documentation in progress:
> http://github.com/dlenski/ttblue/blob/master/tt_bluetooth.md
> [2]:
> http://www.safaribooksonline.com/library/view/getting-started-with/9781491900550/ch01.html#_data_throughput
> [3]:
> http://unix.stackexchange.com/questions/96106/bluetooth-le-scan-as-non-root
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
