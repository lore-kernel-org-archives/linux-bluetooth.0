Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329842810-13449-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1329842810-13449-1-git-send-email-frederic.dalleau@linux.intel.com>
Date: Thu, 8 Mar 2012 11:14:38 +0100
Message-ID: <CA+QXtDu+pM6-oPv+JJ3g65tYz1kjBmY1pOTNZqUEGSO=Nj8nZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gateway: Fix crash if SCO connection fails
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2012/2/21 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> The first patch is a resend of a previous patch with same name.
> The second one happens after the sco connection has failed : the disconnect
> watch is not removed when the media owner is freed upon error in acquire.

Luiz acked, any updates please?

Thanks,
Frédéric
