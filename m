Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0504191448357f24da@mail.gmail.com>
References: <e1effdeb05041913007eacbf88@mail.gmail.com>
	 <1113943613.2469.65.camel@pegasus>
	 <e1effdeb0504191448357f24da@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1113948294.2469.77.camel@pegasus>
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
Date: Wed, 20 Apr 2005 00:04:54 +0200

Hi Claudio,

> Sorry, I was not my objective provoke this discussion. I posted in both list
> to try reach all bluez community members and figure out who are researching this
> topic in order to share information.

the developer mailing list if for the development of BlueZ and the users
mailing list is for user questions and problems. Quite easy.

> I will contact the Network Manager developers to verify if a bluetooth
> dbus service support can be useful.
> 
> At BlueZ side,  search, connect, disconnect, security and IP configuration 
> functions have be provided by a library. I developed a initial library and 
> it is working fine. BlueZ does not need provide a DBUS service, only interfaces 
> for a DBUS service daemon are required. The DBUS service 
> daemon must control all media(bluetooth, WLAN, ETH, ...)  
> This is my idea of how DBUS and Bluetooth can work together providing
> seamless connections.

Start working on it, but I think you will need an integration into the
existing BlueZ daemons.

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
