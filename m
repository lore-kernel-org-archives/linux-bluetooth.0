Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <895415989D644B5AB712230EEFE0904B@sisodomain.com>
References: <1326534835-6995-1-git-send-email-luiz.dentz@gmail.com>
	<895415989D644B5AB712230EEFE0904B@sisodomain.com>
Date: Mon, 16 Jan 2012 17:02:32 +0200
Message-ID: <CABBYNZKqWnHF_robALXuke2LDN3z0rB10fY4iF_rRGyJcFCrMw@mail.gmail.com>
Subject: Re: [PATCH obexd] client: fix parsing of apparam on pbap driver
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Mon, Jan 16, 2012 at 4:52 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> Here one more changes is required. Since we are not updating the size
> while (size > APPARAM_HDR_SIZE) statement will always evaluate as false
> and it will never enter into the loop. So we need to have a statement
> size = params.size; before checking for the while() condition. Correct me if
> I 'm wrong here.

Yep, gonna fix that too, thanks for the feedback.


-- 
Luiz Augusto von Dentz
