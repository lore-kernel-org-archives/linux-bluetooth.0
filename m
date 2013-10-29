Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Tue, 29 Oct 2013 20:44:36 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

on IRC:
<lizardo> dack: it would be nice if you could provide a sample C code that shows the issue you described on the mailing list
<lizardo> specially the arguments you are using for bind/connect/setsockopt/listen/*   (I'm assuming you are using sockets directly)
<dack> lizardo:  unfortunately my code is a mess of C mixed with Python.   yeah, I could provide the argument details



HCI sockets
-----------

socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)
bind(device_id)  // I get device_id's from udev
hci_le_set_scan_parameters(fd, 0, 0x10, 0x10, 0, 0, 1000)  // bluez method in the shared library
setsockopt(SOL_HCI, HCI_FILTER, hci_filter) // I set the filter to let everything through (for testing)
hci_le_set_scan_enable(fd, 1, 0, 1000)  // bluez method in the shared library to turn on scanning
// I shut blocking off on the socket
// I then use epoll to wait for events

L2CAP sockets
-------------

socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)
bind(bdaddr, 0)  // bind to bluetooth address and PSM 0 (Python doesn't support LE directly,
                 // but this is enough for binding to the right device
// shut blocking off

// next part I do in C because of the lack of support in Python...
    PySocketSockObject *sock;  // the socket I created in Python
    char *bdaddr;
    int cid = 0;
    int psm = 0;
    int bdaddr_type = BDADDR_LE_PUBLIC;
    int err;
    struct sockaddr_l2 addr;
       

    // code here to set &bdaddr, &cid, &psm, &bdaddr_type
    // from arguments passed from Python or they're
    // left to their defaults

       
    memset(&addr, 0, sizeof(addr));
    addr.l2_family = sock->sock_family;
    str2ba(bdaddr, &addr.l2_bdaddr);
    
    if (cid)
            addr.l2_cid = htobs(cid);
    else
            addr.l2_psm = htobs(psm);
   
    addr.l2_bdaddr_type = bdaddr_type;
   
   
    err = connect(sock->sock_fd, (struct sockaddr *) &addr, sizeof(addr));

// lastly use epoll to wait for events


I then set CCC values on some attributes to get notifications of changes to sensor readings


Results
-------

On my x86 tests:  everything works fine, notifications come down the proper L2CAP sockets
on my ARM tests:  all notifications come down whatever L2CAP socket was established last


I just realized I missed some fundamental details in the previous emails...

bluez 4.101
linux kernel 3.4.43 compiled with ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf on Allwinner A10 chipset
tried on various armhf chipsets with the same results using kernel 3.0.X