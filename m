Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth settings in debian
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060106063533.35352.qmail@web60612.mail.yahoo.com>
References: <20060106063533.35352.qmail@web60612.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1136540911.7429.3.camel@localhost>
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
Date: Fri, 06 Jan 2006 10:48:31 +0100

Hi Ronny,

> I have Linux Debian 2.6, bluetooth & Bluez already installed.
> But I don't know how to change setting for bluetooth (like friendly
> name & services).
> How / Where can I find those settings ?

Look at /etc/bluetooth/hcid.conf.
 
> I want to make program like rfcomm server that can receive connection
> up to 7 client and then sending messages between them.
> Does bluez support this ?

Yes.

> Maybe anyone has documentation or sample program for this ?

Look at the source code of bluez-utils.

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
