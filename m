Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602170948g37751aaeg7784484f5564eef2@mail.gmail.com>
References: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
	 <1140013222.26072.80.camel@localhost>
	 <e1effdeb0602150831j55ae6d68p856bbc3761ecab00@mail.gmail.com>
	 <e1effdeb0602150918y7b8ce5a8xe0cad1c72aa53a5e@mail.gmail.com>
	 <1140025571.26072.94.camel@localhost>
	 <e1effdeb0602161041i14382295l2eda08be4a515e3d@mail.gmail.com>
	 <e1effdeb0602170948g37751aaeg7784484f5564eef2@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140199094.4850.46.camel@aeonflux.holtmann.net>
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
Date: Fri, 17 Feb 2006 18:58:14 +0100

Hi Claudio,

> Here is a patch to fix a small bug that skipped :)
> I was not able to check this because the patch to fix the remove watch
>  was required. When I sent the patch(timeout03.patch) the solution for
> fix the remove watch function was not ready.
> 
> This patch fix the following bug:
> With the hcid running restart the dbus-daemon before the discoverable
> timeout expires. When the dbus-daemon is restarted the paths are
> registered again, thefore the dbus_data stored in the path is
> overwritten and the handler_timeout pointer becomes NULL.
> The side-effect is turn off the timer and the discoverable mode will
> be changed to connectable mode!

the patch is in the CVS now. Thanks.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
