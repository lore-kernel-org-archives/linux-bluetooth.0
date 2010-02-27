Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8a7a8d7b1002171330m7d1549deye643aecad10c5822@mail.gmail.com>
References: <8a7a8d7b1002171330m7d1549deye643aecad10c5822@mail.gmail.com>
Date: Fri, 26 Feb 2010 18:19:34 -0600
Message-ID: <8a7a8d7b1002261619s497fd87al5232ea0957037d94@mail.gmail.com>
Subject: Re: What's the idea of security_cfm is called for both
	hci_proto_auth_cfm and hci_proto_encrypt_cfm? -resend
From: Liejun Tao <liejuntao001@gmail.com>
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 17, 2010 at 3:30 PM, Liejun Tao <liejuntao001@gmail.com> wrote:
> Hi Marcel,
> Beside the l2cap issue with Blackberry 8900, I meet another l2cap
> connection failure issue when testing
> PTS AVRCP_TC_TG_PTT_BV_01_I.
>
> For 8900, the sequence is:
> l2cap_do_start(): send L2CAP_INFO_REQ
> security_cfm(): send L2CAP_CONN_REQ
> l2cap_information_rsp(): call l2cap_do_start(), send L2CAP_CONN_REQ again
>
> For PTS AVRCP_TC_TG_PTT_BV_01_I, the sequence is:
> l2cap_do_start(): send L2CAP_CONN_REQ
> security_cfm():send L2CAP_CONN_REQ again
> l2cap_conn_rsp(): receive L2CAP_CR_PEND
> l2cap_conn_rsp(): receive L2CAP_CR_NO_MEM
>
> In both cases, security_cfm() is called from hci_proto_encrypt_cfm(),
> and interrupt the normal sequence of l2cap connection.
>
> security_cfm() is also called in hci_proto_auth_cfm. I feel auth_cfm
> and encryption_cfm are for different events, why they call the same
> function?
>
> What's your mind to avoid 2 connection request?
>
> Aside, should we set a state bit after send l2CAP_CONN_REQ?
>

Ping.

Hi Marcel,
Any idea how to resolve these 2 issues?
