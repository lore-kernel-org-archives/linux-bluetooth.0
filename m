Return-Path: <u.wisser@publisher.de>
Subject: Re: [Bluez-users] SuSE 9.1 Pro and Epox Barton wireless desktop
From: Ulrich Wisser <u.wisser@publisher.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1091739998.20839.56.camel@pegasus>
References: <1091568946.3759.18.camel@dorette.Entenhausen>
	 <1091569567.16182.36.camel@pegasus>
	 <1091648489.4237.2.camel@dorette.Entenhausen>
	 <1091661690.16182.74.camel@pegasus>
	 <1091737844.4179.46.camel@dorette.Entenhausen>
	 <1091739998.20839.56.camel@pegasus>
Content-Type: text/plain
Message-Id: <1091741252.4179.50.camel@dorette.Entenhausen>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 23:27:32 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

> > > It should be possible to compile only hid2hci. Download bluez-utils-2.9
> > > and run configure. Make sure that the USB library is installed. Then
> > > change to the tools directory and type "make hid2hci". Then you should
> > > get the hid2hci binary that you can copy everywhere you like.
> > 
> > compiling did  work perfectly. Only when I tried to use the hid2hci the
> > problems started:
> > 
> > Switching device 0a12:1000 to HCI mode failed. (Invalid or incomplete
> > multibyte or wide character)
> 
> sometimes it works even if it reports an error. Check with hciconfig if
> you see a Bluetooth device now.

You are  right. It did work :)
hciconfig did see the bluetooth device and I could convince hcitool to
find my mouse and connect to it. 
Seems I have to find out how to automate the mouse and keyboard
connection. But one of the FAQs on your homepage will probably help.

Thanks for your efforts

Ulrich
