Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] accessing info on paired devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Pall Thayer <palli@pallit.lhi.is>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <415921D4.9000605@pallit.lhi.is>
References: <41570BC9.6090109@pallit.lhi.is>
	 <1096359364.4684.28.camel@notepaq>  <415921D4.9000605@pallit.lhi.is>
Content-Type: text/plain
Message-Id: <1096361009.4684.36.camel@notepaq>
Mime-Version: 1.0
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
Date: Tue, 28 Sep 2004 10:43:29 +0200

Hi Pall,

> But the link key is in binary form so I can't read it. What I've been 
> doing is just sending a single l2ping to each of the discovered devices, 
> the ones that are paired and authorized respond, the others time-out and 
> are eventually ignored. The only problem is that I end up with a stack 
> of PIN request pop-ups for the ones that aren't paired and authorized. 
> Not a big deal but somewhat annoying. I tried playing around with the 
> security settings in hcid.conf but nothing I did managed to avoid the 
> PIN request pop-up.

we will change the link key file to be ASCII, but you should understand
the three security modes of Bluetooth. I think you put your device into
security mode 3 and this is bad unless you really know what you are
doing.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
