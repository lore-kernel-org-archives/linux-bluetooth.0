Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Triona Ryan <triona.ryan@nuigalway.ie>
Subject: Re: [Bluez-users] local device class...
To: bluez-user@schaettgen.de
Cc: bluez-users@lists.sourceforge.net
Message-id: <01LKY0ISS1MC0002UB@beacon.nuigalway.ie>
MIME-version: 1.0
Content-type: text/plain
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
Date: Fri, 18 Feb 2005 09:09:54 +0000

Sorry if I seemed rude but my problem is, I think, ridiculous.

>> Ok, I seem to
 be very much ignored.
>
>> Thanks very much

>You're welcome :P
>Maybe you're w
aiting so long (about 9 hours already!) for an answer because 
>those misplaced 
wh itespace and linebreaks scared the readers? 

Not my fault, but I accept, tot
ally annoying.

>Or it's just 
>because no one tried hard enough to figure out w
hat you tried to achieve by 
>doing what.
>So in short: you want to send files t
o another PC and it's not working, right? 

Correct

>Do you have an obex server
 running?Which one?

Yes, I've tried obexserver, and then the gnome-obex-server,
 the same problem

> Did it register with the SDP server (hint: sdptool --help)?
 

Did the obexserver register with the SDP server. I'm not sure. I've done sdpt
ool --help and still am not sure what you  mean. I've added OBEX with sdptool is
 that's what you mean?

>The device class has very little to do with that. 

>> 
However, IF there's any
>> one out there using this list EXCEPT for one on-going
 thread, could someone
>> plea se check their hciconfig -a and see if their devi
ce class matches
> >their services . I'm using college lab computers, and I inst
alled BT on one

>The device class is not meant to match all your services. 
>Th
at's what the sdp server is for.


As I said, I've added the services, and from 
the other PC(s) I've browsed the services, and see OBEX push etc, but when I "hc
iconfig -a", In Service Class Object transfer is set on the master (the one I'm 
sending from, and have no problem trnafering files to and from my phone with) bu
t not set on the slave (the one that's trying to receive a file, where the serve
r is running.)

Aka. on the master: 

Class: 0x100100...........................
....................(note the MSB is "1", hence, Object Transfer is "set")
     
   Service Classes: Object Transfer
        Device Class: Computer, Uncategorize
d

Whereas on the other PCs
Class: 0x3e0100.....................................
............(note the MSB is "3", hence Object Trnasfer is "set")
       Service
 Classes: Networking, Capturing, Rendering..........(and yet "Object Transfer" i
s NOT here!)
       Device Class: Computer, Uncategorized


This is the only thi
ng I can see that's differenf between a working PC and a non-working PC. I've se
en another computer that has Networking and Object Transfer Activated and the co
rresponding local device class: 12010c, and it works fine. 

My question is, cou
ld this be the problem, and if so, how do I fix it?
Apologies again for my ruden
ess, and what will be no doubt, another whitespace filled and distorted email.

Thanks for your help,
Triona
.
> >computer a few week s ago, and it gave me 0x10
0 as device class, but last
> >week I installed all on an other computer, and I 
got 0x3e0100. They're ALL
> >inked to the SAME lan, and SAME computers etc. I ch
anged the first
> >computer to ox100100, to set Object Transfer , which immediat
ely worked,
>> but the other one is set already and isn't registeri ng the servi
ce. Why

>"Is set already"? Set the device class to 0x100100? What makes you thi
nk it 
>isn't registering the service? Did you actually check the sdp server or 
are 
>you talking about the device class?

Fred

-- 
Fred Schaettgen
bluez-devel
@schaettgen.de
===========End of original message text===========





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
