Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] trusted
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY12-F184548D865F7C7ED1F9A4F8AB40@phx.gbl>
References: <BAY12-F184548D865F7C7ED1F9A4F8AB40@phx.gbl>
Content-Type: text/plain
Message-Id: <1102347788.9644.37.camel@pegasus>
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
Date: Mon, 06 Dec 2004 16:43:08 +0100

Hi Salvatore,

> Does BlueZ impost trusted and Untrusted device?

actually this is application specific.

> Does BlueZ support Authorisation and authentication, authentication only, no 
> authentication no authorisation for access service?

It supports authentication on the stack level and you must take care of
the authorisation inside your application.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
