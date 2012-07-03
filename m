Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Jul 2012 11:18:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v0] Bluetooth: Fix lost socket error code
Message-ID: <20120703081821.GA23286@x220>
References: <1340115637-2595-1-git-send-email-mikel.astiz.oss@gmail.com>
 <20120629132435.GB27007@x220>
 <CANT-zCUmB96Yu=Lij-wb+wOxjkhUP_X=RYeC5XjLio10q0Rbuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANT-zCUmB96Yu=Lij-wb+wOxjkhUP_X=RYeC5XjLio10q0Rbuw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Jul 03, 2012, Mikel Astiz wrote:
> I don't actually get why rfcomm_sock_recvmsg() is being called, but
> that's what I experimentally see:
> 
> [18985.546436] [73] rfcomm_l2data_ready:197: ffff880205613800 bytes 4
> [18985.546535] [21592] rfcomm_process_rx:1853: session
> ffff880230ccc9c0 state 1 qlen 1
> [18985.546546] [21592] rfcomm_recv_disc:1205: session ffff880230ccc9c0
> state 1 dlci 26
> [18985.546552] [21592] rfcomm_send_ua:773: ffff880230ccc9c0 dlci 26
> [18985.546558] [21592] rfcomm_send_cmd:750: ffff880230ccc9c0 cmd 115
> [18985.546563] [21592] rfcomm_send_frame:741: session ffff880230ccc9c0 len 4
> [18985.546591] [21592] __rfcomm_dlc_close:447: dlc ffff88016fe16500
> state 9 dlci 26 err 104 session ffff880230ccc9c0
> [18985.546597] [21592] rfcomm_dlc_clear_timer:286: dlc ffff88016fe16500 state 9
> [18985.546603] [21592] rfcomm_sk_state_change:71: dlc ffff88016fe16500
> state 9 err 104
> 
> Here the error has been set.
> 
> [18985.546628] [21592] rfcomm_dlc_unlink:351: dlc ffff88016fe16500
> refcnt 2 session ffff880230ccc9c0
> [18985.546635] [21592] rfcomm_session_set_timer:250: session
> ffff880230ccc9c0 state 1 timeout 2000
> [18985.546646] [21592] rfcomm_process_dlcs:1792: session
> ffff880230ccc9c0 state 1
> [18985.546701] [32724] bt_sock_stream_recvmsg:300: sk ffff880205615800 size 7768
> 
> And here the error has been cleared.

recvmsg is the function that gets triggered when user space does a
read() system call. So it seems somewhere in user space the error from
read() is being ignored.

Johan
