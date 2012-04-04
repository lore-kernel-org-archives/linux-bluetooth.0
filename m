Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 10:41:17 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Anju Manoj <anju.manoj@sasken.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: unable to find the lex libraries
Message-ID: <20120404134117.GA14816@samus>
References: <2316A524B7DB8C4AB39B9EDEDF597C8F015B35BB0653@EXGMBX01.sasken.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2316A524B7DB8C4AB39B9EDEDF597C8F015B35BB0653@EXGMBX01.sasken.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anju,

On 17:19 Wed 04 Apr, Anju Manoj wrote:
> hi all,
> 
>         i am having a bluez4.82 with me and i am trying  to configure it using the below command in ubuntu 11.04
> 
> ./configure --enable-maintainer-mode --enable-health --enable-attrib  --enable-gstreamer --enable-alsa --enable-usb --enable-tracer --enable-tools --enable-bccmd --enable-pcmcia --enable-hid2hci --enable-dfutool --enable-hidd --enable-pand --enable-dund --enable-cups --enable-test --enable-udevrules --enable-configfiles --enable-debug --enable-maemo6 --enable-hal
> 
> now i am getting an error
> 
>   LEX    tools/lexer.c
> make[1]: *** [tools/lexer.c] Error 1
> make: *** [all] Error 2
> 
> not able to find which lex library have to be installed in order to get around this problem

Most probably you just need to install flex, Ubuntu has it.

> 
> Please help me as i am new to this technology.
> 
> Anju
> 
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
