Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6387889.teEb9JopTL@arawn>
References: <67399724.T38U7nJAul@arawn>
	<CAJdJm_MY_TZqay8L0=qOXy3kFkM4RMsXgRKKh1nK7ukokB7WqA@mail.gmail.com>
	<6387889.teEb9JopTL@arawn>
Date: Sun, 16 Sep 2012 20:44:22 -0400
Message-ID: <CAJdJm_P7CEq1wekVB0n_CtYEFgOTeiy2F-iKG-wiMZm37WOeww@mail.gmail.com>
Subject: Re: Connecting to Bluetooth Low Energy devices
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Philipp Claves <claves@budelmann-elektronik.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 14, 2012 at 4:55 AM, Philipp Claves
<claves@budelmann-elektronik.com> wrote:
>> Which kernel version are you running?
> Linux 3.5.3
> Which is the minimum version required?

If you run a too old kernel with a recent bluez, bluez will complain
(due to mgmt channel change), so I think this version is fine.

> Thanks, -t random did the trick.
> But it's still strange, the device addresses never changed even once while
> working with them. The bluetooth SIG talk about LE adresses mentioned random
> adresses to change every 15 minutes or so....
> I need to investigate this more.

This behavior depends on which random address type is used.

static random addresses are not required to change. Some (all?)
devices change their static random address when battery is removed.

private random addresses need to change periodically to avoid tracking.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
