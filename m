Return-Path: <cyrus@holtmann.org>
Message-ID: <543BF409.7060809@xsilon.com>
Date: Mon, 13 Oct 2014 16:47:21 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
CC: Martin Townsend <mtownsend1973@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
 marcel@holtmann.org, alex.aring@gmail.com
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC decompression.
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>			 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>		 <1413200959.2705.90.camel@jrissane-mobl.ger.corp.intel.com>		 <543BCF44.1030001@xsilon.com>	 <1413211468.2705.104.camel@jrissane-mobl.ger.corp.intel.com>	 <543BE816.80304@xsilon.com> <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
In-Reply-To: <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: multipart/alternative;
 boundary="------------080103020102050105050405"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080103020102050105050405
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Jukka,

>From the last trace it looks like a transmit has been started from the receive worker thread.  I notice that both tx and rx use the same workerqueue structure, e.g.

hci_send_xxx <http://lxr.free-electrons.com/ident?i=hci_send_acl>
...
queue_work <http://lxr.free-electrons.com/ident?i=queue_work>(hdev <http://lxr.free-electrons.com/ident?i=hdev>->workqueue <http://lxr.free-electrons.com/ident?i=workqueue>, &hdev <http://lxr.free-electrons.com/ident?i=hdev>->tx_work);



hci_recv_frame <http://lxr.free-electrons.com/ident?i=hci_recv_frame>
...
queue_work <http://lxr.free-electrons.com/ident?i=queue_work>(hdev <http://lxr.free-electrons.com/ident?i=hdev>->workqueue <http://lxr.free-electrons.com/ident?i=workqueue>, &hdev <http://lxr.free-electrons.com/ident?i=hdev>->rx_work <http://lxr.free-electrons.com/ident?i=rx_work>);


Would this cause problems.  I don't know enough about work queues but in workqueue_struct there is a mutex which may be held by the rx worker and if this rx worker start a transmit maybe this would cause the lock?  Could test by creating separate queues for rx and tx?

Anyway just a thought.

- Martin.


On 13/10/14 16:09, Jukka Rissanen wrote:
> Hi Martin,
>
> On ma, 2014-10-13 at 15:56 +0100, Martin Townsend wrote:
>> Hi Jukka,
>>
>> Does this patch help?
> Unfortunately no, I still see inconsistent lock state. It would probably
> have been too easy :)
>
>> ---
>>  net/bluetooth/l2cap_core.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index b6f9777..fb7b2ff 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -5494,6 +5494,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
>>  	if (credits > max_credits) {
>>  		BT_ERR("LE credits overflow");
>>  		l2cap_send_disconn_req(chan, ECONNRESET);
>> +		l2cap_chan_unlock(chan);
>>  
>>  		/* Return 0 so that we don't trigger an unnecessary
>>  		 * command reject packet.
>
> Cheers,
> Jukka
>
>


--------------080103020102050105050405
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Jukka,<br>
    <br>
    From the last trace it looks like a transmit has been started from
    the receive worker thread.  I notice that both tx and rx use the
    same workerqueue structure, e.g.<br>
    <br>
    <a href="http://lxr.free-electrons.com/ident?i=hci_send_acl">hci_send_xxx</a><br>
    ...<br>
    <a href="http://lxr.free-electrons.com/ident?i=queue_work">queue_work</a>(<a
      href="http://lxr.free-electrons.com/ident?i=hdev">hdev</a>-&gt;<a
      href="http://lxr.free-electrons.com/ident?i=workqueue">workqueue</a>,
    &amp;<a href="http://lxr.free-electrons.com/ident?i=hdev">hdev</a>-&gt;tx_work);<br>
    <br>
    <br>
    <br>
    <a href="http://lxr.free-electrons.com/ident?i=hci_recv_frame">hci_recv_frame</a><br>
    ...<br>
    <a href="http://lxr.free-electrons.com/ident?i=queue_work">queue_work</a>(<a
      href="http://lxr.free-electrons.com/ident?i=hdev">hdev</a>-&gt;<a
      href="http://lxr.free-electrons.com/ident?i=workqueue">workqueue</a>,
    &amp;<a href="http://lxr.free-electrons.com/ident?i=hdev">hdev</a>-&gt;<a
      href="http://lxr.free-electrons.com/ident?i=rx_work">rx_work</a>);<br>
    <br>
    <br>
    Would this cause problems.  I don't know enough about work queues
    but in workqueue_struct there is a mutex which may be held by the rx
    worker and if this rx worker start a transmit maybe this would cause
    the lock?  Could test by creating separate queues for rx and tx?<br>
    <br>
    Anyway just a thought.<br>
    <br>
    - Martin.<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 13/10/14 16:09, Jukka Rissanen
      wrote:<br>
    </div>
    <blockquote
      cite="mid:1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com"
      type="cite">
      <pre wrap="">Hi Martin,

On ma, 2014-10-13 at 15:56 +0100, Martin Townsend wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hi Jukka,

Does this patch help?
</pre>
      </blockquote>
      <pre wrap="">
Unfortunately no, I still see inconsistent lock state. It would probably
have been too easy :)

</pre>
      <blockquote type="cite">
        <pre wrap="">
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b6f9777..fb7b2ff 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5494,6 +5494,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (credits &gt; max_credits) {
 		BT_ERR("LE credits overflow");
 		l2cap_send_disconn_req(chan, ECONNRESET);
+		l2cap_chan_unlock(chan);
 
 		/* Return 0 so that we don't trigger an unnecessary
 		 * command reject packet.
</pre>
      </blockquote>
      <pre wrap="">

Cheers,
Jukka


</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------080103020102050105050405--
