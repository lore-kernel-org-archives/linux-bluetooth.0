Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <18a15270707031238n2cfe388ay3843e6939b890a8f@mail.gmail.com>
Date: Tue, 3 Jul 2007 20:38:09 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        cbe-oss-dev@ozlabs.org
In-Reply-To: <1183433306.6351.19.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com>
	<1183433306.6351.19.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] [PATCH] bluetooth: reset unexpected connections
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1204087791=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1204087791==
Content-Type: multipart/alternative;
	boundary="----=_Part_105830_1519134.1183491489510"

------=_Part_105830_1519134.1183491489510
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

> this is not a proper fix for this problem. And you only reset the local
> host controller. There is no way to send a reset to the remote device.

I'm pretty new to both bluetooth and HID in general, so I'm happy to take
your word for it that I'm doing the wrong thing. I would dispute the claim
that there is no way to send a reset to the remote device, as calling
hci_reset_req causes the remote device to stop sending packets almost
immediately (5 more packets arrive compared to 70 per second before). Even
the lights turn off immediately.

I don't know enough about the stack to know exactly what is going on, but
certainly hci_reset_req does appear to send a reset command somewhere:

    hci_send_cmd(hdev, OGF_HOST_CTL, OCF_RESET, 0, NULL);

and it takes a hdev which as far as I can make it represents a specific
connection to a remote device rather than the entire local stack.

> Did you ever used hcidump and try to find out, why the other side still
> things that we are connected. Especially why the local controller things
> that we are still connected.

Obviously, as these devices are already pumping out data before the machine
boots, I've no way of tracking what if any negotiation linux might have
attempted to make with them. There's nothing interesting in the syslog
before that point:

Jul  3 18:41:52 ps3 kernel: eth0: no IPv6 routers present
Jul  3 18:41:52 ps3 hcid[2291]: Bluetooth HCI daemon
Jul  3 18:41:52 ps3 kernel: Bluetooth: L2CAP ver 2.8
Jul  3 18:41:52 ps3 kernel: Bluetooth: L2CAP socket layer initialized
Jul  3 18:41:52 ps3 hcid[2291]: HCI dev 0 registered
Jul  3 18:41:52 ps3 hcid[2291]: Starting SDP server
Jul  3 18:41:52 ps3 kernel: Bluetooth: HIDP (Human Interface Emulation) ver
1.2
Jul  3 18:41:52 ps3 hcid[2291]: HCI dev 0 up
Jul  3 18:41:52 ps3 hcid[2291]: Device hci0 has been added
Jul  3 18:41:53 ps3 hidd[2302]: Bluetooth HID daemon
Jul  3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for unknown
connection handle 43 ()
Jul  3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for unknown
connection handle 47 ()
Jul  3 18:41:53 ps3 last message repeated 3 times
Jul  3 18:41:53 ps3 hcid[2291]: Device hci0 has been activated
Jul  3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for unknown
connection handle 43 ()
Jul  3 18:41:53 ps3 last message repeated 3 times
Jul  3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for unknown
connection handle 47 ()
Jul  3 18:41:53 ps3 last message repeated 3 times

Certainly nothing in the data has changed, which is exactly the same as
before the reboot (here are two devices broadcasting simultaneously):

> ACL data: handle 47 flags 0x02 dlen 54
    L2CAP(d): cid 0x0041 len 50 [psm 0]
      A1 01 00 00 00 00 00 8B 79 8C 78 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 03 03 14 FF B5 00 12 23 FA 77
      01 81 02 07 01 EE 01 96 00 02
> ACL data: handle 43 flags 0x02 dlen 54
    L2CAP(d): cid 0x0041 len 50 [psm 0]
      A1 01 00 00 00 00 00 79 7A 77 7F 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 03 05 14 FF BA 00 0C 23 16 77
      01 81 02 07 01 EF 01 94 00 02
> ACL data: handle 43 flags 0x02 dlen 54
    L2CAP(d): cid 0x0041 len 50 [psm 0]
      A1 01 00 00 00 00 00 79 7A 77 7F 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 03 05 14 FF BA 00 0C 23 16 77
      01 81 02 07 01 EF 01 93 00 02

etc.

Additionally, because the linux subsystem hasn't connected with them at this
point, there's no way of initiating a connection with them or stopping them:


root@ps3:~# hcitool con
Connections:
root@ps3:~# hidd list
root@ps3:~#

> The PS3 remote controller (and the PS3 itself) have special hacked up
> version of Bluetooth firmware to play nice with remote wakeup. So it
> might simply be an issue with them and it might be better we declare
> them broken instead of adding nasty crap in a clean Bluetooth core. Your
> patch is nasty crap since I haven't seen any real argument why we should
> reset our local controller in that case. It is wild guessing.

You might be happy to declare these controllers broken, however they exist
and people want to use them.

Do you have any suggestions of an alternative approach to handling this
error condition rather than just filling up the syslog? It's definitely a
very real DOS possibility - my syslog was growing by about 1Mb per minute
with just two regular controllers. Someone who deliberately constructed a
device to bombard a linux box with junk bluetooth data could probably fill
someone's /var partition in a matter of hours.

Cheers,
   Ralf.

