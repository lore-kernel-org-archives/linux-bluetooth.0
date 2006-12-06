Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4577529E.7000304@softmonsters.com>
Date: Thu, 07 Dec 2006 00:30:38 +0100
From: Zsolt Barat <zsolt@softmonsters.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45755127.6020907@softmonsters.com> <45773D8B.7020403@xmission.com>
In-Reply-To: <45773D8B.7020403@xmission.com>
Subject: Re: [Bluez-users] [PATCH] fix for kernel flow control patch mh7
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

Brad Midgley schrieb:
> Zsolt
> 
>> attached is a trivially fixed version of the flow-control-patch mh7,
>> which could be found on
>> http://bluetooth-alsa.sf.net/bluez-sco-flowcontrol-mh7.patch
>> to work with gentoo-suspend2-sources and linux-2.6.18-vanilla.
>> i don't know which kernel-version it supposed to be apply.
>> would be nice to mention it on the website somewhere.
> 
> I've linked to Fabien's latest submission and linked to the bluez patch 
> page. Fabien's patch is against -mh7 but I will try it against -mh8 to 
> se if there are any conflicts.
ah, ok now i understand. mh is an extra patch set. i thought mh is
already fabians private patch set.
then all is probably wrong.
nevertheless with the small fix above the flow-control patch applies
also against 2.6.18 with suspend2-patches and even to 2.6.18-vanilla.
if it has any use it's another question.
what i can say for sure is that with the flow-control-patch sco and the
alsa-plugin layer works. i had to figure out to do resampling and
channel-routing right to get it work. but it was after i applied the patch.
btw. the setup with the kernel module is much easier in this regard.

> 
> It would be good to know if suspend2 patches complicate things. I don't 
> use suspend2 myself.
no, no complications so far. i think suspend2 doesn't touch this areas
where flow-control is involved. i have the kernel running on my notebook
since i posted the patch. suspend+resume works fine.

regards

zsolt


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
