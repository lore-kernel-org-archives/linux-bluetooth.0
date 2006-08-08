Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7b9ca310608080658h4e5e64c3i2e3448bc67fc5278@mail.gmail.com>
Date: Tue, 8 Aug 2006 09:58:19 -0400
From: "Michael Ellis" <michael.f.ellis@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <7b9ca310608071818v5871bb19y2593b7a693ca4ab6@mail.gmail.com>
MIME-Version: 1.0
References: <7b9ca310608071427nb9b9d28u86251148f66d7bac@mail.gmail.com>
	<1154999049.3905.108.camel@aeonflux.holtmann.net>
	<7b9ca310608071818v5871bb19y2593b7a693ca4ab6@mail.gmail.com>
Subject: Re: [Bluez-users] dbus-1.pc not found
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0808943809=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0808943809==
Content-Type: multipart/alternative;
	boundary="----=_Part_11392_19120467.1155045499288"

------=_Part_11392_19120467.1155045499288
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/7/06, Michael Ellis <michael.f.ellis@gmail.com> wrote:
>
> Hi Marcel,
>
> Thanks! That did the trick and it installed without error.
>
> So, if I may be so bold as to ask a little more help :-),  I now have a
> configuration that almost works.  I can plug a DBT-120 dongle into the linux
>
>

More information:
Apologies for top posting previous reply. The following is output from
hcidump following the hcitool cc command

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0C:84:00:16:51 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0C:84:00:16:51
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:0C:84:00:16:51
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:0C:84:00:16:51
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0C:84:00:16:51
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:0C:84:00:16:51
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:0C:84:00:16:51
> HCI Event: Connect Complete (0x03) plen 11
    status 0x06 handle 41 bdaddr 00:0C:84:00:16:51 type ACL encrypt 0x00
    Error: PIN or Key Missing

So it looks like there's a problem with pin exchange. I'm not familiar
enough with hcidump to be sure which unit is complaining about the pin.
Both should be using 0000, for time being,  and that pin worked with the
same dongle from a Windows laptop.   My pin helper is a shell script that
simply contains:

#!/bin/sh
echo -n PIN:0000

I've tried various enabling and disable auth and encrypt and also tried
setting security to none.  In the latter case, the connection attempt times
out.

Any suggestions appreciated.

Thanks,

Mike

------=_Part_11392_19120467.1155045499288
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 8/7/06, <b class="gmail_sendername">Michael Ellis</b> &lt;<a href="mailto:michael.f.ellis@gmail.com">michael.f.ellis@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Hi Marcel,<br>
<br>
Thanks! That did the trick and it installed without error.&nbsp; <br>
<br>
So, if I may be so bold as to ask a little more help :-),&nbsp; I now
have a configuration that almost works.&nbsp; I can plug a DBT-120
dongle into the linux </div></blockquote></div><br>
More information:<br>
Apologies for top posting previous reply. The following is output from hcidump following the hcitool cc command<br>
<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0C:84:00:16:51 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 <br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0C:84:00:16:51<br>
&lt; HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0C:84:00:16:51<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp;&nbsp;&nbsp; Link Key Request Negative Reply (0x01|0x000c) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:0C:84:00:16:51<br>
&gt; HCI Event: PIN Code Request (0x16) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0C:84:00:16:51<br>
&lt; HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0C:84:00:16:51<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp;&nbsp;&nbsp; PIN Code Request Negative Reply (0x01|0x000e) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:0C:84:00:16:51<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x06 handle 41 bdaddr 00:0C:84:00:16:51 type ACL encrypt 0x00<br>
&nbsp;&nbsp;&nbsp; Error: PIN or Key Missing<br>
<br>
So it looks like there's a problem with pin exchange. I'm not familiar
enough with hcidump to be sure which unit is complaining about the
pin.&nbsp; Both should be using 0000, for time being,&nbsp; and that
pin worked with the same dongle from a Windows laptop.&nbsp;&nbsp; My
pin helper is a shell script that simply contains:<br>
<br>
#!/bin/sh<br>
echo -n PIN:0000<br>
<br>
I've tried various enabling and disable auth and encrypt and also tried
setting security to none.&nbsp; In the latter case, the connection
attempt times out.<br>
<br>
Any suggestions appreciated.<br>
<br>
Thanks,<br>
<br>
Mike&nbsp;<br>


------=_Part_11392_19120467.1155045499288--


--===============0808943809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0808943809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0808943809==--
