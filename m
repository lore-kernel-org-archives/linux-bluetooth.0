Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Toby Fisher <toby@tjfisher.co.uk>
To: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problems connecting to Nokia 6310I phone.
In-Reply-To: <200405310213.25767.tim@birdsnest.maths.tcd.ie>
Message-ID: <Pine.LNX.4.58.0405311108560.10172@sebagqbbe.gwsvfure.pb.hx>
References: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx>
 <200405310213.25767.tim@birdsnest.maths.tcd.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 31 May 2004 11:09:57 +0100 (BST)

On Mon, 31 May 2004, Timothy Murphy wrote:

> On Sunday 30 May 2004 22:25, Toby Fisher wrote:
> 
> > I'm using kernel 2.6.6RC1, and I almost have the connecting working with
> > Gnokii to the phone.  However, there are some weird things going on which
> > lead me to belioeve that something is wrong.
> >
> > I can, using rfcomm, get a connection to the phone, however tearing it
> > down has strange results:
> > 1.  Once the connection is down, I can no longer ping the phone using
> > l2ping, though hcitool scan and info still work.
> 
> Do you have 
> # CONFIG_BT_HCIUSB_SCO is not set
> in .config (or /proc/config.gz) ?
> On my machine (a Sony C1VFK Picturebook)
> I had more or less your problems when this was set.

The problem here is that I have a usb bluetooth device, so according to 
the kernel help I need this option, so yes, I do have it.

Cheers.

-- 
Toby Fisher	Email: toby@tjfisher.co.uk
Tel.: +44(0)1480 417272	Mobile: +44(0)7974 363239
ICQ: #61744808


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
