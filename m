Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch (remote name and connections)
Message-ID: <20051011195531.GA12935@localhost.localdomain>
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com> <1129053693.8229.1.camel@localhost.localdomain> <20051011192801.GA12571@localhost.localdomain> <434C164E.5090805@csr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <434C164E.5090805@csr.com>
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
Date: Tue, 11 Oct 2005 22:55:31 +0300

Hi Steven,

On Tue, Oct 11, 2005, Steven Singer wrote:
> I'd recommend encapsulating the id in a structure rather than allocating
> sizeof(guint). It doesn't cost you much time now and if, in the future,
> you ever need to store any more information then the structure's already
> there.
> I noticed you already have a structure struct hci_dbus_data which
> contains just an integer. Did you mean to use that here or are they
> logically separate types (that just happen to be the same at the
> moment)?

The watch code is logically completely separate from the code that uses
the hci_dbus_data struct (the "id" variable refers to a GIOChannel id
while in the hci_dbus_data struct id refers to the device id). It is
also much simpler than the code that uses hci_dbus_data and I don't
think that anything besides the GIOChannel id needs to be passed to the
remove_watch function.

Johan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
