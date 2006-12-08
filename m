Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <f376804d3d0.45783d10@cegetel.net>
References: <f376804d3d0.45783d10@cegetel.net>
Date: Fri, 08 Dec 2006 11:22:17 +0100
Message-Id: <1165573337.5529.19.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Pairing-Authentication
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

Hi,

> to understand the authentication procedure, I make
> a test between 2 entities designed by "A" and "B".
> 
> 1. A connection is realized without authentication between these two entities, (they never paired before) 
> 
> 2. Then entity "A" launches an authentication request,
> 
> 3. As they never paired no link key is available for the link "A"-"B", the pairing procedure 
>    works well (same pin code at each side)
>    
> 
> 4. I disconnect the link "A"-"B", I reconnect "A" and "B" without authentication,
> 
> 5. "A" executes an authentication request,
> 
> 
> At this time, the authentication procedure doesn't need a pairing as a link key is available.
> 
> My first question is what can I do to force the pairing before an authentication request  ?

you can always do security mode 3, but that is not recommended and has
problems of its own. Check the mailing list for further details. It has
been discussed multiple times.

You can call HCI_Authentication_Requested any time. Even directly after
the connection has been established, but I don't see any real need for
it. Explain your use case.

> In other word, where can I delete the link key for the link "A"-"B" in bluez ?

Use the D-Bus interface and call the RemoveBonding method.

> My second question, is how to configure security in a pan network ?

Start with reading the pand manual page (man pand).

> Can I set security at the L2CAP level with specific option during the setsockopt ?

Yes. Check the l2test.c source code for an example.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
