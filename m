Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] I have a question about the bdaddr utility
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050907101308.027e8482.pws@csr.com>
References: <431DC228.7030309@infomatrix.com>
	 <1126026222.4645.53.camel@blade> <20050906201502.GA4955@uni-duesseldorf.de>
	 <1126040038.19765.3.camel@blade>  <20050907101308.027e8482.pws@csr.com>
Content-Type: text/plain
Message-Id: <1126139317.14636.15.camel@blade>
Mime-Version: 1.0
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
Date: Thu, 08 Sep 2005 02:28:37 +0200

Hi Peter,

> > > > > My question is, is this change permanently written to the chip, or is it 
> > > > > merely a volatile change as far as the running kernel is concerned?
> > > > the change is permanent.
> > > 
> > > Would it be possible to make it volatile?
> > 
> > in case of CSR chips the BD_ADDR is a PSKEY. I don't know if it can be
> > made volatile. This is a question for the CSR gurus ;)
> 
> It's possible to have volatile PSKEYs.  You need to use the CSR BCCMD
> command set to make this work, but that's the same set you'd be using to
> write the PSKEY to flash.  The command is BCCMDVARID_PS.  You write the
> PSKEY to temporary (actually, it says here "transient") store (code 8)
> instead of the default (code 0) or implementation (usually meaning flash,
> code 1).  Then you have to perform a warm reset by setting
> BCCMDVARID_WARM_RESET --- this resets pretty much everything except the
> persistent store, including resetting the host transport.  There's no way
> around the warm reset; the new address won't take effect otherwise.  Note
> the temporary store overrides any address in flash.

this is great. I added a "-t" switch to the bdaddr utility to make the
change of the address volatile and a "-r" switch to perform the needed
cold or warm reset.

> If you don't already have access to the BCCMD command set this is likely to
> be Greek, unfortunately.  (Unless you speak Greek.)

Some people of us speak Greek ;)

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
