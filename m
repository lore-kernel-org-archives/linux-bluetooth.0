Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Nov 2010 18:54:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: 'Vinicius Costa Gomes' <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	'Bruna Moreira' <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v2 1/7] Fix invalid memory access when EIR field length
 is zero
Message-ID: <20101112165434.GA13238@jh-x301>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
 <20101111210705.GB24514@jh-x301>
 <000b01cb8200$02c24c90$0846e5b0$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000b01cb8200$02c24c90$0846e5b0$@org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Thu, Nov 11, 2010, Inga Stotland wrote:
> Was there a bug to begin with? :)
> The access to eir_data[1] was always valid due to the check (len <
> EIR_DATA_LENGTH - 1)
> and the fact that eir_data is a buffer of fixed length of EIR_DATA_LENGTH
> (240 bytes).

On closer inspection it seems you might be right, however it'd be nice
to get some comments from the original patch author about this (were
there e.g. crashes or some valgrind warnings observed or was this just
speculation based on looking at the code).

Btw, it seems I may need to slow down on my response time to patches so
there's better time for other people to review them too. E.g. both you
and Luiz were a bit late to the game on a couple of recent patches.
Maybe a 24 hour period before I push anything might be good enough?

Johan
