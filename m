Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problems connecting to Nokia 6310I phone.
Message-ID: <20040531115424.GA24449@gmx.net>
References: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx> <200405310213.25767.tim@birdsnest.maths.tcd.ie> <Pine.LNX.4.58.0405311108560.10172@sebagqbbe.gwsvfure.pb.hx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0405311108560.10172@sebagqbbe.gwsvfure.pb.hx>
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
Date: Mon, 31 May 2004 13:54:24 +0200

On  0, Toby Fisher <toby@tjfisher.co.uk> wrote:
> On Mon, 31 May 2004, Timothy Murphy wrote:
> > Do you have 
> > # CONFIG_BT_HCIUSB_SCO is not set
> > in .config (or /proc/config.gz) ?
> > On my machine (a Sony C1VFK Picturebook)
> > I had more or less your problems when this was set.
> 
> The problem here is that I have a usb bluetooth device, so according to 
> the kernel help I need this option, so yes, I do have it.

You need the HCI_USB SCO option for audio transfer, only. For example if
you use the Headset or Handsfree profile. For data transfer there is no
need for SCO support. You are using RFCOMM which uses ACL links.
And >= 2.6.6-mh1 there shouldn't be any problems with the SCO
support activated.

Maybe you can run hcidump while your problem appears and provide here
the log.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
