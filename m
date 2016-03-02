Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: How to detach device from "hidp"? (was: How to get bluetooth HID
 reports?)
To: linux-bluetooth@vger.kernel.org
References: <56D5E099.3070304@m-reimer.de>
From: Manuel Reimer <mail+linux-bluetooth@m-reimer.de>
Message-ID: <56D727F9.1020005@m-reimer.de>
Date: Wed, 2 Mar 2016 18:50:49 +0100
MIME-Version: 1.0
In-Reply-To: <56D5E099.3070304@m-reimer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

after some more hours of trying, I got my first HID report.

I had to blacklist the hidp module. For me this means: The device can be 
accessed only once and so far "hidp" was faster and the device was no 
longer available for my software.

As completely blacklisting hidp is not the solution, I want to use, it 
would be nice if someone could tell me how to detach a device from hidp.

In theory I need something like the "detach kernel driver" in libusb.

Maybe it even is possible to talk to hidp? Is it possible to 
send/receive directly through hidp, so I don't have to use "raw socket 
communication"?

Thank you very much in advance.

Best regards,

Manuel

On 03/01/2016 07:34 PM, Manuel Reimer wrote:
> Hello,
>
> I got stuck with trying to read data from a bluetooth HID device.
>
> Is there some trick when doing this?
>
> Short snippet of my code:
>
>
>
> // allocate a socket
> int int_socket = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> int ctl_socket = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
>
> // set the connection parameters
> addr.l2_family = AF_BLUETOOTH;
> str2ba( dest, &addr.l2_bdaddr );
>
> // connect to server
> addr.l2_psm = htobs(L2CAP_PSM_HIDP_INTR);
> status = connect(int_socket, (struct sockaddr *)&addr, sizeof(addr));
> if (status != 0) {
>    printf("Error connect int_socket\n");
>    exit(1);
> }
> addr.l2_psm = htobs(L2CAP_PSM_HIDP_CTRL);
> status = connect(ctl_socket, (struct sockaddr *)&addr, sizeof(addr));
> if (status != 0) {
>    printf("Error connect ctl_socket\n");
>    exit(1);
> }
>
> // get a message
> char buf[100] = { 0 };
> int bytes_read = recv(int_socket, buf, sizeof(buf), 0);
> if( bytes_read > 0 ) {
>    printf("received [%s]\n", buf);
> }
>
>
>
> I get connected somehow and I am actually able to do interaction on the
> "control socket" (writing and reading), but the "recv" at the "interrupt
> socket" just hangs forever and I don't know how to debug...
>
> Thanks for every help.
>
> Best regards,
>
> Manuel
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

