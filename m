Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 14:35:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] fakehid: Disconnect from PS3 remote after 10 mins
Message-ID: <20120629113546.GC24842@x220>
References: <1339889570.20079.7.camel@sirocco.config>
 <CABBYNZJ0-CDhC6WQJ-k20yCeJRiHR7c__tV6xg9-xphcDdEg_Q@mail.gmail.com>
 <1340027876.3987.117.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340027876.3987.117.camel@novo.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Jun 18, 2012, Bastien Nocera wrote:
> > It doesn't really need to remove/add the timeout separately, upon
> > event just reset the idle timeout.
> 
> I don't understand what you're saying here.
> 
> Are you saying I should call g_source_remove, and then g_timeout_add()?
> There's no functionality to change the interval for g_timeout_add*
> functions.
> 
> The call is separate because it is used multiple times in the code (and
> handling getting/setting in one place is cleaner).
> 
> By the way, the reason why it's handled this way is because the rest of
> the input code relies on the kernel switching off the connection using
> hidp_connadd_req->idle_to. fakehid doesn't use hidp.

Luiz told me that you had some IRC discussion about this and came to
some sort of consensus. Should I be expecting a new patch set?

Johan
