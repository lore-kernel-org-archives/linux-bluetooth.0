Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukz+yRAj-zd6vmYewozNs9=SJsjxujUXXVoT+P_6scDu8uA@mail.gmail.com>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
	<1329241945-32414-2-git-send-email-anderson.lizardo@openbossa.org>
	<CACLukz+nFbUn141XYsN91asx=BT=O1sK3s=__tEr7W+JVK6dyg@mail.gmail.com>
	<CAJdJm_PP+WJ=er2vwDLwJSF4bsS0EjF7S=Wtx20+MQt+xJHa5w@mail.gmail.com>
	<CACLukz+yRAj-zd6vmYewozNs9=SJsjxujUXXVoT+P_6scDu8uA@mail.gmail.com>
Date: Wed, 15 Feb 2012 08:49:50 -0400
Message-ID: <CAJdJm_OHmZC+7=QqY-64_rPN=P=81njwRE=5xzFCjYX57XBCeA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] thermometer: Fix handling of missing
 Temperature Type
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Feb 15, 2012 at 7:06 AM, Santiago Carot <sancane@gmail.com> wrote:
> In any case, I don't think the best solution is to provide a value for
> Type for wich we don't have enough information to determine what it
> is, I think that in the case in wich Type is really optional, the
> value provided in the measurement should be optional too. Under this
> case it would be better not to provide anything in the
> MeasurementReceived callback instead of providing a invented (Body)
> value.

I just sent new patches. Only this one was modified, and I added more
details to the commit message so I hope it is clear now.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
