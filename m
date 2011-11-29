Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4ED4C45E.4090606@globaledgesoft.com>
References: <4ED4A576.8030102@globaledgesoft.com>
	<CABBYNZ+UP2o0-pL3FUAyrPeJi4JeNGR2Xj9DbB8FNWgYTyY9Tg@mail.gmail.com>
	<4ED4C45E.4090606@globaledgesoft.com>
Date: Tue, 29 Nov 2011 14:00:19 +0200
Message-ID: <CABBYNZKGPhwrEd7bhGvP2JUUfauXXcqoHZeg4DZf1dbuuQinMA@mail.gmail.com>
Subject: Re: metadata dbus
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: sathish <sathish.n@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sathish,

On Tue, Nov 29, 2011 at 1:39 PM, sathish <sathish.n@globaledgesoft.com> wrote:
> Hi Luiz,
>    The bluez that is in git repository has the dbus api saying something
> about metadata information , will that dbus api will be useful

I suppose you are talking about org.bluez.MediaPlayer? This interface
is implemented by other processes (players) to expose their metadata,
IMO it is not really suitable for the opposite role. I would suggest
having another interface specific for this role (e.g. org.bluez.Target
or org.bluez.Player) which gonna be registered in the device object
path, it should be pretty similar to MediaPlayer interface except for
Release. It also a good idea to think about how we gonna address
multiple players since that is supported in AVRCP 1.4.

-- 
Luiz Augusto von Dentz
