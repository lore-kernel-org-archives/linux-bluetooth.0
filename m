Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331559165-28367-7-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1331559165-28367-7-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 19 Mar 2012 10:14:41 -0300
Message-ID: <CABBYNZ+KymhsWUiVahAbPcMc=HoqZKHeW-HE4xUYwYND=M9_XQ@mail.gmail.com>
Subject: Re: [PATCH obexd v0 06/11] client: transfers take gobex when starting
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Mar 12, 2012 at 10:32 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> gobex api should not be used by a transfer until it is started. This
> seems more explicit if the pointer is not passed during creation.

Lets get the first 5 patches in since there might be some changes
after the review.


-- 
Luiz Augusto von Dentz
