Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] SAP service connection problem
Message-ID: <20060111175207.GA3775@localhost.localdomain>
References: <9772C290CD0BDF4B91356C9102BA886A02D10A43@ftrdmel1.rd.francetelecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9772C290CD0BDF4B91356C9102BA886A02D10A43@ftrdmel1.rd.francetelecom.fr>
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
Date: Wed, 11 Jan 2006 19:52:07 +0200

> I actually use a 16 digits pin code.

The next step I'd try is to disable auth and encrypt in hcid.conf since
security mode 3 is probably not what you want. After that remove the
link key and try again. The phone should initiate pairing when you try
to connect to the SAP RFCOMM channel. Alternatively you can try to do
the pairing manually before creating the RFCOMM connection (e.g. with
HCI_Create_Connection and HCI_Authentication_Requested).

Johan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
