Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4144634E.4070404@uni-paderborn.de>
Date: Sun, 12 Sep 2004 16:55:10 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdp_search and l2cap concurrently
References: <41430846.4010006@uni-paderborn.de> <1094997749.5695.13.camel@pegasus>
In-Reply-To: <1094997749.5695.13.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel!

Marcel Holtmann schrieb:

>what do you mean by cripple L2CAP and use it concurrently. Explain in
>more detail what your program is really doing 
>
Ok, I'll explain it in Pseudo-Code:

DiscoveryThread does all the time {
  InquiryInfo[] ii = do_inquiry();
  DiscoveryInfo[] di = sdp_filter_for(my_l2cap_service, ii);
  pass_to_UpdateThread(di):
}

UpdateThread does all the time {
  check_for_new_DiscoveryInfo_and_add_them_to(internal_di, di);
  do_for_all(di_item = internal_di[i]) {
    int sock = l2cap_connect(di_item);
    di_item.name = l2cap_read_descriptive_name(sock);
    di_item.content = l2cap_read_website_content(sock);
    di_item.rssi = hci_readRSSI(l2cap_sock2hci_conn(sock));
    di_item.lq = hci_getLinkQuality(l2cap_sock2hci_conn(sock));
    l2cap_close(sock);
    di_item.sum = evaluate(di_item.rssi, di_item.lq);
  }
  sort_by_sum(di_internal);
  show_nearest_website_content(di_internal[0]);
}

By "cripple" I mean if one device is almost out of range (l2cap 
connections would fail, but inquiry discovered it anyway) 
"sdp_filter_for(my_service, ii)" takes quite long to fail by timeout. 
And in this time, the UpdateThread doesn't seem to run eigther. The 
whole thing hangs. I think that is because all Java-Threads belong to 
only one Linux-Process which communicates with BlueZ. And this process 
is blocked by SDP for up to SDP_RESPONSE_TIMEOUT (see 
bluez-sdp/libs/utils.c, sdp_read_rsp(..)). I tried to lower this timeout 
by applying smaller timeouts SO_SNDTIMEO and SO_RCVTIMEO to the 
sdp_session's l2cap socket, but this doesn't seem to work because of the 
use of select().

In my opinion there are three ways to solve this:
1. Make SDP_RESPONSE_TIMEOUT a settable parameter
2. Don't use select(); instead put the socket to non-blocking state 
("fcntl(sock, F_SETFL, flags | O_NONBLOCK)") while connecting.
3. Don't use select(); instead let the user/programmer chose to put a 
SO_SNDTIMEO and SO_RCVTIMEO on the socket.

2. and 3. may be combined.

But probably, it is something quite different or there's an easy 
solution. I just wanted to ask for it :-). I'll test further...

>and check how many low
>level HCI connections are opened at the same time.
>  
>
I think there can only be one low level (ACL) connection to each device 
at a time. Unfortunately, I have only 3 devices for testing. So this 
can't be the problem.

Regards,
Stefan
