Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] local device class...
References: <01LKY0ISS1MC0002UB@beacon.nuigalway.ie>
In-Reply-To: <01LKY0ISS1MC0002UB@beacon.nuigalway.ie>
Cc: Triona Ryan <triona.ryan@nuigalway.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502181503.01245.bluez-user@schaettgen.de>
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
Date: Fri, 18 Feb 2005 15:03:01 +0100

On Friday 18 February 2005 10:09, Triona Ryan wrote:
> Sorry if I seemed rude but my problem is, I think, ridiculous.
>
> > Did it register with the SDP server (hint: sdptool --help)?
>
> Did the obexserver register with the SDP server. I'm not sure. I've done
> sdpt ool --help and still am not sure what you  mean. I've added OBEX with
> sdptool is that's what you mean?

So does sdptool list exactly one obex push service?
Is the rfcomm channel in the sdp record the one which the obex server is 
listening on? You can check it directly on the PC runnning the Obex server 
with 'sdptool browse FF:FF:FF:00:00:00'

..
> As I said, I've added the services, and from
> the other PC(s) I've browsed the services, and see OBEX push etc, but when
> I "hc iconfig -a", In Service Class Object transfer is set on the master
> (the one I'm sending from, and have no problem trnafering files to and from
> my phone with) bu t not set on the slave (the one that's trying to receive
> a file, where the serve r is running.)
>
> Aka. on the master:
>
> Class: 0x100100...........................
> ....................(note the MSB is "1", hence, Object Transfer is "set")
>
>    Service Classes: Object Transfer
>         Device Class: Computer, Uncategorize
> d
>
> Whereas on the other PCs
> Class: 0x3e0100.....................................
> ............(note the MSB is "3", hence Object Trnasfer is "set")
>        Service
>  Classes: Networking, Capturing, Rendering..........(and yet "Object
> Transfer" i s NOT here!)
>        Device Class: Computer, Uncategorized

Looks like Object Transfer should in fact be listed. But this is certainly 
just a problem of hcitool with decoding the device class.  What is the 
"Rendering" bit good for btw.? 

> This is the only thi
> ng I can see that's differenf between a working PC and a non-working PC.
> I've se en another computer that has Networking and Object Transfer
> Activated and the co rresponding local device class: 12010c, and it works
> fine.
>
> My question is, cou
> ld this be the problem, and if so, how do I fix it?

I don't know if any of the obex push tool on linux take a look at the device 
class at all. I can only speak for the kde tools, and those don't. It's more 
likely a problem with the sdp record. There should be just one for obex push 
(or to be more exact: one for each running obex push server) and it must 
point to the right rfcomm channel. If it's just a mobile phone which refuses 
to send files to this PC, the device class could in fact be the problem. 
Obviously the best way to find out is to change it to 0x100100 and see what 
happens.

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
