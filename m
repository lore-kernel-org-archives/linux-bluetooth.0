Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Charles Bueche <charles@bueche.ch>
To: cijoml@volny.cz
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MX900 page updated
Message-Id: <20040625093333.783da328@bluez.bueche.ch>
In-Reply-To: <200406250026.19454.cijoml@volny.cz>
References: <20040624205328.47bf51ee@bluez.bueche.ch>
	<200406250026.19454.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Fri, 25 Jun 2004 09:33:33 +0200

Hi Michal,

thanks for feedback, see below.

On Fri, 25 Jun 2004 00:26:18 +0200
"Bc. Michal Semler" <cijoml@volny.cz> wrote:
> remove hid2hci working for others :) It works for all :) 

I still need to test this... soon.

> remove not needed uinput module and for Marcel

done, thx.

> how about 8 buttons on mouse? Did you make some research about it?

Not personaly, but below is a feedback I got a few days ago. I changed
my setup and page to use proto "ExplorerPS/2", but so far didn't test
the modpam stuff. It continues to work with another protocol, which is
nice :-)

Charles

--------- 8 buttons ---------
>  I noticed that you are attempting to get all eight buttons to work in
>  Linux.
>  The ImPS/2 driver only has support for five buttons. (3 buttons and 2
>  for the scroll wheel.)
>  Micro$oft overcase this limit by creating an extended version of the
>  protocol, ExplorerPS/2.
>  I do know for a fact that the MX300 uses this protocol for the sixth
>  button.
>  The buttons are weird though.
>  The scroll wheel is located before the 6th button, so my ~/.Xmodmap
>  contains the line "buttons = 1 2 3 6 4 5"
>  The program imwheel can send keyboard events when buttons are
>  pressed, but not executing commands (AFAIK)



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
