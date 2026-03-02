Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D434400
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441968; cv=pass; b=pgmUAaw1jsEobrf7SgzaMbKeaHl2U9OO+ZQ2UTswg9o7xEhFtIwEby11xGFXxynklNC4woKbFR2iboNxk6YmNem4tovLPx5hiKep6PoQmgFddX2rz2kHTxekPJmloH4u0GJl82je8rvqCxlz10P4GxS1dBtzKy6+reE6DzUbPVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441968; c=relaxed/simple;
	bh=zi4DOjyoyF5lY+aNb2OyALrGOjjnU4JXSLJM9x5SCAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KJB8YDoiiR0pNO1NRhowVZtRkl/wwXPkT+RP90HCdU9+dlzxhD4xITmlJ+87ZRfoW61wOqA1cJ0lVrCgsdhWBqoVRkg4tFXUwDOD9+u+hTA+A0HxW2jseE82RFXK9r3nnL0mm2JQOQFpi/i4SUr1Rxi58C5nICReUKm/ODT4xL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=YeZY3WLK; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="YeZY3WLK"
ARC-Seal: i=1; a=rsa-sha256; t=1772441957; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HzUNTkbSGjkwoHfdOz+ug/fHTwOFzJ5StcjnvO+lNQNRExfgPZpgJVYMYEoV7S1PfU3fR5iaiXvGexW1YSbWPk7OyIUJNCMI39vRaxbosFti/csLfOfDXuoZKhE71zmqhjUdKFWnEyEQqbGe9dbAC2VJxpcWV8PpyU0zmdcTvBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772441957; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=LvsMTlR4wV9U9dFXYfIa6HilqrqXnwVpVIX83+SLlTo=; 
	b=b6LX2Wmv1fMhmTXKfdCpGxyWyjjdwohFWcaUouuhcmdyF0UaKTtyC8G9KXHrIdk9iiYv+YnsvYbvkxR33BLRJA6hnsKoBZXvky6A+xokmLRNpwmB0lC3y0hOTP+Dzww3fB9RthmyEg5N/sEyOueaBokkg/GRl6/JlGC8cqhwtZw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772441957;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=LvsMTlR4wV9U9dFXYfIa6HilqrqXnwVpVIX83+SLlTo=;
	b=YeZY3WLKhoGdvNBZmHwNxyk5j1RSvI7baI+xu2vqblia5p52XAROYxfhqvnJTsIG
	+JrwbqmrXr5bOJZm/mAqaBrxv/pt9TmIiG58jcuqGukuaCCOiiJVTlfiycYD193WBEw
	q2orTucsFxYzzjxMOyAzcO/lj1WiTzxjJJWS7KQU=
Received: by mx.zohomail.com with SMTPS id 1772441956522806.4368851358208;
	Mon, 2 Mar 2026 00:59:16 -0800 (PST)
Message-ID: <55e57a6e-f4a1-4c76-b9b6-cc8883afeaa5@collabora.com>
Date: Mon, 2 Mar 2026 09:59:14 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 12/15] doc/qualification: gatt-pts: update
 description for GATT/SR/GAI/BV-01-C
To: Christian Eggers <ceggers@arri.de>, linux-bluetooth@vger.kernel.org
References: <20260227160022.21462-1-ceggers@arri.de>
 <20260227160022.21462-13-ceggers@arri.de>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20260227160022.21462-13-ceggers@arri.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Christian,

On 27/02/2026 16:53, Christian Eggers wrote:
> This tests requires an indication on the "Service Changed"
> characteristic of the builtin "GATT" service. This indication can be
> raised by adding (or removing) a custom service. Of course we have to do
> this at the point when PTS is expecting to revice the notification.
>
> https://lore.kernel.org/linux-bluetooth/CABBYNZ+O6KbjXoxTKSaPnSd=p2CDJ7j6cBktPT4xXD=PR0CBhA@mail.gmail.com/
> ---
>   doc/qualification/gatt-pts.rst | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
> index e9acba7e7cd0..3959e70ab73d 100644
> --- a/doc/qualification/gatt-pts.rst
> +++ b/doc/qualification/gatt-pts.rst
> @@ -1158,6 +1158,8 @@ for which we know the test passed.
>   +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
>   | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
>   |                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# advertise on                                             |
> +|                        |          |         |       |                                                                         |
>   |                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
>   |                        |          |         |       |                                                                         |
>   |                        |          |         |       |   - *yes* when asked if primary service                                 |
> @@ -1166,6 +1168,8 @@ for which we know the test passed.
>   |                        |          |         |       |                                                                         |
>   |                        |          |         |       |   - enter '1' when prompted                                             |
>   |                        |          |         |       |                                                                         |
> +|                        |          |         |       | - Wait until PTS prompts for sending an indication                      |

Instead of "- Wait until PTS prompts for sending a notification" you may 
be use "On PTS request to send a notification:"

> +|                        |          |         |       |                                                                         |
>   |                        |          |         |       | - [bluetooth]# gatt.register-application                                |
>   +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
>   | GATT/SR/GAS/BV-01-C    | PASS     |     6.1 | 5.69  | In a first terminal run 'bluetoothctl':                                 |

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


