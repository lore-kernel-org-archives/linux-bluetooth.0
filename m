Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327403188-21981-5-git-send-email-sancane@gmail.com>
References: <1327403188-21981-1-git-send-email-sancane@gmail.com>
	<1327403188-21981-2-git-send-email-sancane@gmail.com>
	<1327403188-21981-3-git-send-email-sancane@gmail.com>
	<1327403188-21981-4-git-send-email-sancane@gmail.com>
	<1327403188-21981-5-git-send-email-sancane@gmail.com>
Date: Tue, 24 Jan 2012 08:47:32 -0400
Message-ID: <CAJdJm_NRwJW45_YcJVNS1yisc2axxP3BPR02wAHyExKbpYhOzw@mail.gmail.com>
Subject: Re: [PATCH 4/8] attrib-server: Allocate 16-bits UUIDS at the begining
 of the list
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Jan 24, 2012 at 7:06 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> ---
>  src/attrib-server.c |   43 ++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 93b7216..68a0b1c 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -350,7 +350,6 @@ static struct attribute *attrib_db_add_new(struct gatt_server *server,
>
>        server->database = g_slist_insert_sorted(server->database, a,
>                                                                attribute_cmp);
> -
>        return a;
>  }

The change above is bogus.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
