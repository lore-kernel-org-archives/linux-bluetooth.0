Return-Path: <cyrus@holtmann.org>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <113d36d80909140452jb808a2bub393aae7307c7450@mail.gmail.com>
References: <113d36d80909140452jb808a2bub393aae7307c7450@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 14 Sep 2009 06:32:34 -0700
Message-Id: <1252935154.3421.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> When we connect a SCO socket, BlueZ decides whether to connect SCO or
> eSCO type according to the remote feature. If the remote device
> declares supporting eSCO in the remote feature, BlueZ will select eSCO
> type to connect with it.
> 
> But in fact  there are some old carkits or headsets which are only
> support SCO but wrongly declare to support eSCO, such as Motorola
> HF850 and HS820 which use a very old CSR chip, so we have problem to
> create sco connection with them.
> 
> We thought a method to resolve this issue, which is force to create
> SCO type connection if we find the HFP version of one remote device is
> less than 1.2. So we need a method to control the SCO type from user
> space. We want to use setsockopt() functon to do that. The code change
> in net/bluetooth/sco.c is like below,
> 
> 
> @@ -653,12 +653,25 @@ static int sco_sock_setsockopt(struct socket *sock, int le
>  {
>        struct sock *sk = sock->sk;
>        int err = 0;
> +       u32 opt;
> 
>        BT_DBG("sk %p", sk);
> 
>        lock_sock(sk);
> 
> +       if (level != SOL_SCO) {
> +               err = -ENOPROTOOPT;
> +               return err;
> +       }
> +
>        switch (optname) {
> +       case BT_DISABLE_ESCO:
> +               if (get_user(opt, (u32 __user *) optval)) {
> +                       err = -EFAULT;
> +                       break;
> +               }
> +               disable_esco = opt;
> +               break;
>        default:
>                err = -ENOPROTOOPT;
>                break;
> 
> 
> Then, in the user space, we can call setsockopt(fd, SOL_SCO,
> BT_DISABLE_ESCO, &disabled, sizeof(disabled)) to force to connect SCO.
> 
> Do you agree with this change?

I don't. You first have to prove to me that this change is needed at
all. Show me the hcidump -X -V connections attempts for these carkits.

Also your analysis is wrong. BlueZ doesn't care if the remote headset
supports eSCO or not. We just care about if our local controller has the
synchronous setup commands. It is the job of the link manager inside the
controller firmware to either establish SCO or eSCO. And we do retry
with SCO if eSCO fails. This sounds more like the case that you have an
outdated kernel.

Regards

Marcel


