Return-Path: <kokor.hekkus@gmx.de>
From: Volker Fritzsch <kokor.hekkus@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] pairing on x86_64
Date: Sat, 21 Feb 2004 15:08:47 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402211252.15735.kokor.hekkus@gmx.de> <200402211434.54164.kokor.hekkus@gmx.de> <1077371771.2716.5.camel@pegasus>
In-Reply-To: <1077371771.2716.5.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402211508.47481.kokor.hekkus@gmx.de>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

> try the attached patch.
unfortunatly, the patch didn't fix it.
I've added some more syslog() calls to security.c:

        type = *ptr++;

        syslog(LOG_INFO, "** type is %s", type);
        if (type == HCI_EVENT_PKT) {
                syslog(LOG_INFO, "** type is HCI_EVENT_PKT");
        }
        if (type == HCI_COMMAND_PKT) {
                syslog(LOG_INFO, "** type is HCI_COMMAND_PKT");
        }
        if (type == HCI_ACLDATA_PKT) {
                syslog(LOG_INFO, "** type is HCI_ACLDATA_PKT");
        }
        if (type == HCI_SCODATA_PKT) {
                syslog(LOG_INFO, "** type is HCI_SCODATA_PKT");
        }
        if (type == HCI_UNKNOWN_PKT) {
                syslog(LOG_INFO, "** type is HCI_UNKNOWN_PKT");
        }
        if (type != HCI_EVENT_PKT) {
                syslog(LOG_INFO, "** type not HCI_EVENT_PKT");
                return TRUE;
        }

now it says:
'** type is (null)'

(without your patch and with
syslog(LOG_INFO, "** type is %d", type);
it was
'** type is 0'
)

thanks, Volker
