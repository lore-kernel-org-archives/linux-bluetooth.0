Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] I have a question about the bdaddr utility
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050906201502.GA4955@uni-duesseldorf.de>
References: <431DC228.7030309@infomatrix.com>
	 <1126026222.4645.53.camel@blade> <20050906201502.GA4955@uni-duesseldorf.de>
Content-Type: text/plain
Message-Id: <1126040038.19765.3.camel@blade>
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
Date: Tue, 06 Sep 2005 22:53:58 +0200

Hi Andy,

> > > My question is, is this change permanently written to the chip, or is it 
> > > merely a volatile change as far as the running kernel is concerned?
> > the change is permanent.
> 
> Would it be possible to make it volatile?

in case of CSR chips the BD_ADDR is a PSKEY. I don't know if it can be
made volatile. This is a question for the CSR gurus ;)

> > > The reason I ask is that I am having trouble with dual-booting between 
> > > Windows XP and Linux. I have to repair each time I swap operating 
> > > systems and it is a pain.
> > Once you paired with Linux you can store the link key on the Bluetooth
> > chip and you don't need to repair with Windows. Check the hciconfig for
> > the correct command.
> 
> Could you please detail on that? I can see no obvious way in the manpage
> (maybe I should use CVS version?) and I don't quite understand how it
> would work. Is there some on-chip storage for linkkeys that gets read
> by the windows drivers?

Whoops. It seems that I forgot to update the manual page. What you are
searching for are the putkey and delkey commands. Call "hciconfig -h".

> I'm asking, because I have the same problem when moving a bluetooth adapter 
> between two different PCs. The headset will need to be re-paired with the 
> other PC, whenever I do so (and I got to remove the linkkey before, of 
> course).
> 
> I could try copying the link keys, as they are both linux (not sure, if 
> that would work, but it sounds worth a try), but I doubt this is possible 
> with windows.

Copying the link key should work.

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
