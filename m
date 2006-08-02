Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Milind Dumbare <milind@linsyssoft.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d23110170608011015h3bef584cn65a7d24fc73ec931@mail.gmail.com>
References: <1154441823.5306.13.camel@Shadowfox.linsyssoft.com>
	<d23110170608011015h3bef584cn65a7d24fc73ec931@mail.gmail.com>
Date: Wed, 02 Aug 2006 11:41:14 +0530
Message-Id: <1154499074.2302.2.camel@Shadowfox.linsyssoft.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Reboot notifier
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

Hi,
	 Reboot notifier will register bluetooth driver to reboot notification
list of kernel. Whenever machine will get rebooted bluetooth drvier will
get notified by type of reboot(Halt/reboot/poweroff). We can do
interesting things after we get notified that reboot will be there.
	

On Tue, 2006-08-01 at 14:15 -0300, Ulisses Furquim wrote:
> Hi Milind,
> 
> On 8/1/06, Milind Dumbare <milind@linsyssoft.com> wrote:
> >         I think bluetooth stack for linux needs reboot notifier. I am thinking
> > of writing it. Shall I?
> 
> Sorry, but I don't know what this "reboot notifier" feature really is.
> Do you mind explaining it, please?
> 
> -- Ulisses
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
-- 
-Milind
"There is no place like 127.0.0.1"


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
