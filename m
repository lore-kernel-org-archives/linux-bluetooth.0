Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <465D4072.6030507@rousse.org>
Date: Wed, 30 May 2007 11:14:26 +0200
From: Alexander <amour@rousse.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <465AF314.5090206@rousse.org>
	<1180411732.21432.119.camel@aeonflux.holtmann.net>
In-Reply-To: <1180411732.21432.119.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] dbus api
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

where can I read or look for examples of a service? I'm confued, how can 
one make a service available with a name and description?

What about listing the currently added local service records? It looks 
like such a method is missing from the API.

If I want to make a rfcomm-based service available on my PC for others, 
than the right way would be to register a service record with a rfcomm 
protocol descriptor and than I should bind listening for new connections 
on rfcomm, right?

What do you mean the RFCOMM API is moved to a service? How can I access 
it? How can I initiate a new rfcomm connection or listen for an incoming 
one?

best regards,
Alexander


Marcel Holtmann wrote:
> Hi Alexander,
>
>   
>> I'm working on a C++ library that invokes bluez over dbus. I'm currently 
>> having some trouble understanding the logic of a local service. Could 
>> someone explain me the way local services are managed? Like, calling 
>> RegisterService() of the org.bluez.Database, what does that method do? 
>> Does it create a new ServiceRecord on hciX? If so, what happens with the 
>> protocol descriptors of that service record? How can I list all the 
>> registered services on hciX? I see Add and Update methods for service 
>> records but no ListServiceRecords()? There is a ListServices() method on 
>> the manager interface but this interface is just for the /org/bluez 
>> object path, so this won't give me a list just for hciX. Also, the 
>> org.bluez.Service interface, does it have anything to do with 
>> Add/UpdateServiceRecord() methods of the database interface? Can I 
>> modify the service record (for example the protocol descriptors) of a 
>> service represented by the org.bluez.Service interface?
>>     
>
> a service and a service record are two different things.
>
> The service is something that is BlueZ based. It normally implements one
> or more profile specifications and provides a D-Bus interface to use
> them.
>
> The service record are SDP records that are mandated by the profile
> specification.
>
> You can use both independently. However both are bound to your D-Bus
> connection. If you connection dies (meaning your process disconnects)
> the service and also the service records will be automatically removed.
>
>   
>> What happened with the RFCOMM API? I agree it wasn't very nice by 
>> forcing you to open /dev/tty* but it was at least something, now there 
>> isn't anything dbus based. A RFCOMM API with connect(), disconnect(), 
>> read() and write() will be just great (all dbus based ofcourse, no 
>> /dev/tty* stuff :) ).
>>     
>
> The RFCOMM API has been moved over to a serial service.
>
> If you don't wanna open /dev/rfcomm* then use Bluetooth RFCOMM sockets
> directly. D-Bus is not for transferring data.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
