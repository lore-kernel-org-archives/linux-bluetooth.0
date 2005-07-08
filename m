Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand D-Bus service
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05070811375af87810@mail.gmail.com>
References: <e1effdeb05070811375af87810@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120849681.7444.1.camel@notepaq>
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
Date: Fri, 08 Jul 2005 21:08:01 +0200

Hi Claudio,

> We exchanged some emails last month about D-Bus services
> for pand. I implemented some D-Bus services, but ...
> How will be the relationship between the pand and the "metaserver"?
> It is not clear for me how the other daemons will
> interact with the current bluez-utils daemons and tools
> (pand, hidd, dund, rfcomm, ...).

forget about the metaserver. This is something KDE specific at the
moment.

> Could you explain me how the D-Bus services will be organized?

I am not 100% sure at the moment. Need to play with it a little bit
more.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
