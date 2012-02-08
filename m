Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328660010-14247-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328660010-14247-1-git-send-email-vinicius.gomes@openbossa.org>
Date: Wed, 8 Feb 2012 06:36:49 -0400
Message-ID: <CAJdJm_N=VLApJpSfKYj6wTvAviMe2j0F3MU2icESfnWLgu=CTw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add support for reusing the same hci_conn
 for LE links
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 7, 2012 at 8:13 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> As most LE devices leave advertising mode when they enter the connected
> state, we may want to "pass" that connection to other users.
>
> The first user will be the pairing procedure, the connection is
> established without an associated socket, after the pairing is
> complete, userspace may want to discover via GATT what services the
> newly bonded device has.
>
> If userspace establishes the connection while the timeout still
> hasn't expired, the connection will be re-used.
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>
> Changes: Rebased against current bluetooth-next.
>
>
>  net/bluetooth/hci_conn.c   |   32 +++++++++++++++------------
>  net/bluetooth/l2cap_core.c |   51 +++++++++++++++++++++++++++++--------------
>  2 files changed, 52 insertions(+), 31 deletions(-)

Just to complement, this also fixes an apparently recent regression
where MGMT_OP_PAIR_DEVICE was not triggering SMP pairing for LE.
Applying this patch made "simple-agent hci0 <bdaddr>" trigger SMP
pairing as before.

Best regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
