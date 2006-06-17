Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060611204551.GA19920@srcf.ucam.org>
References: <20060611204551.GA19920@srcf.ucam.org>
Date: Sat, 17 Jun 2006 13:06:37 +0200
Message-Id: <1150542398.17539.66.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: hal@lists.freedesktop.org, networkmanager-list@gnome.org
Subject: Re: [Bluez-devel] [RFC] HAL/Bluez integration
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Matthew,

> 2) The SDP interface in bluez is currently labelled "experimental" and 
> is fairly limited in functionality. I tried going back through the 
> mailing list archives, but the sourceforge interface makes me cry - has 
> there been discussion of what this interface should look like and the 
> technical problems involved?

we need to add an asynchronous SDP API to bluez-libs and integrate
working caching of SDP objects. This is not a simple task and there was
no enough time for it.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
