Return-Path: <cyrus@holtmann.org>
Message-ID: <518882.38546.qm@web50211.mail.re2.yahoo.com>
Date: Fri, 6 Mar 2009 13:06:50 -0800 (PST)
From: Marco Castillo <mabcastillo@yahoo.com>
Subject: How to choose a predefined Bluetooth device (hcix) in a connect call
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Dear list:
I need to connect as a client to a bluetooth capable device acting as a server. The client device is a linux box running Fedora 10, that has multiple bluetooth usb dongles. I need to connect to the server device using RFCOMM. For that matter I create a socket as follows:
s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

Then, knowing the bluetooth mac address of the server (the dest variable), I made the following calls to connect to the server:

addr.rc_family = AF_BLUETOOTH;
addr.rc_channel = 1;
str2ba(dest, & addr.rc_bdaddr ) ;

status = connect (s, (struct sockaddr *) & addr , sizeof(addr ) ) ;

At this moment, everything goes fine, and I can connect to the server. But now I need to connect concurrently to all the possible bluetooth devices available near the client. There is going to be a thread per client connected. For maximizing the client resources I will like to use all the bluetooth dongles that the linux box (the client) has. So in the above code I don't see where can I set the connection over a predefined bluetooth device (let's say I want to use dongle 2 in the system, or hci1 for example).
So my questions are:
1. Is there a way to create a RFCOMM connection over a predefined bluetooth device (hcix)? Or the connect primitive chooses the one available and I can keep making connections until there is no one available?
2. The previous question takes me to another: how many simultaneous connections can be made over a single bluetooth device (hcix)?
3. How is the relationship between the channel and the bluetooth device? Are there n channels per device?. The channel is the rc_channel member of the address structure.

Thank you in advance for taking the time and read my question. Thanks in advance for any help provided.
This is the first time I write to this list. Please let me know if this is the place for placing questions like the ones before. If not, I will appreciate any guidance.

Regards

Marco Castillo


      
