Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1129986496.11428.36.camel@blade>
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
Date: Sat, 22 Oct 2005 15:08:16 +0200

Hi Claudio,

> This is the initial patch to support authentication. There are
> improving points
> that I am planning send soon if everybody agree with my proposal.

I applied the patch, but please do the coding style right. It seems that
you still copy some parts for your old patches.

	if (sock > 0)
		close (sock);

I first prefer to use "sk" instead of "sock", but this hasn't been used
in full consistency and so I didn't corrected it. However you need to
check for (sock >= 0) in case of a socket or file descriptor and we
don't put a space between the function name and its parameters. So it
must be called "close(sock);" in any case.

It is also better to introduce more error labels than using another if
statement to check for state of a file descriptor. We now if the file
descriptor is valid or not.

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
