Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device Configuration D-Bus services
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3013cac80510241400k2b71125ao7b8b4dfe5077a300@mail.gmail.com>
References: <e1effdeb0510190606x50364b25y52a5092847000105@mail.gmail.com>
	 <3013cac80510241400k2b71125ao7b8b4dfe5077a300@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130189692.7840.21.camel@blade>
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
Date: Mon, 24 Oct 2005 23:34:52 +0200

Hi Eduardo,

> here is the initial patch regarding /org/bluez/Devices. I keep it
> really simple so we can improve it in small steps. I've merged the
> Claudio's code for register and unregister a new path for a device in
> two funcions as this code is used in 3 different parts of the code.

call it *register_device() and *register_manager().

> For now I've leaved the syslog call to register and unregister
> operations so we can see if every thing is going ok. 

I think it is a good idea to introduce some DBG() defines.

> My next step is to provide a list of registed devices (not only the
> devices that are up) through /org/bluez/Devices path.

Feel free to send another patch on top of this one.

> One question: the SetProperty and GetProperty will use an interger or
> a string constant to determing which operation will be used?

You need to explain to me what you are talking about.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
