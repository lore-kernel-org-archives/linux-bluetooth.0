Return-Path: <kokor.hekkus@gmx.de>
From: Volker <kokor.hekkus@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] pairing on x86_64
Date: Sat, 21 Feb 2004 14:34:54 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402211252.15735.kokor.hekkus@gmx.de> <1077365351.2716.2.camel@pegasus>
In-Reply-To: <1077365351.2716.2.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402211434.54164.kokor.hekkus@gmx.de>
List-ID: <bluez-users.lists.sourceforge.net>

On Saturday 21 February 2004 13:09, Marcel Holtmann wrote:
> what does your syslog say? Put some syslog() debugging messages in
> utils/hcid/security.c to see where it stops.

security.c loads the right pin at startup.
during pairing, it enters 

gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data)

and leaves the method at this point:

        if (type != HCI_EVENT_PKT) {
                syslog(LOG_INFO, "** type not HCI_EVENT_PKT");
                return TRUE;
        }

any more points, where I should've a look at?

Volker
