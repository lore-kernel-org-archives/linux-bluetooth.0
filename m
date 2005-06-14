Return-Path: <bluez-users-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] varying time to connect
References: <20050613194748.5455A56F@arbetsmyra.dyndns.org> <ef9938ec05061322251d0b493a@mail.gmail.com>
In-Reply-To: <ef9938ec05061322251d0b493a@mail.gmail.com>
Cc: Albert Huang <ashuang@gmail.com>
MIME-Version: 1.0
Message-Id: <20050614080104.BAA4156F@arbetsmyra.dyndns.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 14 Jun 2005 10:00:39 +0200


> The short answer is no.  The connection algorithm (paging) is
> probabilistic, and the frequency that one bluetooth device is
> listening on may not match the frequency the connecting device is
> transmitting on for a few seconds.
> -albert

Ok, thanks. But isn't inquireing meant to fix that? Then one "scan" for 
remote device clock offset, right? So both use same freq simultaneously 
(my guess only). Isn't that fetched clock offset used when doing a 
connect?

BR
/Ronny Nilsson




> On 6/13/05, Ronny L Nilsson <bb@arbetsmyra.dyndns.org> wrote:
> > When connecting to a remote device with:
> >   hcitool cc 00:11:22:33:44:55
> > the time for the connection to succeed vary from anything between
> > 0.5 - 5 seconds. Is there any good explanation for this? Shouldn't
> > it be somewhat equal each and every time? Especially when trying
> > many times in a row?
> >
> > Is there a way to optimse the connection phase? Obviously it can be
> > made within 0.5 s, but how to do it every time and not just
> > randomly?
> > /Ronny Nilsson




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
