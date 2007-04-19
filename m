Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4626FF17.3010801@tlau.org>
Date: Wed, 18 Apr 2007 22:33:11 -0700
From: Tessa Lau <tlau@tlau.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4625B4FC.9000006@tlau.org>
	<1176939398.6741.24.camel@aeonflux.holtmann.net>
In-Reply-To: <1176939398.6741.24.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] "Can't get conn info" error pairing
 Treo	with	Bluetooth dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2060611143=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============2060611143==
Content-Type: multipart/alternative;
	boundary="------------020408010807060505080405"

This is a multi-part message in MIME format.
--------------020408010807060505080405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Here's the output from hcidump:

HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:07:E0:B9:8A:4A class 0x70020c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:07:E0:B9:8A:4A role 0x00
    Role: Master
 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x21 handle 1 bdaddr 00:07:E0:B9:8A:4A type ACL encrypt 0x00
    Error: Role Change Not Allowed
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:07:E0:B9:8A:4A
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:07:E0:B9:8A:4A
 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:07:E0:B9:8A:4A
 > HCI Event: Auth Complete (0x06) plen 3
    status 0x06 handle 1
    Error: PIN or Key Missing
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection


I am typing my PIN into the Treo when prompted, and it is the same one 
that I specified in the hcid.conf.

--Tessa

Marcel Holtmann wrote:
> Hi Tessa,
>
>   
>> I'm running Ubuntu Edgy.  I'm trying to pair a Treo 700p with the Linux 
>> box via a USB Bluetooth dongle:
>>
>>     Bus 004 Device 011: ID 1131:1001 Integrated System Solution Corp. 
>> KY-BT100 Bluetooth Adapter
>>
>> Linux seems to recognize the Bluetooth adapter.  Hciconfig reports it as 
>> device hci0:
>>
>> hci0:   Type: USB
>>         BD Address: 00:11:67:4F:E7:FF ACL MTU: 678:8 SCO MTU: 64:10
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:2934 acl:0 sco:0 events:180 errors:0
>>         TX bytes:2041 acl:0 sco:0 commands:99 errors:0
>>
>> In /etc/bluetooth/hcid.conf, I have the following settings:
>>
>> options {
>>         autoinit yes;
>>         security auto;
>>         pairing multi;
>>         passkey "XXXXX";
>> }
>>
>> When I initiate pairing from the Treo, it prompts me for a PIN and then 
>> immediately says that it's unable to add my computer to the trusted 
>> security list.  I see the following error in my daemon.log:
>>
>> Apr 17 22:41:23 localhost hcid[4203]: Device hci0 has been activated
>> Apr 17 22:41:42 localhost hcid[4203]: pin_code_request 
>> (sba=00:11:67:4F:E7:FF, dba=00:07:E0:B9:8A:4A)
>> Apr 17 22:41:42 localhost hcid[4203]: Can't get conn info: No such file 
>> or directory (2)
>>
>>  From looking at the code in hcid/security.c:358, it looks like this 
>> error occurs when the ioctl call returns ENOENT (No such file or 
>> directory).  What does this mean?  What file or directory is it looking 
>> for?  What else can I try to triage this problem?
>>     
>
> please run "hcidump -X -V" to see what is going on.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   

--------------020408010807060505080405
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Marcel,<br>
<br>
Here's the output from hcidump:<br>
<br>
HCI sniffer - Bluetooth packet analyzer ver 1.32<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:07:E0:B9:8A:4A class 0x70020c type ACL<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:07:E0:B9:8A:4A role 0x00<br>
&nbsp;&nbsp;&nbsp; Role: Master<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x21 handle 1 bdaddr 00:07:E0:B9:8A:4A type ACL encrypt 0x00<br>
&nbsp;&nbsp;&nbsp; Error: Role Change Not Allowed<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp;&nbsp;&nbsp; handle 1 slots 5<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 1 ptype 0xcc18<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 <br>
&gt; HCI Event: PIN Code Request (0x16) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:07:E0:B9:8A:4A<br>
&lt; HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:07:E0:B9:8A:4A<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp;&nbsp;&nbsp; PIN Code Request Negative Reply (0x01|0x000e) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:07:E0:B9:8A:4A<br>
&gt; HCI Event: Auth Complete (0x06) plen 3<br>
&nbsp;&nbsp;&nbsp; status 0x06 handle 1<br>
&nbsp;&nbsp;&nbsp; Error: PIN or Key Missing<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 1 reason 0x13<br>
&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>
<br>
<br>
I am typing my PIN into the Treo when prompted, and it is the same one
that I specified in the hcid.conf.<br>
<br>
--Tessa<br>
<br>
Marcel Holtmann wrote:
<blockquote cite="mid1176939398.6741.24.camel@aeonflux.holtmann.net"
 type="cite">
  <pre wrap="">Hi Tessa,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I'm running Ubuntu Edgy.  I'm trying to pair a Treo 700p with the Linux 
box via a USB Bluetooth dongle:

    Bus 004 Device 011: ID 1131:1001 Integrated System Solution Corp. 
KY-BT100 Bluetooth Adapter

Linux seems to recognize the Bluetooth adapter.  Hciconfig reports it as 
device hci0:

hci0:   Type: USB
        BD Address: 00:11:67:4F:E7:FF ACL MTU: 678:8 SCO MTU: 64:10
        UP RUNNING PSCAN ISCAN
        RX bytes:2934 acl:0 sco:0 events:180 errors:0
        TX bytes:2041 acl:0 sco:0 commands:99 errors:0

In /etc/bluetooth/hcid.conf, I have the following settings:

options {
        autoinit yes;
        security auto;
        pairing multi;
        passkey "XXXXX";
}

When I initiate pairing from the Treo, it prompts me for a PIN and then 
immediately says that it's unable to add my computer to the trusted 
security list.  I see the following error in my daemon.log:

Apr 17 22:41:23 localhost hcid[4203]: Device hci0 has been activated
Apr 17 22:41:42 localhost hcid[4203]: pin_code_request 
(sba=00:11:67:4F:E7:FF, dba=00:07:E0:B9:8A:4A)
Apr 17 22:41:42 localhost hcid[4203]: Can't get conn info: No such file 
or directory (2)

 From looking at the code in hcid/security.c:358, it looks like this 
error occurs when the ioctl call returns ENOENT (No such file or 
directory).  What does this mean?  What file or directory is it looking 
for?  What else can I try to triage this problem?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
please run "hcidump -X -V" to see what is going on.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
<a class="moz-txt-link-freetext" href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>

  </pre>
</blockquote>
</body>
</html>

--------------020408010807060505080405--


--===============2060611143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2060611143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2060611143==--
