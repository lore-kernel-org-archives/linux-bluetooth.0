Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100628160751.GA5557@vigoh>
References: <1274436293-15063-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20100523023906.GB3385@vigoh>
	<AANLkTilQoPjrNgqjtp7xeQF-yzrE6KNgDdagEXrIIGIv@mail.gmail.com>
	<20100628160751.GA5557@vigoh>
Date: Tue, 29 Jun 2010 15:48:22 +0300
Message-ID: <AANLkTikfe4uO54VzkyYDCPWmOO30jTtQFxFdQuoancg1@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] Bluetooth: Check sk is not owned before freeing
	l2cap_conn
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Ville Tervo <ville.tervo@iki.fi>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Jun 28, 2010 at 7:07 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> Hi Andrei,
>
> * Ville Tervo <ville.tervo@iki.fi> [2010-05-28 10:14:31 +0300]:
>
>> Hi,
>>
>> On Sun, May 23, 2010 at 5:39 AM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
>>
>> > Using the sock timer like you are you using looks too hackish, there are
>> > kernel struct for such defer works. I still prefer the first solution,
>> > that avoids the call to l2cap_chan_del() only.
>> > But we have to solve the problem with the sock_kill() call, I'm
>> > wondering if add a check inside l2cap_sock_kill is good idea. So we
>> > check if the socket is owned by user and if yes, we just return, however
>> > may have problem with socket refcnt doing that.
>> >
>> > Looking to the rfcomm code I found something that could be cause of the
>> > problem, there isn't any sock_hold() in the rfcomm code, maybe is it
>> > missing? Nevertheless it does the sock_put() without call sock_hold().
>> >
>> > Like you I'm trying to figure out how to fix this issue, I don't know
>> > yet how to fix it properly. I advice to take a look on the rfcomm code
>> > and check if we really are missing a sock_hold() there.
>>
>> Wouldn't backlogging of destructive operations (l2cap disc rsp and
>> req) solve these issues? All operations cannot be backlogged since
>> they cannot mapped to certain sock.
>
> I've been thinking about this issue and now I agree that backlog them is
> the better solution. We're already using backlog queue for ERTM, so you
> will have to extend it only. Check the branch for-next of my tree to see
> how I did that.

IMO The case we are talking about is different. Personally I do not
think we need to backlog
packets for removed connection. Those packets will be discarded anyway
since there will
be no connection and this operation will consume CPU just for nothing.

Regards,
Andrei
