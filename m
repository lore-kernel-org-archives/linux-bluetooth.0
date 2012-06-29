Return-Path: <cyrus@holtmann.org>
Message-ID: <1340970375.5325.70.camel@novo.hadess.net>
Subject: Re: [PATCH 2/3] fakehid: Disconnect from PS3 remote after 10 mins
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Fri, 29 Jun 2012 12:46:15 +0100
In-Reply-To: <20120629113546.GC24842@x220>
References: <1339889570.20079.7.camel@sirocco.config>
	 <CABBYNZJ0-CDhC6WQJ-k20yCeJRiHR7c__tV6xg9-xphcDdEg_Q@mail.gmail.com>
	 <1340027876.3987.117.camel@novo.hadess.net> <20120629113546.GC24842@x220>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-06-29 at 14:35 +0300, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Mon, Jun 18, 2012, Bastien Nocera wrote:
> > > It doesn't really need to remove/add the timeout separately, upon
> > > event just reset the idle timeout.
> > 
> > I don't understand what you're saying here.
> > 
> > Are you saying I should call g_source_remove, and then g_timeout_add()?
> > There's no functionality to change the interval for g_timeout_add*
> > functions.
> > 
> > The call is separate because it is used multiple times in the code (and
> > handling getting/setting in one place is cleaner).
> > 
> > By the way, the reason why it's handled this way is because the rest of
> > the input code relies on the kernel switching off the connection using
> > hidp_connadd_req->idle_to. fakehid doesn't use hidp.
> 
> Luiz told me that you had some IRC discussion about this and came to
> some sort of consensus. Should I be expecting a new patch set?

Have we? I didn't understand what changes he wanted me to do. So don't
expect any updated patches until he answers on the list.

