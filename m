Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213C372B27
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470742; cv=none; b=FhWldtFRmbI1TE2SveaT7yQOSvzqSIb8CTPNlyEACyoh6uaosQ+NVANkESqUgs+jcf0DRLSxOjPI9m1Gwv8lnJKCyRHJFb6wXOaQ7nwuFCX/aUO+j8i9TpGVq392EPAH83lBNh8qO78jqyZXZOLBfswdYSJUpLXpEAyJHkof6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470742; c=relaxed/simple;
	bh=RLC7IJS7hYux7gIIMvCrsNe0rDzJBcoKqFC5xfNXs+4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twAM6WFnmSFRsJHSfEE46qeL0k98C+QmibUmUBNOtBcHT2YfP4oUQyYSqY/clafUMMHtz4I9U8hAMPMc/z5C/7MQlKUVhJP6YP5wkgpD2edkSQMw/z1iAaHZyZSR64xzx56L836EXX0sp7uvHV18F6zNw5GYBf+S+62oJ01NTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97C253EE81;
	Thu,  3 Sep 2026 21:25:36 +0000 (UTC)
Message-ID: <3b83e066595615a41b14a063027e810b1e3fbd34.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] btattach: Update for glibc 2.42 compatability
From: Bastien Nocera <hadess@hadess.net>
To: Aaron Brice <aaron@embeddedts.com>, linux-bluetooth@vger.kernel.org
Date: Thu, 03 Sep 2026 23:25:36 +0200
In-Reply-To: <20260903182709.473976-2-aaron@embeddedts.com>
References: <20260903182709.473976-1-aaron@embeddedts.com>
	 <20260903182709.473976-2-aaron@embeddedts.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEMWv8f+Fr93SvE8+OuYChviTJHVz/izN00ogoV6HQ8zu3NAHCzdPaWpH1GOtGlBd2kHffDLaMD6V7E/zk/wjwWWOhjCfnG8nqHTdlGZVVwuzqQrFDsC90jilgFTIF1XREYnUuP0LK+ENrHgMv/44rWIEw1y8gp9GumRB7D8mjEd7EpU2Eaoqcj8zs4d22pLeM1h2VO4bSuTHAAF6YblwOw4UxrPuhEyVbCTIHhBedAzUAlJozR+cFTlonUcb/QNJ7asTiMvsRbEOrLONe+A1Axqg6R8gGPa7zJtNnuaeBBChzWXycLS3WQ6BV++Ar0fZ09kryGpJJxFJe8EB3gpRrpiw68ZwkSals/MpX65Lv1I5p5uvj52KhiIjH8uFyJ/w5uREPa4hEscb0QO1M3ekuQZc0uCRmiFW45gM4B0AH6URIJ3zDuJQBayETqANJCwqchvNTuqVgZ+0ky1OO0/87ITw6hYH7yyFIGUhRPzxsc4u8w4SIceuCjuWFT7JEaU3zdfINPppgmT60ZvxYuNScQQdt6J5eNlqQsbl0aiPg0OXA2VUggU4Q6RcSy4h0hUkdpZXwojnoIzFB5YPpVFz0f81Rnf9R/vYLdD1WprGDAn6yjCh9lN0VvdylNPzxSjkjSMkpG6WGFw+WjnVhHYGl8Hqv4LjLfJe5gGnNKu+6kgg
X-GND-State: clean
X-GND-Score: -100

Subject should be "compatibility" (3 "i"s)

On Thu, 2026-09-03 at 11:27 -0700, Aaron Brice wrote:
> glibc 2.42 baud rate constants changed, use cfsetspeed to be
> compatible
> with newer glibc.
> ---
> =C2=A0tools/btattach.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/btattach.c b/tools/btattach.c
> index 5f7d19093..cdd7b125b 100644
> --- a/tools/btattach.c
> +++ b/tools/btattach.c
> @@ -64,7 +64,12 @@ static int open_serial(const char *path, unsigned
> int speed, bool flowctl)
> =C2=A0	memset(&ti, 0, sizeof(ti));
> =C2=A0	cfmakeraw(&ti);
> =C2=A0
> -	ti.c_cflag |=3D (speed | CLOCAL | CREAD);
> +	ti.c_cflag |=3D (CLOCAL | CREAD);
> +	if (cfsetspeed(&ti, speed) < 0) {
> +		perror("Failed to set serial port speed");
> +		close(fd);
> +		return -1;
> +	}
> =C2=A0
> =C2=A0	if (flowctl) {
> =C2=A0		/* Set flow control */
