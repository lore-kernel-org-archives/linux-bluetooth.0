Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SCO route way!!
From: Marcel Holtmann <marcel@holtmann.org>
To: Chen Bin <binch@mobilesoft.com.cn>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1096360479.2115.9.camel@debian>
References: <1096249564.1725.0.camel@debian>
	 <1096359291.4684.26.camel@notepaq>  <1096360479.2115.9.camel@debian>
Content-Type: text/plain
Message-Id: <1096360690.4684.33.camel@notepaq>
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
Date: Tue, 28 Sep 2004 10:38:10 +0200

Hi Chen,

> If the SCO is over PCM, what should I do before I write data from the
> codec to the chip, just establish the connection is enough?

in general, yes.

> I mean, I use HCI ACL to add a SCO link with the chip, then I write the
> voice data from the codec to the chip. I wonder if there are several SCO
> connections over the chip, how can the chip determine which connection
> will be used to send the voice? Should I do more steps to specify which
> connection to use?

This depends on your chip manufacturer. Ask them.

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
