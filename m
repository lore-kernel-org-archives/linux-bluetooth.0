Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Create Services using BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7846f1440511221058lbfe6ff1g951ea529e4152af0@mail.gmail.com>
References: <7846f1440511221058lbfe6ff1g951ea529e4152af0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1132806449.5982.27.camel@blade>
Mime-Version: 1.0
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
Date: Thu, 24 Nov 2005 05:27:29 +0100

Hi Arthur,

> I am currently trying to create a server that will response to
> bluetooth request. The client will be in Java. Since the client need
> to search for devices and services before connecting, I need to create
> services on the server side. I am trying to have the client sending
> "Hello World" to the server.
> 
> My questions:
> 1) Can I create custom services like "hello world service" or it must
> be from the list of services shown in sdptool? How can I do so?

you need to create your own service record using your own UUID-128 for
identification.

> 2) Which test or sample tool contain example that handles service
> requests (i saw sdptool only browses for services, not using them)

The service records are only information about the service and not the
service itself. Tools like l2test and rctest work without any service
record descriptions.

> 3) What kind of headers would I need to attach in front of data if I
> want to communicate with standard devices (like phones). I see in
> l2test.c that the L2CAP format contains 4 bytes of sequence number and
> 2 bytes of data length. What other information are there if I need to
> send things through SDP? 

Nothing. The SDP doesn't contain any information about the protocol. I
may tell you the L2CAP PSM or RFCOMM channel number, but that's it.

> 4) Does L2CAP data format (those headers) = ACL data format? If not,
> what's the difference? 

You can use L2CAP as a SOCK_SEQPACKET and RFCOMM as SOCK_STREAM. For
more information about L2CAP and RFCOMM in general, read the Bluetooth
specification. For the rest check the source of l2test or rctest.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
