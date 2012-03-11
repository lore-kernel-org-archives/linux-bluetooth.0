Return-Path: <cyrus@holtmann.org>
Message-ID: <1331488929.14217.62.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Implement Read Transmit Power Level command
From: Marcel Holtmann <marcel@holtmann.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Date: Sun, 11 Mar 2012 11:02:09 -0700
In-Reply-To: <1331455196-26441-1-git-send-email-arik@wizery.com>
References: <1331455196-26441-1-git-send-email-arik@wizery.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

> Add Read Transmit Power Level command in Management Interface and all
> infrastructure need for that.
> 
> Read Transmit Power Level command is defined on Part E, section 7.3.35
> of Bluetooth 4.0 Spec.
> 
> [Arik: Rebase to master, add type argument to HCI command, small
> bug fixes and style changes]
> 
> Signed-off-by: Bruna Moreira <bruna.moreira@openbossa.org>
> Signed-off-by: Arik Nemtsov <arik@wizery.com>
> ---
>  include/net/bluetooth/hci.h      |   11 ++++
>  include/net/bluetooth/hci_core.h |    4 ++
>  include/net/bluetooth/mgmt.h     |   12 ++++
>  net/bluetooth/hci_event.c        |   24 ++++++++
>  net/bluetooth/mgmt.c             |  108 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 159 insertions(+), 0 deletions(-)

please lead with a patch to doc/mgmt-api.txt first. I like to see the
proposed API first and not the implementation.

Regards

Marcel


