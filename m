Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: Robert Wlaschin <robertw@healthhero.com>
Cc: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CBBBD909D2D6D211B4700090273F9E6E04C49A66@polaris.hhn.com>
References: <CBBBD909D2D6D211B4700090273F9E6E04C49A66@polaris.hhn.com>
Content-Type: text/plain
Message-Id: <1128455925.26362.21.camel@blade>
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
Date: Tue, 04 Oct 2005 21:58:45 +0200

Hi Robert,

> In regards to the type of communication, I'm trying to create a BT
> serial connection.  The device I'm attempting to connect to is
> actually a weight scale (medical device).  It doesn't support any
> other services.  I probably need to add that I changed rfcomm.conf to
> listen, bind, and connect for rfcomm0.  Note: The last time I used
> linux was in college and it was only to compile my assignments, so I'm
> not savvy.

you need to do a "rfcomm bind 0 <bdaddr> <channel>" and you will get a
new /dev/rfcomm0 TTY device. Now use a terminal program like minicom or
cu for the communication.

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
