Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED2153833
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804372; cv=pass; b=fU02FS+TPtElOEuXfo8xYAtnn3sgTMsxqyKvvfapDZdWo/+Y2rUZBdsUt1NNP68oWQAt5ALJKQZd4DsmK+24IG+Z9CzvwmiG9Mb0jeGhPghAmQ0QGSSSTkBVnD+xhysH2APzBim3zvOoZeo2bEhElh7f9SRMVnNZMsvXQ70OkiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804372; c=relaxed/simple;
	bh=PeMeJWhiQHNfNxOtFNBcFqKq2ExvzrX74XgGETTvgkI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ur++ngzAIwyMMkzlbxCevSLxGJyeuqjW4e0sT7W3+dfi/i90KcXydehNdCRXDs4jUPjEfviRuM12aFsqPXo/+evSJyKQeyAXSkKGdN2VpPOLWaJRRZyKlflpfgtqy8acLMMm3Z1bury7uJBZdi1+0oW2Kwh6WqEaHJu5LTCYQNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=hYAaWMnM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="hYAaWMnM"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VNWNG3SqYz49PsS;
	Mon, 22 Apr 2024 19:46:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1713804367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZECcpTwzYvji0cUCh+TpaT5i0mZiW7hq1MhxO3brLCE=;
	b=hYAaWMnMfosHL6wR4+AwZaJEMTZGGTcT9V+8SmnmOvZ6dq/5nlsUm0/gYolL8BAMM/bSI+
	65XMZy6VXfPy0GCpbUz6yaev0Z7P7d/VSHtbuQzcp4ZWhSRu0Axq94vwTmj9EZzopJDona
	71W4DmgWsxLS7yKfEvA4sgZSqgLqhHHs9uWc0E8bycu9WaQJs+/k8ZGvsk5R2Q09rgirvX
	LY9dkvnlYV90EtIct4dpMEHYlqhjGUwh2oGjVGMNkrt26vTVxKq902PNiXxf/VvfhquhdM
	oxypm1W+mXfXeLD6KyQ0HsffuJSZTo/npWe9BjWYs4clWQfbAKZv1EZdAXKSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1713804367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZECcpTwzYvji0cUCh+TpaT5i0mZiW7hq1MhxO3brLCE=;
	b=hXKL/EuhffuLuw7iKejxs5oTVTzMAXSLu9YGFZkcHrEdI1D7lV7r+fjPpT5RC+YGNUGHrI
	NDcDpKmV8WO9GNDAqhCLDcEr19owRl/Br8jMW53E+l38adJD/OV2Bpp7Yhp/hnLO+530oB
	I340RrN3n5O2komdUl7Wpi6RcSRmpGIpmzKs73jnMzyt4yigjRpwixqbLox0fKGbgr/Vjj
	npZLS7NpIPc13wwvrdFq0Jpv2mFndCjU5hhUJcnq85VoNye04q8U4de4C3YZ3eJq5AzRCq
	BtQQNRMshecXvfKcEyQmpMJFoATmHhF+B6bTOOjGtmiUyjHNpITd9ak3TbU3Qg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1713804367; a=rsa-sha256;
	cv=none;
	b=I5HHKS5vu9GIIyiZdvQ6HjHvN+HgeoxdeSDlMPch7oJVNyJi1U2/TUPGF0+Ns5LpONZ8oE
	ikalLRoRhwG71NnyrMhhYvWSjp8GVIZdxxFcbpN3im8Vu1z57uDdD8eN1ISn9d4A/J+xdH
	YkjcQZcdk8QP+x/CWZ9XWWMONcpsWyNXtokFRMT1m+bkF2EExabRPzirxNpmPBO6h6BAUQ
	TruRUlMqGceZHd26E0USHgCOP5v6Y9uwNBGoUdIS96/xEKxgKsLpF7gDNcQvLxp39qiWff
	whROEuRGniNCwOmD0Rawup6znjuNjXR3aSPnBmxlSo0EL/l7ZigQT8BBWM2pvQ==
Message-ID: <a0f4a248a25ee54259249cf0e00214e14f99d52d.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 2/2] client/player: Fix using unicast QoS for
 broadcast
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Mon, 22 Apr 2024 19:46:03 +0300
In-Reply-To: <20240419202341.1635591-2-luiz.dentz@gmail.com>
References: <20240419202341.1635591-1-luiz.dentz@gmail.com>
	 <20240419202341.1635591-2-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2024-04-19 kello 16:23 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> The code needs to identify first if the parameters refers to a broadcast
