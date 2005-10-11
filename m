Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <434C164E.5090805@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch (remote name and connections)
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com> <1129053693.8229.1.camel@localhost.localdomain> <20051011192801.GA12571@localhost.localdomain>
In-Reply-To: <20051011192801.GA12571@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 11 Oct 2005 20:45:18 +0100

Johan Hedberg wrote:
> +	id = malloc(sizeof(guint));

I'd recommend encapsulating the id in a structure rather than allocating
sizeof(guint). It doesn't cost you much time now and if, in the future,
you ever need to store any more information then the structure's already
there.

I noticed you already have a structure struct hci_dbus_data which
contains just an integer. Did you mean to use that here or are they
logically separate types (that just happen to be the same at the
moment)?

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
