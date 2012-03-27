Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 14:23:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] MAP/dummy: fix message-dummy.c build
Message-ID: <20120327112339.GB14481@x220>
References: <1331809522-6840-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1331809522-6840-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Mar 15, 2012, Frédéric Danis wrote:
> If g_slist_free_full is not supported by glib, build fails with error:
> 
> plugins/messages.o: In function `get_folder_listing':
> /home/fdanis/src/obexd/plugins/messages.c:199: undefined reference to `g_slist_free_full'
> ---
>  plugins/messages-dummy.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
