Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] C Program for Getting Link Quality
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <94e407f00511080131u11f01d79x65d05cfe47ccbb7@mail.gmail.com>
References: <94e407f00511080131u11f01d79x65d05cfe47ccbb7@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131454195.5824.161.camel@blade>
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
Date: Tue, 08 Nov 2005 13:49:55 +0100

Hi Arpit,

> I've written a C program to help me get the link quality between two
> bluetooth dongles. But, on compilation there are problems with the
> definition: 
> 
> cr = (hci_conn_info_req *)malloc(sizeof(*cr) + sizeof(struct
> hci_conn_info)); (Error: 'hci_conn_info_req' undeclared)
> 
> This the program I'm running:
> 
> //Program for finding LQ
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>

don't forget to include <sys/socket.h> before <bluetooth/bluetooth.h> or
use a newer version of the Bluetooth library.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
