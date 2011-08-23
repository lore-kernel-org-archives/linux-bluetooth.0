Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABUK1aiEJCCpmxMvob4PDtMS1PX8KA=rCxD+JZ2DGxuWavp18A@mail.gmail.com>
References: <CABUK1aiEJCCpmxMvob4PDtMS1PX8KA=rCxD+JZ2DGxuWavp18A@mail.gmail.com>
Date: Tue, 23 Aug 2011 10:16:47 +0200
Message-ID: <CACLukzKd6g3_N3D1oeLx_uCUD499iLnPbxErzHrHi99GdkXTkw@mail.gmail.com>
Subject: Re: using test-health and test-health-sink
From: Santiago Carot <sancane@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

See commnets below.

2011/8/22 Pavan Savoy <pavan_savoy@sify.com>:
> I am trying to make my desktop running latest BlueZ (4.96) as a hdp
> source, and want to use test-health to communicate with a sink that I
> know off.
> However, when I try to use the test-health service  - I see that the
> hdp_device hasn't been probed and then the dbus service
> "org.bluez.HealthDevice" isn't running and hence getting this
> error....
>
> org.bluez.HealthManager seems to be running fine...
> How do I make org.bluez.HealthDevice to be registered ?
>

Have you compiled your sources using --enable-health flag?

Regards.
