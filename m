Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: hcid patch (remote name and connections)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <434C2B19.5040909@csr.com>
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com>
	 <e1effdeb0510110749jf47c023ne87567fba3d65937@mail.gmail.com>
	 <434C16C4.3040009@csr.com>
	 <e1effdeb0510111307r3bf0822aya57f5003efd8f655@mail.gmail.com>
	 <434C2B19.5040909@csr.com>
Content-Type: text/plain
Message-Id: <1129070245.6487.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 Oct 2005 00:37:24 +0200

Hi Steven,

> > It's from hcitool code :)
> 
> :-)
> 
> Still, that's no reason to propagate the error. Fix it and port the fix
> back to hcitool (and wherever else it's escaped from).
> 
> > I will replace by "7", the maximum number of connections. Is it ok?
> 
> It wasn't the value I was concerned about. It was the free-floating 10
> in the code twice.

the current API sucks and so we have some more of these crazy numbers
flying around. I am aware of them and the new sysfs based interface will
hopefully solve all our problems.

All of these magic number are from the really beginnings of BlueZ where
it was almost impossible to get any CSR based dongles or PCMCIA cards ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
