Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41D3600B.8000702@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] rfcomm socket and rfcomm tty
References: <41D12158.6020206@avantwave.com> <1104315958.6319.13.camel@notepaq>
In-Reply-To: <1104315958.6319.13.camel@notepaq>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 30 Dec 2004 09:55:23 +0800

Dear Marcel
    Thanks for your clarification.
    Here come to a question , i am wrting a socket rfcomm program and 
try to use it connect to a bluetooth rfcomm channel by bluez-util rfcomm 
listen from two different computer. My program gives out "Resource 
temporarily unavailable" after connect system call . Here is the hcidump 
from listening side, there is a pause from listening side when connect 
system call fail.

 > HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
 > HCI Event: Max Slots Change (0x1b) plen 3
 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
------------------------------------------------------------------------------- 
Pause here
 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 6 pf 1 ilen 0 fcs 0x32
 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Disconn Complete (0x05) plen 4

    Thanks for helping
best regard
Mike,Lee


Marcel Holtmann wrote:

>Hi Mike,
>
>  
>
>>    I have little knowledge on tty structure, so i want to clarify 
>>something is that, if i want to connect to a rfcomm enabled phone. Are 
>>there any difference when i sending raw data to the phone with tty 
>>rfcomm and socket rfcomm? I ask this question because i see that from 
>>bluez-util rfcomm source code, tty connection is built up from socket 
>>first and then set the tty attr. So if i do not need tty functions, only 
>>read/write from/to external device is needed, socket rfcomm will be more 
>>simple. Am i right?
>>    
>>
>
>this is right. The RFCOMM socket is the native interface and the TTY is
>only there for legacy reasons.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
