Return-Path: <i_p_a_u_l@yahoo.com>
Message-ID: <20040816180651.48235.qmail@web50202.mail.yahoo.com>
Date: Mon, 16 Aug 2004 11:06:51 -0700 (PDT)
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [Bluez-users] Need help with PAND between 2  linux boxes
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092666785.4375.150.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> > ifconfig bnep0
> > down, and I wanted to "rmmod bnep".
> > But rmmod bnep gives:
> > ERROR: Module bnep is in use
> > And indeed is in use by "ps xa|grep bnep" :
> > 2660 ?        SW<    0:00 [kbnepd bnep0]
> > 
> > Is this normal ?
> 
> Yes, because "ifconfig bnep0 down" doesn't kill the
> BNEP connection
> between these two devices. Try to run "pand -K".

It worked flawlessly with "pand -K".
And thanks again, your answers were like instant.

Paul,
A happy now pan with bluez user.


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
