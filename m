Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Victor Shcherbatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Connection with a phone staysopenafterclosingRFCOMM
 channel
Message-ID: <Pine.LNX.4.44.0503022132370.23041-100000@antilope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 2 Mar 2005 21:40:15 +0100 (MET)

Hi Marcel,

The /proc/bluetooth/rfcomm/{dlc,sock} are empty upon completion of the program. hcitool con gives:
> ACL 00:0f:de:11:e4:42 handle 41  state 1 in SLAVE

Regards,
    Victor.

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, March 02, 2005 15:19
Subject: RE: [Bluez-devel] Connection with a phone stays 
openafterclosingRFCOMM channel


> Hi Victor,
> 
>> Don't know if I have to post it on the mailing list (with binary
>> files)...
> 
> if I ask for it, it is always fine ;)
> 
>> I can not try 2.11 rc5 cause it is not an option for the current 
project
>> and I do not have time to try it at home at the moment.
> 
> Using a 2.6.10-mh4 is also possible, but you should at least try it with
> my kernel patch.
> 
>> At the moment it is not clear from the protocol (at least for me) who 
is
>> responsible for terminating connection. It may be as well a bug in
>> SE630, cause Nokia 7650 for instance takes initiative to terminate the
>> connection after DISC on dlci6 (but from another side Nokias do not 
take
>> initiative to reconnect to HF device when call is received when
>> bluetooth connection is broken, as SE phones do...)
> 
> You won't find any written words or hints inside the specification who
> is responsible for terminating a connection. I discussed this problem
> with a lot of people so far and there is no solution besides accepting
> bad implementations.
> 
> Actually I asked you for the contents of
> 
> /proc/bluetooth/rfcomm/{dlc|sock}
> 
> after you ran into the stalled connection. They are really needed,
> because it might be a bug with our code that we don't cleanup the mess
> of the SE 630.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