> stream or unicast.
> ---
>  client/player.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>=20
> diff --git a/client/player.c b/client/player.c
> index 65f771039258..6b70e9ed3f9d 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -34,6 +34,7 @@
> =20
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
> +#include "lib/iso.h"
> =20
>  #include "profiles/audio/a2dp-codecs.h"
>  #include "src/shared/lc3.h"
> @@ -143,6 +144,7 @@ struct transport {
>  	struct io *io;
>  	uint32_t seq;
>  	struct io *timer_io;
> +	int num;
>  };
> =20
>  static void endpoint_unregister(void *data)
> @@ -5008,7 +5010,6 @@ static bool transport_timer_read(struct io *io, voi=
d *user_data)
>  	struct bt_iso_qos qos;
>  	socklen_t len;
>  	int ret, fd;
> -	uint32_t num;
>  	uint64_t exp;
> =20
>  	if (transport->fd < 0)
> @@ -5032,11 +5033,7 @@ static bool transport_timer_read(struct io *io, vo=
id *user_data)
>  		return false;
>  	}
> =20
> -	/* num of packets =3D ROUND_CLOSEST(latency (ms) / interval (us)) */
> -	num =3D ROUND_CLOSEST(qos.ucast.out.latency * 1000,
> -				qos.ucast.out.interval);
> -
> -	ret =3D transport_send_seq(transport, transport->fd, num);
> +	ret =3D transport_send_seq(transport, transport->fd, transport->num);
>  	if (ret < 0) {
>  		bt_shell_printf("Unable to send: %s (%d)\n",
>  					strerror(-ret), ret);
> @@ -5052,7 +5049,7 @@ static bool transport_timer_read(struct io *io, voi=
d *user_data)
>  }
> =20
>  static int transport_send(struct transport *transport, int fd,
> -					struct bt_iso_qos *qos)
> +					struct bt_iso_io_qos *qos)
>  {
>  	struct itimerspec ts;
>  	int timer_fd;
> @@ -5070,14 +5067,15 @@ static int transport_send(struct transport *trans=
port, int fd,
>  		return -errno;
> =20
>  	memset(&ts, 0, sizeof(ts));
> -	ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> -	ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 1000000;
> +	ts.it_value.tv_nsec =3D qos->latency * 1000000;
> +	ts.it_interval.tv_nsec =3D qos->latency * 1000000;
> =20
>  	if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
>  		return -errno;
> =20
>  	transport->fd =3D fd;
> -
> +	/* num of packets =3D ROUND_CLOSEST(latency (ms) / interval (us)) */
> +	transport->num =3D ROUND_CLOSEST(qos->latency * 1000, qos->interval);
>  	transport->timer_io =3D io_new(timer_fd);

This probably=C2=A0is intended to be writing at the average rate of one SDU
per SDU_Interval, so probably should be:

	transport->num =3D ...;

	ts.it_value.tv_nsec =3D transport->num * qos->interval * 1000;
	ts.it_interval.tv_nsec =3D transport->num * qos->interval * 1000;

Sorry for late comment.

> =20
>  	io_set_read_handler(transport->timer_io, transport_timer_read,
> @@ -5131,8 +5129,20 @@ static void cmd_send_transport(int argc, char *arg=
v[])
>  			bt_shell_printf("Unable to getsockopt(BT_ISO_QOS): %s",
>  							strerror(errno));
>  			err =3D transport_send(transport, fd, NULL);
> -		} else
> -			err =3D transport_send(transport, fd, &qos);
> +		} else {
> +			struct sockaddr_iso addr;
> +			socklen_t optlen;
> +
> +			err =3D getpeername(transport->sk, &addr, &optlen);
> +			if (!err) {
> +				if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY)))
> +					err =3D transport_send(transport, fd,
> +							     &qos.bcast.out);
> +				else
> +					err =3D transport_send(transport, fd,
> +							     &qos.ucast.out);
> +			}
> +		}
> =20
>  		if (err < 0) {
>  			bt_shell_printf("Unable to send: %s (%d)",

