Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387276373-23882-2-git-send-email-alex.aring@gmail.com>
References: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
	<1387276373-23882-2-git-send-email-alex.aring@gmail.com>
Date: Tue, 17 Dec 2013 06:58:12 -0400
Message-ID: <CAJdJm_MC7DOYZ_nf-Sv6c61s0X-i2yY-7chgd5gA9ScFvVkRBg@mail.gmail.com>
Subject: Re: [PATCH v2 bluetooth-next 1/7] 6lowpan: fix udp nullpointer dereferencing
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, werner@almesberger.net,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

On Tue, Dec 17, 2013 at 6:32 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> Sometimes a nullpointer dereferencing occurs because of using a wrong
> pointer arithmetic in udp_uncompression.
>
> This patch changes "**(hc06_ptr + 3)" to the right one "*(*hc06_ptr +
> 3)". Dereferencing like "**(hc06_ptr + 3)" works in a random case only.

And why not use hc06_ptr[0][3] ? IMHO it is more readable and the
arithmetic is the same (as far as I know).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
