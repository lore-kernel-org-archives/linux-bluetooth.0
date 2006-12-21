Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <458B1519.6020800@glidos.net>
Date: Thu, 21 Dec 2006 23:13:29 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4587BB0E.2070909@glidos.net>	<1166523629.29972.18.camel@violet>	<4587DAEC.8000603@glidos.net>	<20061219153627.GJ7959@suse.de>	<45884A49.5040702@glidos.net>	<20061220085414.GA18455@suse.de>	<458904A1.5090508@glidos.net>	<20061220110457.GC20278@suse.de>
	<4589BBF5.5090604@glidos.net>
In-Reply-To: <4589BBF5.5090604@glidos.net>
Subject: Re: [Bluez-users] hcid.conf seemingly ignored
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

Paul Gardiner wrote:
> Stefan Seyfried wrote:
>>>> If the procedure explained in /usr/share/doc/packages/bluez-utils/README.dund
>>>> does not work, please file a bugreport at bugzilla.novell.com so i can update
>>>> the documentation.
>>> Ok thanks. I'm not sure I have read that before. That may help a lot.
>> If it does not work, let me know so that i can fix the documentation.
> 
> No, I still can't tease any response out of dund, whatever I do. I'm
> seeing this in the logs:
> 
> Dec 20 22:15:22 plonty dund[13620]: Accept failed. Interrupted system 
> call(4)
> Dec 20 22:15:22 plonty pand[13617]: Accept failed. Interrupted system 
> call(4)
> Dec 20 22:16:58 plonty dund[13730]: Accept failed. Interrupted system 
> call(4)
> Dec 20 22:16:58 plonty pand[13727]: Accept failed. Interrupted system 
> call(4)
> 
> 
> Could that be anything to do with it.

I've since realised that these warnings are just part of bluez shutting 
down, so nothing to do with my problem.

> I added the option "debug" to /etc/ppp/peers/dun, but I didn't
> see any new output from that.

So, is there any other way I can debug this problem?  I can get a
trace from hcidump. Is there a way to get that to display the meaning
of what is transmitted?

I really don't want to just give up, seeing as I had this working
perfectly on whatever version of bluez ran under suse 10.1.  I
can't believe the changes that went through bluez since then
have made connecting a Qtek S100 to a linux box impossible.
That would be a real backward step.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
