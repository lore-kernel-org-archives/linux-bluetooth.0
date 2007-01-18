Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45AF7265.4050806@glidos.net>
Date: Thu, 18 Jan 2007 13:13:09 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45AD232F.30104@glidos.net>
In-Reply-To: <45AD232F.30104@glidos.net>
Subject: Re: [Bluez-users] Problems fooling my S100 into using Bluez as a
 modem
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
> Paul Gardiner wrote:
>  > Paul Gardiner wrote:
>  > No chance someone can have a quick look at the three
>  > traces? (should be the messages that appear at the
>  > same level in this thread as this message)
>  >
>  > I know its a lot to ask, but I so much want to have
>  > this working again, and there's no way forward
>  > without help.
> 
> That'll be a no then, I guess. :-(
> 
> Anyway, here's another strange thing that might
> be an indicator of what's wrong: ps alx shows me
> 
>    /usr/bin/dund --listen --persist --msdun call dun
> 
> 
> suggesting that dund is running and happy, but
> 
> sdp://localhost lists
> 
> Obex Push Server
> KBSerialChat
> KDE Bemused
> LAN Access Point
> 
> and that's it. No Dial Up Networking.  Why would
> that be?

Just a suggestion as to what I should check next, maybe?

Or is the general consensus that I should give up? (although
this all worked fine with an earlier version of bluez).

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
