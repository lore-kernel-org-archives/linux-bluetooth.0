Return-Path: <cyrus@holtmann.org>
Message-ID: <503568C5.4040000@globaledgesoft.com>
Date: Wed, 22 Aug 2012 19:18:29 -0400
From: Ajay KV <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Re : BLE -Multiple connection
References: <503545C5.80607@globaledgesoft.com> <CAJdJm_NHy82UOofuQv1jGObJPg4MOj68R3D_xcBjNhCZWdy9Hw@mail.gmail.com>
In-Reply-To: <CAJdJm_NHy82UOofuQv1jGObJPg4MOj68R3D_xcBjNhCZWdy9Hw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/22/2012 08:24 AM, Anderson Lizardo wrote:
> Hi Ajay,
>
> On Wed, Aug 22, 2012 at 4:49 PM, Ajay KV<ajay.kv@globaledgesoft.com>  wrote:
>>              I think we already discussed about this issue  . following is
>> our previous conversation. please go through it
>
> Please, try to disable HTML on your email client and send plain text
> e-mails. It is difficult to follow your discussion with all this HTML.
> It is very likely people are not helping you because your emails are
> unreadable for a lot of people here.
>
> Much information is missing from your previous messages:
>
> 1) You did not provide the exact steps you followed (which commands
> you run after plugging the bluetooth dongle). Therefore it is
> difficult to reproduce your tests.
> 2) Your HCI dump output shows just the command giving error. This is
> not enough, you should provide the entire dump since the adapter was
> plugged, including the first "B to A" connection you described, and
> the second LE advertising attempt, otherwise it is not possible to
> identify at which state the LE controller is when the LE adv. enable
> command is issued.
>
> Also, do you realize that you are not allowed by the current Core spec
> v4.0 to have one dual mode device connected to another dual mode over
> the LE link? The spec says that a dual mode device in "connectable
> mode" (like device "A" in you original scenario) shall not be issuing
> connectable advertising over the LE channel. This is not enforced by
> the controller (and we actually do this for testing BlueZ to BlueZ
> connections over LE), but the spec explicitly forbids it.
>
> Regards,



Hi Anderson,

	First of all, sorry for my ignorance . Following are the steps i did in 
my test case.  i am also using dual mode dongles , so as you said  spec 
is not allowing us to do  this operation

In device A side:

1: Enable advertise using  hciconfig  hci0 leadv
2: run "l2test" tool in bluez  as a  server   ( slight modification has 
been made  in this code, like we are explicitly making cid as 0x04 )

  In Device B side:

1: Enable scanning  using  hcitool lescan
2: run "l2test -S <bdaddr A>"   as a  client   ( slight modification has 
been made  in this code, like we are explicitly making cid as 0x04)

      now the LE  connection is established  b/w A and B and data starts 
transferring

In this state i can not able to enable or disable advertise again , 
showing "command disallowed"

In Device C side

1; Enabled LE scanning , but device A is not detecting since it is 
connected to device B
2: ran  l2test -s <bdaddr A > as client  gives connection timed out


   Only essential log messages are given below
  DEVICE A

< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
     value 0x01 (advertising enabled)
 > HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertise Enable (0x08|0x000a) ncmd 1
 > HCI Event: LE Meta Event (0x3e) plen 19
     LE Connection Complete
       status 0x00 handle 43, role slave

data  receiving.......

DEVICE B
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
     bdaddr 00:1B:DC:05:E0:5D type 0
 > HCI Event: Command Status (0x0f) plen 4
     LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
 > HCI Event: LE Meta Event (0x3e) plen 19
     LE Connection Complete
       status 0x00 handle 64, role master

data sending.......

  Now if tries to enable or disable advertising  in Device A it shows 
error as follows

root@localhost ~]# hciconfig 0 leadv
LE set advertise enable on hci0 returned status 12

< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
     value 0x01 (advertising enabled)
 > HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertise Enable (0x08|0x000a) ncmd 1
     status 0x0c pktlen 0x0004 maxpkt 0x38
     Error: Command Disallowed



DEVICE C

< HCI Command: LE Create Connection (0x08|0x000d) plen 25
     bdaddr 00:1B:DC:05:E0:5D type 0
 > HCI Event: Command Status (0x0f) plen 4
     LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
< HCI Command: LE Create Connection Cancel (0x08|0x000e)plen 0
 > HCI Event: Command Complete (0x0e) plen 4
     LE Create Connection Cancel (0x08|0x000e) ncmd 1
 > HCI Event: LE Meta Event (0x3e) plen 19
     LE Connection Complete
       status 0x02 handle 0, role master


BR,
   ajay.kv












	
















	
	




