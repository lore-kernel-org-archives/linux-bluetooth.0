Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluetooth.init enhance
References: <200407101216.11706.cijoml@volny.cz> <1089456352.13519.52.camel@pegasus>
In-Reply-To: <1089456352.13519.52.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200407101251.18796.cijoml@volny.cz>
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
Date: Sat, 10 Jul 2004 12:51:18 +0200

On Saturday 10 of July 2004 12:45, you wrote:
> Hi Michal,
>
> > maybe you should tweak this script little bit:
> >
> > add this into HIDD start section to allow others to use hidd and bthid at
> > the same time, if they have bthid from CVS (I know you want remove it at
> > all, but now in 2.4 we don't have any other way to use hid devices)
>
> this is nice, but there exists already a backport of HIDP for 2.4 and I
> submitted the HIDP support with boot protocol only for inclusion into
> 2.6 and my plan is to include the same into 2.4.28 and my patches if I
> found time to do this.

Hmmm :) Few mounths ago you posted into mailing list that you don't plan to 
port hidp into 2.4. It's nice to hear that you changed your opinion :)

M.

>
> Regards
>
> Marcel


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
