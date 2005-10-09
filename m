Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com>
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
	 <1128784148.5212.17.camel@blade>
	 <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128896442.19569.26.camel@blade>
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
Date: Mon, 10 Oct 2005 00:20:42 +0200

Hi Claudio,

> The basic configuration file is attached. We can define better 
> policies after. Check the dbus-daemon man for more policies
> information.
> 
>  The hcid.conf file have to be copied to /etc/dbus-1/system.d/

this looks like an old version of the file. I committed a new version as
dbus.conf to the CVS.

After some basic cleanups your patch is now in the CVS. I am not fully
happy with parts of it, but we need a starting point now. I like to
invite everybody to help us out with the D-Bus support. The goal for the
next release should be a D-Bus interface for the device discovery.

Can someone write a Python based application that uses the D-Bus
interface of hcid to inquiry devices and present them?

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
