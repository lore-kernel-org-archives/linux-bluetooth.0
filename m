Return-Path: <ashuang@gmail.com>
Message-ID: <ef9938ec0406291130a9b3760@mail.gmail.com>
Date: Tue, 29 Jun 2004 14:30:00 -0400
From: Albert Huang <ashuang@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] how to do asynchronous device inquiry?
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1088500888.6030.261.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <ef9938ec040628194321db5d9c@mail.gmail.com> <1088500888.6030.261.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

sorry, I'm having a tough time finding this piece of code you mention.
 The interface to sourceforge mailing list archives is terrible.  Do
you remember around when you posted it?

thanks.

-albert

On Tue, 29 Jun 2004 11:21:29 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> 
> Hi Albert,
> 
> 
> > Can somone point me to an example of how to do an asynchronous device
> > inquiry using bluez?  I'd like to start an inquiry with an ioctl or
> > something like that, and then be notified either with signals or by
> > polling as devices are discovered.  If this is currently not possible,
> > can you point me to which source files I could modify that would allow
> > me to do this?  Thanks!
> 
> you must use the HCI raw socket interface for it. Some time ago I posted
> example code for integration into the GNOME Bluetooth subsystem. Check
> the mailing list archives.
> 
> Regards
> 
> Marcel
> 
>
