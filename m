Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTiltwpMN2U3tVry3I-77HDl5-KYsPZHmFqeD58Nl@mail.gmail.com>
References: <1278969545-26864-1-git-send-email-gustavo@padovan.org>
	<AANLkTiltwpMN2U3tVry3I-77HDl5-KYsPZHmFqeD58Nl@mail.gmail.com>
Date: Tue, 13 Jul 2010 14:30:13 -0300
Message-ID: <AANLkTikS1-1crv118hO40CSjCmgJg-fVYufVYTrcV8rP@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add Fixed Channels support to bind
	syscall.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtman.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 13, 2010 at 2:26 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> If sk->sport is always filled with either cid or psm , why not have
> just a single "__l2cap_sock_addr"  function ?

In other words, my suggestion is to keep __l2cap_get_sock_by_addr() as
is (as it already checks for sport) and use it both for PSM and CID.
This could potentially allow a bit of refactoring on the
l2cap_sock_bind() changes as well.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
