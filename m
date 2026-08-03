Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A123783BB
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737984; cv=none; b=JBRPLTcjdXV7v5FT6F9tvZD3kaRQt52XsBaRjCyNPCICa4EfgGEwB7dMyoieLSzwaxlr8tb4FAkmisdqAr+fz4xFTxb6doLkee1XllG0CxEx7WqtlO/CdViNWB3Vpf3irR50QVIb9oYwuh3JpdQQHCxqZnCC2cOQLtmiTt/j1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737984; c=relaxed/simple;
	bh=Aj9Q8Hle+H2O8qZUoPh9+ToeRT9tto4AgTJ3plzxJFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOUZrEB913xlHituGEcmIKUIFDO5JJQE0jnxXttN2sNLixf21HWy4oFtZUm9SW43C5ylwu5zx9G6v0j+qbUw/D7ZROJu9nMCKAnZ2TGHq7W6JMAtJiYED0UUB7anhaosYUcgCtAE+MO0sHb6FEems4wM7tbGCXXUdafbpw22vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=X8ugUc7Y; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="X8ugUc7Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1785737977;
	bh=B8OlC1REksKCwaKrwMIUoGmHoV5WnP2cN3Fj51rJ51I=;
	h=From:Subject:Date:Message-ID;
	b=X8ugUc7YdJoJCsKqInkQ9WRM+4zgtMEtVoDM3PFUOnEDiZvxJpaaFryH48tKroQSa
	 kwMPQqwCKUn53QLuI6lZWqHfk0wIdw600CejDUs1ZQVsLYZ/RvSzr4J0OBA2N/7OY1
	 p9x7CqSt8UDqGKD0wfw92ImKyckvvhDQCsgGPVtk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.32) with ESMTP
	id 6A7031AD000019C8; Mon, 3 Aug 2026 14:14:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5049054457269
X-SMAIL-UIID: 623C63C234D54EF18A871F18DD244286-20260803-141408-1
From: Hillf Danton <hdanton@sina.com>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
Date: Mon,  3 Aug 2026 14:13:57 +0800
Message-ID: <a5db0837d52496b7b2c23072f5da036b82f1433d.1785672691.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260803061357.zp2wKy6cMMtGvZHkX5_m6M2SPbWsvlN0EZ6Wu6_LKDA@z>

On Sun,  2 Aug 2026 15:12:28 +0300 Pauli Virtanen wrote:
> For L2CAP sockets without owning sk->sk_socket, reading
> l2cap_pi(sk)->chan may race against concurrent l2cap_sock_kill() ->
> l2cap_sock_put_chan().  This excludes simultaneous proto_ops callbacks,
> but access in l2cap_sock_cleanup_listen() has unsafe lockless read.
> 
> Fix the race by taking lock_sock() in l2cap_sock_kill() to
> synchronize with l2cap_sock_cleanup_listen().  hold_unless_zero() is not
> needed here, l2cap_pi(sk)->chan owns reference if it is non-NULL.
> 
> Fixes: 0e2c0392b9dc ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()")
> Reported-by: syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e6382a2f53f5fc7453ac
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/l2cap.h |  5 +++++
>  net/bluetooth/l2cap_sock.c    | 23 +++++++++++++----------
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index ef6ce1c20a4f..3d9a32094347 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -699,7 +699,12 @@ struct l2cap_rx_busy {
>  
>  struct l2cap_pinfo {
>  	struct bt_sock		bt;
> +
> +	/* With owning sk_socket chan may be read without lock, other access
> +	 * should hold lock_sock.
> +	 */
>  	struct l2cap_chan	*chan;
> +
>  	struct list_head	rx_busy;
>  };
>  
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 735167f73f31..9540617a0e6c 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1312,7 +1312,12 @@ static void l2cap_sock_kill(struct sock *sk)
>  
>  	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
>  
> +	/* Take lock to synchronize against access without owning sk->sk_socket,
> +	 * eg. in l2cap_sock_cleanup_listen(). proto_ops etc. don't need lock.
> +	 */
> +	lock_sock(sk);
>  	l2cap_sock_put_chan(sk);
> +	release_sock(sk);
>  
>  	/* Kill poor orphan */
>  	sock_set_flag(sk, SOCK_DEAD);

In l2cap_sock_teardown_cb(), sock is only zapped after cleanup including unlink,
so why do you see a linked and zapped sock in l2cap_sock_cleanup_listen()?

> @@ -1516,14 +1521,10 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
>  	 * establish sk_lock -> conn->lock and invert the established
>  	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
>  	 *
> -	 * Instead, briefly take the child sk lock to fetch and pin its chan.
> -	 * l2cap_conn_del() reaches the chan free only via
> -	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
> -	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
> -	 * therefore guarantees the chan cannot be freed while we read and
> -	 * pin it (hold_unless_zero() additionally skips a chan already past
> -	 * its last reference).  We then drop the sk lock before taking
> -	 * chan->lock, so sk and chan locks are never held together.
> +	 * Instead, briefly take the child sk lock to synchronize vs.
> +	 * l2cap_sock_kill that puts l2cap_pi(sk)->chan. We then drop the sk
> +	 * lock before taking chan->lock, so sk and chan locks are never held
> +	 * together.
>  	 *
>  	 * Since we cannot call l2cap_chan_close() without conn->lock,
>  	 * schedule l2cap_chan_timeout to close the channel; it already
> @@ -1533,10 +1534,12 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
>  		struct l2cap_chan *chan;
>  
>  		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
> -		chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
> +		chan = l2cap_pi(sk)->chan;
> +		if (chan)
> +			l2cap_chan_hold(chan);
>  		release_sock(sk);
>  		if (!chan) {
> -			/* l2cap_conn_del() already tearing this child down */
> +			/* Already torn down */
>  			sock_put(sk);
>  			continue;
>  		}
> -- 
> 2.55.0
