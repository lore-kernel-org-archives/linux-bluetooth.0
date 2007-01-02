Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
Date: Tue, 02 Jan 2007 09:09:58 +0100
Message-Id: <1167725398.30886.32.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem in making multiple connections
	using	single bluetooth adapter using bluez
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

>     I am trying to open multiple connections by connecting to OBEX
> push servers on different mobiles using single blue tooth adapter. The
> steps that i am taking right now are as follows:-
> 
> i) Detecting bluetooth devices. 
> ii) Sending data to any detected device through a different process (i
> do a fork in the main program). This new process first sets up  a
> RFCOMM channel to the devices OBEX push server and then sends data to
> it through using open obex API. 
> 
> But the above scheme  is not working correctly. Can someone tell me
> the mistake i am making and how should i correct it. Please help me as
> i find my  self quite clueless abt to how to proceed now. Also it
> would be great help if anyone can even give me a direction in which i
> should proceed now. 

you should start using "hcidump -X -V" as root to see what actually
happens. And without seeing the code, we can't tell you anything.

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
