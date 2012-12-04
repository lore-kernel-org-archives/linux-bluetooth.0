Return-Path: <cyrus@holtmann.org>
Message-ID: <50BE45BB.409@globaledgesoft.com>
Date: Wed, 05 Dec 2012 00:19:31 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BLE issue: Start_LE_Encryption fails
References: <508D6672.8000009@globaledgesoft.com> <CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com> <CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com> <508DCE10.40801@globaledgesoft.com> <CAJdJm_P=USyDO5op7_7ynOT8Qe7dOifyN=notezK1HGCxOe8bA@mail.gmail.com> <508DDCE7.6030708@globaledgesoft.com> <CAJdJm_PLSAZBc+ef_YXsmQ+VE5aW3aD_CPs3x2Y7gY+8zY19Bw@mail.gmail.com>
In-Reply-To: <CAJdJm_PLSAZBc+ef_YXsmQ+VE5aW3aD_CPs3x2Y7gY+8zY19Bw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------060108010605040606050106"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060108010605040606050106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Sun, Oct 28, 2012 at 1:08 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
 > Hi,
 >         I am getting le_long_term_key_negative reply  from the remote 
device
 > , on sending le_start_encryption . I am testing this with 2 ubuntu
 > machines(3.2.5) with IOGEAR dual mode dongles .

To connect to a dual mode dongle, you need to set LE Adv. flags to
0x06 (which means general discoverable + BR/EDR not supported) on the
acceptor side. You can use this command (on the acceptor/slave side):

sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
     $(perl -e 'print "00 " x 28')

Next, enable LE advertising:

sudo hciconfig hci0 leadv

On the initiator/master side, run "hcitool lescan" and try pairing again.





Hi Ajay,

On Sun, Oct 28, 2012 at 8:30 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
 > Thanks, but "sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 " ,   this
 > command only sets the advertising data to zero right . so how do i 
set the
 > adv flag as 0x06 . Which hci command is used for this  purpose .

No, this sets adv. data to have "Flags" AD set to 0x06. But you missed
the second line of the command:

sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
     $(perl -e 'print "00 " x 28')

The second line is important because it fills the other bytes with
zero (which some controllers require).





On Tuesday 30 October 2012 07:45 PM, Anderson Lizardo wrote:
> Hi Ajay,
>
> On Sun, Oct 28, 2012 at 9:33 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>>   ya , i got your point ,advertiser is informing the remote device  , that it
>> is not BR/EDR capable .That is done and device is connecting now.
>>          But  still i dont know, how to do le specific pairing and
>> start_encryption enable(part of le pairing) . Is there any tool in bluez
>> providing LE pairing before connecting the devices (want to try with 2
>> ubuntu pc's ).
>
> We use the "simple-agent" script from test/ directory in BlueZ for pairing.
>
> On the slave side run:
>
> test/simple-agent hci0
>
> on the master side, after "hcitool lescan", run:
>
> test/simple-agent hci0 <slave-address>
>
> This should trigger Just Works SMP pairing.
>
> Regards,
>


Hi,
     I have included some of our previous conversations  related to this 
issue.

I got some error while testing the above case for LE pairing using 
simple_agent . kindly find a solution



MASTER side
Steps followed
root@test:/home# hcitool lescan

root@test:/home# ./simple-agent  hci0 00:02:72:D6:A1:0D

Creating device failed: org.freedesktop.DBus.Error.NoReply: Did not 
receive a reply. Possible causes include: the remote application did not 
send a reply, the message bus security policy blocked the reply, the 
reply timeout expired, or the network connection was broken.

hcidump on master side
********************************************************************************
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
     type 0x01 (active)
     interval 10.000ms window 10.000ms
     own address: 0x00 (Public) policy: All
 > HCI Event: Command Complete (0x0e) plen 4
     LE Set Scan Parameters (0x08|0x000b) ncmd 1
     status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
     value 0x01 (scanning enabled)
     filter duplicates 0x00 (disabled)
 > HCI Event: Command Complete (0x0e) plen 4
     LE Set Scan Enable (0x08|0x000c) ncmd 1
     status 0x00

       RSSI: -71
 > HCI Event: LE Meta Event (0x3e) plen 12
     LE Advertising Report
       SCAN_RSP - Scan Response (4)
       bdaddr 00:02:72:D6:A1:0D (Public)
       RSSI: -70
 > HCI Event: LE Meta Event (0x3e) plen 15
     LE Advertising Report
       ADV_IND - Connectable undirected advertising (0)
       bdaddr 00:02:72:D6:A1:0D (Public)
       Flags: 0x06
       RSSI: -69

 > HCI Event: LE Meta Event (0x3e) plen 12
     LE Advertising Report
       SCAN_RSP - Scan Response (4)
       bdaddr 00:02:72:D6:A1:0D (Public)

< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
     value 0x00 (scanning disabled)
     filter duplicates 0x00 (disabled)
 > HCI Event: Command Complete (0x0e) plen 4
     LE Set Scan Enable (0x08|0x000c) ncmd 1
     status 0x00
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
     bdaddr 00:02:72:D6:A1:0D type 0
 > HCI Event: Command Status (0x0f) plen 4
     LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
 > HCI Event: LE Meta Event (0x3e) plen 19
     LE Connection Complete
       status 0x00 handle 64, role master
< ACL data: handle 64 flags 0x00 dlen 11
     ATT: Read By Group req (0x10)
       start 0x0001, end 0xffff
       type-uuid 0x2800
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 64 packets 1
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
     handle 64
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
 > HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
     status 0x00 handle 64
     LMP Version: 4.0 (0x6) LMP Subversion: 0x220e
     Manufacturer: Broadcom Corporation (15)
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 64 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 64 reason 0x16
     Reason: Connection Terminated by Local Host


SLAVE side

root@test:/home#  hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
     			$(perl -e 'print "00 " x 28')
root@test:/home# hciconfig hci0  leadv


Hcidump shows ..

< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
 > HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertising Data (0x08|0x0008) ncmd 1
     status 0x00
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
 > HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertise Enable (0x08|0x000a) ncmd 1
     status 0x00

 > HCI Event: LE Meta Event (0x3e) plen 19
     LE Connection Complete
       status 0x00 handle 64, role slave
       bdaddr 00:02:72:D6:AB:AD (Public)
 > ACL data: handle 64 flags 0x02 dlen 11
     ATT: Read By Group req (0x10)
       start 0x0001, end 0xffff
       type-uuid 0x2800
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 64 reason 0x13
     Reason: Remote User Terminated Connection

***************************************************************************


-- 
Thanks & Regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703

--------------060108010605040606050106
Content-Type: text/x-vcard; charset=utf-8;
 name="ajay_kv.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ajay_kv.vcf"

begin:vcard
fn:AJAY KV
n:;AJAY
tel;cell:8892753703
version:2.1
end:vcard


--------------060108010605040606050106--
