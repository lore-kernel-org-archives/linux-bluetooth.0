Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/3] btmon: Fix memory leak
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1388753686-29400-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 3 Jan 2014 10:30:35 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <111CF8C1-856F-461E-A346-321D64B754F2@holtmann.org>
References: <1388753686-29400-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1388753686-29400-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Dynamic memory stored in company allocated through function
> hwdb_get_company shall be freed.
> ---
> monitor/packet.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index c991d04..b271cae 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -408,18 +408,20 @@ static void print_addr(const char *label, const uint8_t *addr,
> 		if (!hwdb_get_company(addr, &company))
> 			company = NULL;
> 
> -		if (company)
> +		if (company) {
> 			print_field("%s: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X"
> 					" (%s)", label, addr[5], addr[4],
> 							addr[3], addr[2],
> 							addr[1], addr[0],
> 							company);
> -		else
> +			free(company);

good catch. I totally forgot about the fact that the memory is allocated.

> +		} else {
> 			print_field("%s: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X"
> 					" (OUI %2.2X-%2.2X-%2.2X)", label,
> 						addr[5], addr[4], addr[3],
> 						addr[2], addr[1], addr[0],
> 						addr[5], addr[4], addr[3]);
> +		}
> 		break;

In userspace we do not require the else statement to be enclose by { } if the if part is as well. We usually don’t.

Regards

Marcel

