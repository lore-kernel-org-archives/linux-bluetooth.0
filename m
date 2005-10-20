Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051020083703.GA23553@localhost.localdomain>
References: <20051019140715.GA15123@localhost.localdomain>
	 <1129762736.2241.18.camel@blade>
	 <20051020070532.GA20546@localhost.localdomain>
	 <1129794748.2241.26.camel@blade>
	 <20051020083703.GA23553@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129798977.2241.35.camel@blade>
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
Date: Thu, 20 Oct 2005 11:02:57 +0200

Hi Johan,

> > Do you think the status parameter is needed? Is it not better to send
> > two different responses? One for the success case and one for the
> > failure case.
> 
> I'm not sure whether the status parameter is needed, perhaps if someone
> wants to make an UI which shows an accurate error message why the name
> request failed? Anyway, I don't have a strong opinion about it, so if
> you want to I can remove the status parameter and split the signal to
> RemoteName and RemoteNameFailed signals.

I am not that big in D-Bus programming, but I think that is how it
should work. The failed signal then can contain an error code or we
simply use the error method for it.

Another thing is that we might wanna have a method where we can request
a name from the cache and if not available we request it.

Besides this we also should keep the extended inquiry in mind. This can
deliver us the full name via an inquiry response or at least a short
name for a device. So what I see is we have four different types of
device names inside our system.

	- Full device names (up to 248 characters)
	- Short names or inquiry names (up to around 235 at max)
	- Cached names (in generell only up to 248 characters)
	- Alias names (no length requirement)

How do deal with them through a nice interface, because all of them can
be different.

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
