Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MJM3AKu6Rrir+WkwyeyoEezjjvqQY2E14bzcUSz2NcXw@mail.gmail.com>
References: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
	<1343428380-32705-5-git-send-email-vinicius.gomes@openbossa.org>
	<CAJdJm_MJM3AKu6Rrir+WkwyeyoEezjjvqQY2E14bzcUSz2NcXw@mail.gmail.com>
Date: Fri, 27 Jul 2012 18:55:10 -0400
Message-ID: <CAJdJm_M8CzJZut_2Ck9L1b_wUDNO1-RHqXm5A7=ZPiaPnUJs4g@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] Bluetooth: Refactor ACL connection into its own function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jul 27, 2012 at 6:52 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Does it make sense to merge the two if()'s above into one? i.e.:
>
> if (IS_ERR(acl) || type == ACL_LINK)
>     return acl;
>
> It's still clear, IMHO.

Nevermind, now I see you just factored out this code on next patch.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
