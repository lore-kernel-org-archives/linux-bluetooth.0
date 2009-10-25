Return-Path: <cyrus@holtmann.org>
Date: Sun, 25 Oct 2009 12:48:21 +0100
From: Andrea Veri <andrea.veri89@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: rfkill read / write access needs to be enabled for normal users
Message-ID: <20091025124821.7236d733@bluepaper>
In-Reply-To: <1256401467.7812.7.camel@localhost.localdomain>
References: <20091024171318.345c2bbf@bluepaper>
	<1256401467.7812.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Il giorno Sun, 25 Oct 2009 01:24:27 +0900
Marcel Holtmann <marcel@holtmann.org> ha scritto:


> I have said this before and let me repeat it again, gnome-bluetooth
> should not mess directly with the RFKILL subsystem. It is the wrong
> approach and that is the reason why normal users don't have
> uncontrolled access to /dev/rfkill.


yeah, I know. That's why I didnt apply the patch yet, but indeed this
needs to be fixed ASAP, so my question is what can I do in the meantime
to have it fixed? (e.g while upstream implement it directly into bluez)

is the patch proposed by Bastien, the only one available for *now*?

Thanks for your work,


Andrea
