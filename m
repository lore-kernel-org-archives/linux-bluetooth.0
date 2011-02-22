Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-14-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<1298068173-16518-14-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 22 Feb 2011 14:27:50 -0300
Message-ID: <AANLkTikX6ajkK8J9W8K5HqQFiTvt1YwJw3w03oRh-=dc@mail.gmail.com>
Subject: Re: [RFC v2 13/14] Add att_put_u128
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Feb 18, 2011 at 7:29 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> ATT protocol uses little endian byte order, before to add a UUID128
> value in the PDU it needs to converted from host order to little endian.
> ---
>  attrib/att.c |    4 ++--
>  attrib/att.h |    7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)

Similarly, this part of the original code is still buggy and we need a
ntoh128() call before att_put_u128().

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
