Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365690946-28050-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
	<1365690946-28050-2-git-send-email-claudio.takahasi@openbossa.org>
Date: Thu, 11 Apr 2013 10:52:34 -0400
Message-ID: <CAJdJm_MdQLF2gaK5vOt+k+rewvk54541cgquLGaJ1VoY5RuPmw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add rejecting SCO
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Apr 11, 2013 at 10:35 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> @@ -276,7 +286,8 @@ static void hci_conn_timeout(struct work_struct *work)
>                                 hci_acl_create_connection_cancel(conn);
>                         else if (conn->type == LE_LINK)
>                                 hci_le_create_connection_cancel(conn);
> -               }
> +               } else if (conn->type == SCO_LINK || conn->type == ESCO_LINK)
> +                       hci_reject_sco(conn);

IIRC for kernel you always use curly braces if one of the if()
branches have it (even if one of the branches has a single line), i.e.
use:

if (...) {
...
} else {
...
}

instead of:

if (...) {
...
} else
...

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
