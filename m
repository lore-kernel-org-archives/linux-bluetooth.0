Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42397A0E.6050001@indt.org>
From: Claudio Takahasi <takahasi@indt.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <4238804C.4070607@indt.org> <1111058131.11792.65.camel@pegasus>
In-Reply-To: <1111058131.11792.65.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Re: [Bluez-devel] PAN Attributes
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
Date: Thu, 17 Mar 2005 09:37:34 -0300

Hi Marcel,

Currently, I think that PAN attributes are not being exported(registered)
at server side. Therefore, I need add to NAP/GN and retrieve from PANU.

I didn't find references for them. "pan_attrib_names" structure is used
only in the uuid16_names and at the moment I don't know how change
the code to make these information available.

My objective is try enhance/make easy the PAN setup. Currently, the
user has to be aware of the PAN role and setup the IP address in
both side(master and slave).

In the PAN Profile, Zeroconf is one of  suggested standard to solve
the IP assigment problem. Zeroconf generates a pseudo random IP.
However, this approach is NOT feasible for Bluetooth PAN. For NAP
scenario, a route must be added in the PANU to reach the gateway.
But the PANU doesn't know the NAP IP address!!!

Using the IPv4Subnet attribute and using a rule for gateway IP
assigment the PANU can be able to get the NAP IP. Another aproach
is add one attribute like "gateway address", but this implies in PAN
profile changes and I think that this is not a simple process.

Regards,
Claudio





Marcel Holtmann wrote:

>Hi Claudio,
>
>  
>
>>Which modification should be done in order to get
>>NAP/GN attribute values?
>>    
>>
>
>to retrieve them from a remote side or to add them to your PAN server?
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
