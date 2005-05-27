Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Eric Vaandering <ewv@fnal.gov>
Subject: Re: [Bluez-users] Problem with dund and LG 325 phone.
In-reply-to: <1117143784.12036.78.camel@pegasus>
To: bluez-users@lists.sourceforge.net
Message-id: <42967B9B.2000203@fnal.gov>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <42962705.9010902@fnal.gov> <1117143784.12036.78.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 26 May 2005 20:44:59 -0500

Marcel, thanks that helped and at one point I got the phone dialing, but not 
anymore. I'm still getting "Connection refused" errors. The computer and phone 
are definitely paired since I can use kbthandsfree.

If I issue these commands:

   748  echo 1 > /proc/sys/net/ipv4/ip_forward
   749  rfcomm bind 0 08:00:37:13:A1:C7 4
   750  pppd /dev/rfcomm0 debug nocrtscts novj novjccomp defaultroute connect 
'chat -v -f /root/sprint-chat'

May 26 20:38:12 localhost pppd[4987]: pppd 2.4.3 started by root, uid 0
May 26 20:38:13 localhost hcid[3622]: link_key_request (sba=00:10:60:AA:5C:CE, 
dba=08:00:37:13:A1:C7)
May 26 20:38:13 localhost pppd[4987]: Failed to open /dev/rfcomm0: Connection 
refused
May 26 20:38:13 localhost pppd[4987]: Exit.

This is what hcidump shows (sorry for the length, but I don't know what's 
important)

# hcidump
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
 > HCI Event: Command Complete (0x0e) plen 10
 > HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
 > HCI Event: Command Complete (0x0e) plen 6
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Max Slots Change (0x1b) plen 3
 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
     MTU 1024
 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
     MTU 675
< ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0029 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 8 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 670 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 8 pf 0 ilen 0 fcs 0xf6
< ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Disconn Complete (0x05) plen 4
< HCI Command: Inquiry (0x01|0x0001) plen 5
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Inquiry Result (0x02) plen 15
 > HCI Event: Inquiry Complete (0x01) plen 1

after this, even cat or echo to rfcomm0 gives me a connection refused error.

Thanks for any help,

Eric



Marcel Holtmann wrote:
> Hi Eric,
> 
> 
>>I have an LG PM-325 which I am trying to get DUN working with. It works under
>>Windows, but I want to use linux.
>>
>>I think the two devices are paired since I can do l2ping and get responses,
>>but I still seem to be a few steps away from being able to do DUN.
>>
>>When I type this, I expect to get a success message back, right? Instead I get 
>>nothing:
>>
>>[root@a122077 root]# dund -c 08:00:37:13:A1:C7 -n
>>dund[5586]: Bluetooth DUN daemon
>>dund[5586]: Searching for LAP on 08:00:37:13:A1:C7
>>[root@a122077 root]#
>>
>>I don't have to do anything with rfcomm before this, right? I also don't need 
>>to run pand, right, since my device only supports DUN.
>>
>>When I try to do a pppd call command, I get this in syslog:
>>May 26 14:43:02 a122077 kernel: PPP generic driver version 2.4.2
>>May 26 14:43:02 a122077 pppd[5708]: pppd 2.4.3 started by root, uid 0
>>May 26 14:43:03 a122077 hcid[3602]: link_key_request (sba=00:10:60:AA:5C:CE, 
>>dba=08:00:37:13:A1:C7)
>>May 26 14:43:03 a122077 pppd[5708]: Failed to open /dev/rfcomm0: Connection 
>>refused
>>May 26 14:43:03 a122077 pppd[5708]: Exit.
>>
>>which isn't surprising.
> 
> 
> using dund for Dialup-Networking is the wrong way. The dund is for LAN
> access using PPP. And yes, I know that the name is confusing.
> 
> What you need is to find the RFCOMM channel number for Dialup-Networking
> with the help of
> 
> 	sdptool search --bdaddr <bdaddr> dun
> 
> and then you bind a RFCOMM TTY port to that channel with
> 
> 	rfcomm bind 0 <bdaddr> <channel>
> 
> After that you can use any dialer (for example wvdial) to setup your
> dialup connection through /dev/rfcomm0.
> 
> Regards
> 
> Marcel


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
