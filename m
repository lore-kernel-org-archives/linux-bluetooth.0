Return-Path: <SRS0=NoyY=YH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040A5C4CECE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 10:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF0F2084B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 10:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="AY93KN0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfJNKPf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:15:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40020 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbfJNKPf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Oct 2019 06:15:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so16040415ljw.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2019 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3INgyaKWPjZBty9lV+1mTdUe1+dH6YK0zgr3wXWgOjE=;
        b=AY93KN0Zh/Bd7gaMIS0x3ZHvVGRbI5iCC3vF4kN3mXyeKrG/073cuVsDWctonoVPB8
         W+XLWwCUEmXeHCATARQY5ZSd0v0eO6c2D91bQJMzA92QYQdvv0+UTlT6CQN5+eA6xX0V
         c8K6m+XRPfysFkBLPb80P62q4V8nkb0a8/IkShc50cDikRiSLSk2FdYFwEzaw7GPXVbU
         ICp5c6DRU5SgSzYEPAam5/xMn0xCekGJsFqBoy7PjhVBifcZIB83OUe0N9VeDG1BIe9y
         eEk+xu6k21UCFuSE/HwB8LDbXSVl/HcPeHtLJmF1ryNKK5n0sJlmRH/PfocI2HeMRYAh
         FzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3INgyaKWPjZBty9lV+1mTdUe1+dH6YK0zgr3wXWgOjE=;
        b=RDnHBLy7FQeP/YOCqsmz4Q6ahBAqKAYSGfwDytCXaxjuxG7F57YIlOTcF+g79kvOyE
         d5Xc8AWFEqSI3hcrAi3/Y6r3hEvv7JU8Vw8cRn/UKeigyjLS9IQnOo5JBimHkb52xETV
         S9K51/tri2doWdVREbYXf9Uf2MEtY7mL42TfXB9o8Zh9AnIHJYgpdnhvcA8g/63BtZiA
         V1MHRXk+uDCOOfmKNwDY+2jtO6jahTbIvnrAkCqVQAWJZZAlqmPO4wTZQ9ZaIUCtcwRp
         MmqqlKaQIlLkZRvqkM5IEfQft4d9t4PLWCSHZYrtQCLzg7D7phsUOCr2ggsix/IKqxWq
         vgcg==
X-Gm-Message-State: APjAAAUGagKh5OxB6Y/4ovHusQVk+3P3VUsyqMCSHGyyz5a9FmnaUwXy
        ZsSSyBPtZf/zwVDmJPUeES5nwMY8Fl8=
X-Google-Smtp-Source: APXvYqyZSemRr+WPlUjWVviliOgVI9u3gFOytlNWLSExTSem8kCSHKumNvNQ60qfsIBDTTu4QhgG9w==
X-Received: by 2002:a2e:286:: with SMTP id y6mr18703765lje.184.1571048132746;
        Mon, 14 Oct 2019 03:15:32 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id i6sm4082323lfc.37.2019.10.14.03.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 03:15:32 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: Re: [PATCH V3 1/3] monitor: Extract TTY data processing to separate function
Date:   Mon, 14 Oct 2019 12:15:30 +0200
Message-ID: <1584729.7OtKVoQiSF@ix>
Organization: CODECOUP
In-Reply-To: <20191004054334.5479-1-szymon.janc@codecoup.pl>
References: <20191004054334.5479-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday, 4 October 2019 07:43:32 CEST Szymon Janc wrote:
> From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
> 
> ---
>  monitor/control.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/monitor/control.c b/monitor/control.c
> index 39a413be1..4022e7644 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -1300,23 +1300,8 @@ static bool tty_parse_header(uint8_t *hdr, uint8_t
> len, struct timeval **tv, return true;
>  }
> 
> -static void tty_callback(int fd, uint32_t events, void *user_data)
> +static void process_data(struct control_data *data)
>  {
> -	struct control_data *data = user_data;
> -	ssize_t len;
> -
> -	if (events & (EPOLLERR | EPOLLHUP)) {
> -		mainloop_remove_fd(data->fd);
> -		return;
> -	}
> -
> -	len = read(data->fd, data->buf + data->offset,
> -					sizeof(data->buf) - data-
>offset);
> -	if (len < 0)
> -		return;
> -
> -	data->offset += len;
> -
>  	while (data->offset >= sizeof(struct tty_hdr)) {
>  		struct tty_hdr *hdr = (struct tty_hdr *) data->buf;
>  		uint16_t pktlen, opcode, data_len;
> @@ -1358,6 +1343,26 @@ static void tty_callback(int fd, uint32_t events,
> void *user_data) }
>  }
> 
> +static void tty_callback(int fd, uint32_t events, void *user_data)
> +{
> +	struct control_data *data = user_data;
> +	ssize_t len;
> +
> +	if (events & (EPOLLERR | EPOLLHUP)) {
> +		mainloop_remove_fd(data->fd);
> +		return;
> +	}
> +
> +	len = read(data->fd, data->buf + data->offset,
> +					sizeof(data->buf) - data-
>offset);
> +	if (len < 0)
> +		return;
> +
> +	data->offset += len;
> +
> +	process_data(data);
> +}
> +
>  int control_tty(const char *path, unsigned int speed)
>  {
>  	struct control_data *data;


Applied.

-- 
pozdrawiam
Szymon Janc


