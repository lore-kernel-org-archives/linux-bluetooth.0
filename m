Return-Path: <cyrus@holtmann.org>
Message-ID: <1438843403.19625.7.camel@dlenski-ultra>
Subject: setting BLE connection interval from an unprivileged program?
From: Daniel Lenski <dlenski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 05 Aug 2015 23:43:23 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm working on Linux tools to communicate with the TomTom's GPS sport
watches over Bluetooth LE. I've figured out all the relevant details
of the protocol by snooping on traffic with the official Android app
[1], and have some working code in C to communicate with the devices
by creating L2CAP sockets and bit-banging ATT packets.

These devices transfer GPS activity files to the host, and an activity
file for an hour-long run or ride will be about 200 KiB in size. Using
default settings for an L2CAP socket, data transfer is *extremely*
slow, about 300 B/s of user data.

The BLE connection interval directly impacts the transfer rate [2],
and the minimum (7.5 msec) should be specified to maximize the data
transfer rate, but the L2CAP socket interface doesn't clearly give a
way to do this.

Wireshark shows that when the L2CAP connection is created to the
watch, the host (Linux 3.19) proposes a connection interval of 50-70
msec:

    Bluetooth HCI Command - LE Create Connection
        Connection Interval Min: 40 (50 msec)
        Connection Interval Max: 56 (70 msec)
        Connection Latency: 0 (number events)
        Supervision Timeout: 42 (0.42 sec)
        Min CE Length: 0 (0 msec)
        Max CE Length: 0 (0 msec)

I have found a couple ways to force a shorter connection interval, and
indeed I get about a 6x speedup in data transfer rate at the minimum
connection interval, but these use "raw" HCI sockets and require
elevated privileges [3].

1) Create an HCI socket first, selecting the desired connection
   interval, and then an L2CAP socket. I'm don't actually know *why*
   this works... does every l2cap socket to a given remote device
   actually use the same underlying HCI connection?

    did = hci_get_route(NULL);
    dd = hci_open_dev(did);

    uint16_t hci_handle;
    result = hci_le_create_conn(dd,
        htobs(0x0004), htobs(0x0004), 0,
        LE_RANDOM_ADDRESS, dst_addr, LE_PUBLIC_ADDRESS,
        htobs(0x0006) /*min_interval*/, htobs(0x0006) /*max_interval*/,
        htobs(0) /*latency*/, htobs(200) /*supervision_timeout*/,
        htobs(0x0001), htobs(0x0001), &hci_handle, 25000);

    // L2CAP socket (uses the already-created HCI connection?)
    fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);

2) Create a L2CAP socket with default settings, then use
   hci_le_conn_update() to update the connection parameters. This
   seems suboptimal since it requires negotiating the connection
   settings twice, but allows me to avoid redundantly specifying some
   of the other HCI details:

    // create L2CAP socket first, then get HCI handle
    fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
    
    struct l2cap_conninfo l2cci;
    int length = sizeof l2cci;
    int result = getsockopt(fd, SOL_L2CAP, L2CAP_CONNINFO, &l2cci,
        &length);
    
    result = hci_le_conn_update(dd, l2cci.hci_handle,
        0x0006 /* min_interval */, 0x0006 /* max_interval */,
        0 /* latency */, 200 /* supervision_timeout */, 2000);

Questions:

* Is there a better way to accomplish this in an unprivileged program?
  Is there some L2CAP socket option which I can use to set the LE
  connection interval parameters?
* Why does the Linux kernel default to a needlessly long minimum
  connection interval when creating a L2CAP socket?

Thanks
Dan Lenski

[1]: TomTom BLE protocol documentation in progress:
http://github.com/dlenski/ttblue/blob/master/tt_bluetooth.md
[2]:
http://www.safaribooksonline.com/library/view/getting-started-with/9781491900550/ch01.html#_data_throughput
[3]:
http://unix.stackexchange.com/questions/96106/bluetooth-le-scan-as-non-root


