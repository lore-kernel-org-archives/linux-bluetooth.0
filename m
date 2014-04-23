Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+6aXGkqnHcoaYCU+2DQ95i_W-+g2H4dM8uAV0rob1_CA@mail.gmail.com>
References: <1398143280-21017-1-git-send-email-martin.kampas@tieto.com>
	<CABBYNZL763g4AptiqcS-M4LvwD1BwMQnZg=HLHiJGYCG9qznFg@mail.gmail.com>
	<7726122.LGD9fIbFvh@5th>
	<CABBYNZ+6aXGkqnHcoaYCU+2DQ95i_W-+g2H4dM8uAV0rob1_CA@mail.gmail.com>
Date: Wed, 23 Apr 2014 11:28:55 +0300
Message-ID: <CABBYNZJjB6D4Bekqu+wK9EeRrzg=26GFhB-KW-Spzq7X-tt4cg@mail.gmail.com>
Subject: Re: [PATCH] obex-client-tool: Set the length header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Martin Kampas <martin.kampas@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Wed, Apr 23, 2014 at 11:20 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Martin,
>
> On Wed, Apr 23, 2014 at 10:54 AM, Martin Kampas <martin.kampas@tieto.com> wrote:
>> Hi Luiz,
>>
>> On Wednesday, April 23, 2014 10:24:17 AM Luiz Augusto von Dentz wrote:
>>> The patch itself is fine but there got to be something wrong with
>>> obexd if it cannot accept a PUT without length, maybe it is the agent
>>> that is rejecting it?
>>
>> If I am not wrong it is rejected inside the opp plugin in opp_chkput() [1] (where OBJECT_SIZE_DELETE should be the initial value of obex_session::size), called from check_put() [2]
>>
>> I also tried with an Android 4.1 device and got the same result.
>>
>> BR,
>> Martin
>>
>> [1] http://git.kernel.org/cgit/bluetooth/obexd.git/tree/plugins/opp.c?id=0.48#n122
>> [2] http://git.kernel.org/cgit/bluetooth/obexd.git/tree/src/obex.c?id=0.48#n918
>
> Hmm, looks likes it is still broken, btw the proper check is probably
> to check the existence of a body header and then set size to
> OBJECT_SIZE_UNKNOWN before parse_length.

Try the with the following patch:

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index bd4770d..7b4634e 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -873,6 +873,10 @@ static void cmd_put(GObex *obex, GObexPacket
*req, gpointer user_data)

        os->cmd = G_OBEX_OP_PUT;

+       /* Set size to unknown if a body header exists */
+       if (g_obex_packet_get_body(req))
+               os->size = OBJECT_SIZE_UNKNOWN;
+
        parse_name(os, req);
        parse_length(os, req);
        parse_time(os, req);


-- 
Luiz Augusto von Dentz
