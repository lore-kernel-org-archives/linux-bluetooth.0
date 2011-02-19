Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-10-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<1298068173-16518-10-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 18 Feb 2011 21:50:19 -0300
Message-ID: <AANLkTin59LiPURHfQKXVaO0FJjC+fkaqhL786H2hopBB@mail.gmail.com>
Subject: Re: [RFC v2 09/14] Replace UUID128 values from char array to
 uint128_t on sdptool
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Feb 18, 2011 at 7:29 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> @@ -3992,7 +4005,7 @@ static int cmd_search(int argc, char **argv)
>                        sdp_uuid16_create(&context.group, class16);
>                }
>        } else
> -               sdp_uuid128_create(&context.group, uuid);
> +               sdp_uuid128_create(&context.group, &n128);

I think you meant "n128" instead of "&n128" here.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
