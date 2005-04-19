Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05041913007eacbf88@mail.gmail.com>
References: <e1effdeb05041913007eacbf88@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1113943613.2469.65.camel@pegasus>
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
Date: Tue, 19 Apr 2005 22:46:53 +0200

Hi Claudio,

stop cross-posting. I don't like it and actually I don't tolerate it.

> I would like to know if are there plans to develop a 
> library/application to integrate bluez and dbus service 
> to control bluetooth connections?
> 
> BlueZ provides tools to enable setup Bluetooth PANs. However, 
> an user mode application is not able to control Bluetooth 
> connections (connect, disconnect, assign IP, ...)
> 
> I found the Network Manager application, developed by Red Hat. 
> There is comments to bluetooth support, however it is not 
> supported at the moment.
> http://people.redhat.com/dcbw/NetworkManager/
> 
> Is this topic useful for this project? 

at some point I think we need full D-Bus support, but I don't think that
it will be me adding it. I never really got fully into the concept of
D-Bus and how to program it correctly. However I am not against it, but
the core work must be done by someone else.

> If yes, how can I contribute?

Start writing patches and post them on the mailing list for review.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
