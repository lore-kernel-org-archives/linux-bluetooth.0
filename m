Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Wacom Graphire Bluetooth  problems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050925123425.GA8683@polar.elf12.net>
References: <20050924200358.GJ28437@polar.elf12.net>
	 <1127644165.6362.0.camel@localhost.localdomain>
	 <20050925123425.GA8683@polar.elf12.net>
Content-Type: text/plain
Message-Id: <1127661017.6362.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 25 Sep 2005 17:10:17 +0200

Hi Robert,

> > are you using the -mh patch for the latest 2.6 kernel?
> 
> I'm using debian and it's kernel-making tool but the latest prepared
> kernel was 2.6.12.  I patched it with 2.6.12-mh3. There does not seem
> to be much Bluetooth/HID related changes between it and 2.6.13 with
> patch. - Am I wrong?

yes, you are.

> Other question: does BlueZ support HID get/set report feature?? How to
> interface it?

No really at the moment. The will come with generic HID driver sometime
in the future.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
