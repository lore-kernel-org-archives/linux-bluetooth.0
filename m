Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110328203346.GA2664@piper>
References: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
	<20110328203346.GA2664@piper>
Date: Mon, 28 Mar 2011 20:40:32 +0000
Message-ID: <AANLkTin8et-m0pczJKm9y3z-EHqQdN-49KkAXGGm8jqO@mail.gmail.com>
Subject: Re: [PATCH 0/6] Move Attrib client (including: should we disconnect
 or not?)
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Mar 28, 2011 at 8:33 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Johan,
>
> On 21:01 Fri 25 Mar, Vinicius Costa Gomes wrote:
>> Hi,
>>
>> The move itself is pretty simple, but when implementing it, I took a decision
>> and I would like to hear your opinion about it.
>
> There were problems with some useless includes. I will send another version
> soon. But the question below remains.
>
>>
>> With this patch series, the behaviour is that we never disconnect from
>> a LE device unless we are told so, i.e. org.bluez.Device.Disconnect(),
>> is that what is expected from us?

In my opinion, the profiles should define how to manage connections.
For LE re-connections should be avoided since the remote disables the
advertising when the connection is established.
Keep the link up seems to be acceptable for now, but for the final
solution we need to disconnect based on the registered "watchers" and
profile inputs. Some profiles such as proximity keeps the devices
always connected and auto-reconnect, others require user interaction.

Cheers,
Claudio.

>>
>>
>> Cheers,
>> --
>>
>> Vinicius Costa Gomes (6):
>>   Move Attrib client to the core
>>   Register Attrib interface when loading device from storage
>>   Register Attrib interface after Primary Service discovery
>>   Remove _init and _exit methods from Attrib client
>>   Add support for re-using the attrib channel
>>   Fix disconnecting when primary service discovery is done
>>
>>  Makefile.am      |    4 ++--
>>  attrib/client.c  |   49 ++++++++++++++++++-------------------------------
>>  attrib/client.h  |    6 +++---
>>  attrib/manager.c |   47 -----------------------------------------------
>>  src/adapter.c    |    5 +++++
>>  src/device.c     |   20 +++++++++++++-------
>>  6 files changed, 41 insertions(+), 90 deletions(-)
>>
>> --
>> 1.7.4.1
>>
>
> Cheers,
> --
> Vinicius
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
