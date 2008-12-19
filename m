Return-Path: <cyrus@holtmann.org>
Subject: Re: conn->state vs conn->sk->sk_state
From: Marcel Holtmann <marcel@holtmann.org>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <ac290f760812181815h719d9c95nb724872a4beb04ca@mail.gmail.com>
References: <ac290f760812171405r79473a67l6769913bc7e62d2e@mail.gmail.com>
	 <ac290f760812171407te7a079eycf45c36d376b0c5c@mail.gmail.com>
	 <ac290f760812181815h719d9c95nb724872a4beb04ca@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 19:58:00 +0100
Message-Id: <1229713080.879.8.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

> Looking at this a bit further, I see a discrepancy between the code in
> function  hci_conn_complete_evt and hci_sync_conn_complete_evt.
> Is this intentional or a bug ? Like I said below, using
> hci_conn_complete_evt (when the AG doesn't support eSCO) results in
> the connect() never returning because the socket state is not updated.

I still have no idea what's your problem. It doesn't matter if the
remote side supports eSCO or not. The sync setup commands can be used
even for setting up SCO channels.

Regards

Marcel


