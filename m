Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130406024803.GC10666@joana>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
	<1365166670-3271-4-git-send-email-dh.herrmann@gmail.com>
	<20130406024803.GC10666@joana>
Date: Sat, 6 Apr 2013 20:31:16 +0200
Message-ID: <CANq1E4QM8-ArGgZh6PUPXs0o-VpNvF8B-hJ7ks89-Nz5sE+apQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] Bluetooth: rename hci_conn_put to hci_conn_drop
From: David Herrmann <dh.herrmann@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

On Sat, Apr 6, 2013 at 4:48 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi David,
>
> * David Herrmann <dh.herrmann@gmail.com> [2013-04-05 14:57:35 +0200]:
>
>> We use _get() and _put() for device ref-counting in the kernel. However,
>> hci_conn_put() is _not_ used for ref-counting, hence, rename it to
>> hci_conn_drop() so we can later fix ref-counting and introduce
>> hci_conn_put().
>>
>> hci_conn_hold() and hci_conn_put() are currently used to manage how long a
>> connection should be held alive. When the last user drops the connection,
>> we spawn a delayed work that performs the disconnect. Obviously, this has
>> nothing to do with ref-counting for the _object_ but rather for the
>> keep-alive of the connection.
>>
>> But we really _need_ proper ref-counting for the _object_ to allow
>> connection-users like rfcomm-tty, HIDP or others.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>>  include/net/bluetooth/hci_core.h |  2 +-
>>  net/bluetooth/hci_conn.c         |  6 +++---
>>  net/bluetooth/hci_event.c        | 36 ++++++++++++++++++------------------
>>  net/bluetooth/l2cap_core.c       |  6 +++---
>>  net/bluetooth/mgmt.c             |  6 +++---
>>  net/bluetooth/sco.c              |  6 +++---
>>  net/bluetooth/smp.c              |  2 +-
>>  7 files changed, 32 insertions(+), 32 deletions(-)
>
> This patch doesn't apply anymore. Maybe you didn't rebase it on the latest
> bluetooth-next before send it. Please do this and resend. You can already add
> Marcel's acks to your patches when you resend it.

Sorry, I rebased in v1, but it seems there were some changes in
between. I rebased again and added Marcel's Acked-By.

Thanks!
David
