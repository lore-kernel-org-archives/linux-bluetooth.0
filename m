Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple mouse gives me various "Can't get device
	information" troubles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1137558415.7455.20.camel@localhost.localdomain>
References: <1137558415.7455.20.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1137590078.27515.10.camel@localhost>
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
Date: Wed, 18 Jan 2006 14:14:38 +0100

Hi Sunnan,

> I'm trying to pair my Apple wireless mouse on my Ubuntu 5.10 iBook with
> built in bt; it's been out of use for a while and now nothing works
> (maybe some packages messed up or something; the hidd daemon doesn't
> start by default anymore, for one). I'm still using bluez-utils 2.20,
> hope that's fine.
> 
> If I understand correctly, hidd --connect is used for pairing and only
> has to be done once (unless it resets somehow), right? Well, it resetted
> somehow and now I try to --connect it again.

run "hcidump -X -V" while trying to connect and show us the output.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
