Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Reply-To: tim@birdsnest.maths.tcd.ie
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Confessions of an ignoramus - what is all this PIN stuff?
References: <412D99CA.5050209@nue.et-inf.uni-siegen.de> <200408261502.13690.tim@birdsnest.maths.tcd.ie> <412E45FC.4070604@csr.com>
In-Reply-To: <412E45FC.4070604@csr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408271059.06005.tim@birdsnest.maths.tcd.ie>
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
Date: Fri, 27 Aug 2004 10:59:04 +0100

On Thursday 26 August 2004 21:20, Steven Singer wrote:

> > I find this PIN business very hard to follow.
> > Is there a simple account somewhere?
> > (Please don't refer me to the Bluetooth Spec
> > which I find more or less unintelligble.)
>
> Every Bluetooth device has a unique address. As has been noted on this
> mailing list, addresses can be faked.

Thanks, I found that very helpful.

> > I have two laptops, martha and william (my grandparents).
> > I first linked to my Nokia 6310 with martha.
> > For some reason the phone thinks william is also martha.
> > Is this something to do with the fact that I always use the same PIN?
>
> More likely it's to do with you using the same dongle for both PCs. The
> phone probably read the name stored in the dongle once and has cached
> it. On subsequent occasions when it sees the same device (that is, when
> it has a connection from the same Bluetooth address), it's not bothering
> to read the name, it's just displaying the cached name.

In fact, these are two almost identical laptops with built-in bluetooth.
They have different BT addresses.
I think what must have happened is that at some point in the past
I copied /etc/bluetooth from one to the other.
(I had to replace the hard disk on one.)

Which raises one very minor point -
how can one force two devices to re-pair?

-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
