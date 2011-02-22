Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-4-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<1298068173-16518-4-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 22 Feb 2011 14:24:16 -0300
Message-ID: <AANLkTik7JOK6Hiatt=MC-Vg1DRKDWYOTEHFsNv6ZuaHA@mail.gmail.com>
Subject: Re: [RFC v2 03/14] Add att_get_u128
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Feb 18, 2011 at 7:29 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Function to convert 128-bits values from little endian to host
> order. Different than SDP, ATT uses little endian format.
> ---
>  attrib/att.c      |   12 ++++++++----
>  attrib/att.h      |   10 ++++++++++
>  attrib/gatt.c     |   13 ++++++++-----
>  attrib/gatttool.c |    6 ++++--
>  4 files changed, 30 insertions(+), 11 deletions(-)

This patch could be refactored by adding a hton128() call before
calling sdp_uuid128_create(). This way we fix the valid bug where we
are not passing big-endian ordered bytes to sdp_uuid28_create(). What
do you think?

At least the att_get_u128() function is still valid and needs to be
applied IMHO.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
