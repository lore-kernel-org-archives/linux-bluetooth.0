Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076493798.6281.19.camel@kalkyl.roxen.com>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076493798.6281.19.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1076506369.2777.88.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 11 Feb 2004 14:32:50 +0100

Hi Fredrik,

> This looks good but many HCI functions are perhaps a bit low level? These
> are probably OK:
> 
>    org.bluetooth.hci.devup
>    org.bluetooth.hci.devdown
>    org.bluetooth.hci.devreset
>    org.bluetooth.hci.devinfo
>    org.bluetooth.hci.set_pkt_type
>    org.bluetooth.hci.set_link_policy
>    org.bluetooth.hci.set_link_mode
>    org.bluetooth.hci.write_local_name
>    org.bluetooth.hci.read_local_name
>    etc.

we don't have to use the HCI names for it. We can choose names that fit
a little bit more better.

> But these do not appear to be suited for a DBus interface because they deal
> with low level things like sockets:
> 
>    hci_open
>    hci_close
>    hci_recv
>    hci_send_command
>    hci_send_request
>    hci_errno
>    etc.

These are not needed in the D-Bus interface. The first parameter of a
D-Bus method will be "string device" and can be "hci0" or a BD_ADDR and
this is enough to identify the device and open the needed socket.

> Do you mean an extended subset of HCI? I'm not sure I understand, please
> explain. What will be omitted and what will be extended?

The HCI don't defines anything on PIN or link key management, but a
D-Bus interface should provide functions for it.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
