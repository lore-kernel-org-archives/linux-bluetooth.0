Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid patch (remote name and connections)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510121414u3c1ae79k98c9ba17e99f4b31@mail.gmail.com>
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com>
	 <1129053693.8229.1.camel@localhost.localdomain>
	 <20051011192801.GA12571@localhost.localdomain> <434C164E.5090805@csr.com>
	 <20051011195531.GA12935@localhost.localdomain>
	 <1129070919.6487.4.camel@localhost.localdomain>
	 <20051012193811.GA5505@localhost.localdomain>
	 <e1effdeb0510121414u3c1ae79k98c9ba17e99f4b31@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1129196311.6543.5.camel@localhost.localdomain>
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
Date: Thu, 13 Oct 2005 11:38:31 +0200

Hi Claudio,

> This is the patch to add remote name and display connections. I fixed
> a bitwise operation in the error message function and the dbus message
> handler.
> 
> Apply the segmentation fault  patch before!

I applied both patches, but you should start looking at my changes to
your previous patch. There are some ways to code the if clauses a little
bit better using goto. This will make the code better readable. I might
fix this up later anyhow, but at the moment my Internet connection is
limited.

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
