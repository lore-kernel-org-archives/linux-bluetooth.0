Return-Path: <gareth@apache.org>
Date: Fri, 28 Nov 2003 13:07:51 -0800 (PST)
From: Gareth Reakes <gareth@apache.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bthid question
In-Reply-To: <20031128070531.F61007@minotaur.apache.org>
Message-ID: <20031128125922.O44245@minotaur.apache.org>
References: <20031128011412.C61007@minotaur.apache.org>  <1070025957.9036.153.camel@pegasus>
  <20031128060135.H61007@minotaur.apache.org> <1070031670.9036.166.camel@pegasus>
 <20031128070531.F61007@minotaur.apache.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hey,
	grrrrrr. This did not work. I think my problem is different so I
suggest that someone who has the M$ stuff try Marcels idea. To try this I
think you can put the code in the shutdown method. Mine now looks like
this

static
void
shut_down (int status) {
	kb_reset ();
	mouse_reset ();

	close(intr_sock);
	sleep(1);
	close(ctl_sock);


	if (status == EXIT_SUCCESS &&
	    will_initiate_reconnections)
		status = EXIT_FAILURE;

	exit (status);
}

Note that this may not end up being the correct place for the code,
especially if the control and interupt have to be shut down in different
orders, depending on who is terminating, but it should do to test if this
will solve the problem.

This may well solve the keyboard reconnect problem. I would be interested
to hear anyones results. I would also like to know peoples experience when
they go ./bthid -l. The moment I touch the mouse or keyboard 100% of the
CPU is used until I kill bthid. Does this happen with other people? Note
that I have no other bthids running.

Does anyone have any idea what to try next (I will start work on the USB
HID kernel modification when I have some time soon but would love to get
them working first)?


Cheers,

Gareth

On Fri, 28 Nov 2003, Gareth Reakes wrote:

>
> > If you exit the program without closing the L2CAP sockets, the OS will
> > close it for you and this is the same as you close the sockets without
> > sleeping between it. Closing the ACL link is the job of the kernel.
>
> OK, this may be the problem then :) Thanks for that. I will try it when I
> get home tonight and report back.
>
> I appreciate all your time on this Marcel,
>
> Gareth
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
