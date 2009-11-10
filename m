Return-Path: <cyrus@holtmann.org>
Subject: Re: Make bluetoothd start w/o SDP Server
From: Bastien Nocera <hadess@hadess.net>
To: Susanne Goldammer <susanne.goldammer@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4AF9721B.3010405@gmx.de>
References: <4AF9721B.3010405@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 10 Nov 2009 14:05:16 +0000
Message-ID: <1257861916.10888.1372.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-11-10 at 15:00 +0100, Susanne Goldammer wrote:
> Hi all,
> 
> i was worrying about the missing cmdline option of bluetoothd which
> would allow the new daemon to start without its internal sdp server.
> Such an option was available for the old hcid.
> 
> So i created a patch for me to fix this in bluez-4.51 source, which
> works fine here but might not be the best implementation.
> Now I would like to know if anyone is interested in this patch at all
> and might want to make it a bit more professional :-)
> 
> Or is there already another way to suppress the internal sdp server
> starting, so the changes are not needed anymore????
> 
> Thanks for responses in advance !

Why would you want to do that?

