Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout, VIA USB HUBS
From: Marcel Holtmann <marcel@holtmann.org>
To: "t.[NO_SPAM]" <schorpp@gmx.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FFABD90.1020903@gmx.de>
References: <3FF9E3F2.4040506@gmx.de> <1073393043.2508.50.camel@pegasus>
	 <3FFAB0C5.4050407@gmx.de> <1073396288.2508.72.camel@pegasus>
	 <3FFABD90.1020903@gmx.de>
Content-Type: text/plain
Message-Id: <1073397402.2508.81.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 06 Jan 2004 14:56:43 +0100

Hi Thomas,

> > This is HCI 16.4 firmware and it should work fine. Do you use the SCO
> > audio support for the HCI USB driver? If yes, disable it, because I
> > heard of problems with ISOC transfers on VIA chips if I remember
> > correctly.
> 
> NO sco module loaded(?)

I am not talking about the sco module. I am talking about the SCO audio
option of the HCI USB driver. Disable it to avoid ISOC transfers.

> > Use 2.4.23-mh1 or 2.4.24-mh1.
> 
> roger that. what change do you think in the changelogs should target the 
> problem?

In general nothing will help here, but I must be sure that we talk about
the same version of the Bluetooth subsystem.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
