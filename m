Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <419C118D.8050309@patbert.com>
From: Patrick <patbert@patbert.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Using windows breaks bluetooth in linux? huh
References: <419AE72F.3030307@patbert.com>	 <1100673867.7208.128.camel@pegasus>  <419B6990.7020009@patbert.com>	 <1100704877.7607.8.camel@pegasus>  <419BB514.3030807@patbert.com> <1100723967.7164.11.camel@pegasus>
In-Reply-To: <1100723967.7164.11.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 17 Nov 2004 22:05:49 -0500

Kawaii64 patrick # hcidump -x
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
   33 8B 9E 08 C8
 > HCI Event: Command Status (0x0f) plen 4
   00 01 01 04
 > HCI Event: Inquiry Result (0x02) plen 15
   01 E4 63 3A 95 0A 00 01 00 00 40 25 00 16 2E
 > HCI Event: Inquiry Complete (0x01) plen 1
   00
< HCI Command: Create Connection (0x01|0x0005) plen 13
   E4 63 3A 95 0A 00 18 CC 01 00 16 AE 01
 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
 > HCI Event: Link Key Request (0x17) plen 6
   E4 63 3A 95 0A 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
   E4 63 3A 95 0A 00 8F 77 B9 44 7B 94 1E 98 A9 9A 41 9D 3E 40
   89 95
 > HCI Event: Command Complete (0x0e) plen 10
   01 0B 04 00 E4 63 3A 95 0A 00
 > HCI Event: Connect Complete (0x03) plen 11
   05 29 00 E4 63 3A 95 0A 00 01 00


If only they would release I linux version of half life 2 this problem 
wouldn't exist!

Thanks again for your help! You are by far the most helpful developer I 
have ever met.

Patrick

Marcel Holtmann wrote:
> Hi Patrick,
> 
> 
>>For some reason I was under the impression that auth and encrypt had to 
>>be on for the Apple Keyboard.
>>
>>I have turned them off and restarted but I am still receiving the same 
>>error. Do I have to do something to reset the device? I took the 
>>batteries out.
> 
> 
> check again with "hcidump -x".
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
