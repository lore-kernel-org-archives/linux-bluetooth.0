Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] SAP service connection problem
Message-ID: <20060111171406.GA3697@localhost.localdomain>
References: <9772C290CD0BDF4B91356C9102BA886A02D10A08@ftrdmel1.rd.francetelecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9772C290CD0BDF4B91356C9102BA886A02D10A08@ftrdmel1.rd.francetelecom.fr>
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
Date: Wed, 11 Jan 2006 19:14:06 +0200

Hi,

> Does somebody have any clue on how to connect to this SAP service ?

Your problem is probably that you are pairing with a PIN code which is
less than 16 characters (SAP requires "strong" PIN code for the
pairing).

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
