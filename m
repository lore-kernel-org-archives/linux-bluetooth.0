Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 17 Jul 2007 16:10:24 -0400
From: TJ OConnor <tjoconno@unity.ncsu.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <C2C29A70.5C3%tjoconno@unity.ncsu.edu>
In-Reply-To: <1184702279.28210.40.camel@aeonflux.holtmann.net>
Mime-version: 1.0
Subject: Re: [Bluez-devel] Connectionless l2ping.
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

Ok. Thank you. I have another question. In the 2.1 standard, there is a
mechanism to use Diffie-Helman to negotiate a key later used to create the
linkkey. 

How do pairing devices know to use the 2.1 standard instead of the 2.0 and
below standard. Is this discovered during the extended inquiry and then the
decision is defaulted to the lowest version between the 2 devices? Or is
there a message that agrees on a key negotiation mechanism? Thank you.


On 7/17/07 3:57 PM, "Marcel Holtmann" <marcel@holtmann.org> wrote:

> Hi TJ,
> 
>> Is it possible to use connectionless sockets with L2CAP? I tried rewriting
>> l2ping to use SOCK_DGRAM and sendto / recvfrom instead of SOCK_RAW,
>> send,recv but with no luck.
> 
> of course not. This is not how L2CAP works. The SOCK_RAW is special and
> only present for that exactly purpose.
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



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
