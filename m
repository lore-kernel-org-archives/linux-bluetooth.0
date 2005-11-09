Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] C Program for Getting Link Quality
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <94e407f00511090452m7f86753bq6f1ba05a8653379f@mail.gmail.com>
References: <94e407f00511080131u11f01d79x65d05cfe47ccbb7@mail.gmail.com>
	 <1131454195.5824.161.camel@blade>
	 <94e407f00511080958j74841800k45532fdbd149e9cd@mail.gmail.com>
	 <1131473837.5544.4.camel@blade>
	 <94e407f00511090452m7f86753bq6f1ba05a8653379f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131544952.5544.36.camel@blade>
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
Date: Wed, 09 Nov 2005 15:02:32 +0100

Hi Arpit,

> Yes, I forgot to include the icotl.h as well.Anyway, for I changed the
> definition of: cr = (hci_conn_info_req *)malloc(sizeof(*cr) +
> sizeof(struct hci_conn_info)); to this: cr = (struct
> hci_conn_info_req*) malloc(sizeof(struct hci_conn_info_req) +
> sizeof(struct hci_conn_info)); . This doesn't give me the error any
> more.
> 
> However, running the compiled program results in:  Get connection info
> failed

why don't you make your program GPL and copy the code from hcitool for
getting the link quality. And use a decent coding style and not HTML
mail, because this give me a headache.

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
