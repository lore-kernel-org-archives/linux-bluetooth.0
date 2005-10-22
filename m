Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051020112153.GA31872@localhost.localdomain>
References: <20051019140715.GA15123@localhost.localdomain>
	 <1129762736.2241.18.camel@blade>
	 <20051020070532.GA20546@localhost.localdomain>
	 <1129794748.2241.26.camel@blade>
	 <20051020083703.GA23553@localhost.localdomain>
	 <1129798977.2241.35.camel@blade>
	 <20051020095035.GA26910@localhost.localdomain>
	 <1129803367.2241.56.camel@blade>
	 <20051020112153.GA31872@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129985882.11428.31.camel@blade>
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
Date: Sat, 22 Oct 2005 14:58:02 +0200

Hi Johan,

> > > Ok. I'll create a new RemoteNameFailed signal which has one byte
> > > parameter (the status code). Do you want yet another patch against the
> > > current CVS HEAD, or should I wait for you to commit my previous patch
> > > and then create a new patch against the new CVS revision?
> > 
> > I only applied the library patch and not your remote name patch. So
> > please do it against CVS HEAD now.
> 
> Here you go (patch attached).

the patch is now in the CVS. I had to catch the non D-Bus case and
changed the parameter orders of the failed function.

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
