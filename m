Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 3
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050203142619.94035.qmail@web60902.mail.yahoo.com>
References: <20050203142619.94035.qmail@web60902.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107442481.11944.75.camel@pegasus>
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
Date: Thu, 03 Feb 2005 15:54:41 +0100

Hi,

>     Now I put all parts of rctest.c in my main program
> to test, and then I found the error message " Can't
> set RFCOMM link mode: Protocol not available (92)",
> and this happens in do_listen part. My T610 has
> included  my PC in the menu of "My device". So, what
> have I do so that the RFCOMM link can be set?

you have two possibilities. First you can install a Linux kernel where
RFCOMM link mode is supported. This is a 2.6.10-mh3 or a 2.6.11-rc3.
Second you don't use any link mode features. Means that no master, auth,
encrypt or secure variable should be set to 1.

I really would feel better if you try to understand what the code in
rctest.c means and actually does, instead of only copy it and then try
to use it.

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
