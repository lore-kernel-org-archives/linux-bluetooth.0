Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: Robert Wlaschin <robertw@healthhero.com>
Cc: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CBBBD909D2D6D211B4700090273F9E6E04C49A6E@polaris.hhn.com>
References: <CBBBD909D2D6D211B4700090273F9E6E04C49A6E@polaris.hhn.com>
Content-Type: text/plain
Message-Id: <1128538549.5447.40.camel@localhost.localdomain>
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
Date: Wed, 05 Oct 2005 20:55:49 +0200

Hi Robert,

> I appreciate the help.  Is there a recommended way to verify the
> linkkey isn't incorrect?

in case of an authentication and an previous requested link key we
should remove it from the file storage, but we are not doing this at the
moment.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
