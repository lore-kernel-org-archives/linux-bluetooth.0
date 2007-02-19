Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45DA34F8.4070606@free.fr>
Date: Tue, 20 Feb 2007 00:38:32 +0100
From: Eric Estievenart <eric.estievenart@free.fr>
MIME-Version: 1.0
To: timur.alperovich@gmail.com
References: <52950c3f0702191401s4747d0cat8b765596d1998ccc@mail.gmail.com>
In-Reply-To: <52950c3f0702191401s4747d0cat8b765596d1998ccc@mail.gmail.com>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Iscan turning off
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



Timur Alperovich wrote:
> Hi,
> 
> I'm using bluez utils 3.7 and I try to put the bluetooth card in my
> laptop in piscan mode. The operation succeeds, but after a relatively
> short period of time (about 10 minutes), the card goes back to just
> pscan. The reason I'd like to have iscan is that my laptop does not
> appear to be discoverable without it. Could anyone suggest what may be
> the issue? I am attaching my hcid.conf file.

in device {} section, add:

   discovto 0;

This set the iscan timeout to 0 otherwise hcid will
put back the device in non-discoverable mode after
some time (for security reasons).

people, isn't there an FAQ for that (other than /faq.html) ?

Cheers.

-- 
Eric

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
