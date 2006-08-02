Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44D08B77.4010302@infitsrl.com>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
	<20060724103824.1ff98fa6@McGee-XPC> <44C4CC37.1060308@infitsrl.com>
	<20060724155621.02cd5e11@localhost.localdomain>
	<1153758912.25058.3.camel@localhost>
	<20060724203433.7184d301@localhost.localdomain>
	<7359D844-F738-4AD1-A1FD-F59BEFD149EC@infitsrl.com>
	<1153775541.25058.6.camel@localhost> <44C881B5.7060809@infitsrl.com>
	<1154085261.2298.34.camel@localhost> <44CDD529.6030001@infitsrl.com>
	<1154355262.4982.2.camel@aeonflux.holtmann.net>
	<44D08B77.4010302@infitsrl.com>
Date: Wed, 02 Aug 2006 15:43:10 +0200
Message-Id: <1154526190.3905.52.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About l2cap patch to handle
	multiple	connections....
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabrizio,

> I have not made great progresses but I try to explain them looking some 
> one can help me.
> System hangs after l2cap_connect_cfm function, this is called for every 
> device to which I try to connect to (in my case only 2).
> 
> In non-patched version of l2cap_connect_cfm there was a call to 
> l2cap_conn_ready if status was 0x00 on a valid conn.
> In patched version l2cap_conn_ready is no more called. l2cap_conn_ready 
> it seems to execute the l2cap connection request so is
> this a forgetfulness? I've try to insert the call but without success 
> (system hangs again) so if the response to previous question is true this
> is not the only problem.

the call to l2cap_conn_ready() is still there. Check the code in more
detail.

Actually the code after l2cap_conn_read() to find the next pending ACL
connection might be the problem.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
