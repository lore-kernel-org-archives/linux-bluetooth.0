Return-Path: <marco.milanesi@iaki.it>
Date: Thu, 6 Sep 2007 11:33:57 +0200
From: Marco Milanesi <marco.milanesi@iaki.it>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] pin less obex file transfer
Message-Id: <20070906113357.be276256.marco.milanesi@iaki.it>
In-Reply-To: <1189070433.7318.26.camel@aeonflux.holtmann.net>
References: <20070906105703.d2e79f4d.marco.milanesi@iaki.it>
	<1189070433.7318.26.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

> wild guess is that you used the wrong RFCOMM channel number. Make sure
> you use the Object Push channel retrieved via SDP and not some static
> magic. If the phone requires a PIN you can't do anything about it.

that was it! at least... partially. now operating on obex push channel (I didn't knew that there was a specific channel for PUSH) I can approve the file receving from the mobile, but obex prints this strange error:
root@myhost:/home/kpanic# obexftp -b 00:02:EE:46:5F:32 -B 9 -p image.jpg 
Browsing 00:02:EE:46:5F:32 ...
Channel: 10
Connecting...failed: FBS UUID
Still trying to connect
Connecting...failed: FBS UUID
Still trying to connect
Connecting...failed: FBS UUID
Still trying to connect

I'm noticing that also that I use -B 9 but Channel 10 is used, weird

suggestions?

and thanks :)

ciao,
Marco
