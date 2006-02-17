Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43F62ECF.7040702@hasborg.com>
From: Joshua Wright <jwright@hasborg.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hcidump version 1.30 and DBT-120 version B-4
References: <20060217195408.21336.qmail@web61223.mail.yahoo.com>
In-Reply-To: <20060217195408.21336.qmail@web61223.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 17 Feb 2006 15:15:11 -0500

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Deva,

deva seetharam wrote:
> i am trying to run hcidump to sniff bluetooth packets. for some
> reason, hcidump doesn't produce any output eventhough the there is
> plenty of bluetooth  traffic in the vicinity (i have verified it
> using MAC OS bluetooth packet logger).

hcidump is a local sniffer, it only is capable of sniffing local HCI
messages.  Because Bluetooth is based on FHSS, sniffing traffic out of
the air is a bit more challenging.

The Frontline Test Equipment FTS4BT sniffer is designed to help
developers troubleshoot Bluetooth applications and does give you the
ability to sniff Bluetooth frames.  www.fte.com

- -Josh
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFD9i7PTS8i9jZYpL8RAoVSAKDT0wELkbN2ZHP+Ax1z3VH0163lIQCg6pEv
/yB8S42w2/iQCS3y0ivj7h0=
=i66O
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
