Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076311376.14742.202.camel@akka.yeti.nocrew.org>
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
Content-Type: text/plain
Message-Id: <1076321200.6869.75.camel@pegasus>
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
Date: Mon, 09 Feb 2004 11:06:41 +0100

Hi Fredrik,

> > not this way. I want to seperate the running services/profiles. The hcid
> > must serve "org.bluetooth.hci" as its base.
> 
> What would the Apache webserver use? "org.w3c.http"? Something like
> "org.apache.httpd" fits better for a DBus interface. Similarly hcid
> ought to use "org.bluez.hcid", I think.

this actually depends on what you provide. The httpd provides the
implementation of the HTTP. We will provide a general and extend
interface to the HCI functions, so we call it "hci". The hcid is the
implementation of these functions on the server side.

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
