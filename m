Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41ADD32D.2060502@suche.org>
From: =?ISO-8859-15?Q?Thomas_Lu=DFnig?= <bluez@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <200412010839.06669.mailsp@sebastian-eichner.de>	 <200412010943.33419.mail@sebastian-eichner.de>	 <1101894192.18840.44.camel@pegasus>	 <200412011224.29191.mail@sebastian-eichner.de>  <41ADAC67.10706@suche.org>	 <1101901302.18840.72.camel@pegasus>  <41ADB1C2.8070805@suche.org> <1101902920.18840.79.camel@pegasus>
In-Reply-To: <1101902920.18840.79.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] btsco2
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 01 Dec 2004 15:20:29 +0100

Hi,

i have some Questions:

a) How should btsco2 Handle Multiple Headset in the Parameter ?
- ./btsco2 <mac1> <mac2> <mac3>
- ./btsco2 <mac1> -1 <mac2> 1 <mac3> 2
Where -1 in the Channel Parameter stand for Autodetec

b) How tell the User what  BT Device to use for the headset(s)

c) Is there any Plan to allow th BT-SCO Sound driver in kernel Space to 
handle mor than one bluetooth as sound device.
Nice would be an option to tell the driver how many sound device he 
sould allocate.

Fixed Problems from btsco:
1) If headset is not available on start the server try to connect it 
every 3 seconds
Open:
1) Detect if headset disconnects and close sco/rfcomm socket and tell 
the kernel space
2) An rfcomm listener for inbound connections where headset initiate the 
connection.

I think Open.1 i can fix.

Cu Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
