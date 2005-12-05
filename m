Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Did not proceed with 2nd OBEX Connect request
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051205083440.79581.qmail@web32414.mail.mud.yahoo.com>
References: <20051205083440.79581.qmail@web32414.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133818488.4559.7.camel@localhost.localdomain>
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
Date: Mon, 05 Dec 2005 22:34:48 +0100

Hi Arch,

> Yes, you're right. There was no OBEX Connect request following the SDP
> service request. What I was trying to ask is that supposed to be,
> there is another OBEX Connect request following the SDP service
> request. However as you have seen in the hcidump trace, this did not
> happen. The normal flow of the Bluetooth transaction on the client
> side is that after the SDP service request, there will be a 2nd OBEX
> Connect request (without a prior OBEX Disconnect request for the 1st
> OBEX Connect request). In this regard, is there something in BlueZ
> that prevents this from happening?

additional SDP request can happen every time. For example to get
information about a status channel or something else. Check the
Bluetooth core or profile specifications for more details.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
