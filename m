Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1175170837.5815.194.camel@violet>
References: <007801c77120$bb936640$9d0cc70a@dlh.st.com>
	<1175077084.5815.123.camel@violet>
	<1175085249.2996.1.camel@dhcp-1-148.fab.redhat.com>
	<1175086057.5815.132.camel@violet>
	<1175087236.2996.8.camel@dhcp-1-148.fab.redhat.com>
	<1175088059.5815.139.camel@violet>
	<1175170710.15698.156.camel@cookie.hadess.net>
	<1175170837.5815.194.camel@violet>
Date: Thu, 29 Mar 2007 14:24:14 +0100
Message-Id: <1175174654.15698.160.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid returning "Device or resource busy"?
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

On Thu, 2007-03-29 at 14:20 +0200, Marcel Holtmann wrote:
> Hi Bastien,
<snip>
> > Shouldn't it return org.bluez.Error.InProgress instead in that case?
> 
> it is a different operation that is in progress.

Ha. The documentation could do with a bit of rewording for that error
(it's not clear that InProgress is when the *same* operation that one
tried to perform is already running).

> > > You can wait for the completed RemoteNameUpdated or RemoteNameFailed
> > > signals before actually starting the DiscoverDevices procedure. However
> > > in case of devices out of range this might not be a good idea.
> > 
> > The problem is that I don't know for which devices hcid will try to go
> > and fetch the names for.
> > 
> > Also, the doc for ListRemoteDevices should mention the fact that it
> > might perform remote operations, as it's not really clear from the doc
> > right now.
> 
> Actually ListRemoteDevices is not doing it. It happens when you call
> GetRemoteName while you are adding it to your list.

Oh, my mistake. I'll fix my code then :)

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
