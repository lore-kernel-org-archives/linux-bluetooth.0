Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: shutdown(3) and bluetooth.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131113002819.GB12615@redhat.com>
Date: Wed, 13 Nov 2013 10:58:43 +0900
Cc: netdev@vger.kernel.org,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <78727581-9350-4E23-95C6-5E7510C24A72@holtmann.org>
References: <20131112211125.GA2912@redhat.com> <DF4C2B40-BD87-4E88-911D-E3E5F488CAE4@holtmann.org> <20131112221038.GA6689@redhat.com> <FC5CE013-B077-4EA5-81C1-A7D8B4A5EF85@holtmann.org> <20131112224819.GE9057@redhat.com> <D8BE686E-E81D-48CD-8D67-2B138191E0CC@holtmann.org> <20131113002819.GB12615@redhat.com>
To: Dave Jones <davej@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

>>> So it seems it affects both SCO and RFCOMM.
>>> 
>>>> What kernel did you run this against? It is a shot in the dark, but can you try linux-next quickly.
>>>> There was a socket related fix for the socket options where we confused RFCOMM vs L2CAP struct sock.
>>> 
>>> first noticed it on Linus' latest HEAD, and then reproduced it on 3.11.6
>>> I'll look at linux-next tomorrow.
>> 
>> I looked through the code and only call bt_sock_wait_state when SOCK_LINGER and sk_lingertime is set. In that case we actually block until the socket state changes to BT_CLOSED.
>> 
>> The only way I see this could happen is if you have a huge linger timeout and confused the socket state before. What is actually the list of system calls that you are throwing at this socket.
> 
> Ah. I recently changed some code that's now doing this on every socket at shutdown..
> (simplified cut-n-paste)
> 
>        struct linger ling = { .l_onoff = FALSE, };
> 
>        for (i = 0; i < nr_sockets; i++) {
>                fd = shm->sockets[i].fd;
>                shm->sockets[i].fd = 0;
> 
>                setsockopt(fd, SOL_SOCKET, SO_LINGER, &ling, sizeof(struct linger));
>                shutdown(fd, SHUT_RDWR);
>                close(fd);
>        }
> 
> I could just rip out that linger code completely and just hope that sockets staying in
> TIME_WAIT is good enough. iirc, I added it when after multiple runs, some of the
> weirder protocols would fail to open a socket once a certain number of existing
> sockets had opened, even if they were in SOCK_WAIT
> 
> two remaining questions though. That code is setting linger to false. Why would
> that cause the sk_lingertime to be taken into consideration ?  And why is this
> only a problem for bluetooth (apparently) ?

we are not touching that part of setsockopt. That is handled by net/core/sock.c and we just check if SOCK_LINGER flag is set and if we have a positive sk_lingertime. So this is a bit suspicious on why this is happening, but I don’t think it is our mistake.

Regards

Marcel

