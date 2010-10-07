Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101006214303.GB21610@jh-x301>
References: <1286397594-12366-1-git-send-email-claudio.takahasi@openbossa.org>
	<1286397594-12366-2-git-send-email-claudio.takahasi@openbossa.org>
	<20101006214303.GB21610@jh-x301>
Date: Thu, 7 Oct 2010 10:50:53 -0300
Message-ID: <AANLkTi=RfJa4MsnboDWRZvJdH+dmXkUsnA-mcya-NBZt@mail.gmail.com>
Subject: Re: [PATCH 2/2] Client Characteristic Configuration on attribute server
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 6, 2010 at 6:43 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Wed, Oct 06, 2010, Claudio Takahasi wrote:
>> Initial implementation of per client attribute configuration for the
>> attribute server. Notification and indication shall be sent to the peer
>> only if Client Characteristic Configuration bit field is set.
>> ---
>>  TODO                |    7 --
>>  src/attrib-server.c |  194 +++++++++++++++++++++++++++++++++++---------------
>>  src/storage.c       |   44 ++++++++++++
>>  src/storage.h       |    4 +
>>  4 files changed, 184 insertions(+), 65 deletions(-)
>
> I feel a bit conflicted about this one. Do we really want to have a
> generic storage for all characteristics? I'd think that it'd make sense
> to let each service implementation take care of how to store their state
> persistently (if it needs to be done at all).
>
> Would it be possible for you to create a patch that fixes the
> notification sending to clients that haven't subscribed for them but
> leaves out the storage stuff?
>
> Johan
>

Hi Johan,

"clientconfig" file stores the <<Client Characteristic Configuration>>
attribute only. Each characteristic declaration can have this optional
attribute.
The file format is:
MAC#handle xxxx, where the handle is the <<Client Characteristic
Configuration>> handle.

Only <<Client Characteristic Configuration>> and <<Server
Characteristic Configuration>> descriptors are writeable. If you want
to test this feature, my suggestion is to push this code upstream and
move it to the service implementation if necessary in the future.
Currently, we don't have this API/interface between the attrib server
and service implementation, this is the reason why I implemented the
storage inside the attrib server. IMHO, the attribute server can
manage indications, notifications and broadcasting, otherwise we will
duplicate the code in the services implementations.

 I gonna send another patch to disable the automatic
notification/indication in the sample server and it is up to you to
decide which one to apply.

Claudio
