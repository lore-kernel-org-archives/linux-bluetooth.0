Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309125366-29016-2-git-send-email-syamsidhardh@gmail.com>
References: <1309125366-29016-1-git-send-email-syamsidhardh@gmail.com>
	<1309125366-29016-2-git-send-email-syamsidhardh@gmail.com>
Date: Mon, 27 Jun 2011 10:05:31 +0200
Message-ID: <BANLkTimXxwQHSdjFHYYt-Dw3+dRaMbDKQg@mail.gmail.com>
Subject: Re: [PATCH obexd 2/3] Fix white space related coding style issues for gwobex
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jun 26, 2011 at 11:56 PM, Syam Sidhardhan
<syamsidhardh@gmail.com> wrote:
> @@ -134,7 +134,7 @@ time_t parse_iso8601(const gchar *str, int len) {
>     time_t    time;
>     time_t    tz_offset = 0;
>
> -    memset (&tm, 0, sizeof (struct tm));
> +    memset (&tm, 0, sizeof(struct tm));
>
>     /* According to spec the time doesn't have to be null terminated */
>     if (str[len - 1] != '\0') {

I suppose space before '(' can also be removed here and in some other
(possibly 3) calls in gwobex.

-- 
Slawomir Bochenski
