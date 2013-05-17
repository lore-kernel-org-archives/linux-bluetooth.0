Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130517072830.GA24865@x220>
References: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
	<1367612371-20930-1-git-send-email-anderson.lizardo@openbossa.org>
	<CAJdJm_O7dnpKZcTq_RJG5Hk2V_DR8jVdojSz6zuJAChyJbaZzQ@mail.gmail.com>
	<20130517072830.GA24865@x220>
Date: Fri, 17 May 2013 06:49:40 -0400
Message-ID: <CAJdJm_P6Z_=2dub7AyMNngw3zy_OiwibFARHBStYmJDudj2bhQ@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] tools: Add script for updating bt_compidtostr() implementation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, May 17, 2013 at 3:28 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> The script still doesn't work for me. It spews out some java script and
> finally ends with "ERROR: could not parse company IDs from bluetooth.org".

It seems that FC18 source has some patches that make it behave
different from Ubuntu and upstream sources. I built the upstream
(without any patches) and it worked fine (just like the Ubuntu
version). After applying FC18 patches, I got the problem you
mentioned.

I'll now change the script to make it work with both upstream and FC18 versions.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
