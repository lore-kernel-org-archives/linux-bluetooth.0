Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth serial vs. audio connection
In-Reply-To: <1111942691.9195.241.camel@pegasus>
Message-ID: <Pine.LNX.4.62.0503280908130.3082@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.62.0503271303450.3134@ybpnyubfg.ybpnyqbznva>
 <1111923433.9195.216.camel@pegasus>  <Pine.LNX.4.62.0503271357080.3134@ybpnyubfg.ybpnyqbznva>
  <1111926923.9195.218.camel@pegasus>  <Pine.LNX.4.62.0503271736360.3135@ybpnyubfg.ybpnyqbznva>
  <1111938339.9195.229.camel@pegasus>  <Pine.LNX.4.62.0503271751420.3135@ybpnyubfg.ybpnyqbznva>
  <1111939568.9195.236.camel@pegasus>  <Pine.LNX.4.62.0503271813180.3135@ybpnyubfg.ybpnyqbznva>
 <1111942691.9195.241.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 28 Mar 2005 09:11:49 +0200 (CEST)

On Sun, 27 Mar 2005, 18:58, Marcel Holtmann (as MH) wrote:

Hi Marcel, I'm back again


>MH: > >MH: > If I just run sdptool browse 00:xx, I don't get any 
>MH: > >MH: > output, I'm not sure, this is the normal behavior. I see 
>MH: > >MH: > this as a problem, as there are some supported services. 
>MH: > >MH: > But then, I didn't check the code of this tool.
>MH: > >MH: 
>MH: > >MH: this does not answer my question. What kind of phone is 
>MH: > >MH: this? Does adding "--tree" before the "--bdaddr" parameter 
>MH: > >MH: helps?
>MH: > 
>MH: > Yes, I misread the question. This is a Samsung SGH-D500 (a nice 
>MH: > phone but crappy windows software...)
>MH: > 
>MH: > No difference. With or without --tree, there is only one line of 
>MH: > output "Browsing 00:xx ...", nothing else
>MH: 
>MH: I actually meant the "spdtool search" part to see if the 
>MH: segmentation fault is still present then. However, again the bad 
>MH: Samsung phone. I think I need one of these at home for fixing this 
>MH: thing.

Ok, with --tree, I get no segmentation fault:

root@notebook:~ > sdptool search --tree --bdaddr 00:xx DUN
Searching for DUN on 00:xx ...
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10002
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID32 : 0x00001103 - DialupNetworking (DUN)
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID32 : 0x00000100 - L2CAP
    Data Sequence
      UUID32 : 0x00000003 - RFCOMM
      Channel/Port (Integer) : 0x4
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    UUID32 : 0x00001103 - DialupNetworking (DUN)
Attribute Identifier : 0x100
  Text : "Dial-up networking"

root@notebook:~ > 


Andreas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
