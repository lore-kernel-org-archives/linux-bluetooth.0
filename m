Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] disappointed with my MX900 battery life
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073636191.8413.743.camel@bluez.bueche.ch>
References: <1073555620.5632.8.camel@bluez.bueche.ch>
	 <1073583568.2563.29.camel@pegasus>
	 <1073636191.8413.743.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1073657745.2563.85.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 09 Jan 2004 15:15:45 +0100

Hi Charles,

> > On the other hand the Apple Bluetooth
> > mouse never uses sniff mode to save power. Run a hcidump and check what
> > your mouse is doing.
> 
> I left hcidump running for a while (~15 min) and I saw it doing a change
> mode :
> 
> 1073632217.880298 > HCI Event: Mode Change(0x14) plen 6
> 1073632217.892269 > HCI Event: Mode Change(0x14) plen 6
> 
> ....time goes a bit
> 
> 1073632832.674873 > HCI Event: Mode Change(0x14) plen 6
> 1073632832.688834 > HCI Event: Mode Change(0x14) plen 6
> 
> Can you interpret this ? Looks like Klingon to me :-)

run the hcidump with "-x" to see that packet content, but in general it
changes to sniff mode and so power saving works.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
