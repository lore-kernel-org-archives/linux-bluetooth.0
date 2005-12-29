Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci connect and switch role modifications
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <loom.20051229T161453-986@post.gmane.org>
References: <loom.20051229T161453-986@post.gmane.org>
Content-Type: text/plain
Message-Id: <1135882032.5426.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 29 Dec 2005 19:47:11 +0100

Hi Marcello,

> we are working with Bluetooth and BlueZ since two years, and during the
> development of a field failure data analysis of Bluetooth networks, we
> experienced some annoying and frequent runtime errors that could be avoided.
> Those errors concern the creation of a L2CAP connection via HCI and the role
> switch operation. However, we discovered how to prevent these errors from
> occurring, by adding a little amount of code in the hci_create_connection and
> hci_switch_role functions in hci.c.   
> 
> We would like to contribute to the development and let the community know and
> evaluate these modifications.
> 
> If you are interested, let us know what is the procedure to contribute.

simply sent a unified diff against the latest CVS to the mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
