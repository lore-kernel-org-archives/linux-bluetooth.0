Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 10 Jan 2007 10:11:30 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070110081130.GA16066@jh-mbp>
References: <20070110050553.27942.qmail@webmail47.rediffmail.com>
MIME-Version: 1.0
In-Reply-To: <20070110050553.27942.qmail@webmail47.rediffmail.com>
Subject: Re: [Bluez-devel] bt.headset issue
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

Hi Nel,

On Wed, Jan 10, 2007, Nel wrote:
>  My question is 
>  1. Has the new bluez-util integrated btsco ??

No. Well, at least not yet. It's possible that the API described in the 
"future" pages of bluetooth-alsa.sf.net will get integrated to 
bluez-utils at some point. However, the plan is to call the daemon 
bt.audiod then. bt.headsetd is purely an experimental thing currently 
(and not really useful for anything yet) and the D-Bus API it implements 
is still undergoing a lot of change.

>  2. What am i missing to get this error ??

The Service interface (implemented by hcid) that bt.headsetd uses is 
marked as experimental and you need to therefore give the -x switch to 
hcid in order to enable it.

Johan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
