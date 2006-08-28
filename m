Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e4f1f0110608280930l3475b147ob2f7f3e5e6bf5efe@mail.gmail.com>
Date: Mon, 28 Aug 2006 17:30:55 +0100
From: "jonny Linux" <jonnylinux@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <e1effdeb0608280517l13c117fg4f958870027c4595@mail.gmail.com>
MIME-Version: 1.0
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
	<e1effdeb0608280517l13c117fg4f958870027c4595@mail.gmail.com>
Subject: Re: [Bluez-users] How do I reset a pairing?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1249449889=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1249449889==
Content-Type: multipart/alternative;
	boundary="----=_Part_114233_31389793.1156782655627"

------=_Part_114233_31389793.1156782655627
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/28/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>
> Hi Jonny,
>
> You can use the D-Bus services to do remove the link key:
> $dbus-send --system --type=method_call --print-reply --dest=org.bluez/org/bluez/hci0
> org.bluez.Adapter.RemoveBonding
> string:XX:XX:XX:XX:XX:XX
>
>
> or remove the entry in the file:
> /var/lib/bluetooth/local_bt_address/linkkeys



Thanks Claudio, I couldn't get that command to work, I got an error:
Must use org.mydomain.Interface.Method notation, no dot in
"string:00:16:53:03:1D:31"
So I removed the entry in the linkkeys file.

The NXT device asks me for a PIN, but the computer doesn't ask for a pin, I
then get a connection error in the perl script I'm using which says "Invalid
Exchange".

Below is the results of hcidump -X -a -V:

Any ideas?

Thanks,

Jonny

HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:53:03:1D:31
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:16:53:03:1D:31
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:16:53:03:1D:31
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:16:53:03:1D:31
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:16:53:03:1D:31
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:16:53:03:1D:31
> HCI Event: Connect Complete (0x03) plen 11
    status 0x06 handle 11 bdaddr 00:16:53:03:1D:31 type ACL encrypt 0x00
    Error: PIN or Key Missing
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:53:03:1D:31
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:16:53:03:1D:31
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:16:53:03:1D:31

------=_Part_114233_31389793.1156782655627
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 8/28/06, <b class="gmail_sendername">Claudio Takahasi</b> &lt;<a href="mailto:cktakahasi@gmail.com">cktakahasi@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Jonny,<br><br>You can use the D-Bus services to do remove the link key:<br>$dbus-send --system --type=method_call --print-reply --dest=org.bluez/org/bluez/hci0 org.bluez.Adapter.RemoveBonding<br>string:XX:XX:XX:XX:XX:XX
<br><br><br>or remove the entry in the file:<br>/var/lib/bluetooth/local_bt_address/linkkeys</blockquote><div><br><br>Thanks Claudio, I couldn't get that command to work, I got an error:<br>Must use org.mydomain.Interface.Method
 notation, no dot in &quot;string:00:16:53:03:1D:31&quot;<br>So I removed the entry in the linkkeys file.<br><br>The NXT device asks me for a PIN, but the computer doesn't ask for a pin, I then get a connection error in the perl script I'm using which says &quot;Invalid Exchange&quot;.
<br><br>Below is the results of hcidump -X -a -V:<br><br>Any ideas?<br><br>Thanks,<br><br>Jonny<br><br>HCI sniffer - Bluetooth packet analyzer ver 1.30<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13
<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 <br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1
<br>&gt; HCI Event: Link Key Request (0x17) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31<br>&lt; HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31<br>&gt; HCI Event: Command Complete (0x0e) plen 10
<br>&nbsp;&nbsp;&nbsp; Link Key Request Negative Reply (0x01|0x000c) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:53:03:1D:31<br>&gt; HCI Event: PIN Code Request (0x16) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31<br>&lt; HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; PIN Code Request Negative Reply (0x01|0x000e) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:53:03:1D:31<br>&gt; HCI Event: Connect Complete (0x03) plen 11
<br>&nbsp;&nbsp;&nbsp; status 0x06 handle 11 bdaddr 00:16:53:03:1D:31 type ACL encrypt 0x00<br>&nbsp;&nbsp;&nbsp; Error: PIN or Key Missing<br>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 <br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>&gt; HCI Event: Link Key Request (0x17) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31
<br>&lt; HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:53:03:1D:31<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; Link Key Request Negative Reply (0x01|0x000c) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:53:03:1D:31<br><br><br><br></div><br></div><br>

------=_Part_114233_31389793.1156782655627--


--===============1249449889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1249449889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1249449889==--
