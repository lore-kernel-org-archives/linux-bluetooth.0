Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] killing a persisted pand session
Date: Sun, 7 Mar 2004 02:21:59 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com> <1078622263.2807.2.camel@pegasus>
In-Reply-To: <1078622263.2807.2.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403070221.59578.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>


> you have to kill the pand process first and then run 'pand -k' to kill
> the active connections.
>
> Or you extend pand that it will kill the current connection by itself if
> it receives SIG_TERM. Patches are welcome ;)

	Ah so it means that pand -k does not send anything to the pand that is 
running .  pand --connect just does something to create the connection.

	If that is the case why doesn't pand without --persist return after the
	connection was established ?

	W
