Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] change inquiry_cache to
	hci_inquiry_cache to avoid possible name conflicts
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Marcel Holtmann <marcel@holtman.org>, Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040622144148.13ef5b10@dell_ss3.pdx.osdl.net>
References: <20040622144148.13ef5b10@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1087981913.4209.70.camel@pegasus>
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
Date: Wed, 23 Jun 2004 11:11:54 +0200

Hi Stephen,

> This patch changes the inquiry_XXX function to be either local to hci_core.c
> or change name from inquiry_cache_lookup to hci_inquiry_cache_lookup to try and
> reduce the potential for namespace conflicts.  There could be USB or SCSI or other
> code that uses an inquiry_cache.

you forgot to change it in hci_conn.c:

  CC [M]  net/bluetooth/hci_conn.o
net/bluetooth/hci_conn.c: In function `hci_acl_connect':
net/bluetooth/hci_conn.c:72: warning: implicit declaration of function `inquiry_cache_lookup'
net/bluetooth/hci_conn.c:72: warning: assignment makes pointer from integer without a cast

Please fix this and resend the patch.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
