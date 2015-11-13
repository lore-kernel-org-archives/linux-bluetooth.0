Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Embree <s.embree@gmail.com>
Date: Fri, 13 Nov 2015 09:25:28 -0500
Message-ID: <CAMwUBEVga6d+264R7MrtDQysEdoc9N6EQJrpOFfdwMwRQ8DQDw@mail.gmail.com>
Subject: ACL connection handle
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I would like to send a command OCF_LE_READ_CHANNEL_MAP to the hci
interface of an adapter using the hci library.  To do this, I think I
need to open a socket connection to the hci interface of the adapter
and obtain the ACL connection handle.  My question is, how do I obtain
the handle?

I try the following, but the ioctl returns -1 with error "File
descriptor in a bad state".

    // find the connection handle to the specified bluetooth device
    cr = (struct hci_conn_info_req*) malloc(
            sizeof(struct hci_conn_info_req) +
            sizeof(struct hci_conn_info));
    bacpy( &cr->bdaddr, ba );
    cr->type = ACL_LINK;
    dd = hci_open_dev( hci_get_route( &cr->bdaddr ) );
    if( dd < 0 ) {
        err = dd;
        goto cleanup;
    }
    err = ioctl(dd, HCIGETCONNINFO, (unsigned long) cr );
    if( err ) {
        // !!!This is where the program ends with "File descriptor in bad state"
     perror("Failed to get connection info");
     goto cleanup;
    }

    // build a command packet to send to the bluetooth microcontroller
    cmd_param.handle = cr->conn_info->handle;
