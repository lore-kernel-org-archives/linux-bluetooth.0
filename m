Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2] Bluetooth: Make Fast Connectable available while powered off
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426011267-6986-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Mar 2015 11:39:52 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <28873DA8-6019-4960-8FCF-6A2446736161@holtmann.org>
References: <1426011267-6986-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To maximize the usability of the Fast Connectable feature we should make
> it possible to set (or unset) it at any given moment. This means
> removing the dependency on the 'connectable' setting as well as the
> 'powered' setting. The former makes also sense since page scan may get
> enabled through add_device even if 'connectable' is false. To keep the
> setting available over power cycles its flag also needs to be removed
> from the flags that are cleared upon HCI_Reset.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: After discussion with Marcel, we agreed that it makes sense to allow
> this setting in an even wider scope, i.e. also when powered off.
> 
> include/net/bluetooth/hci.h |  2 +-
> net/bluetooth/mgmt.c        | 30 ++++++++++++------------------
> 2 files changed, 13 insertions(+), 19 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

