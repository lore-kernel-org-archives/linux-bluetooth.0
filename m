Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327409936-6709-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1327409936-6709-1-git-send-email-dmitriy.paliy@nokia.com>
Date: Tue, 24 Jan 2012 15:23:13 +0200
Message-ID: <CABBYNZJ99t68PrYwi57KPuJXrJpu76Rt-6KNwwZuxwy39uA8GA@mail.gmail.com>
Subject: Re: [RFC BlueZ 0/4] Add hciops_allow_sniff to disable and restore
 LMP_SNIFF bit
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Jan 24, 2012 at 2:58 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> Hi,
>
> The following set of patches introduces disabling/enabling sniff bit
> in link policy settings. Further, the sniff mode is than disallowed
> while SCO channel is open.
>
> This helps to avoid problems in instability in some of TI controllers
> firmware when sniff request comes from remote device during an active
> call. Real impact is that controller becomes unconnectable eventhough
> page scan is enabled.
>
> Any comments, and possibly ideas, would be highly appreciated.

It looks like we would need a new command/operation to support it on
mgmt which is not addressed by your patches, in the other hand perhaps
this could be done automatically by the kernel when SCO is active.

-- 
Luiz Augusto von Dentz
