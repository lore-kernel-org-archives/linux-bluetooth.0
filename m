Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076323138.6869.93.camel@pegasus>
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
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076493798.6281.19.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Wed, 11 Feb 2004 11:03:18 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

mån 2004-02-09 klockan 11.38 skrev Marcel Holtmann:
> The HCI is well defined in the Bluetooth specification and you can of
> course look at libs2. The source contains all defined HCI commands and
> events for Bluetoth 1.2.

This looks good but many HCI functions are perhaps a bit low level? These
are probably OK:

   org.bluetooth.hci.devup
   org.bluetooth.hci.devdown
   org.bluetooth.hci.devreset
   org.bluetooth.hci.devinfo
   org.bluetooth.hci.set_pkt_type
   org.bluetooth.hci.set_link_policy
   org.bluetooth.hci.set_link_mode
   org.bluetooth.hci.write_local_name
   org.bluetooth.hci.read_local_name
   etc.

But these do not appear to be suited for a DBus interface because they deal
with low level things like sockets:

   hci_open
   hci_close
   hci_recv
   hci_send_command
   hci_send_request
   hci_errno
   etc.

> We will provide a general and extend interface to the HCI functions, 
> so we call it "hci".

Do you mean an extended subset of HCI? I'm not sure I understand, please
explain. What will be omitted and what will be extended?

Thanks,
Fredrik
