Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45A23D10.8030002@free.fr>
Date: Mon, 08 Jan 2007 13:46:08 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Brad Midgley <bmidgley@xmission.com>
References: <20070107120608.05a65c7f@ningauble.scrye.com>
	<45A174A7.3040707@xmission.com>
In-Reply-To: <45A174A7.3040707@xmission.com>
Subject: Re: [Bluez-devel] 2 plugz issues
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

Kevin,
> 
>> 2. Once I comment out that code from 1 above, my headset works fine and
>> sounds ok. However, if I do anything that sends a DTMF from my sip
>> phone (I am using twinkle) it causes twinkle to go into a 100% cpu
>> spin, and once to totally lock up my machine. Any idea why DTMF would
>> cause that? Is there any way I can test or get more info to track down
>> the problem?
> 
> please try it with plugz/patches/sco-flowcontrol-v3.0.diff applied.
> 

I would second Brad remark. With an unpatched kernel you will experience 
kernel crashes. The test you removed from the code was supposed to check 
for the above kernel patch !! ;-)

Btw, i would like to update the project documentation, to explicitely 
say the kernel patch is mandatory.

Brad, how could i do this ? I noticed the web site content is available 
in docs directory of plugz module. Is it enough to modify this directory 
to update the web site ?

Cheers,

Fabien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
