Return-Path: <cyrus@holtmann.org>
Message-ID: <5535AD63.9070507@gmail.com>
Date: Tue, 21 Apr 2015 03:52:35 +0200
From: "jerico.dev" <jerico.dev@gmail.com>
MIME-Version: 1.0
To: Florian Grandel <fgrandel@gmail.com>,
 linux-bluetooth@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Arman Uguray <armansito@chromium.org>
Subject: Re: [PATCH v3 0/2] Bluetooth: Multi-Advertising Infrastructure
References: <20150409094913.GB10676@t440s.lan> <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

I'd be glad if someone found the time to review this patch set.

I made the changes proposed by Johan in his review. So not sure whether 
this is good to be applied now or whether further changes are needed.

I'm holding back with more multi-advertisement change sets until I'm 
sure that we have a good basis...

Thanks!!

Florian

On 04/10/2015 04:30 AM, Florian Grandel wrote:
> A patch set introducing the infrastructure for multi-advertising
> capability to the HCI core and mgmt API.
>
> v1 -> v2:
> - add missing braces in read_adv_features()
>
> v2 -> v3:
> - split change-set into several patches
> - replace err == 0 by !err
> - fix coding style problems
>
> Florian Grandel (2):
>    Bluetooth: hci_core: Introduce multi-adv inst list
>    Bluetooth: mgmt: Start using multi-adv inst list
>
>   include/net/bluetooth/hci_core.h |  21 ++-
>   net/bluetooth/hci_core.c         | 118 ++++++++++++-
>   net/bluetooth/mgmt.c             | 349 +++++++++++++++++++++------------------
>   3 files changed, 321 insertions(+), 167 deletions(-)
>
