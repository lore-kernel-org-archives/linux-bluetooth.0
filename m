Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device Busy during "hcitool info" or
	"sdptoolsearch"
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: ag@new-media-artists.de,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FE0C1B9.5090504@csr.com>
References: <FJENILNPNAGPJMMDOKDCKEKBDJAA.ag@new-media-artists.de>
	 <3FE0C1B9.5090504@csr.com>
Content-Type: text/plain
Message-Id: <1071699104.21804.77.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Dec 2003 23:11:44 +0100

Hi Steven,

> The create_connection-inquiry restriction is there because both
> procedures need to get as much radio bandwidth as possible to work. In
> particular, taking bandwidth away from paging can cause spurious failed
> connections. In this case, create_connection wins. If you issue a
> create_connection while an inquiry is in progress, we will terminate
> the inquiry with an inquiry_complete event and start paging
> immediately.

this is a nice thing/feature to know. Is it documented anywhere in the
firmware release notes?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
