Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076284317.14742.179.camel@akka.yeti.nocrew.org>
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
Content-Type: text/plain
Message-Id: <1076287085.6869.70.camel@pegasus>
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
Date: Mon, 09 Feb 2004 01:38:06 +0100

Hi Fredrik,

> We can perhaps have alteranative interfaces for different purposes, if
> the difference in semantics is large enough. For example a "standard"
> HCI interface with all such methods. (I'm not familiar with HCI myself.)
> 
> For example: org.bluez.hci
> 
> For stuff that doesn't fit within HCI, or becomes very akward, we
> can have other complementary interfaces. GUI applications have other
> needs than for example server applications, I suspect. Having
> several interfaces for the same things isn't ideal though, but some
> overlap for the sake of the HCI standard is perhaps a good idea?
> 
> > Lets talk about the namespaces you are thinking of. What makes sense to
> > separate?
> 
> Some ideas:
> 
>    - Name services: including local device, paired and scanned
>      names. Preferably using the same "lookup" function, because
>      when searching for a name, applications don't want to bother
>      where (local/remote/cache/whatever) the name comes from. Given 
>      a device address, simply return the name if it's readily
>      available.
> 
>      Note that since initiating a scan is expensive, this ought
>      to be a separate method call.
> 
>      Example: org.bluez.name
> 
>    - Key/pairing services: including requesting/receiving a pairing
>      procedure, link key and PIN management.
> 
>      Example: org.bluez.link
> 
>    - (Local) device configuration services: activate/deactivate
>      devices etc. Link modes? Classes? Or maybe org.bluez.hci will
>      be enough for this?
> 
>      Example: org.bluez.device

not this way. I want to seperate the running services/profiles. The hcid
must serve "org.bluetooth.hci" as its base.

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
