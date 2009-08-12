Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4A82B32E.3020903@gmail.com>
References: <4A82B32E.3020903@gmail.com>
Date: Wed, 12 Aug 2009 09:59:44 -0300
Message-ID: <2d5a2c100908120559h1a3ed5acn26b8a07ab41cd95@mail.gmail.com>
Subject: Re: NAP/GN with bluez-4
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "y.dmitry@gmail.com" <y.dmitry@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 12, 2009 at 9:18 AM, y.dmitry@gmail.com<y.dmitry@gmail.com> wrote:
> Hi!
>
> Can't setup NAP-server with bluez-4 (versions 4.39, 4.47). Remote device
> can't discover any services. But when i trying to run  'simple-service'
> script from sources, i can see a "Serial Port" service on remote device.
> Service disappears when script canceled. As I understand at this point,
> all ok with connectivity and access rights.
>
> I mean linux box must became an Access Point for phone, netbook, etc.


The service registration is done by network plugin, you can edit
network.conf to configure which script/interface name to be used. Also
check if they are enabled by calling
org.bluez.NetworkRouter.GetProperties(), if not enabled enable it by
calling org.bluez.NetworkRouter.SetProperty("Enabled", True). Another
detail is that you should configure NAP bridge to be used since if you
follow the spec it needs to enable dhcp server and configure the
routes while GN is just a simple bridge.

Enabled is good for those applications that want to enable/disable
data tethering over bluetooth, so it can really be changed without
restarting bluetoothd.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
