Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 15:16:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 2/2] gobex: add check for connection id
Message-ID: <20111107131601.GA21304@fusion.localdomain>
References: <1320668958-11238-1-git-send-email-luiz.dentz@gmail.com>
 <1320668958-11238-2-git-send-email-luiz.dentz@gmail.com>
 <868faa5baf31e0246cd0d9d54ac6d76c@mail.hendrik-sattler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <868faa5baf31e0246cd0d9d54ac6d76c@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 07, 2011, Hendrik Sattler wrote:
> Am 07.11.2011 13:29, schrieb Luiz Augusto von Dentz:
> >+		g_obex_debug(G_OBEX_DEBUG_ERROR, "Connection id don't match");
> 
> s/don't/does not/

I already fixed this before pushing.

Johan
