Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do asynchronous device inquiry?
From: Marcel Holtmann <marcel@holtmann.org>
To: Albert Huang <ashuang@gmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec040628194321db5d9c@mail.gmail.com>
References: <ef9938ec040628194321db5d9c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1088500888.6030.261.camel@pegasus>
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
Date: Tue, 29 Jun 2004 11:21:29 +0200

Hi Albert,

> Can somone point me to an example of how to do an asynchronous device
> inquiry using bluez?  I'd like to start an inquiry with an ioctl or
> something like that, and then be notified either with signals or by
> polling as devices are discovered.  If this is currently not possible,
> can you point me to which source files I could modify that would allow
> me to do this?  Thanks!

you must use the HCI raw socket interface for it. Some time ago I posted
example code for integration into the GNOME Bluetooth subsystem. Check
the mailing list archives.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
