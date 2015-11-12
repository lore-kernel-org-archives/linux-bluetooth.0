Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Embree <s.embree@gmail.com>
Date: Thu, 12 Nov 2015 15:49:20 -0500
Message-ID: <CAMwUBEXCACieXfg=Z1D1w1rx_xXbynBsXgCUiv2+116JUGG5-g@mail.gmail.com>
Subject: ioctl request for HCIGETCONNINFO returning "File descriptor in bad state"
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to obtain a handle to an HCI socket using the code below.
The ioctl is returning with an error (see triple exclamation !!! in
the comments below).  I have seen others who have had this problem in
previous posts to the email list.  I could not find any satisfactory
answers.

#include <unistd.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

int main()
{
    int err = 0, dd;
    struct hci_conn_info_req *cr = 0;
    bdaddr_t ba;
    uint16_t handle;

    str2ba( "00:19:0E:16:A6:62", &ba );  // Where XX:XX... is local hci0 address

    // find the connection handle to the specified bluetooth device
    cr = (struct hci_conn_info_req*) malloc(
   sizeof(struct hci_conn_info_req) +
   sizeof(struct hci_conn_info));
    bacpy( &cr->bdaddr, &ba );
    cr->type = ACL_LINK;
    dd = hci_open_dev( hci_get_route( &cr->bdaddr ) );
    if( dd < 0 ) {
err = dd;
perror("Failed to obtain socket for hci device.");
return 1;
    }
    err = ioctl(dd, HCIGETCONNINFO, (unsigned long) cr );
    if( err ) {
// !!!This is where the program ends with "File descriptor in bad state"
perror("Failed to get connection info");
return 1;
    }

    handle = cr->conn_info->handle;

    printf("Handle: %i\n", handle);

    // Use handle to send an hci req using hci_send_req()...

    return 0;
} //end main
