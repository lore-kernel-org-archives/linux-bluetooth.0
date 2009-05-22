Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1242999521-8303-1-git-send-email-holler@ahsoftware.de>
References: <1242999521-8303-1-git-send-email-holler@ahsoftware.de>
Date: Fri, 22 May 2009 16:26:44 -0300
Message-ID: <2d5a2c100905221226y5d318219lc2ebe76ae306e91d@mail.gmail.com>
Subject: Re: [PATCH 1/1] BTWinLinkKeyExport - Tool to export link-keys stored
	by the WIDCOMM stack
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

On Fri, May 22, 2009 at 10:38 AM, Alexander Holler <holler@ahsoftware.de> wrote:
> I've used this for dualboot-systems because I didn't want to
> pair the devices every time I've switched systems.
>
> Currently it exports the keys using the old bluez format with files
> named 'link_key' and 'linkkeys'. To use it with newer versions of bluez
> it has either to be modified or someone has to write an import.

Im afraid this is not really useful anymore, at least not if you
expect to things like the new gnome-bluetooth to work since bluetoothd
needs the sdp records the device export in order to probe the driver
which takes care of profiles. In other words profiles won't just work
because you got the linkkey. Despite this I don't think such thing
belongs to BlueZ codebase, nobody will be going to maintain a windows
c++ source code.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
