Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   kernel-janitors@lists.osdl.org
In-Reply-To: <20050121190909.GD3340@us.ibm.com>
References: <20050120235123.GG2600@us.ibm.com>
	 <1106267534.7955.36.camel@pegasus>  <20050121190909.GD3340@us.ibm.com>
Content-Type: text/plain
Message-Id: <1106416648.8118.3.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [UPDATE PATCH 18/39] net/core: use wait_event_timeout()
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 22 Jan 2005 18:57:28 +0100

Hi Nishanth,

> Description: Use wait_event_timeout() instead of custom wait-queue code.
> The current code uses TASK_INTERRUPTIBLE but only cares about timing out and the
> wq event taking place (does not actively do anything in response to signals), so
> wait_event_timeout() should be ok.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> 
> --- 2.6.11-rc1-kj-v/net/bluetooth/hidp/core.c	2005-01-15 16:55:44.000000000 -0800
> +++ 2.6.11-rc1-kj/net/bluetooth/hidp/core.c	2005-01-21 11:07:11.000000000 -0800
> @@ -36,6 +36,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/file.h>
>  #include <linux/init.h>
> +#include <linux/wait.h>
>  #include <net/sock.h>
>  
>  #include <linux/input.h>
> @@ -325,7 +326,6 @@ static int hidp_session(void *arg)
>  	struct sk_buff *skb;
>  	int vendor = 0x0000, product = 0x0000;
>  	wait_queue_t ctrl_wait, intr_wait;
> -	unsigned long timeo = HZ;
>  
>  	BT_DBG("session %p", session);
>  
> @@ -370,28 +370,14 @@ static int hidp_session(void *arg)
>  
>  	hidp_del_timer(session);
>  
> -	if (intr_sk->sk_state != BT_CONNECTED) {
> -		init_waitqueue_entry(&ctrl_wait, current);
> -		add_wait_queue(ctrl_sk->sk_sleep, &ctrl_wait);
> -		while (timeo && ctrl_sk->sk_state != BT_CLOSED) {
> -			set_current_state(TASK_INTERRUPTIBLE);
> -			timeo = schedule_timeout(timeo);
> -		}
> -		set_current_state(TASK_RUNNING);
> -		remove_wait_queue(ctrl_sk->sk_sleep, &ctrl_wait);
> -		timeo = HZ;
> -	}
> +	if (intr_sk->sk_state != BT_CONNECTED)
> +		wait_event_timeout(*(ctrl_sk->sk_sleep),
> +				(ctrl_sk->sk_state == BT_CLOSED), HZ);

and this does not make it look better. For me this is too much pointer
stuff here. I think the interface of wait_event_timeout() is wrong. It
should take a pointer to wait_queue_head_t.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
