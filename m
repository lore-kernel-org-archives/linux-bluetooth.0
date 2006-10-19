Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061019102818.11A17215448@mrelay1.st2.lyceu.net>
References: <20061019102818.11A17215448@mrelay1.st2.lyceu.net>
Date: Thu, 19 Oct 2006 12:36:52 +0200
Message-Id: <1161254212.27710.36.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PAND Network
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Monica,

> I have been performing test during the last two weeks with my PAN network
> topology and I get always the same result.
> 
> I have been looking for information in this forum and I have found this
> message:
> 
> 
> 	From: Max Krasnyansky <maxk@qu...>
> 	Re: Multiple PAN/BNEP connections from 1 machine  
> 	2003-06-12 12:02
> 
> 	 At 10:56 AM 6/12/2003, MUSSON MICHAEL JOHN wrote:
>  
> 	 >Hello all,
> 	 >
> 	 >I just want to know if it"s possible to have one machine with two
> 	 >BT adapters establish 2 BNEP connections to a separate machine
> with 	1
> 	 >adapter. 
> 	 No it"s not.
>  
>  	>If this is not possible, how hard would it be
> 	 >to hack the code to make it possible?
> 	 First we"d have to learn how to plug _two_ Ethernet cables
> 	 into a _single_ port ;-).
>  
> 	 Max
>  
>  This is exactly my situation, I have two BT adapters in the same PC trying
> to establish two BNEP connections to a separate machine with 1 adapter. As
> this message is also quite old, isn't it possible now to have one machine
> with two BT adapters establish 2 BNEP connections to a separate machine with
> 1 adapter?.

I am pretty sure that I have done that before. However you must be
careful with your master/slave configuration. Also you must be 100% sure
to pick the second adapter for the second connection.

If you run "hcidump -X -V", what is actual error you get or is the
second connection simply not working.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
