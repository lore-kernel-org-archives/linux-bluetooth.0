Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Feb 2011 12:57:06 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3 v4] Add libtracker-sparql to obexd dependencies
Message-ID: <20110203105706.GA17209@jh-x301>
References: <1296726203-22613-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296726203-22613-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Feb 03, 2011, Radoslaw Jablonski wrote:
> In PBAP tracker is used only for reading and returns rather big
> parts of data, so using direct access libtracker-sparql is better
> solution than tracker D-Bus API(libtracker-sparql in most PBAP
> scenarios should be faster).
> ---
>  Makefile.am  |    4 +++-
>  configure.ac |    7 +++++++
>  2 files changed, 10 insertions(+), 1 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
