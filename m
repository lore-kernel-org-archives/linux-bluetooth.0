Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Problems while sending and receiving with
	rfcomm sockects
From: Marcel Holtmann <marcel@holtmann.org>
To: dsas@mega.ist.utl.pt
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1086538596.40c34364bec57@webmail.rnl.ist.utl.pt>
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>
	 <1086094054.1978.26.camel@fischer>
	 <1086102474.40bc9bca939eb@webmail.rnl.ist.utl.pt>
	 <1086536804.40c33c64e8456@webmail.rnl.ist.utl.pt>
	 <1086537556.4765.59.camel@pegasus>
	 <1086538596.40c34364bec57@webmail.rnl.ist.utl.pt>
Content-Type: text/plain
Message-Id: <1086555166.4765.157.camel@pegasus>
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
Date: Sun, 06 Jun 2004 22:52:47 +0200

Hi Didier,

> No, I don't use hcidump. I simply compare the array of chars passed in send()
> with the one I receive with recv().

please use read() and write() to be sure that it not a problem of send()
or recv().

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
