Return-Path: <cyrus@holtmann.org>
Message-ID: <8c7950360811240958x79ac94e4we897f55756f7cfc8@mail.gmail.com>
Date: Mon, 24 Nov 2008 12:58:11 -0500
From: "Shane Volpe" <shanevolpe@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <8c7950360809160950m35e259e0r76d1dac49be67d1b@mail.gmail.com>
MIME-Version: 1.0
References: <8c7950360809160950m35e259e0r76d1dac49be67d1b@mail.gmail.com>
Subject: Re: [Bluez-users] Help with setting up NAP
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7930764821745160245=="
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============7930764821745160245==
Content-Type: multipart/alternative;
	boundary="----=_Part_117138_20769377.1227549491271"

------=_Part_117138_20769377.1227549491271
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I did not get a reply back to this so I'm re-posting it, is there additional
information I need to provide?
Regards,
Shane

On Tue, Sep 16, 2008 at 11:50 AM, Shane Volpe <shanevolpe@gmail.com> wrote:

> I'm trying to understand the best way to set up a device as a NAP.
> The old way I performed this was by using pand with the following
> options:
> PAND_OPTIONS=" --secure --listen --master --role  NAP
> --devup=/etc/bluetooth/pan/dev-up"
>
> Moving forward I want to use dbus commands and configure the NAP the
> *right* way.
>
> Here is my current understanding from the wiki you can completely set
> up everything via dbus or you can configure the basic settings using
> .service files (/etc/bluetooth) and the network.conf file.
>
> Here is what I think I should do:
> 1.) Set up a service file:
> [Bluetooth Service]
> Identifier=network
> Name=Network service
> Description=Bluetooth Personal Area Network service
> Autostart=true
>
> 2.) It looks like the network.conf default setting are good for what I
> want to do.
>
> 3.) Issue dbus commands to start NAP.  This is were I'm confused and
> NEED HELP, I'm not sure what all needs to be done here to allow a PANU
> device to connect to my NAP device.
> Once I have the connection (bnepX) I know what to do, just set up a
> bridge (pan0) and set up any forwarding/NAT/firewall rules using
> standard iptables/masq commands against the pan0.
>
> I believe the example on the wiki
> (http://wiki.bluez.org/wiki/HOWTO/NetworkConnections) details how to
> have a PANU device connect to a pre-existing NAP but I do not believe
> it details how to set up the NAP which is really what I want to
> accomplish.
> Regards,
> Shane
>

------=_Part_117138_20769377.1227549491271
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I did not get a reply back to this so I&#39;m re-posting it, is there additional information I need to provide?<br>Regards,<br>Shane<br><br><div class="gmail_quote">On Tue, Sep 16, 2008 at 11:50 AM, Shane Volpe <span dir="ltr">&lt;<a href="mailto:shanevolpe@gmail.com" target="_blank">shanevolpe@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I&#39;m trying to understand the best way to set up a device as a NAP.<br>
The old way I performed this was by using pand with the following<br>
options:<br>
PAND_OPTIONS=&quot; --secure --listen --master --role &nbsp;NAP<br>
--devup=/etc/bluetooth/pan/dev-up&quot;<br>
<br>
Moving forward I want to use dbus commands and configure the NAP the<br>
*right* way.<br>
<br>
Here is my current understanding from the wiki you can completely set<br>
up everything via dbus or you can configure the basic settings using<br>
.service files (/etc/bluetooth) and the network.conf file.<br>
<br>
Here is what I think I should do:<br>
1.) Set up a service file:<br>
[Bluetooth Service]<br>
Identifier=network<br>
Name=Network service<br>
Description=Bluetooth Personal Area Network service<br>
Autostart=true<br>
<br>
2.) It looks like the network.conf default setting are good for what I<br>
want to do.<br>
<br>
3.) Issue dbus commands to start NAP. &nbsp;This is were I&#39;m confused and<br>
NEED HELP, I&#39;m not sure what all needs to be done here to allow a PANU<br>
device to connect to my NAP device.<br>
Once I have the connection (bnepX) I know what to do, just set up a<br>
bridge (pan0) and set up any forwarding/NAT/firewall rules using<br>
standard iptables/masq commands against the pan0.<br>
<br>
I believe the example on the wiki<br>
(<a href="http://wiki.bluez.org/wiki/HOWTO/NetworkConnections" target="_blank">http://wiki.bluez.org/wiki/HOWTO/NetworkConnections</a>) details how to<br>
have a PANU device connect to a pre-existing NAP but I do not believe<br>
it details how to set up the NAP which is really what I want to<br>
accomplish.<br>
Regards,<br>
<font color="#888888">Shane<br>
</font></blockquote></div><br>

------=_Part_117138_20769377.1227549491271--


--===============7930764821745160245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============7930764821745160245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============7930764821745160245==--
