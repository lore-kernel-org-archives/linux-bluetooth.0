Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY124-W5118C7F2144DA03833009AF0610@phx.gbl>
References: <BAY124-W5118C7F2144DA03833009AF0610@phx.gbl>
Date: Sun, 01 Apr 2007 14:58:08 +0200
Message-Id: <1175432288.5815.285.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Multithread Service Discovery
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

Hi Robert,

> Thanks again for your help, I'm glad that i now know simultaneous
> service requests is -not- an option, which means that my current
> solution isn't so bad. At the moment i run an HCI enquiry and then
> loop through the results, SDP each device for the obex channel and
> initiate a push to them. The speed is pretty good, we just have the
> problem that if we've got a slow 1.1 device in range, they can hold up
> the queue a couple of seconds.
>  
> Basically i'm looking to build a small application which distributes
> calendar information to people as they walk past my clients pub. But
> as people are walking past it is important that we discover the device
> and its services as quickly as possible, so they dont walk out of
> range before we get chance to push the file to them.
>  
> Have any of you had experience of working with this before? or have
> any advice on it?

sort the list of found devices by RSSI to contact the devices in range
first. Modify the page timeout and link supervision timeout to faster
detect page failures and disconnected links.

You can use two dongles. So one for running the inquiry and the other
one for service discovery and pushing the actual files.
 
> With regards to pushing a file to them, is ObexObjectPush my best
> option? or is ObexFTP replacing this now?

No. OBEX Push is for pushing files and OBEX FTP is for FTP like access
to a file storage.
 
> Using python wont be an issue, I find that most of these top level
> languages are very similar so learning the syntax for python wont be
> an issue, its just a case of finding some good examples to look it.

The inquiry and service discovery is kinda simple via D-Bus and Python.
For pushing the actual file, we don't have a real Python binding.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
