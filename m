Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Beck <becka@uni-duesseldorf.de>
Subject: Re: [Bluez-users] I have a question about the bdaddr utility
In-reply-to: <1126026222.4645.53.camel@blade>
To: bluez-users@lists.sourceforge.net
Message-id: <20050906201502.GA4955@uni-duesseldorf.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <431DC228.7030309@infomatrix.com> <1126026222.4645.53.camel@blade>
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
Date: Tue, 06 Sep 2005 22:15:02 +0200

Marcel Holtmann <marcel@holtmann.org> wrote:
> > My question is, is this change permanently written to the chip, or is it 
> > merely a volatile change as far as the running kernel is concerned?
> the change is permanent.

Would it be possible to make it volatile?

> > The reason I ask is that I am having trouble with dual-booting between 
> > Windows XP and Linux. I have to repair each time I swap operating 
> > systems and it is a pain.
> Once you paired with Linux you can store the link key on the Bluetooth
> chip and you don't need to repair with Windows. Check the hciconfig for
> the correct command.

Could you please detail on that? I can see no obvious way in the manpage
(maybe I should use CVS version?) and I don't quite understand how it
would work. Is there some on-chip storage for linkkeys that gets read
by the windows drivers?

I'm asking, because I have the same problem when moving a bluetooth adapter 
between two different PCs. The headset will need to be re-paired with the 
other PC, whenever I do so (and I got to remove the linkkey before, of 
course).

I could try copying the link keys, as they are both linux (not sure, if 
that would work, but it sounds worth a try), but I doubt this is possible 
with windows.


CU, Andy


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
