Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130226200101.GD10898@joana>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
	<1361731026-7428-5-git-send-email-dh.herrmann@gmail.com>
	<20130226200101.GD10898@joana>
Date: Wed, 27 Feb 2013 12:14:20 +0100
Message-ID: <CANq1E4Qm8zEZM6FkgXA_+rs4q6uhbYSQiyOypMiVSvHuLVw6-g@mail.gmail.com>
Subject: Re: [PATCH 04/16] Bluetooth: hidp: verify l2cap sockets
From: David Herrmann <dh.herrmann@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>, David Herrmann <dh.herrmann@gmail.com>,
	linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

On Tue, Feb 26, 2013 at 9:01 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi David,
>
> * David Herrmann <dh.herrmann@gmail.com> [2013-02-24 19:36:54 +0100]:
>
>> We need to verify that the given sockets are actually l2cap sockets. If
>> they aren't, we are not supposed to access bt_sk(sock) and we shouldn't
>> start the session if the offsets turn out to be valid local BT addresses.
>
> What is the issue you are trying to fix here, I don't get it.

Look what happens if you pass TCP sockets instead of l2cap sockets (or
any other kind of socket). In hidp_add_connection() we do:

if (bacmp(&bt_sk(ctrl_sock->sk)->src, &bt_sk(intr_sock->sk)->src) ||
    bacmp(&bt_sk(ctrl_sock->sk)->dst, &bt_sk(intr_sock->sk)->dst))

Who guarantees that ctrl_sock->sk is a bt_sock? We shouldn't access
bt_sk(ctrl_sock->sk)->src if it's not a bt_sock. Because there might
be sockets that have a "struct X_sock" that is smaller than "bt_sock"
and hence, we would access unknown kernel memory.

>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>>  include/net/bluetooth/l2cap.h | 1 +
>>  net/bluetooth/hidp/core.c     | 2 ++
>>  net/bluetooth/l2cap_sock.c    | 6 ++++++
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 7588ef4..ae6210e 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -787,6 +787,7 @@ extern bool disable_ertm;
>>
>>  int l2cap_init_sockets(void);
>>  void l2cap_cleanup_sockets(void);
>> +bool is_l2cap_socket(struct socket *s);
>
> Make it l2cap_is_socket() or something like that. Use 'sk' instead of 's'.

I will fix that.

Thanks!
David
