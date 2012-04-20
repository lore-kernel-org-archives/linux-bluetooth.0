Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334786904-26282-16-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-16-git-send-email-jprvita@openbossa.org>
Date: Fri, 20 Apr 2012 15:31:44 -0400
Message-ID: <CAJdJm_OetAmLuiMzZdPFu+TYC4Nh9x9SsJA=YJhYG0fZFe=zkw@mail.gmail.com>
Subject: Re: [RFC v2 15/16] HoG: Register only one notification callback
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

2012/4/18 João Paulo Rechi Vita <jprvita@openbossa.org>:
> From: Claudio Takahasi <claudio.takahasi@openbossa.org>
>
> Fix registering the notification callback per report. Only one instance
> of GAttrib callback for all report notifications should be registered.
> ---
>  input/hog_device.c |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)

Shouldn't this patch be squashed with some other on this series?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
