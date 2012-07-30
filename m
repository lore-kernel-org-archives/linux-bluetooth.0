Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343428198-23621-8-git-send-email-jprvita@openbossa.org>
References: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
	<1343428198-23621-8-git-send-email-jprvita@openbossa.org>
Date: Mon, 30 Jul 2012 07:46:33 -0400
Message-ID: <CAJdJm_PyZa_0K-5nZOo_D796x5cwiZ6GKMb7-Jey48CYPys88Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 07/14] mgmt: Add LE scanning callback
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Jul 27, 2012 at 6:29 PM, João Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> +       cp->type = info->discov_type;
> +
> +       if (write(mgmt_sock, buf, sizeof(buf)) < 0) {
> +               int err = errno;
> +               error("failed to write to MGMT socket: %s", strerror(err));
> +               return -err;

For consistency, "err" should be a negative value, and use
"strerror(-err)" and "return err" instead.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
