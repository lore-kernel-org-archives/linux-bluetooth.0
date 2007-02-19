Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D91EC2.5000201@xmission.com>
Date: Sun, 18 Feb 2007 20:51:30 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5b9417770702181902v287f5d44uc513b4d8bc8f1a79@mail.gmail.com>
In-Reply-To: <5b9417770702181902v287f5d44uc513b4d8bc8f1a79@mail.gmail.com>
Subject: Re: [Bluez-devel] if using bluetooth DUN,
	how to get best performance?
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

John

> I am using bluetooth DUN on an EVDO network, but it's not that fast.
> Is there anything I should do to maximize the speed I get?
> 
> like, should i leave it at 230000 baud, or increase it to something else, etc.

it depends a lot on the phone. The pocketpc phones I've tried were 
notoriously bad at the data rate (and also tend to drop the connection 
at random)

the best phone was a e815 but verizon seems to have messed up dun on it. 
it was getting 600kbps in urban areas. the 700p I have now gets around 
400kbps.

evdo quality varies a bit... some areas I never got better than 300kbps 
even with the motorola.

my serial baud rate is set to 460800 but that doesn't seem to really matter.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
