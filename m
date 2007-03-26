Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 26 Mar 2007 09:06:53 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070326070653.GG32603@suse.de>
References: <200703252035.05891.dgollub@suse.de>
MIME-Version: 1.0
In-Reply-To: <200703252035.05891.dgollub@suse.de>
Subject: Re: [Bluez-devel] Input service and multiple adapters
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

On Sun, Mar 25, 2007 at 08:35:05PM +0200, Daniel Gollub wrote:
> Hi folks,
> 
> i started playing around with the Input DBUS API and found an obscurity when 
> multiple bluetooth adapters are used. Actually this is a really rare use 
> case...
> 
> If i use Adapter A and call CreateDevice() and Connect() to an input device .. 
> everything works as expected. If Adapter A got unplugged/broken and got 
> replaced by Adapter B and call CreateDevice() for the same input device. The 
> result will be org.bluez.input.AlreadyExists
> 
> Again.. this is a really rare use case, but is it intended to only have one 

No, it is pretty common.
I have one USB cable at home, with a hub and everything (including BT dongles)
connected to it and one USB cable at work, again with a BT dongle.  And then i
have a BT dongle in my pocket for on-the-road usage.
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out." 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
