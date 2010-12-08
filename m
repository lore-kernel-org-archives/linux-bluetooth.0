Return-Path: <cyrus@holtmann.org>
Message-ID: <4CFF6359.7000305@nokia.com>
Date: Wed, 08 Dec 2010 13:52:09 +0300
From: Yuri Ershov <ext-yuri.ershov@nokia.com>
MIME-Version: 1.0
To: "ext Gustavo F. Padovan" <padovan@profusion.mobi>
CC: marcel@holtmann.org, davem@davemloft.net, jprvita@profusion.mobi,
        ville.tervo@nokia.com, andrei.emeltchenko@nokia.com,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] bluetooth: Fix NULL pointer dereference issue
References: <e98b2c6fd02b11300d82577cb54cfdb63e8400d2.1290678703.git.ext-yuri.ershov@nokia.com> <20101206211516.GH883@vigoh> <4CFE32A0.6090601@nokia.com> <20101207155037.GA2944@vigoh>
In-Reply-To: <20101207155037.GA2944@vigoh>
Content-Type: multipart/alternative;
 boundary="------------060506080804030505040308"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060506080804030505040308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gustavo,

ext Gustavo F. Padovan wrote:
> Hi Yuri,
>
> * Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-12-07 16:12:00 +0300]:
>
>   
>> Hello Gustavo,
>>
>> ext Gustavo F. Padovan wrote:
>>     
>>> Hi Yuri,
>>>
>>> * Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-11-25 12:55:33 +0300]:
>>>
>>>   
>>>       
>>>> This patch is an addition to my previous patch for this issue.
>>>> The problem is in resynchronization between two loops:
>>>> 1. Main controlling loop (l2cap_connect_req, l2cap_config_req,
>>>> l2cap_config_rsp, l2cap_disconnect_req, etc.)
>>>> 2. Loop waiting of BT_CONNECTED state of socket (l2cap_sock_accept,
>>>> bt_accept_dequeue, etc.).
>>>> In case of fast sequence of connect/disconnect operations the loop #1
>>>> makes several cycles, while the loop #2 only has time to make one
>>>> cycle and it results crash.
>>>> The aim of the patch is to skeep handling of sockets queued for
>>>> deletion.
>>>>
>>>> Signed-off-by: Yuri Ershov <ext-yuri.ershov@nokia.com>
>>>> ---
>>>>  net/bluetooth/af_bluetooth.c |    2 ++
>>>>  net/bluetooth/l2cap.c        |    6 ++++--
>>>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>>>> index c4cf3f5..f9389da 100644
>>>> --- a/net/bluetooth/af_bluetooth.c
>>>> +++ b/net/bluetooth/af_bluetooth.c
>>>> @@ -200,6 +200,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
>>>>  	BT_DBG("parent %p", parent);
>>>>  
>>>>  	list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
>>>> +		if (n == p)
>>>> +			break;
>>>>     
>>>>         
>>> So in which situations (n == p), or (p == p->next)? That should happen only
>>> when p is the only element in the list, then p == head, right?
>>>   
>>>       
>> The (n == p) is in situation, when sk is unlinked by task responsible 
>> for handling connect/disconnect requests while the "bt_accept_dequeue". 
>> This condition is indirect checking of sk validity.
>>     
>
> Why not using a list lock here instead? Fits a way better.
>
>   
Yes, it's better. I tried to use the locks in this function, but it 
slows down the task handling connect/disconnect/etc. events and the task 
skips some events from fast clients.


--------------060506080804030505040308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Gustavo,<br>
<br>
ext Gustavo F. Padovan wrote:
<blockquote cite="mid:20101207155037.GA2944@vigoh" type="cite">
  <pre wrap="">Hi Yuri,

* Yuri Ershov <a class="moz-txt-link-rfc2396E" href="mailto:ext-yuri.ershov@nokia.com">&lt;ext-yuri.ershov@nokia.com&gt;</a> [2010-12-07 16:12:00 +0300]:

  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello Gustavo,

ext Gustavo F. Padovan wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Hi Yuri,

* Yuri Ershov <a class="moz-txt-link-rfc2396E" href="mailto:ext-yuri.ershov@nokia.com">&lt;ext-yuri.ershov@nokia.com&gt;</a> [2010-11-25 12:55:33 +0300]:

  
      </pre>
      <blockquote type="cite">
        <pre wrap="">This patch is an addition to my previous patch for this issue.
The problem is in resynchronization between two loops:
1. Main controlling loop (l2cap_connect_req, l2cap_config_req,
l2cap_config_rsp, l2cap_disconnect_req, etc.)
2. Loop waiting of BT_CONNECTED state of socket (l2cap_sock_accept,
bt_accept_dequeue, etc.).
In case of fast sequence of connect/disconnect operations the loop #1
makes several cycles, while the loop #2 only has time to make one
cycle and it results crash.
The aim of the patch is to skeep handling of sockets queued for
deletion.

Signed-off-by: Yuri Ershov <a class="moz-txt-link-rfc2396E" href="mailto:ext-yuri.ershov@nokia.com">&lt;ext-yuri.ershov@nokia.com&gt;</a>
---
 net/bluetooth/af_bluetooth.c |    2 ++
 net/bluetooth/l2cap.c        |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index c4cf3f5..f9389da 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -200,6 +200,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 	BT_DBG("parent %p", parent);
 
 	list_for_each_safe(p, n, &amp;bt_sk(parent)-&gt;accept_q) {
+		if (n == p)
+			break;
    
        </pre>
      </blockquote>
      <pre wrap="">So in which situations (n == p), or (p == p-&gt;next)? That should happen only
when p is the only element in the list, then p == head, right?
  
      </pre>
    </blockquote>
    <pre wrap="">The (n == p) is in situation, when sk is unlinked by task responsible 
for handling connect/disconnect requests while the "bt_accept_dequeue". 
This condition is indirect checking of sk validity.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Why not using a list lock here instead? Fits a way better.

  </pre>
</blockquote>
Yes, it's better. I tried to use the locks in this function, but it
slows down the task handling connect/disconnect/etc. events and the
task skips some events from fast clients. <br>
<br>
</body>
</html>

--------------060506080804030505040308--
