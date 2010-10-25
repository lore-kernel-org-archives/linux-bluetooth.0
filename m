Return-Path: <cyrus@holtmann.org>
Message-ID: <4CC576D3.2090304@nokia.com>
Date: Mon, 25 Oct 2010 16:23:47 +0400
From: Yuri Ershov <ext-yuri.ershov@nokia.com>
MIME-Version: 1.0
To: "ext Gustavo F. Padovan" <padovan@profusion.mobi>
CC: marcel@holtmann.org, davem@davemloft.net, jprvita@profusion.mobi,
        linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
        andrei.emeltchenko@nokia.com
Subject: Re: [PATCH] bluetooth: Fix NULL pointer dereference issue
References: <1987fd374e92ea2e4ebb06b24c6321e65ab933c6.1287676475.git.ext-yuri.ershov@nokia.com> <20101022135859.GA15476@vigoh>
In-Reply-To: <20101022135859.GA15476@vigoh>
Content-Type: multipart/alternative;
 boundary="------------010808070600010908000003"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010808070600010908000003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Gustavo,

The problem appears in case of multiple connect-transfer-disconnect 
sequence (e.g. by using l2test). The conditions are the following:
There are 2 BT devices. The first one listens and receives (l2test -r), 
the second one makes "connect-disconnect-connect..." sequence (l2test -c 
-b 1000 -i hci0 -P 10 <addr>). After some time this will cause the race 
between functions bt_accept_dequeue and l2cap_chan_del. The fail sequence:

struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
{
...
    list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
        sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);

        lock_sock(sk);



In this time the function l2cap_chan_del sets the socket state to 
BT_CLOSED, unlinks and kills the socket.



        /* FIXME: Is this check still needed */
        if (sk->sk_state == BT_CLOSED) {
            release_sock(sk);
            bt_accept_unlink(sk);
            continue;
        }

...

        release_sock(sk);
    }
    return NULL;
}
 

Regards,
Yuri



ext Gustavo F. Padovan wrote:
> Hi Yuri,
>
> * Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-10-21 20:08:58 +0400]:
>
>   
>> This patch fixes NULL pointer dereference at running test with
>> connect-transfer-disconnect in loop. Sometimes sk_state is 
>> BT_CLOSED and sk_refcnt equal to 0, so there is oops in 
>> bt_accept_unlink. In normal case removed block is not used.
>>     
>
> Question here is: Why sk_refcnt is 0 at that point of the code?  The
> socket should be destroyed if it ref is 0, but it wasn't, so something
> in another point of the code went is wrong. "Sometimes" is not a good
> description of the problem, you have to show why that happened.
>
>   


--------------010808070600010908000003
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hello Gustavo,<br>
<br>
The problem appears in case of multiple connect-transfer-disconnect
sequence (e.g. by using l2test). The conditions are the following:<br>
There are 2 BT devices. The first one listens and receives (l2test -r),
the second one makes "connect-disconnect-connect..." sequence (l2test
-c -b 1000 -i hci0 -P 10 &lt;addr&gt;). After some time this will cause
the race between functions bt_accept_dequeue and l2cap_chan_del. The
fail sequence:<br>
<br>
struct sock *bt_accept_dequeue(struct sock *parent, struct socket
*newsock)<br>
{<br>
...<br>
&nbsp;&nbsp;&nbsp; list_for_each_safe(p, n, &amp;bt_sk(parent)-&gt;accept_q) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;lock_sock(sk);<br>
<br>
<br>
<br>
In this time the function l2cap_chan_del sets the socket state to
BT_CLOSED, unlinks and kills the socket. <br>
<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;/* FIXME: Is this check still needed */<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;if (sk-&gt;sk_state == BT_CLOSED) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;release_sock(sk);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;bt_accept_unlink(sk);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;continue;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;}<br>
<br>
...<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; release_sock(sk);<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; return NULL;<br>
} <br>
&nbsp;<br>
<br>
Regards,<br>
Yuri<br>
<br>
<br>
<br>
ext Gustavo F. Padovan wrote:
<blockquote cite="mid:20101022135859.GA15476@vigoh" type="cite">
  <pre wrap="">Hi Yuri,

* Yuri Ershov <a class="moz-txt-link-rfc2396E" href="mailto:ext-yuri.ershov@nokia.com">&lt;ext-yuri.ershov@nokia.com&gt;</a> [2010-10-21 20:08:58 +0400]:

  </pre>
  <blockquote type="cite">
    <pre wrap="">This patch fixes NULL pointer dereference at running test with
connect-transfer-disconnect in loop. Sometimes sk_state is 
BT_CLOSED and sk_refcnt equal to 0, so there is oops in 
bt_accept_unlink. In normal case removed block is not used.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Question here is: Why sk_refcnt is 0 at that point of the code?  The
socket should be destroyed if it ref is 0, but it wasn't, so something
in another point of the code went is wrong. "Sometimes" is not a good
description of the problem, you have to show why that happened.

  </pre>
</blockquote>
<br>
</body>
</html>

--------------010808070600010908000003--
