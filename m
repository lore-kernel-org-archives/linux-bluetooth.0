Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 1
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050131143018.21479.qmail@web60910.mail.yahoo.com>
References: <20050131143018.21479.qmail@web60910.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107182296.7902.11.camel@pegasus>
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
Date: Mon, 31 Jan 2005 15:38:16 +0100

Hi Michael,

>     The version of my hcidump is 1.16. Is it related?
> And how can I correct it as you said the setting is
> fine but the hcidump is strange?

don't worry so much about it. Check with hciconfig that auth and encrypt
are not set and that you put your PIN in /etc/bluetooth/pin and then
restart hcid. Make sure that only one copy of hcid is running.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
