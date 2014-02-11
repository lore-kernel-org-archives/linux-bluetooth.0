Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <52F8F4E9-BCAF-4137-B21C-101F11DE1519@holtmann.org>
References: <1392119413-26341-1-git-send-email-andrzej.kaczmarek@tieto.com> <52F8F4E9-BCAF-4137-B21C-101F11DE1519@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Tue, 11 Feb 2014 23:26:49 +0100
Message-ID: <CAF3PWx0PkL8fQ2ypsU24xM1HveQAia19OFDLcX9D=90_Oo9Vig@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix channel check when binding RFCOMM sock
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 11 February 2014 16:58, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>> When binding RFCOMM socket we should only check if there is another
>> socket bound or listening on the same channel number. In other case,
>> it won't be possible to bind/listen on a channel in case we have
>> connection made to remote device on the same channel number.
>
> since this has been used for years now, you need to be more specific on when this fails.

It's quite simple: create one socket and connect on channel X, then
create another socket and try to bind on channel X. Event though we
don't have listening socket on channel X yet, it will fail with
EADDRINUSE since rfcomm_sock_bind looks for *any* socket on specified
channel and doesn't care if it's bound/listening on local channel or
just connected to remote channel (in which case it should not fail).

Is it specific enough?

>> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
>> ---
>> net/bluetooth/rfcomm/sock.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
>> index 00573fb..9912e23 100644
>> --- a/net/bluetooth/rfcomm/sock.c
>> +++ b/net/bluetooth/rfcomm/sock.c
>> @@ -331,6 +331,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
>> {
>>       struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
>>       struct sock *sk = sock->sk;
>> +     struct sock *sk1;
>>       int err = 0;
>>
>>       BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
>> @@ -352,7 +353,9 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
>>
>>       write_lock(&rfcomm_sk_list.lock);
>>
>> -     if (sa->rc_channel && __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
>> +     sk1 = __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr);
>> +     if (sa->rc_channel && sk1 && (sk1->sk_state == BT_BOUND ||
>> +                                             sk1->sk_state == BT_LISTEN)) {
>>               err = -EADDRINUSE;
>
> can we find a better name than sk1 here.

Something like 'existing_sk'? Or just 'oldsk'? I have no clue how to
make a meaningful name here.

BR,
Andrzej
