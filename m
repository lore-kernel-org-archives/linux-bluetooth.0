Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/2] shared/att: Improve client support.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404795901-29367-1-git-send-email-armansito@chromium.org>
Date: Wed, 9 Jul 2014 15:38:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0808B431-893B-4318-A353-4E2E8B0901C9@holtmann.org>
References: <1404795901-29367-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch set makes the following additions/changes:
> 
>  - The opcode + param structure semantics are no longer used. bt_att_send now
>    takes in the PDU as it will be sent over the physical link and it won't
>    perform any explicit encoding or decoding of PDUs between host order and BT
>    order. Any packed structs that get passed to bt_att_send need to be
>    formatted according to the correct endianness.
> 
>  - bt_att_register and bt_att_unregister* functions are implemented. Callbacks
>    are registered for a particular opcode and they get invoked when an incoming
>    PDU of type "request", "indication", or "notification" is received.
> 
> This provides the basic functionality needed to implement a GATT client layer,
> except for PDU signing and verifications of incoming signed PDUs. This isn't
> immediately needed to implement a functioning client and could be left to the
> upper layer.
> 
> Arman Uguray (2):
>  shared/att: Remove parameters structures.
>  shared/att: Implement bt_att_register.
> 
> src/shared/att-types.h | 153 +-------------------
> src/shared/att.c       | 383 ++++++++++++++++++++++++++++++++-----------------
> src/shared/att.h       |  19 +--
> 3 files changed, 267 insertions(+), 288 deletions(-)

I have applied both patches. However please keep in mind that the CSRK signing and resolving still needs to happen in this low-level ATT. The signatures are calculated over the whole PDU including opcode. Our BlueZ for Android code is capable of using signed write, so you can test against that one.

Regards

Marcel

