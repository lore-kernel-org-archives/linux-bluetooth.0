Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Manuel Reimer <mail+linux-bluetooth@m-reimer.de>
Subject: How to get bluetooth HID reports?
Message-ID: <56D5E099.3070304@m-reimer.de>
Date: Tue, 1 Mar 2016 19:34:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I got stuck with trying to read data from a bluetooth HID device.

Is there some trick when doing this?

Short snippet of my code:



// allocate a socket
int int_socket = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
int ctl_socket = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

// set the connection parameters
addr.l2_family = AF_BLUETOOTH;
str2ba( dest, &addr.l2_bdaddr );

// connect to server
addr.l2_psm = htobs(L2CAP_PSM_HIDP_INTR);
status = connect(int_socket, (struct sockaddr *)&addr, sizeof(addr));
if (status != 0) {
   printf("Error connect int_socket\n");
   exit(1);
}
addr.l2_psm = htobs(L2CAP_PSM_HIDP_CTRL);
status = connect(ctl_socket, (struct sockaddr *)&addr, sizeof(addr));
if (status != 0) {
   printf("Error connect ctl_socket\n");
   exit(1);
}

// get a message
char buf[100] = { 0 };
int bytes_read = recv(int_socket, buf, sizeof(buf), 0);
if( bytes_read > 0 ) {
   printf("received [%s]\n", buf);
}



I get connected somehow and I am actually able to do interaction on the 
"control socket" (writing and reading), but the "recv" at the "interrupt 
socket" just hangs forever and I don't know how to debug...

Thanks for every help.

Best regards,

Manuel
