Return-Path: <cyrus@holtmann.org>
Message-ID: <e6fea9c20901140148k55c1c5f8i6e1a65878e69f803@mail.gmail.com>
Date: Wed, 14 Jan 2009 10:48:22 +0100
From: "Thierry Pierret" <tpi@qspin.be>
To: "Liu, Raymond" <raymond.liu@intel.com>
Subject: Re: Obexd 0.8 : howto
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E04839CD5@pdsmsx502.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e6fea9c20901130535h88b819bve691e84642b02b59@mail.gmail.com>
	 <0463F45F3606F4428ED35AC8C709F92E04839CD5@pdsmsx502.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>        Well, under OBEXD 0.8, you can use test/send-files to verify that is your whole env. is setting correctly for the obexd and OPP profile. Though I know you are not comfortable with python, but this is the quickest way to verify it. And there is an API doc at doc/client-api.txt

The mentioned files are indeed the ones I use as documentation.
Finaly, Python is not so complicated to read and to understand ;-)

>        And what's your meaning for using dbus commands? You mean using libdbus or using dbus-send? For using libdbus or dbus's glib binding, I guess you can also read Meamo's tutorial doc for some example.  And for using dbus-send, it's a little bit complicate to send a dict as input parameter to dbus, man dbus-send is a good start. But actually using Python will be easier :)

Python is not installed on the platform I'm testing. That's the reason
why I could not use the test samples and I'm attempting to test the
bluetooth features with the dbus-send command. And as you said, I'm
stucked with the dict parameter. I think I will have to install Python
anyway.

> Raymond

Thanks for your answer.

Does anyone have an idea for the 1st of my questions : why any attempt
to push a file to the obexd server fails with a "HUP" message ?

Thierry
