Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <49D1FE96.1090200@binarywings.net>
References: <49D1FE96.1090200@binarywings.net>
Date: Tue, 31 Mar 2009 10:44:33 -0300
Message-ID: <2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com>
Subject: Re: PAN with bluez-utils-3
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Florian Philipp <lists@binarywings.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

On Tue, Mar 31, 2009 at 8:29 AM, Florian Philipp <lists@binarywings.net> wrote:
> So my question is: Does anyone have a working set of configuration files
> for newer bluez-utils? Preferably something related to the roles GN or  NAP.

Check the documentation under doc/network-api.txt, it should be very
simple to detect if the remote device supports PAN it will export
org.bluez.Network on its dbus object. Now if your application doesn't
support introspection you can detect it by using the UUIDs property
exported in the very same dbus object I had mentioned.

For actually connecting to the device you will only need to call
org.bluez.Network.Connect({"panu","gn","nap"...}) , you can tell
bluetoothd to run a script of your choice when the connection is
activated by editing network.conf. Note that some daemons like
NetworkManager and connman should not require any script.

To act like a server you don't need to do anything for panu, for gn we
normally create a bridge called pan0 where all client are added, nap
is especial because of the routing stuff so you/your system need to
configure a bridge properly and make network.conf to use it (by
default this should be pan1).

Now if you got any problem you could please provide a more detailed
info of it, if it is a bug we will be happy to fix it.

Thanks,

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
