Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1362402872-13080-2-git-send-email-jaganath.k@samsung.com>
References: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
	<1362402872-13080-2-git-send-email-jaganath.k@samsung.com>
Date: Mon, 4 Mar 2013 09:44:22 -0400
Message-ID: <CAJdJm_P8unpbmR6Y1dzmkmXErrP6cLwaX8wza_6f+EPB5rr=CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] attrib: Fix use after free of attrib
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Mar 4, 2013 at 9:14 AM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> If attrib is freed in cmd->func(), then it will be used if either
> request or response queue has some data to send.

As far as I know, attrib was not supposed to be freed on the
cmd->func() callback. Do you have an example/testcase where this is
happening? To me, looks like a refcount issue (i.e. g_attrib_unref()
is deleting the attrib because a reference was not properly kept where
necessary).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
