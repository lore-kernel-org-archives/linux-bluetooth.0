Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040308161155.51782.qmail@web40709.mail.yahoo.com>
From: Lalith Chakravarthi <lalithvc@yahoo.com>
Subject: Re: [Bluez-users] bluez pan problem
To: Ronan Naughton <wadgienaughton@hotmail.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <BAY10-F1216PYzDabig00010bb6@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 8 Mar 2004 08:11:55 -0800 (PST)

Hi Ronan

> I am having a problem with setting up a bluez pan between three
> machines and 
> i don't know what I'm doing wrong.
> 
> I set one node ( say B )the GN to listen
> 
>                                            pand --listen --master
> --role GN
> 
> 
> I then connect  the other two nodes ( A & C )
> 
>                                           pand --connect 
> mac_addr_of_master
> 
> 
> I then assign an ip address to A, C and then the master B:
> 
>                                            ifconfig bnep0 10.0.0.1
>                                            ifconfig bnep0 10.0.0.3
>                                            ifconfig bnep0 10.0.0.2

I am not exactly sure about your problem. But I think you should be
using the ifconfig bnep0 for the connection with one PANU and ifconfig
bnep1 for the other PANU. 
> 
> Then for some reason:
> The first pc (10.0.0.1) can ping the other PANU and the GN
> The second pc (10.0.0.3) cannot ping the other PANU or the GN
> The GN (10.0.0.2 ) can only ping the second pc (10.0.0.3)
> 
> Why on earth is this happening. Ip forwarding is turned on on all
> machines. 
> I have no idea why it won't work-please help!!!!!!!!
Anyways, do send the output screens when you enter 

##> ifconfig bnep0 

and 

##> ifconfig bnep1 

on the three computers. That will help in getting a clearer
understanding of your problem. And guys, if I am wrong, please do
correct me also...

Regards
Lalith


__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
