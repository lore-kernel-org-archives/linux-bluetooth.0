Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: Thierry Pierret <tpi@qspin.be>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 14 Jan 2009 10:14:31 +0800
Subject: RE: Obexd 0.8 : howto
Message-ID: <0463F45F3606F4428ED35AC8C709F92E04839CD5@pdsmsx502.ccr.corp.intel.com>
References: <e6fea9c20901130535h88b819bve691e84642b02b59@mail.gmail.com>
In-Reply-To: <e6fea9c20901130535h88b819bve691e84642b02b59@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pierret

>Hi,
>
>I'm only an end-user. Ans as is, I'm not comfortable with D-Bus stuff,
>neither with Python samples. Hence the current request may look dumb
>for you. Apologizes. Be indulgent.
>
>I'm trying to transfer files through OBEX. obexd (-o -a -r /var/obex)
>and obex-client are running on my target.
>1°/ Any attempt to push a file to my target ends with a "HUP" message.
>What's happening ? What should I do ?

	Well, under OBEXD 0.8, you can use test/send-files to verify that is your whole env. is setting correctly for the obexd and OPP profile. Though I know you are not comfortable with python, but this is the quickest way to verify it. And there is an API doc at doc/client-api.txt

	And without your detail information of how you are doing on your PC, I guess no one know what's happening on you side.

>2°/ How to push a file from my target using the dbus commands ? Any
>call fails, but the error certainly lies in the given pathes and
>arguments.
>I'm diving in D-Bus doc, but I would earn some times with some
>examples. Note that those examples in the wiki would be appreciated.
>
>Many thanks.
>Regards.


	And what's your meaning for using dbus commands? You mean using libdbus or using dbus-send? For using libdbus or dbus's glib binding, I guess you can also read Meamo's tutorial doc for some example.  And for using dbus-send, it's a little bit complicate to send a dict as input parameter to dbus, man dbus-send is a good start. But actually using Python will be easier :)

Raymond

