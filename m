Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth.init enhance
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407101251.18796.cijoml@volny.cz>
References: <200407101216.11706.cijoml@volny.cz>
	 <1089456352.13519.52.camel@pegasus>  <200407101251.18796.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1089457318.13519.56.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 10 Jul 2004 13:01:58 +0200

Hi Michal,

> > this is nice, but there exists already a backport of HIDP for 2.4 and I
> > submitted the HIDP support with boot protocol only for inclusion into
> > 2.6 and my plan is to include the same into 2.4.28 and my patches if I
> > found time to do this.
> 
> Hmmm :) Few mounths ago you posted into mailing list that you don't plan to 
> port hidp into 2.4. It's nice to hear that you changed your opinion :)

I don't really planned it, but at that point I also had no plans for the
boot protocol mode. The broken EPoX devices convinced me otherwise and
so a least the boot protocol mode should be possible for 2.4, but don't
ask me how soon I will do that. Is there anyone else who will fill this
gap right now?

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
