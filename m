Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Jun 2011 10:14:44 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add RequestSecurePinCode to agent API
Message-ID: <20110610011444.GA13293@dell.ccr.corp.intel.com>
References: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1307615061.2589.36.camel@aeonflux>
 <BANLkTimz5QrqtXpEnEF8gwiVesGt8-HjLQ@mail.gmail.com>
 <20110609191833.GD2533@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110609191833.GD2533@joana>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Jun 09, 2011, Gustavo F. Padovan wrote:
> > We are getting closer to 4.100, maybe it is time to start doing the
> > transition to 5.x, which means we could start thinking on fixing the
> > current API without worrying if it breaks or not. How about that?
> 
> I'm with Luiz here. Unless we want the the crazy idea of have a development
> branch we should start breaking the API someday. How about now?

I'd prefer to have mgmtops.c on par with hciops.c for BR/EDR before
doing the move to 5.x. I do prefer the RequestPinCode with the boolean
parameter option, but since it breaks the API I think it needs to wait
until we're ready to go for 5.0.

Johan
