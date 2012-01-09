Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201201052340.55020.post@hendrik-sattler.de>
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
	<201201041948.19890.post@hendrik-sattler.de>
	<CABBYNZJZ1yaswJsrO4G4gdaNENAoJSb85TvdgMQFbUA6vQyiRA@mail.gmail.com>
	<201201052340.55020.post@hendrik-sattler.de>
Date: Mon, 9 Jan 2012 13:10:47 +0200
Message-ID: <CABBYNZJynnDu_fW74jryaX206NTQrjjUBr9NT21bA=3CJfyVjA@mail.gmail.com>
Subject: Re: [PATCH obexd 3/4] gobex: automatically use SRM when transport
 type is SOCK_SEQPACKET
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Fri, Jan 6, 2012 at 12:40 AM, Hendrik Sattler
<post@hendrik-sattler.de> wrote:
>> And it continues stating that SRM can be enable outside of connection
>> scope: "If this mode is enabled outside the scope of an OBEX connection,
>> SRM is automatically disabled when the operation that enabled this mode
>> completes."
>
> I guess this is only specified if there is ever a transport that actually
> specifies this. GOEP v2.0 does not do that.

It does state SRM is automatically disabled when operations finishes,
that is specified by both OBEX 1.4 and GOEP 2.0.

>> I believe this is why GOEP 2.0 want to avoid using SRM per connection,
>> because multiple outstanding operations are not very easy to be
>> handled without an id/serial to identify them which OBEX doesn't have,
>> for instance there could be SRMP headers in responses which alters SRM
>> and breaks the assumption that only one response occurs per operation.
>
> No. Unless the server does not correctly handle SRM, this assumption is not
> broken. The main problem is actually when sending an ABORT after the GET that
> comes too late. Then you get responses: one SUCCESS for GET and one SUCCESS
> for ABORT instead of one SUCCESS for GET. This can break the synchronisation
> of client and server and the writers of the OBEX spec did not consider this.

In any case this is pretty bad.

>> IMO what the OBEX spec writer suggests is that the operations are
>> queued by the server, so it only starts responding once the previous
>> operation is finished, but this doesn't have any benefit over enabling
>> SRM per operation as GOEP 2.0 suggests.
>
> And there is the problem: "SRM per operation" is not specified by OBEX v1.4.
> There, it is always "SRM per connection", so this must be something new from
> OBEX v1.5.

It is specified, GET, PUT, SETPATH and DISCONNECT can all have SRM
headers, it is also stated in page 32 of OBEX 1.4:

"If no OBEX connection exists when SRM is enabled, SRM shall be
automatically disabled upon completion of the operation which enabled
it."

The question is, connection means CONNECT operation has been complete
or within CONNECT request/response, GOEP 2.0 interpret it as the
latter which might be what OBEX 1.5 specifies due to the issues of
multiple outstanding operations. Btw, GOEP 2.0 test specification used
for qualification has a test which strictly forbids the server to
respond with SRM headers in case of CONNECT:

"3.16 TP/SRM/BI-03-C Process an OBEX CONNECT request
(incorrectly) containing a SRM header

• Expected Outcome
Pass Verdict:
– On receiving the invalid SRM header in the OBEX_CONNECT request, the IUT
responds with a SUCCESS without a SRM header.
– OBEX/L2CAP channel is established.
Fail Verdict:
– On receiving the invalid SRM header in the OBEX_CONNECT request, the IUT does
not respond with a SUCCESS and/or includes a SRM header in the response.
– OBEX/L2CAP channel is not established or OBEX/RFCOMM channel is established."

>> OBEX spec says that if SRM is enabled during the connection context it
>> is valid to all subsequent operations, I guess GOEP 2.0 interpret
>> context as just within CONNECT request/response. Again I think this is
>> to avoid having to support multiple outstanding operations, but it is
>> not stated anywhere so it is just my guess.
>
> This must be from OBEX v1.5. Good guess, then :-)
> Strange enough they chose to support SRM but only a less efficient setup (you
> still have twice as much RTTs for each PUT and GET than with SRM enabled with
> CONNECT.

You mean +1 response for PUT to enable SRM, for GET it is exactly the
same since the first response should enable SRM and no other request
should be sent. I think this is pretty good considering that it
reduces the complexity compared to supporting SRM on CONNECT.

-- 
Luiz Augusto von Dentz
