Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <cuvg8v$6qs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Profiles and Service publicing
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
Date: Wed, 16 Feb 2005 14:04:49 +0100

Hi,

This post is about a specific headset, about btsco and about SDP support 
in BlueZ. I'm not sure if btsco is being talked here, but anyway I think 
  this post also concerns BlueZ

This is the context:
· BlueZ and btsco installed and working.
· btsco works fine with the headset (Bluetrek G2).
· once SCO connected, pushing the TALK button on the headset leads to a 
SCO disconnect state, but pushing TALK again will reconnect without 
problems.

But:
· When the headset is switched OFF, the SCO channel is abrubtly 
disconnected and the btsco daemon goes on running.
· When I switch ON the headset again (not in the pairing mode, only 
switch on) it won't connect to the Audio GAteway again.
· Pushing now the TALK button breafly it enters in which I have named 
"dumb mode" (because it is unfructuous). I have dumped what is going on 
in the dumb mode, which I will interpret for you:

The following SDP transaction is repeating again and again until the 
headset gets tired:

 > ACL data: handle 0x0029 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 1]
         SDP SS Req: tid 0x49 len 0xa
           pat uuid-32 0x1112 (AG)
           max 0x28
           cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SS Rsp: tid 0x49 len 0x5
           tot 0x0 cur 0x0
           cont 00

The first is a SDP_ServiceSearch Request from the headset looking for a 
service with UUID  of value 0x1112 (corresponds to AudioGateway).
The second is a SDP_ServiceSearch Response from BlueZ saying that the 
requested service is not found in the SDP database nor nothing even 
similar, which is really true because I have not add this service 
("sdptool add AG" is not supported)

Now:
Now is when some leak of knowledge hammers mi soul:
· In the assumption that, some way, I could create a service record in 
the service database specifying AudioGateway UUID, would it be enough 
for the heaset to reconnect again?
· I think of btsco as if it was an AudioGateway implementation (or 
headset profile implementation) using the BLuez stack, but if it doesn't 
register by its own the AG service in the local database, maybe it is 
not a profile imlpementation?

So:
Please, could you give me some points to understand this? Also, if it's 
not being possible to fix the reconnection problem because of some lack 
of development, I would like to know where is the failure.

Thank you very much

Luis



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
