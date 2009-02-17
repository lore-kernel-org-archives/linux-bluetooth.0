Return-Path: <cyrus@holtmann.org>
From: Nicola Ranaldo <ranaldo@unina.it>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Bnep networking with dbus on 4.*
Date: Tue, 17 Feb 2009 18:59:17 +0100
Cc: linux-bluetooth@vger.kernel.org
References: <200902031603.03451.ranaldo@unina.it> <1233772264.12562.2.camel@californication>
In-Reply-To: <1233772264.12562.2.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200902171859.17876.ranaldo@unina.it>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 04 February 2009 19:31:04 Marcel Holtmann wrote:
[...]
> > Is it possible to establish bnep connection with dbus api 4.*?
> > I'm not able to find documentation on that.
>
> yes it is. See network-api.txt document from the bluez-4.x source.
>

Hi Marcel,
I was able to migrate my code to 4.*, test networking api and succesfull 
establish a bnep connection, but I have a doubt:

When a remote device offers GN and/or NAP services an org.bluez.Network 
interface is created on dbus, and this may establish both GN and NAP 
connection.
The only one "Connected" property suggests me that the api is constructed as 
it's not possibile to establish GN *and* PAN connection to the same remote 
device at the same time.
Is this a bluetooth limitation? a bluez limitation? an api limitation or am I 
missing somethingh?

Best Regards

	Nicola
