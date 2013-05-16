Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1367612371-20930-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
	<1367612371-20930-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Thu, 16 May 2013 09:13:36 -0400
Message-ID: <CAJdJm_O7dnpKZcTq_RJG5Hk2V_DR8jVdojSz6zuJAChyJbaZzQ@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] tools: Add script for updating bt_compidtostr() implementation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 3, 2013 at 4:19 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> This script uses curl and html2text to fetch company IDs from
> bluetooth.org's "Assigned Numbers" section.
> ---
>
> v2:
>
> * Use iconv to strip unrelated UTF-8 text from the HTML prior to passing it to
>   html2text.
> * Add simple sanity check for when HTML parsing fails.

ping

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
