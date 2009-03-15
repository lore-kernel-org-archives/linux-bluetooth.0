Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 15 Mar 2009 00:18:09 -0700
Message-ID: <37666aa80903150018m5a000bd1w23885e2ea67856a8@mail.gmail.com>
Subject: question about "Create Connection Cancel"
From: Han <keepsimple@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am a beginner to use bluez library to do bluetooth programming. I am
using Ubuntu with 2.6.27-11 kernel and bluez 4.32 installed.

When I try to connect to another computer using RFCOMM, it failed and
I got the following log from hcidump:

< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
    bdaddr 00:1C:26:F6:41:02
> HCI Event: Command Status (0x0f) plen 4
    Create Connection Cancel (0x01|0x0008) status 0x01 ncmd 1
    Error: Unknown HCI Command

What does this message mean ?

Strange enough, if I run the same program from another computer to
connect to this one, it succeeded.

btw, the code I wrote to do the connection is as following:

<snipped>
    /*
     * open the Bluetooth socket
     */
    s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
    if (s == -1) {
        perror("socket create failed");
        exit(1);
    }

    addr.rc_family = AF_BLUETOOTH;
    addr.rc_channel = 1;
    str2ba(dest, &addr.rc_bdaddr);

    status = connect(s, (struct sockaddr *)&addr,
                     sizeof(addr));
<snipped>

The connect returned status -1, and error string is: "Operation now in
progress".


Thanks in advance.
Han
