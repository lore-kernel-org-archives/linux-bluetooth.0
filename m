Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1080744176.1907.15.camel@baroque.rococosoft.com>
References: <1080744176.1907.15.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1080744748.2536.13.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: specifying client-side link mode properties before connect()
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 31 Mar 2004 16:52:28 +0200

Hi Stephen,

> I have a server application which can specify the link mode requirements
> of incoming connections using setsockopt(sock, SOL_L2CAP, L2CAP_LM, opt,
> sizeof(opt)). This works fine, if a client can't meet the requirements,
> no connection is made and the server's accept() sees nothing.
> 
> However I'd now like to be able to specify these requirements to the
> connect() call on the client-side. That is, I'd like to call setsockopt
> specifying the client's requirements (master, auth, encrypt) before
> calling connect(). While I can /do/ this, the LM parameters seem to have
> no effect. For example, I can set the L2CAP_LM_MASTER flag on both
> sides, yet a connection is still established.

you can set the link mode, but the connection establishment procedure
dont't care about it.

> I suppose my question really is: are there any plans to implement this? 
> Or is the usual answer (to send a patch) the correct one :-)?

>>From my side I have no plan to implement it, but if you will do the work
and the patch don't break any other behaviour, I am going to apply it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
