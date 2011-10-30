Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319920465-32766-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319920465-32766-1-git-send-email-dh.herrmann@googlemail.com>
Date: Sun, 30 Oct 2011 10:26:38 -0400
Message-ID: <CAJdJm_NYEiw21=XwSCsqHtGjK18r6SXAJcLVdAG0LPEB6a9Wdg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hidp: Fix module reference cleanup
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sat, Oct 29, 2011 at 4:34 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> @@ -1033,6 +1032,7 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
>                product = 0x0000;
>        }
>
> +       __module_get(THIS_MODULE);
>        session->task = kthread_run(hidp_session, session, "khidpd_%04x%04x",
>                                                        vendor, product);
>        if (IS_ERR(session->task)) {

Can this leak if kthread_run() fails?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
