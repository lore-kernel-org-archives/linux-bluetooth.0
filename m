Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluez BNEP connection close
References: <6.1.2.0.2.20050124165802.04168330@luna.tlmat.unican.es> <1106581771.8058.49.camel@pegasus> <6.1.2.0.2.20050124172931.041a03a0@pop.gmx.net>
In-Reply-To: <6.1.2.0.2.20050124172931.041a03a0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501241723.02175.cijoml@volny.cz>
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
Date: Mon, 24 Jan 2005 17:23:01 +0100

Send us your code (you used GPL code :)) and maybe we'll find way to fix it.

Michal

Dne po 24. ledna 2005 17:46 George napsal(a):
> Hello.
>
> The fact is that I have copy pand code to automate them into my
> application. My application makes a bridge in order to communicate WIFI and
> BlueTooth.
>
> The traffic is not too much.. when I run a ping -s 50000 it crashes and
> hangs. The result is that some packets are transmitted correctly while
> others doesn't.
> The bnep0 connection disappears and then both ends are no more connected.
>
> After happening all that things I have to restart everything as the sdpd
> and also the bluetooth devices on both ends are hanged.
>
> For giving more information, one of the ends is a Sharp Zaurus 5500 and the
> other is a Laptop using and AnyCom usb dongle
>
> By having a look at /var/log/messages I have one messge that is:
>
> Kernel: NETDED WATCHDOG: bnep0: transmit timed out
>
> and also in other parts
>
> Jan 24 17:14:35 kernel: hci_acl_tx_to: hci0 ACL tx timeout
> Jan 24 17:14:35 kernel: hci_acl_tx_to: hci0 killing stalled ACL connection
> BA:D4:09:EE:02:00
> Jan 24 17:14:35 kernel: hci_acl_tx_to: hci0 ACL tx timeout
> Jan 24 17:14:35 kernel: hci_acl_tx_to: hci0 killing stalled ACL connection
> BA:D4:09:EE:02:00
>
>
> TA.
>
> At 16:49 24/01/2005, Marcel Holtmann wrote:
>  >Hi George,
>  >
>  >> I'm facing a problem using the Bluez stack for linux and I don't know
>  >> the reason and how to solve it.
>  >> I'm using the PAN environment, using the BNEP over L2CAP. I'm using
>  >> kernel 2.4.28-mh1 and bluez-libs-2.10 and bluez-utils-2.10.
>  >>
>  >> I manage to get both devices connected and running a ping over it.
>  >> However when I do some web browsing a problem appear (also if doing an
>  >> FTP or whatever thing).
>  >> When the amount of traffic through the connection increase, the
>  >> connection shut down without any reason.
>  >>
>  >> Any idea of why when stressing the connection by transferring big
>
> amount of
>
>  >> data it closes.
>  >
>  >check the syslog or dmesg for any error messages when this happens. I
>  >never had problems with big amount of data over BNEP. Btw about how much
>  >data are we talking?
>  >
>  >Regards
>  >
>  >Marcel
>  >
>  >
>  >
>  >
>  >-------------------------------------------------------
>  >This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>  >Tool for open source databases. Create drag-&-drop reports. Save time
>  >by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>  >Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>  >_______________________________________________
>  >Bluez-users mailing list
>  >Bluez-users@lists.sourceforge.net
>  >https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
S pozdravem

Michal Semler


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
