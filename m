Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Jun 2010 10:58:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
Message-ID: <20100622075833.GA14319@jh-x301>
References: <4C206507.40402@gmail.com>
 <20100622073841.GA13989@jh-x301>
 <4C206924.50303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C206924.50303@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 22, 2010, Jiri Slaby wrote:
> > libopenobex seems to be indicating REQDONE, so it doesn't look like
> > anything is necessarily wrong with obexd here. However, you'd need to
> > look at the HCI level trafic (output of "hcidump -XV") to determine
> > what's really going on (e.g. is it obexd or the client that's
> > disconnecting).
> 
> Attached:

Thanks.

> # hcidump -XV
<snip>
> < ACL data: handle 42 flags 0x02 dlen 11
>     L2CAP(d): cid 0x0041 len 7 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 18 pf 0 ilen 3 fcs 0x14
>         OBEX: Put rsp(f): status 403 len 3

So obexd is responding with "forbidden" to the client.
Possible reasons:

* obexd doesn't have write access to the directory it's trying to
  write to

* You don't have an agent registered for obexd that could accept
  the request or you're not running obexd in the auto-accept mode
  (the -a switch).

Johan
