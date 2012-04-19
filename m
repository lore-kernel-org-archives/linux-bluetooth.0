Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OASRGQJVLJzYHSkgWW+oXRtrOPEKZNacfLb4R=1_9mDg@mail.gmail.com>
References: <1334850342-23063-1-git-send-email-hemant.gupta@stericsson.com>
	<CAJdJm_OASRGQJVLJzYHSkgWW+oXRtrOPEKZNacfLb4R=1_9mDg@mail.gmail.com>
Date: Thu, 19 Apr 2012 13:24:59 -0400
Message-ID: <CAJdJm_NKPEuYvbEgt0h1=aSH61D8hazS81U2RapkgJncP-sXLw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Update L2CAP Channel State for LE Link
 during Pairing
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 19, 2012 at 1:23 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> I suggest you explain what it means for smp_conn_security() return
> "true" or "false" (at least what you understand from it), and why
> l2cap_chan_ready() (which updates the socket/channel state to
> BT_CONNECT) needs to be called when the condition is "false".

My mistake: it is not BT_CONNECT, but whatever state which means the
socket is "ready".

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
