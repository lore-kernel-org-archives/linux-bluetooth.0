Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
Message-ID: <20051020095035.GA26910@localhost.localdomain>
References: <20051019140715.GA15123@localhost.localdomain> <1129762736.2241.18.camel@blade> <20051020070532.GA20546@localhost.localdomain> <1129794748.2241.26.camel@blade> <20051020083703.GA23553@localhost.localdomain> <1129798977.2241.35.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1129798977.2241.35.camel@blade>
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
Date: Thu, 20 Oct 2005 12:50:35 +0300

On Thu, Oct 20, 2005, Marcel Holtmann wrote:
> I am not that big in D-Bus programming, but I think that is how it
> should work. The failed signal then can contain an error code or we
> simply use the error method for it.

Ok. I'll create a new RemoteNameFailed signal which has one byte
parameter (the status code). Do you want yet another patch against the
current CVS HEAD, or should I wait for you to commit my previous patch
and then create a new patch against the new CVS revision?

> Another thing is that we might wanna have a method where we can request
> a name from the cache and if not available we request it.

Maybe this could be done by adding a boolean "use cache" parameter to
the RemoteName method?

> Besides this we also should keep the extended inquiry in mind. This can
> deliver us the full name via an inquiry response or at least a short
> name for a device. So what I see is we have four different types of
> device names inside our system.
> 
> 	- Full device names (up to 248 characters)
> 	- Short names or inquiry names (up to around 235 at max)
> 	- Cached names (in generell only up to 248 characters)
> 	- Alias names (no length requirement)
> How do deal with them through a nice interface, because all of them can
> be different.

I think that the extendend inquiry response names could either be
handled by adding new parameters to the end of the InquiryResult signal,
or then by creating a new ExtendendInquiryResult signal. We might want
to leave the "alias name" feature to be handled by higher SW layers.
E.g. gnome-bluetooth has some support for storing the alias name under
the GConf path /system/bluetooth/device/<bd addr>/alias.

Johan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
