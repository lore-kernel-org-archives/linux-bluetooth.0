Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] syntax for advertising a service with specific
	uuid
From: Marcel Holtmann <marcel@holtmann.org>
To: Nikita Tovstoles <Nikita.Tovstoles@Sun.COM>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40902623.8060509@sun.com>
References: <40902623.8060509@sun.com>
Content-Type: text/plain
Message-Id: <1083190769.4000.90.camel@pegasus>
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
Date: Thu, 29 Apr 2004 00:19:29 +0200

Hi Nikita,

> I'd like to create a client-server application in which a linux box 
> (running bluez) will advertise a service by declaring a specific service 
> uuid. the service needs to only be capable of sending / receiving 
> strings so i'm assuming declaring a btspp service should be enough. that 
> specific uuid will be embedded into a j2me midlet running on nokia 6600 
> (implementing jsr-82). the midlet will then search for service using url 
> of format:
> 
> "btspp://1234567890123456789012" (uuid *has* to be chars long - nokia's 
> apparent implementation limitation).
> so (correct me if i'm wrong )what i need is:
> 1.add Serial Port service via "sdptool add SP"
> 2.set attributeID 0x0003 (ServiceID) for the above Service Record to 
> "1234567890123456789012"
> 
> correct?

I am not familiar with Symbian phones or JSR-82, so I can't help here.

> i'm not sure of the sdptool syntax for step 2.
> 
> problem:
> 1.when i do step 1, i get "Serial Port registered". but, if i issue 
> "sdptool get SP" afterwards, i get description of
> "SDP Server" (0x1000). shouldn't it return something like "SerialPort" 
> (0x1101)  - service class id for SerialPort per bt spec?
> note: actually even if i issue "sdptool add LAN", subsequent "sdptool 
> get LAN" returns same description as above.

I prefer you read the manpage of sdptool. The get command needs the
record handle of the previous created record.

> 2. also, i couldn't figure out exact syntax to accomplish step 2 above 
> (set attribute):
> sdptool setattr --help returns
> 
> "usage: sdptool get rec_handle attrib_id attrib_value", which seems not 
> to be what i need to do...

Again. Look at the manpage.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
