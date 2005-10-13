Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Set D-BUS signal paths according to local device
Message-ID: <20051013180202.GA24902@localhost.localdomain>
References: <20051013172036.GA24585@localhost.localdomain> <e1effdeb0510131036v1ff73b7an369333a71bf0cca8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1effdeb0510131036v1ff73b7an369333a71bf0cca8@mail.gmail.com>
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
Date: Thu, 13 Oct 2005 21:02:02 +0300

On Thu, Oct 13, 2005, Claudio Takahasi wrote:
> I didn't analized all the patch content, but I guess it's possible change
> the signature of the functions passing the dev id instead of receive the BT
> address and convert it.
> 
> What do you think?

Yes, that would also be one possibility. However, it requires some
changes to security.c (where those functions are being called from).
Also, if we decide to start using the device address (instead of the id)
in the object paths, there's no point in changing the function
parameters. Maybe Marcel has an opinion about this?

Johan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