------=_Part_105830_1519134.1183491489510
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div>Hi Marcel,<br><br>&gt; this is not a proper fix for this problem. And you only reset the local<br>&gt; host controller. There is no way to send a reset to the remote device.<br></div><div><br>I&#39;m pretty new to both bluetooth and HID in general, so I&#39;m happy to take your word for it that I&#39;m doing the wrong thing. I would dispute the claim that there is no way to send a reset to the remote device, as calling hci_reset_req causes the remote device to stop sending packets almost immediately (5 more packets arrive compared to 70 per second before). Even the lights turn off immediately.
<br><br>I don&#39;t know enough about the stack to know exactly what is going on, but certainly hci_reset_req does appear to send a reset command somewhere:<br><br>&nbsp;&nbsp;&nbsp; hci_send_cmd(hdev, OGF_HOST_CTL, OCF_RESET, 0, NULL);
<br><br>and it takes a hdev which as far as I can make it represents a specific connection to a remote device rather than the entire local stack.<br><br>&gt; Did you ever used hcidump and try to find out, why the other side still
<br>&gt; things that we are connected. Especially why the local controller things
<br>&gt; that we are still connected.</div><div><br>Obviously, as these devices are already pumping out data before the machine boots, I&#39;ve no way of tracking what if any negotiation linux might have attempted to make with them.
There&#39;s nothing interesting in the syslog before that point:<br><br>Jul&nbsp; 3 18:41:52 ps3 kernel: eth0: no IPv6 routers present<br>Jul&nbsp; 3 18:41:52 ps3 hcid[2291]: Bluetooth HCI daemon<br>Jul&nbsp; 3 18:41:52 ps3 kernel: Bluetooth: L2CAP ver 
2.8<br>Jul&nbsp; 3 18:41:52 ps3 kernel: Bluetooth: L2CAP socket layer initialized<br>Jul&nbsp; 3 18:41:52 ps3 hcid[2291]: HCI dev 0 registered<br>Jul&nbsp; 3 18:41:52 ps3 hcid[2291]: Starting SDP server<br>Jul&nbsp; 3 18:41:52 ps3 kernel: Bluetooth: HIDP (Human Interface Emulation) ver 
1.2<br>Jul&nbsp; 3 18:41:52 ps3 hcid[2291]: HCI dev 0 up<br>Jul&nbsp; 3 18:41:52 ps3 hcid[2291]: Device hci0 has been added<br>Jul&nbsp; 3 18:41:53 ps3 hidd[2302]: Bluetooth HID daemon<br>Jul&nbsp; 3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 43 ()
<br>Jul&nbsp; 3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 47 ()<br>Jul&nbsp; 3 18:41:53 ps3 last message repeated 3 times<br>Jul&nbsp; 3 18:41:53 ps3 hcid[2291]: Device hci0 has been activated
<br>Jul&nbsp; 3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 43 ()<br>Jul&nbsp; 3 18:41:53 ps3 last message repeated 3 times<br>Jul&nbsp; 3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 47 ()
<br>Jul&nbsp; 3 18:41:53 ps3 last message repeated 3 times<br><br>Certainly nothing in the data has changed, which is exactly the same as before the reboot (here are two devices broadcasting simultaneously):<br><br>&gt; ACL data: handle 47 flags 0x02 dlen 54
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 50 [psm 0]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A1 01 00 00 00 00 00 8B 79 8C 78 00 00 00 00 00 00 00 00 00 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 00 00 00 00 00 00 00 00 00 03 03 14 FF B5 00 12 23 FA 77 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 81 02 07 01 EE 01 96 00 02 <br>&gt; ACL data: handle 43 flags 0x02 dlen 54
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 50 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A1 01 00 00 00 00 00 79 7A 77 7F 00 00 00 00 00 00 00 00 00 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 00 00 00 00 00 00 00 00 00 03 05 14 FF BA 00 0C 23 16 77 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 81 02 07 01 EF 01 94 00 02 
<br>&gt; ACL data: handle 43 flags 0x02 dlen 54<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 50 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A1 01 00 00 00 00 00 79 7A 77 7F 00 00 00 00 00 00 00 00 00 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 00 00 00 00 00 00 00 00 00 03 05 14 FF BA 00 0C 23 16 77 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 81 02 07 01 EF 01 93 00 02 <br><br>etc.<br><br>Additionally, because the linux subsystem hasn&#39;t connected with them at this point, there&#39;s no way of initiating a connection with them or stopping them:
<br><br>root@ps3:~# hcitool con<br>Connections:<br>root@ps3:~# hidd list<br>root@ps3:~# <br><br>&gt; The PS3 remote controller (and the PS3 itself) have special hacked up<br>&gt; version of Bluetooth firmware to play nice with remote wakeup. So it
<br>&gt; might simply be an issue with them and it might be better we declare<br>&gt; them broken instead of adding nasty crap in a clean Bluetooth core. Your
<br>&gt; patch is nasty crap since I haven&#39;t seen any real argument why we should<br>&gt; reset our local controller in that case. It is wild guessing.<br></div><div><br>You might be happy to declare these controllers broken, however they exist and people want to use them.
<br><br>Do you have any suggestions of an alternative approach to handling this error condition rather than just filling up the syslog? It&#39;s definitely a very real DOS possibility - my syslog was growing by about 1Mb per minute with just two regular controllers. Someone who deliberately constructed a device to bombard a linux box with junk bluetooth data could probably fill someone&#39;s /var partition in a matter of hours.
<br><br>Cheers,<br>&nbsp;&nbsp; Ralf.</div></div><br>

------=_Part_105830_1519134.1183491489510--


--===============1204087791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1204087791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1204087791==--
