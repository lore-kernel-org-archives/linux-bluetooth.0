Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] blue-fw not working for USB Belkin F8T001
	in	Gentoo Linux
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex Holland <ah160@york.ac.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FFC03A3.5090807@york.ac.uk>
References: <3FFBFC34.3050509@york.ac.uk>
	 <1073479827.2508.143.camel@pegasus>  <3FFC03A3.5090807@york.ac.uk>
Content-Type: text/plain
Message-Id: <1073491974.2508.173.camel@pegasus>
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
Date: Wed, 07 Jan 2004 17:12:54 +0100

Hi Alex,

> Any plans to backport the -mh2 patch to 2.4? The Gentoo devs would 
> probably be interested, they're patch crazy :)

I have a backport of the driver, but it crashes on 2.4 after unlinking
the URB and I have no time for further investigations.

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
