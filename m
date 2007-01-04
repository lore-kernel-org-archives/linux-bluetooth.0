Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 4 Jan 2007 09:14:05 +0800
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070104011404.GA3205@163.com>
References: <1543.200.124.231.241.1167846814.squirrel@ceibo.fiec.espol.edu.ec>
MIME-Version: 1.0
In-Reply-To: <1543.200.124.231.241.1167846814.squirrel@ceibo.fiec.espol.edu.ec>
From: amateur <ztl.post@gmail.com>
Subject: Re: [Bluez-devel] [Fwd: how to install bluez utils]
Reply-To: amateur <tlzhao@nudt.edu.cn>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

On Wed, Jan 03, 2007 at 12:53:34PM -0500, eduran@fiec.espol.edu.ec wrote:
> I installed Bluez libs but when I want to install bluez utils, I pasted
> the folder in the desktop
> opened a terminal and writed ./configure
> but i get it:
> for BLUEZ configure: error: Bluetooth library is required
> 
> Could Someone help me, please
I'm afraid your bluez-libs are not installed to the standard position,
eg. /usr/lib, /usr/local/lib, /usr/include etc. You can always use the 
gcc option -I and -L to specifiy where you have installed the
libraries if you did have installed them.

-- 
Are you making all this up as you go along?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
