Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Problems while sending and receiving with
	rfcomm sockects
From: Marcel Holtmann <marcel@holtmann.org>
To: dsas@mega.ist.utl.pt
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1086536804.40c33c64e8456@webmail.rnl.ist.utl.pt>
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>
	 <1086094054.1978.26.camel@fischer>
	 <1086102474.40bc9bca939eb@webmail.rnl.ist.utl.pt>
	 <1086536804.40c33c64e8456@webmail.rnl.ist.utl.pt>
Content-Type: text/plain
Message-Id: <1086537556.4765.59.camel@pegasus>
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
Date: Sun, 06 Jun 2004 17:59:16 +0200

Hi Didier,

> I've compiled kernel-2.6.6 with the new mh3 patch and now, everything works
> fine. So, I think it is a kernel bug (2.4.20). It also works without
> semaphores.

this is good to hear.

> Just one more thing about this: The number of bytes sent and received is the
> same but the data received appears shifted by one byte... Strange.

How do you compare this? You don't use hcidump for it, do you? All
version prior 1.8 don't decode the credit based flow control byte
correctly. They show it as part of the payload.

> If you're still interested, I'll send you a small program in a few days (I have
> some work to do for now...).

Please do so. I must assure that we don't have a kernel bug here.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
