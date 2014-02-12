Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Fix channel check when binding RFCOMM sock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAF3PWx0PkL8fQ2ypsU24xM1HveQAia19OFDLcX9D=90_Oo9Vig@mail.gmail.com>
Date: Wed, 12 Feb 2014 15:01:56 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <7E549E73-52F4-432E-8B71-FC2F9E862772@holtmann.org>
References: <1392119413-26341-1-git-send-email-andrzej.kaczmarek@tieto.com> <52F8F4E9-BCAF-4137-B21C-101F11DE1519@holtmann.org> <CAF3PWx0PkL8fQ2ypsU24xM1HveQAia19OFDLcX9D=90_Oo9Vig@mail.gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

>>> When binding RFCOMM socket we should only check if there is another
>>> socket bound or listening on the same channel number. In other case,
>>> it won't be possible to bind/listen on a channel in case we have
>>> connection made to remote device on the same channel number.
>> 
>> since this has been used for years now, you need to be more specific on when this fails.
> 
> It's quite simple: create one socket and connect on channel X, then
> create another socket and try to bind on channel X. Event though we
> don't have listening socket on channel X yet, it will fail with
> EADDRINUSE since rfcomm_sock_bind looks for *any* socket on specified
> channel and doesn't care if it's bound/listening on local channel or
> just connected to remote channel (in which case it should not fail).
> 
> Is it specific enough?

can we add a test case to rfcomm-tester for this first.

>>> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
>>> ---
>>> net/bluetooth/rfcomm/sock.c | 5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
>>> index 00573fb..9912e23 100644
>>> --- a/net/bluetooth/rfcomm/sock.c
>>> +++ b/net/bluetooth/rfcomm/sock.c
>>> @@ -331,6 +331,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
>>> {
>>>      struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
>>>      struct sock *sk = sock->sk;
>>> +     struct sock *sk1;
>>>      int err = 0;
>>> 
>>>      BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
>>> @@ -352,7 +353,9 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
>>> 
>>>      write_lock(&rfcomm_sk_list.lock);
>>> 
>>> -     if (sa->rc_channel && __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
>>> +     sk1 = __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr);
>>> +     if (sa->rc_channel && sk1 && (sk1->sk_state == BT_BOUND ||
>>> +                                             sk1->sk_state == BT_LISTEN)) {
>>>              err = -EADDRINUSE;
>> 
>> can we find a better name than sk1 here.
> 
> Something like 'existing_sk'? Or just 'oldsk'? I have no clue how to
> make a meaningful name here.

I wonder if you should not just fix __rfcomm_get_sock_by_addr to check only for BT_BOUND and BT_LISTEN.

Regards

Marcel


