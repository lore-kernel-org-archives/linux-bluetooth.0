Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTin7oCB9L0S0_kjESF6SfMfaqjwMtA@mail.gmail.com>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
	<BANLkTin7oCB9L0S0_kjESF6SfMfaqjwMtA@mail.gmail.com>
Date: Mon, 2 May 2011 19:32:25 -0300
Message-ID: <BANLkTik3ym098WN_KisEhyjcECV+MKf9Yg@mail.gmail.com>
Subject: Re: [RFC 00/16] Discovery procedure refactoring
From: Andre Guedes <andre.guedes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 2, 2011 at 5:39 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andre,
>
> On Sat, Apr 30, 2011 at 3:27 AM, Andre Guedes
> <andre.guedes@openbossa.org> wrote:
>> Hi all,
>>
>> Today, discovery procedure is supported only in hciops. This refactoring has
>> been done to provide easier implementation of discovery procedure in mgmtops.
>> Lots of effort would be necessary to implement discovery procedure in mgmtops
>> because its logic is spread out adapter layer and hciops layer.
>>
>> The approach this patchset follows is moving all logic related to discovery
>> procedure from adapter layer to hciops layer.
>>
>> Future work will be:
>>        - full support for discovery procedure (BR/EDR, LE-Only, BR/EDR/LE
>>          devices) in kernel via management interface (today, only BR/EDR is
>>          supported).
>>        - name resolving support through mgmt interface (kernel + userspace)
>>
>> Thanks,
>> Guedes.
>>
>> Anderson Briglia (1):
>>  Implement mgmt start and stop discovery
>>
>> Andre Guedes (15):
>>  Add discovery callbacks to btd_adapter_ops
>>  Replace inquiry/scanning calls by discovery calls
>>  Add 'discov_state' field to struct dev_info
>>  Code cleanup event.c
>>  Remove Periodic Inquiry support in hciops
>>  Change DiscoverSchedulerInterval default value
>>  Add 'timeout' param to start_scanning callback
>>  Refactoring adapter_set_state()
>>  Remove 'suspend' param from stop_discovery()
>>  Add extfeatures to struct dev_info
>>  Implement start_discovery hciops callback
>>  Remove obsolete code.
>>  Implement stop_discovery hciops callback
>>  Remove inquiry and scanning callbacks from btd_adapter_ops
>>  Remove 'periodic' param from hciops_start_inquiry()
>>
>>  plugins/hciops.c  |  373 ++++++++++++++++++++++++++++++++++++-----------------
>>  plugins/mgmtops.c |   35 ++----
>>  src/adapter.c     |  217 ++++++++++---------------------
>>  src/adapter.h     |   19 +--
>>  src/event.c       |   48 +-------
>>  src/event.h       |    1 -
>>  src/main.conf     |    4 +-
>>  7 files changed, 345 insertions(+), 352 deletions(-)
>
> How do we solve the problem with command failing to restart
> inquiring/scanning, with pinq we only need to send the command once
> and if it fails we can signal the error back to the client, but if we
> are sending commands every round they may fail (buggy hardware) and
> currently we have no way to notify the client if discovery session
> failed after it has been started.
>

I think this problem already exists if we change "DiscoverSchedulerInterval"
option to a value different from zero. So, there is no regression. The problem
you reported is masked by using PINQ as a default configuration in main.conf.

But anyway, you're right, we need to come up with some mechanism to
signal the client an error occurred during the discovery procedure.

> Im afraid because of dual mode adapters we may need to change the
> D-Bus API in the future and have the client to specify somehow on
> StartDiscovery if LE only, BR/EDR only or both like connman does with
> RequestScan, otherwise it may take too long (each cycle taking 20-30
> seconds) to discover devices because it wasting time scanning or
> resolving names in the wrong technology.
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

The purpose of this patchset is refactoring discovery procedure related code.
It doesn't aim to fix known bugs.

--
Andre Guedes.
