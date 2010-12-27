Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101227151122.GD17203@jh-x301>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
	<1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
	<20101227151122.GD17203@jh-x301>
Date: Mon, 27 Dec 2010 14:23:26 -0400
Message-ID: <AANLkTin0LaPXDNgaSd-L=R9tXUrw1LxWm-7-dZc0F_+x@mail.gmail.com>
Subject: Re: [PATCH 4/4] Fix leak of EIR data if RSSI does not change
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Dec 27, 2010 at 11:11 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> In general this seems fine, but to avoid future memory leaks in case you
> go ahead and change the eir_data struct wouldn't it be better to have a
> separate free_eir_data() function which does the g_slist_foreach,
> g_slist_free and g_free?

I followed your suggestion and created a free_eir_data(). I also did a
simple code reordering that simplified the complete EIR name storage.
See v2 of this patch. (2/4 should be ignored).

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
