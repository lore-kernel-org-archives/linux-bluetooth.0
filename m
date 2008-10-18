Return-Path: <cyrus@holtmann.org>
Message-ID: <48F9CD5E.3010902@dailyda.com>
Date: Sat, 18 Oct 2008 14:49:50 +0300
From: Tadas Dailyda <tadas@dailyda.com>
MIME-Version: 1.0
To: David Sainty <david.sainty@dtsp.co.nz>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Sending files via bluez-gnome
References: <48F9A964.2030107@dtsp.co.nz>
In-Reply-To: <48F9A964.2030107@dtsp.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

As of newest bluez-gnome git, bluetooth-sendto is still not updated to 
obex-data-server 0.4 API (patch was already sent to this list in mail 
called "Make bluetooth-sendto functional with ODS SVN head"). I also 
wrote a wiki page to make migration easier: 
http://wiki.muiline.com/obex-data-server/migrating_to_0.4
I installed newest bluez-gnome just recently and I was pretty much blown 
away :) Why is OBEX server stuff disabled? The old code will work with 
Bluez 4.x and requires no changes.
And good luck with obexd, BTW :) If you are going for a full blown 
client API, you are up for a good waste of time.

Cheers,
Tadas

David Sainty wrote:
> Hi people,
>
> I notice that the "Send files to device" menu item off 
> bluetooth-applet is only available if "obex-data-server" is in the 
> $PATH.  But I get the impression that "obexd" is trying to provide the 
> DBus service that the applet is actually after (point being that 
> searching the $PATH for "obex-data-server" isn't a very good test for 
> "obexd" presence :)
>
> Sadly, either way (running either server) I can't seem to transfer 
> files to my Blackberry.  But that could be a Blackberry problem, its 
> Bluetooth support is pretty dismal...
>
> Cheers,
>
> Dave
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

