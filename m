Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4214AFB1.4010109@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Profiles and Service publicing
References: <cuvg8v$6qs$1@sea.gmane.org>
In-Reply-To: <cuvg8v$6qs$1@sea.gmane.org>
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
Date: Thu, 17 Feb 2005 07:52:33 -0700

Hi

> The first is a SDP_ServiceSearch Request from the headset looking for a 
> service with UUID  of value 0x1112 (corresponds to AudioGateway).
> The second is a SDP_ServiceSearch Response from BlueZ saying that the 
> requested service is not found in the SDP database nor nothing even 
> similar, which is really true because I have not add this service 
> ("sdptool add AG" is not supported)

We need sdptool to support ag for one thing. I hadn't realized it wasn't 
supported (I have always been initiating computer->headset but we want 
to support headset->computer)

If you are comfortable with it, get the sdptool from cvs (to make sure 
it hasn't been added recently) and add ag support. It's likely a table 
somewhere with the uuid value and "ag" string. Submit patches here.

> · In the assumption that, some way, I could create a service record in 
> the service database specifying AudioGateway UUID, would it be enough 
> for the heaset to reconnect again?

There are more details to take care of probably, but we need to try it 
to find out.

> · I think of btsco as if it was an AudioGateway implementation (or 
> headset profile implementation) using the BLuez stack, but if it doesn't 
> register by its own the AG service in the local database, maybe it is 
> not a profile imlpementation?

We are trying to implement the profile completely. The profile is not 
finished if it doesn't advertise the service.

> 
> So:
> Please, could you give me some points to understand this? Also, if it's 
> not being possible to fix the reconnection problem because of some lack 
> of development, I would like to know where is the failure.

Yes, it is a shortcoming of the current system. We want to fix it but we 
need more good developers trying stuff like you are and fixing stuff.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
