Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 16:35:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sdp: Prevent duplicate records registration
Message-ID: <20120629133505.GC27007@x220>
References: <1340182921-12448-1-git-send-email-frederic.danis@linux.intel.com>
 <20120620093513.GA17683@x220>
 <CABBYNZLatbQeMHtaBcXRpFVs4HfWZsUmi36MU9MKw2TQYjemZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLatbQeMHtaBcXRpFVs4HfWZsUmi36MU9MKw2TQYjemZw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jun 21, 2012, Luiz Augusto von Dentz wrote:
> On Wed, Jun 20, 2012 at 12:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> 
> > Also, the RFCOMM server socket code in the kernel should already give an
> > error if binding to the same channel is attempted twice, so this would
> > look like a bug in one of the DUN implementations that they do not
> > unregister their service record when binding the server socket fails. So
> > simply fixing this bug would also make sure that two service records
> > aren't present (though it would remove the existence of the clueless
> > admin ;)
> 
> Good point, and should actually work for L2CAP as well, apparently
> __rfcomm_get_sock_by_addr don't check BDADDR_ANY:
> 
> 		if (rfcomm_pi(sk)->channel == channel &&
> 				!bacmp(&bt_sk(sk)->src, src))
> 			break;
> 
> So the question is, should we check in every adapter if there is
> listen socket for the given channel?

I think the kernel should return an error is bind is tried with
BDADDR_ANY more than once for the same PSM or RFCOMM channel.

> This complicates a little bit more the code, the other option is to
> oFono don't do the socket management itself, this might be possible
> with org.bluez.Telephony, so just register an agent for DUN as it will
> be for HFP, bluetoothd takes care of handling the connection and
> authorization and when its done

Isn't that exactly what the last two patches (for DUN and SAP) from the
telephony patch set do?

Johan
