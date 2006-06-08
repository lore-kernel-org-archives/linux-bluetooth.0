Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4487D426.7060403@xmission.com>
Date: Thu, 08 Jun 2006 01:39:18 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <96B7A15232D6CF42836BFD428AD6B6034E5727@deexmb01.de.icap.com>
In-Reply-To: <96B7A15232D6CF42836BFD428AD6B6034E5727@deexmb01.de.icap.com>
Subject: Re: [Bluez-users] bluetooth-alsa:
	a2recv	stutteringsound	from	WM5.0AKU2.0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Guido

> Have tried as a normal User and it works!!
> Thanks so far, but is this a bug, that you can not use a2recv as root?

strange. i don't have the ppc now... could you disable the call to
hci_switch_role() and try running it as root again?

the role switch is required by one of the a2dp transmitter dongles out
there but if it causes problems we should at least make it a
command-line option.

> The first stuttering in WM5.0 can be fixed with a registry path ... than
> there will be no stuttering on the first secounds.

can you tell us the registry hack for the archives?

thanks
brad


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
