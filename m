Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
Date: Sun, 27 Aug 2006 13:18:29 +0100
From: "jonny Linux" <jonnylinux@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
MIME-Version: 1.0
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2047041236=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2047041236==
Content-Type: multipart/alternative;
	boundary="----=_Part_99711_24375783.1156681109228"

------=_Part_99711_24375783.1156681109228
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> If I try to connect from the laptop I get no problems connecting. But if I
> try to connect from the desktop I get a "Permission denied error", or if I
> try "hcitool cc <ba>" I get "Can't create connection: Input/output error".
>
> I don't get asked for a pin when I connect from the desktop, but I think I
> was once asked for a pin. So I think somehow the pairing between the devices
> has been broken. Is there anyway I can reset the pairing between the desktop
> and the NXT?
>


Hi,

Sorry to reply to my own post, but I'm still having problems with this and
I'd really like to get it working. I've tried using hciconfig delkey, but
nothing seems to happen. Is delkey the command I should be trying to use?
Which address should I give as a parameter to delkey, should it be the
address of the bluetooth device I'm trying to connect to (the NXT) or the
local bluetooth device (the USB dongle plugged into the computer)?

Whenever I try to use "hciconfig delkey" there is no output, and it always
exits with exit code 0. Is there any way to make it ask me which pin I want
to use with the device?

Thanks,

Jonny

------=_Part_99711_24375783.1156681109228
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>If I try to connect from the laptop I get no problems connecting. But if I try to connect from the desktop I get a &quot;Permission denied error&quot;, or if I try &quot;hcitool cc &lt;ba&gt;&quot; I get &quot;Can't create connection: Input/output error&quot;.
<br><br>I don't get asked for a pin when I connect from the desktop, but I think I was once asked for a pin. So I think somehow the pairing between the devices has been broken. Is there anyway I can reset the pairing between the desktop and the NXT?
</div></blockquote><div><br><br>Hi,<br><br>Sorry to reply to my own post, but I'm still having problems with this and I'd really like to get it working. I've tried using hciconfig delkey, but nothing seems to happen. Is delkey the command I should be trying to use? Which address should I give as a parameter to delkey, should it be the address of the bluetooth device I'm trying to connect to (the NXT) or the local bluetooth device (the USB dongle plugged into the computer)?
<br><br>Whenever I try to use &quot;hciconfig delkey&quot; there is no output, and it always exits with exit code 0. Is there any way to make it ask me which pin I want to use with the device?<br><br>Thanks,<br><br>Jonny<br>
</div><br></div><br>

------=_Part_99711_24375783.1156681109228--


--===============2047041236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2047041236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2047041236==--
