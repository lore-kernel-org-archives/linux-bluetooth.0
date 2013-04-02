Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Apr 2013 09:45:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Subject: Re: [PATCH v2] core: Fix a double free on adapter_stop
Message-ID: <20130402064543.GA3509@x220>
References: <20130330155523.GA27129@x220.P-661HNU-F1>
 <1364840044-3577-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364840044-3577-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Mon, Apr 01, 2013, Alex Deymo wrote:
> The discovery_list list has the list of current discovery clients and is
> removed on adapter_stop (for example due a "power off" command). The
> g_slist_free_full will call discovery_free on every element of the list
> and remove the nodes of the list, but discovery_destroy (called by
> discovery_free) will not only free the element, but also remove it from
> the list. This causes the list node to be freed twice, once by
> g_slist_free_full and once by g_slist_remove.
> 
> This fix calls successively discovery_destroy and lets it remove the list's
> elements one by one.
> ---
>  src/adapter.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)

Applied (after a couple minor coding style changes). Thanks.

Johan
