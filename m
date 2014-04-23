Return-Path: <cyrus@holtmann.org>
From: Martin Kampas <martin.kampas@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] obex-client-tool: Set the length header
Date: Wed, 23 Apr 2014 09:54:37 +0200
Message-ID: <7726122.LGD9fIbFvh@5th>
In-Reply-To: <CABBYNZL763g4AptiqcS-M4LvwD1BwMQnZg=HLHiJGYCG9qznFg@mail.gmail.com>
References: <1398143280-21017-1-git-send-email-martin.kampas@tieto.com> <CABBYNZL763g4AptiqcS-M4LvwD1BwMQnZg=HLHiJGYCG9qznFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wednesday, April 23, 2014 10:24:17 AM Luiz Augusto von Dentz wrote:
> The patch itself is fine but there got to be something wrong with
> obexd if it cannot accept a PUT without length, maybe it is the agent
> that is rejecting it?

If I am not wrong it is rejected inside the opp plugin in opp_chkput() [1] (where OBJECT_SIZE_DELETE should be the initial value of obex_session::size), called from check_put() [2]

I also tried with an Android 4.1 device and got the same result.

BR,
Martin

[1] http://git.kernel.org/cgit/bluetooth/obexd.git/tree/plugins/opp.c?id=0.48#n122
[2] http://git.kernel.org/cgit/bluetooth/obexd.git/tree/src/obex.c?id=0.48#n918
