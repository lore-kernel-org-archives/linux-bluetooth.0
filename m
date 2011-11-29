Return-Path: <cyrus@holtmann.org>
Message-ID: <4ED4CE94.7060002@globaledgesoft.com>
Date: Tue, 29 Nov 2011 17:52:44 +0530
From: sathish <sathish.n@globaledgesoft.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: metadata dbus
References: <4ED4A576.8030102@globaledgesoft.com>	<CABBYNZ+UP2o0-pL3FUAyrPeJi4JeNGR2Xj9DbB8FNWgYTyY9Tg@mail.gmail.com>	<4ED4C45E.4090606@globaledgesoft.com> <CABBYNZKGPhwrEd7bhGvP2JUUfauXXcqoHZeg4DZf1dbuuQinMA@mail.gmail.com>
In-Reply-To: <CABBYNZKGPhwrEd7bhGvP2JUUfauXXcqoHZeg4DZf1dbuuQinMA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  On Tuesday 29 November 2011 05:30 PM, Luiz Augusto von Dentz wrote:
> Hi Sathish,
>
> On Tue, Nov 29, 2011 at 1:39 PM, sathish<sathish.n@globaledgesoft.com>  wrote:
>> Hi Luiz,
>>     The bluez that is in git repository has the dbus api saying something
>> about metadata information , will that dbus api will be useful
> I suppose you are talking about org.bluez.MediaPlayer? This interface
> is implemented by other processes (players) to expose their metadata,
> IMO it is not really suitable for the opposite role. I would suggest
> having another interface specific for this role (e.g. org.bluez.Target
> or org.bluez.Player) which gonna be registered in the device object
> path, it should be pretty similar to MediaPlayer interface except for
> Release. It also a good idea to think about how we gonna address
> multiple players since that is supported in AVRCP 1.4.
>
Hi Luiz,
     Thanks for the kind reply.  Will these interface gives metadata 
information about all players or players that support mpris.

-- 
Thanks&  Regards,
Sathish N

