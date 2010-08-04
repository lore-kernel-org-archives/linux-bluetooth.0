Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com>
References: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com>
Date: Wed, 4 Aug 2010 16:09:49 +0300
Message-ID: <AANLkTima=oJ4mPMkfPCNPjsqhxX0drGBDURXBMaLrJ1C@mail.gmail.com>
Subject: Re: Changes in HDP API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 4, 2010 at 10:49 AM, Jose Antonio Santos Cadenas
<santoscadenas@gmail.com> wrote:
> This patch makes some changes in the HDP API based in the conversation that I
> had yesterday with Luiz and Elvis.
>
> I still have a doubt about the notification of devices in the agent. Luiz
> commented that with this API the Agent and the Application could not be in
> different processes, is this a problem?
>
> An other open issue is: if we notify when a device is discovered and suitable
> for connect with an application and when a devices is removed (or becomes not
> suitable for connect). I think that we already need something like the patch
> that we start discussing yesterday, something that can be called by the user
> in order to force a new service discovery and notifies the driver that will
> notify the agent. Of course we can avoid this not notifying the suitable
> devices and just letting to try the connection against all the devices (if
> there is no matching service it will fail). What do you think?
>
> Regards.

Lets say you want the pairing agent to connect right after pairing or
directly via applet, these applications has zero knowledge of what
endpoints the devices has, that why I suggest something simpler, so we
might only need e.g. HealthDevice which the applet can say, please
connect to this device so it calls e.g. HealthDevice.Connect(), this
basically will start a discovery of the health endpoints on
bluetoothd, then it matches with local endpoints (HealthApplication),
create the channels which are informed to the HealthAgent which can
then acquire the file descriptor.

This has 2 main advantages:

1.  Anyone can request to connect not only applications which holds
local endpoints
2.  There is no need to fetch the services, discovery will take place
every time the application attempt to connect.

-- 
Luiz Augusto von Dentz
Computer Engineer
