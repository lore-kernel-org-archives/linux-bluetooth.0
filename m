Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Jul 2010 20:44:29 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: bluez installs alsa related stuff under /etc/alsa instead of
 /usr/share/alsa
Message-ID: <20100716234429.GA24529@jh-x301>
References: <20100716180817.GA10326@vigoh>
 <1279306004.29479.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279306004.29479.3.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 16, 2010, Pacho Ramos wrote:
> From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
> Date: Fri, 16 Jul 2010 20:38:58 +0200
> Subject: [PATCH] Install alsa stuff in correct place
> 
> ---
>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

The patch is now upstream. Thanks.

Johan
