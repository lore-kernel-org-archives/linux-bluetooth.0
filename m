Return-Path: <cyrus@holtmann.org>
Message-ID: <5072E1E3.10606@rug.nl>
Date: Mon, 08 Oct 2012 16:23:31 +0200
From: Sietse Achterop <s.achterop@rug.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Unreliable communication with multiple bluetooth devices and
 some delay
References: <506AEDFC.9060300@rug.nl> <507298AA.2020704@rug.nl> <20121008091535.GG2456@aemeltch-MOBL1>
In-Reply-To: <20121008091535.GG2456@aemeltch-MOBL1>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08-10-12 11:15, Andrei Emeltchenko wrote:
> 
> Get capture with hcidump like "hcidump -tX -i hciX". It will tell you why
> connection is closed. Also dmesg might give some warnings.

    Dear Andrei,
thanks for the response.

I did some tests, see the dump fragment below. I shows the output from just before
the error until the 20 second timeout. There is nothing in dmesg or syslog at all.
I cannot completely interpret the output, but have the following questions.

1 When sending the next 3 strings "l,1,2\n" as shown in the beginning of the fragment,
  i see that only handle 48 talks about RFCOMM and has a different psm than the other 2.
  When running the test without the 0.1 second delay each time in the loop, then the psm
  value is always 3.
  Is there any significance to this?

2 According to the log, around timestamp 13:36:59.436715 the "ack" for handle 42 is missing.
  After that handle 42 is out of order and the rest hangs because of the program loop.
  After 20 seconds the timeout occurs.
    What does this mean? What are the possible and probable causes.
    How likely is it that the hardware (on either side) is so broken?
    Where is the failure, on which side of the communication channel, what is more likely.
    If the lmx9838 is malfunctioning, shouldn't there be attempts (retries) to try and
    recover from this. Could i instrument the driver to see this better?

   Thanks for your attention,
      Sietse

==========================================================================================

2012-10-08 13:36:59.030346 < ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.030371 < ACL data: handle 45 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.030393 < ACL data: handle 48 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 6c 2c 31 2c 32 0a                                 l,1,2.
2012-10-08 13:36:59.034712 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
2012-10-08 13:36:59.036709 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 48 packets 1
2012-10-08 13:36:59.039712 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 45 packets 1
2012-10-08 13:36:59.130538 < ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.130560 < ACL data: handle 45 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.130584 < ACL data: handle 48 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 6c 2c 31 2c 32 0a                                 l,1,2.
2012-10-08 13:36:59.135710 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
2012-10-08 13:36:59.135719 > ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 09 ff 01 02 5c                                    ....\
2012-10-08 13:36:59.139711 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 48 packets 1
2012-10-08 13:36:59.141711 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 45 packets 1
2012-10-08 13:36:59.142714 > ACL data: handle 48 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
2012-10-08 13:36:59.144715 > ACL data: handle 45 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 09 ff 01 02 5c                                    ....\
2012-10-08 13:36:59.230650 < ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.230671 < ACL data: handle 45 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.230694 < ACL data: handle 48 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 6c 2c 31 2c 32 0a                                 l,1,2.
2012-10-08 13:36:59.235713 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
2012-10-08 13:36:59.239711 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 48 packets 1
2012-10-08 13:36:59.241711 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 45 packets 1
2012-10-08 13:36:59.330765 < ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.330785 < ACL data: handle 45 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.330809 < ACL data: handle 48 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 6c 2c 31 2c 32 0a                                 l,1,2.
2012-10-08 13:36:59.335713 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
2012-10-08 13:36:59.339712 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 48 packets 1
2012-10-08 13:36:59.340715 > ACL data: handle 48 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
2012-10-08 13:36:59.341713 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 45 packets 1
2012-10-08 13:36:59.342715 > ACL data: handle 45 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 09 ff 01 02 5c                                    ....\
2012-10-08 13:36:59.430914 < ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.430926 < ACL data: handle 45 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.430946 < ACL data: handle 48 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 6c 2c 31 2c 32 0a                                 l,1,2.
2012-10-08 13:36:59.436715 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 48 packets 1
2012-10-08 13:36:59.439713 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 45 packets 1
2012-10-08 13:36:59.531023 < ACL data: handle 45 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.531043 < ACL data: handle 48 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 6c 2c 31 2c 32 0a                                 l,1,2.
2012-10-08 13:36:59.538714 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 48 packets 1
2012-10-08 13:36:59.540714 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 45 packets 1
2012-10-08 13:36:59.540721 > ACL data: handle 48 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
2012-10-08 13:36:59.543715 > ACL data: handle 45 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 09 ff 01 02 5c                                    ....\
2012-10-08 13:36:59.631126 < ACL data: handle 45 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 0b ef 0d 6c 2c 31 2c 32  0a 9a                    ...l,1,2..
2012-10-08 13:36:59.631132 < ACL data: handle 48 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 6c 2c 31 2c 32 0a                                 l,1,2.
2012-10-08 13:36:59.636714 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 45 packets 1
2012-10-08 13:36:59.638712 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 48 packets 1
2012-10-08 13:37:19.361788 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x08
    Reason: Connection Timeout


