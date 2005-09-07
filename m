Return-Path: <bluez-users-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] I have a question about the bdaddr utility
References: <431DC228.7030309@infomatrix.com> <20050906201502.GA4955@uni-duesseldorf.de> <1126040038.19765.3.camel@blade>
In-Reply-To: <1126040038.19765.3.camel@blade>
MIME-Version: 1.0
Message-Id: <20050907091350.437D57ED@arbetsmyra.dyndns.org>
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
Date: Wed, 7 Sep 2005 11:13:13 +0200


> > > > My question is, is this change permanently written to the chip,
> > > > or is it merely a volatile change as far as the running kernel
> > > > is concerned?
> > >
> > > the change is permanent.
> >
> > Would it be possible to make it volatile?
>
> in case of CSR chips the BD_ADDR is a PSKEY. I don't know if it can
> be made volatile. This is a question for the CSR gurus ;)


Hi
This is a bit of guessing...but I think there is at least a theoretical 
way of achieving this volatile.

Some PSKEYs can be written to the device RAM which then overrides the 
persisten flash values as long power supply retains. Haven't tried it 
though but it's perhaps something to investigate further.

/Ronny




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
