Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Martin Stolle <mstoll@sus.mcgill.ca>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Two "identical" laptops, same phone, one works, one doesn't
Message-ID: <20060129143304.GA7562@sus.mcgill.ca>
References: <37f261b0601090736w6d7157d6x6ea876ecafb3572e@mail.gmail.com> <37f261b0601120320n516e7466ld95aa0b2d1ac9f83@mail.gmail.com> <37f261b0601120821t3b0449f4me94b7b73707d49a8@mail.gmail.com> <37f261b0601282344k416742d1j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37f261b0601282344k416742d1j@mail.gmail.com>
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
Date: Sun, 29 Jan 2006 09:33:07 -0500

On Sun, Jan 29, 2006 at 09:44:19AM +0200, Hugo van der Merwe wrote:
> For the record, for future reference by other people having similar
> problems, I've solved this problem, with the help of a tip from a
> friend. He said I should wipe /var/lib/bluetooth/* to start from
> scratch. That solved the problem.
> 

I've also had similar problems with RFCOMM, that were solved my wiping
that directory.  In particular, I could communicate with my phone once,
during the original pairing, and after that, future connections were
refused.  Deleting the pairing on the phone (a Nokia 6310i), would allow
me to re-pair, but any subsequent connections after the initial re-pair
connection would fail until I deleted the pairing on the phone.

After a lot of grief, I finally found some random forum post about
the /var/lib/bluetooth directory.  Is there any documentation on this?
It seems like it stores the cryptographic keys for the pairing, and this
mechanism changed recently in bluez?  Unfortunately, none of the man
pages hint at this at all and the bluez webpage doesn't have any
official documentation either.  Where should I have looked?

Martin



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
